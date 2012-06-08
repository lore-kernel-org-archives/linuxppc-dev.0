Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 17A50B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2012 01:48:45 +1000 (EST)
Message-ID: <4FD21D1B.3030506@ovro.caltech.edu>
Date: Fri, 08 Jun 2012 08:41:15 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mohan <mohanaraov@vrindatech.com>
Subject: Re: need support for PCI driver
References: <000501cd4562$df6915d0$9e3b4170$@com>
In-Reply-To: <000501cd4562$df6915d0$9e3b4170$@com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Using PMC -PCI Adapter card ,i have interfaced my *PowerPC MPC8280*
> (which is configured as *PCI bridge*) as agent to personal computer.
> when this setup having MPC8280 card with *powered ON* and connected to
> *PC* .*PC* is getting hanged while system is booting up. I am finding
> problem when this card is powered ON state before system is boot up. But
> if this MPC8280(PCI Bridge) card with powered ON is connected to PMC
> carrier adapter after PC has booted up, it is getting identified by
> system and able to watch my device details (configuration space) using
> "*PCI Explorer Software"*. But using this software, it is showing this
> single PCI device as *31* different devices. *Why this is showing as 31
> PCI devices? Also why PC is not getting Booted, after this PCI Bridge in
> power ON state is connected to PMC –PCI Adapter card that already in PCI
> slot of my PC?* I am unable to solve this problem.

Have you looked at the PCI bus activity when this is failing?

If your MPC8280 does not configure the PCI bridge correctly, or
before the host PC BIOS performs configuration space access to
configure the PCI bridge, then that may explain your issue.

> I am finding the same issue even I am using this set up on Linux based
> host .

Because its a BIOS issue, not an OS issue.

> I approached Freescale support for this issue by sending my *PCI card
> schematics*. They analyzed and came up with small changes, but still we
> could not able to solve this problem. So we wanted to start tracing the
> problem from software side. That’s why I wanted to install my PCI card
> into Linux based host. To do this whether I need to write /include any
> driver code into my Linux host .If I need to write driver code how to
> start & where exactly needs changes/inclusions of code stuff in linux code.
>
> Already I am studying kernel documentation and drivers code under source
> code. Referring Linux device Driver 3^rd edition O’reilly s book.
>
> I am new to linux.

You do not need to write a driver while trying to debug your PCI
BAR regions issues. You only need a driver when working with
interrupts.

Under Linux, you can use the lspci command to look at the PCI
configuration space exposed by the PCI interface on your board.
Once you are happy that the BAR layout corresponds to what you
expect, i.e., what you PCI bootloader configures the card as,
you can move onto accessing the board via those BAR regions.

You can then use simple command line tools (run as root) to
access the BAR regions.

Here's a simple command-line tool I wrote for read/write access:

http://www.ovro.caltech.edu/~dwh/pci_debug.zip

I believe the tool devmem (part of busybox) can also be used.

Cheers,
Dave
