Date: Mon, 25 Feb 2002 16:06:03 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202260006.g1Q063n02737@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been trying other kernels with some different results
2.4.17 = has mmap problem
2.4.14 = has mmap problem
2.4.13 = has mmap problem
2.4.12 = has mmap problem
2.4.10 = has mmap problem but takes more iterations to happen
2.4.8  = not quite done getting it to boot.

The only files I change to get a kernel to boot on our box are:
Makefile
  set arch to ppc and set the CROSS_COMPILE
arch/ppc/8260_io/fcc_enet.c
arch/ppc/8260_io/uart.c
arch/ppc/8260_io/commproc.c
  Slight changes to deal with our board's io port assignments
include/asm-ppc/est8260.c
  changes in the boardinfo structure passed from ppcboot
fs/proc/proc_misc.c
  added a /proc file to view some of the boardinfo structure

I'm not initializing usb or pci in the non-2.4.17 kernels.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
