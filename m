Return-Path: <knight@princeton.edu>
Received: from skuld.princeton.edu (skuld.Princeton.EDU [128.112.173.239])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F299E2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 07:20:15 +1000 (EST)
Message-ID: <51AD088C.8040803@princeton.edu>
Date: Mon, 03 Jun 2013 17:20:12 -0400
From: Robert Knight <knight@princeton.edu>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: IBM OpenPower 720 ipr driver woes
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com>
In-Reply-To: <51A644C2.5090300@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Wendy Xiong <wenxiong@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/29/2013 2:11 PM, Brian King wrote:
> On 05/29/2013 10:15 AM, Robert Knight wrote:
>> Sometime after kernel 3.3.4, Fedora 17 running on an IBM OpenPower
>> 720 stopped being able to read the SCSI disks with an error
>> concerning a return code -1.  In the updates since, it has not
>> resumed working.
>>
>> Does the ipr driver no longer support this (admittedly ancient)
>> hardware?
> Do you have a boot log you can share?
>
> Thanks,
>
> Brian
>
Apologies for the slowness of my response.  I had wiped the system, 
Fedora 17 won't install without grub2 tweaks and I had to discover that.

I have copied and pasted the HMC console window:

> Boo
> ting `Fedora (3.8.11-100.fc17.ppc64)'
>
> Loading Fedora (3.8.11-100.fc17.ppc64)
> Loading initial ramdisk ...
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 3.8.11-100.fc17.ppc64 
> (mockbuild@ppc-builder7.qa
> .fedoraproject.org) (gcc version 4.7.2 20120921 (Red Hat 4.7.2-2) 
> (GCC) ) #1 SMP
>  Wed May 1 13:51:54 MST 2013
> Detected machine type: 0000000000000101
> Max number of cores passed to firmware: 512 (NR_CPUS = 1024)
> Calling ibm,client-architecture-support... not implemented
> command line: BOOT_IMAGE=/vmlinuz-3.8.11-100.fc17.ppc64 
> root=/dev/mapper/vg_narv
> i-lv_root ro rd.md=0 rd.dm=0 KEYTABLE=us rd.lvm.lv=vg_narvi/lv_swap 
> rd.luks=0 rd
> .lvm.lv=vg_narvi/lv_root SYSFONT=True LANG=en_US.UTF-8 rhgb quiet
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 0000000004800000
>   alloc_top    : 0000000008000000
>   alloc_top_hi : 00000000ee000000
>   rmo_top      : 0000000008000000
>   ram_top      : 00000000ee000000
> instantiating rtas at 0x00000000077b0000... done
> Querying for OPAL presence... not there.
> boot cpu hw idx 0
> starting cpu hw idx 2... done
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000004810000 -> 0x000000000481123d
> Device tree struct  0x0000000004820000 -> 0x0000000004840000
> Calling quiesce...
> returning from prom_init
> [    1.376359] ehci-pci 0000:c8:01.2: can't setup
> [    1.376749] ehci-pci 0000:c8:01.2: init 0000:c8:01.2 fail, -19
> [   11.388273] ohci_hcd 0000:c8:01.0: USB HC takeover failed! 
> (BIOS/SMM bug)
> [   11.388287] ohci_hcd 0000:c8:01.0: can't setup
> [   11.388686] ohci_hcd 0000:c8:01.0: init 0000:c8:01.0 fail, -16
> [   21.408214] ohci_hcd 0000:c8:01.1: USB HC takeover failed! 
> (BIOS/SMM bug)
> [   21.408228] ohci_hcd 0000:c8:01.1: can't setup
> [   21.408596] ohci_hcd 0000:c8:01.1: init 0000:c8:01.1 fail, -16
> Cannot open font file True
> Cannot open font file True
> [   21.949512] ipr 0001:d0:01.0: Write of cache line size failed
> [   22.032546] pata_pdc2027x: Invalid PLL input clock 0kHz, give up!
>
>
> dracut Warning: Unable to process initqueue
> Cannot open font file True
>
>
> dracut Warning: Unable to process initqueue
> dracut Warning: /dev/mapper/vg_narvi-lv_root does not exist
> dracut Warning: /dev/vg_narvi/lv_root does not exist
> dracut Warning: /dev/vg_narvi/lv_swap does not exist
>
> Dropping to debug shell.
>
> dracut:/#
