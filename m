Return-Path: <highguy@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05E93B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 21:23:09 +1000 (EST)
Received: by qwf7 with SMTP id 7so1128780qwf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 04:23:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1311244404-4463-1-git-send-email-Shaohui.Xie@freescale.com>
References: <1311244404-4463-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Fri, 22 Jul 2011 13:23:05 +0200
Message-ID: <CAOY=C6GD6e3FWWNALaHXwr-32+0BWVXtKbSZ6ZZdZ1FsQE2+2Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] edac/85xx: PCI/PCIE error interrupt edac support.
From: Stijn Devriendt <highguy@gmail.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mm-commits@vger.kernel.org, kumar.gala@freescale.com, avorontsov@mvista.com,
	"Kai.Jiang" <Kai.Jiang@freescale.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 21, 2011 at 12:33 PM, Shaohui Xie <Shaohui.Xie@freescale.com> wrote:
> From: Kai.Jiang <Kai.Jiang@freescale.com>
>
> Add pcie error interrupt edac support for mpc85xx and p4080.
> mpc85xx uses the legacy interrupt report mechanism - the error
> interrupts are reported directly to mpic. While, p4080 attaches
> most of error interrupts to interrupt 0. And report error interrupt
> to mpic via interrupt 0. This patch can handle both of them.
>
> Due to the error management register offset and definition
>
> difference between pci and pcie, use ccsr_pci structure to merge
> pci and pcie edac code into one.
>

This code has been posted a couple of months ago, if I'm not mistaken.
I'm currently testing it on a P2020 based design.

One of the failures I'm trying to cope with is a PCIe device that does not
send back a completion with data. e.g. a userspace process reads memory
through a memory map, but the PCIe device is not responding.
In this case the P2020 will stall due to the core_fault_in being asserted.

If configured, this interrupt will be called, but it does nothing to cure the
root cause (e.g. kill the process). End result is that the processor still
hangs.
I've been hacking my way around the kernel for a while and ended up a lot
closer to a working solution to recover from such a failure.

The issue I'm facing now is that the PIC can be configured to send the
interrupt as a critical interrupt to one of both cores, but that may not
be the core that is running the process that initiated the read.
I've done 2 test-runs and both killed the right process, but I'd like to make
sure that it's not by accident.
Bottom-line: what mechanisms are in place (or are required) to ensure
that the the right process (on the same core or on another core) is killed
regardless of how the PIC is configured?

Regards,
Stijn
