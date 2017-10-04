Return-Path: <danielhb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6nPJ6SP6zDr0K
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 07:21:56 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v94KK49h030794
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Oct 2017 16:21:54 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dd5p6jtaj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Oct 2017 16:21:54 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <danielhb@linux.vnet.ibm.com>;
 Wed, 4 Oct 2017 14:21:53 -0600
To: linuxppc-dev@lists.ozlabs.org
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Subject: Possible LMB hot unplug bug in 4.13+ kernels
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 4 Oct 2017 17:21:48 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <94618f16-b47f-b714-9cb5-4bbbf7fdccdf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've stumbled in a LMB hot unplug problem when running a guest with 
4.13+ kernel using QEMU 2.10. When trying to hot unplug a recently 
hotplugged LMB this is what I got, using an upstream kernel:

---------------
QEMU cmd line: sudo ./qemu-system-ppc64 -name migrate_qemu -boot 
strict=on -device nec-usb-xhci,id=usb,bus=pci.0,addr=0xf -device 
spapr-vscsi,id=scsi0,reg=0x2000 -smp 
32,maxcpus=32,sockets=32,cores=1,threads=1 --machine 
pseries,accel=kvm,kvm-type=HV,usb=off,dump-guest-core=off -m 
4G,slots=32,maxmem=32G -drive 
file=/home/danielhb/vm_imgs/f26.qcow2,format=qcow2,if=none,id=drive-virtio-disk0,cache=none 
-device 
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x2,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 
-nographic


Last login: Wed Oct  4 12:28:25 on hvc0
[danielhb@localhost ~]$ grep Mem /proc/meminfo
MemTotal:        4161728 kB
MemFree:         3204352 kB
MemAvailable:    3558336 kB
[danielhb@localhost ~]$ QEMU 2.10.50 monitor - type 'help' for more 
information
(qemu)
(qemu) object_add memory-backend-ram,id=ram0,size=1G
(qemu) device_add pc-dimm,id=dimm0,memdev=ram0
(qemu)

[danielhb@localhost ~]$ grep Mem /proc/meminfo
MemTotal:        5210304 kB
MemFree:         4254656 kB
MemAvailable:    4598144 kB
[danielhb@localhost ~]$ (qemu)
(qemu) device_del dimm0
(qemu) [  136.058727] pseries-hotplug-mem: Memory indexed-count-remove 
failed, adding any removed LMBs

(qemu)
[danielhb@localhost ~]$ grep Mem /proc/meminfo
MemTotal:        5210304 kB
MemFree:         4253696 kB
MemAvailable:    4597184 kB
[danielhb@localhost ~]$

-------------

The LMBs are about to be unplugged, them something happens and they 
ended up being hotplugged back.

This isn't reproducible with 4.11 guests. I can reliably reproduce it in 
4.13+. Haven't tried 4.12.

Changing QEMU snapshots or even the hypervisor kernel/OS didn't affect 
the result.


In an attempt to better understand the issue I did the following changes 
in upstream kernel:

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c 
b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 1d48ab424bd9..37550833cdb0 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -433,8 +433,10 @@ static bool lmb_is_removable(struct of_drconf_cell 
*lmb)
         unsigned long pfn, block_sz;
         u64 phys_addr;

-       if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
+       if (!(lmb->flags & DRCONF_MEM_ASSIGNED)) {
+               pr_err("lmb is not assigned \n");
                 return false;
+       }

         block_sz = memory_block_size_bytes();
         scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
@@ -442,8 +444,10 @@ static bool lmb_is_removable(struct of_drconf_cell 
*lmb)

  #ifdef CONFIG_FA_DUMP
         /* Don't hot-remove memory that falls in fadump boot memory area */
-       if (is_fadump_boot_memory_area(phys_addr, block_sz))
+       if (is_fadump_boot_memory_area(phys_addr, block_sz)) {
+               pr_err("lmb belongs to fadump boot memory area\n");
                 return false;
+       }
  #endif

         for (i = 0; i < scns_per_block; i++) {
@@ -454,7 +458,9 @@ static bool lmb_is_removable(struct of_drconf_cell *lmb)
                 rc &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
                 phys_addr += MIN_MEMORY_BLOCK_SIZE;
         }
-
+       if (!rc) {
+               pr_err("is_mem_section_removable returned false \n");
+       }
         return rc ? true : false;
  }

@@ -465,12 +471,16 @@ static int dlpar_remove_lmb(struct of_drconf_cell 
*lmb)
         unsigned long block_sz;
         int nid, rc;

-       if (!lmb_is_removable(lmb))
+       if (!lmb_is_removable(lmb)) {
+               pr_err("dlpar_remove_lmb: lmb is not removable! \n");
                 return -EINVAL;
+       }

         rc = dlpar_offline_lmb(lmb);
-       if (rc)
+       if (rc) {
+               pr_err("dlpar_remove_lmb: offline_lmb returned not zero 
\n");
                 return rc;
+       }

         block_sz = pseries_memory_block_size();
         nid = memory_add_physaddr_to_nid(lmb->base_addr);

And this is the output:

---------

[danielhb@localhost ~]$ QEMU 2.10.50 monitor - type 'help' for more 
information
(qemu)
(qemu) object_add memory-backend-ram,id=ram0,size=1G
(qemu) device_add pc-dimm,id=dimm0,memdev=ram0
(qemu)

[danielhb@localhost ~]$ grep Mem /proc/meminfo
MemTotal:        5210304 kB
MemFree:         4254656 kB
MemAvailable:    4598144 kB
[danielhb@localhost ~]$ (qemu)
(qemu) device_del dimm0
(qemu) [  136.058473] pseries-hotplug-mem: is_mem_section_removable 
returned false
[  136.058607] pseries-hotplug-mem: dlpar_remove_lmb: lmb is not removable!
[  136.058727] pseries-hotplug-mem: Memory indexed-count-remove failed, 
adding any removed LMBs

(qemu)

[danielhb@localhost ~]$ grep Mem /proc/meminfo
MemTotal:        5210304 kB
MemFree:         4253696 kB
MemAvailable:    4597184 kB
[danielhb@localhost ~]$

---------------

It appears that the hot unplug is failing because lmb_is_removable(lmb) 
is returning
false inside dlpar_remove_lmb, triggering the hotplug of the LMBs again:

         if (rc) {
                 pr_err("Memory indexed-count-remove failed, adding any 
removed LMBs\n");

                 for (i = start_index; i < end_index; i++) {
                         if (!lmbs[i].reserved)
                                 continue;

                         rc = dlpar_add_lmb(&lmbs[i]);
                         if (rc)
                                 pr_err("Failed to add LMB, drc index %x\n",
be32_to_cpu(lmbs[i].drc_index));

                         lmbs[i].reserved = 0;
                 }

I am not aware of anything that I can do from QEMU side to fix this. Can 
anyone take a look or provide
guidance? Am I missing something in my tests?


Thanks,


Daniel
