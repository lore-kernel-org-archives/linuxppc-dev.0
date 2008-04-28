Return-Path: <adobriyan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id CD1ADDE452
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 06:12:04 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so3215793nfd.9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 13:12:00 -0700 (PDT)
Date: Tue, 29 Apr 2008 01:07:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: pci_proc_init: proc_dir_entry '00' already registered
Message-ID: <20080428210725.GA15955@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> On Sun, Feb 10, Alexey Dobriyan wrote:
> 
> > On Sun, Feb 10, 2008 at 11:07:57AM +0100, Olaf Hering wrote:
> > > Current Linus tree gives this new warning during bootup:
> > > 
> > > +proc_dir_entry '00' already registered
> > > +Call Trace:
> > > +[c00000007b0dfba0] [c00000000000e4b0] .show_stack+0x70/0x1bc
> > > (unreliable)
> > > +[c00000007b0dfc50] [c0000000000f2714] .proc_register+0x130/0x210
> > > +[c00000007b0dfd00] [c0000000000f299c] .proc_mkdir_mode+0x40/0x70
> > > +[c00000007b0dfd80] [c000000000276ed8]
> > > .pci_proc_attach_device+0xac/0x144
> > > +[c00000007b0dfe20] [c0000000005bdb3c] .pci_proc_init+0x74/0xac
> > > +[c00000007b0dfea0] [c0000000005a27ac] .kernel_init+0x1d0/0x394
> > > +[c00000007b0dff90] [c00000000001e258] .kernel_thread+0x4c/0x68
> > 
> > Can you insert dump_stack() when '00' is registered, not just second
> > time?
> 
> Its pci_bus_add_device(). Full dmesg attached:

It can't be. "proc_initialized" is 0 at that point, so no new files in
/proc .

Must be something PCI domains related: if pci_proc_domain() returns 0
for some reason, busses will be different, but name the same -- '00'.
The reason there is no second warning is that you don't have anything
on 0001:0a .

> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b113800 - 0000:00:0b.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b113000 - 0000:0a:00.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b149800 - 0001:00:00.0
> proc_dir_entry '00' already registered
> Call Trace:
> [c00000007b0dfb60] [c00000000000f4ec] .show_stack+0x5c/0x1f0 (unreliable)
> [c00000007b0dfc10] [c000000000112e40] .proc_register+0x190/0x250
> [c00000007b0dfcd0] [c000000000113130] .proc_mkdir_mode+0x40/0x80
> [c00000007b0dfd50] [c0000000002c7548] .pci_proc_attach_device+0x158/0x190
> [c00000007b0dfe00] [c00000000065c3f8] .pci_proc_init+0xb8/0x100
> [c00000007b0dfe90] [c00000000063c8a8] .kernel_init+0x1d8/0x420
> [c00000007b0dff90] [c000000000021dac] .kernel_thread+0x4c/0x68
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b149000 - 0001:00:01.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a4800 - 0001:00:02.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a4000 - 0001:00:03.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a5800 - 0001:00:04.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a5000 - 0001:00:05.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a6800 - 0001:00:06.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a6000 - 0001:00:07.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a7800 - 0001:00:08.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a7000 - 0001:00:09.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a9800 - 0001:05:04.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1a9000 - 0001:05:04.1
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1ab800 - 0001:01:07.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1ab000 - 0001:01:0b.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1ac800 - 0001:01:0b.1
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1ac000 - 0001:01:0b.2
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1ae800 - 0001:03:0c.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1ae000 - 0001:03:0d.0
> pci_proc_attach_device(395) swapper(1):c0,j4294937353 1: c00000007b1af800 - 0001:03:0e.0
