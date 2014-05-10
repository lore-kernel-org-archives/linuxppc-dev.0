Return-Path: <matorola@gmail.com>
Received: from mail-ve0-f176.google.com (mail-ve0-f176.google.com
 [209.85.128.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4769214009C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 16:28:48 +1000 (EST)
Received: by mail-ve0-f176.google.com with SMTP id jz11so6298545veb.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 May 2014 23:28:43 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 10 May 2014 10:28:42 +0400
Message-ID: <CADxRZqy6tyEMs6sWpxAg=wquv4K5v8VbGiezAe=NNf9bjJf+Dw@mail.gmail.com>
Subject: device tree, fedora 20 install
From: Anatoly Pugachev <matorola@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

There's a regression somewhere in kernel, I'm unable to boot
installation kernel version 3.11.10-301.fc20.ppc64 of fedora 20 on IBM
JS22 (type 7998) blade. But my previous attempt with kernel
3.9.5-301.fc19.ppc64 was able to boot.

I have the following output with 3.11.10-301.fc20.ppc64 kernel:

  Booting `Install Fedora 20 (64-bit kernel)'

OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 3.11.10-301.fc20.ppc64
(mockbuild@ppc-builder7.qa.fedoraproject.org) (gcc version 4.8.2
20131017 (Red Hat 4.8.2-1) (GCC) ) #1 SMP Tue Dec 10 00:35:15 MST 2013
Detected machine type: 0000000000000101
Max number of cores passed to firmware: 512 (NR_CPUS = 1024)
Calling ibm,client-architecture-
support... done
command line: BOOT_IMAGE=/ppc/ppc64/vmlinuz ro
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000006e80000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000008000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000008000000
found display   : /pci@800000020000202/display@1, opening... done
instantiating rtas at 0x0000000006eb0000... done
Querying for OPAL presence... not there.
boot cpu hw idx 0
starting cpu hw idx 2... done
starting cpu hw idx 4... done
starting cpu hw idx 6... done
copying OF device tree...
Building dt strings...
Building dt structure...
No memory for flatten_device_tree (no room)
EXIT called ok
0 >



while with 3.9.5-301.fc19.ppc64 it pass DT stage:

Welcome to the 64-bit Fedora 19 installer!
Hit <TAB> for boot options.


Welcome to yaboot version 1.3.17 (Red Hat 1.3.17-6.fc19)
Enter "help" to get some basic usage information
boot: linux
Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 03980000, size: 9872 Kbytes
OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 3.9.5-301.fc19.ppc64
(mockbuild@ppc-builder3.qa.fedoraproject.org) (gcc version 4.8.1
20130603 (Red Hat 4.8.1-1)
(GCC) ) #1 SMP Tue Jun 11 15:07:48 MST 2013
Detected machine type: 0000000000000101
Max number of cores passed to firmware: 512 (NR_CPUS = 1024)
Calling ibm,client-architecture-support... done
command line: ro
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000004330000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000008000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000008000000
found display   : /pci@800000020000202/display@1, opening... done
instantiating rtas at 0x0000000006db0000... done
Querying for OPAL presence... not there.
boot cpu hw idx 0
starting cpu hw idx 2... done
starting cpu hw idx 4... done
starting cpu hw idx 6... done
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000004440000 -> 0x000000000444182e
Device tree struct  0x0000000004450000 -> 0x0000000004470000
Calling quiesce...
returning from prom_init
[    0.000000] Using pSeries machine description
[    0.000000] Using 1TB segments
[    0.000000] Found initrd at 0xc000000003980000:0xc000000004324000
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Partition configured for 8 cpus.
(and so on...)



Can someone help me with this issue? Thanks.
