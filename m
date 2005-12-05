Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (unknown [198.161.247.241])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A11868866
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Dec 2005 15:08:59 +1100 (EST)
Date: Sun, 4 Dec 2005 21:08:55 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051205040855.GA4219@obsidianresearch.com>
References: <20051202080711.GA32759@obsidianresearch.com>
	<1133742158.6100.119.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133742158.6100.119.camel@gaston>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.15-rc4] ppc32: Fixes for non-zero PPC_MEMSTART on
	PPC440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Dec 05, 2005 at 11:22:37AM +1100, Benjamin Herrenschmidt wrote:

> Just out of curiosity: why did you do such a bogus setup in the first
> place ?

Historical.. This a FPGA design (Xilinx, embedded 405's) and the first
time we deployed it was in conjunction with a 2nd MIPS processor that
had system memory mapped 0 -> 0x200000. To keep the world sane and
simple the 405's memory was desired to be non-overlapping with the
MIPS world. The MIPS did care about the memory layout so it got to
have RAM at address 0. This put the PPC ram at 0xC00000. The same
basic components (mini embedded OS, internal FPGA cores, etc, etc)
kept getting reused from project to project.

Nowadays, the 405 part of the original design has been retasked for
something totally different and the MIPS is gone, taking along with it
the reason for the odd memory map. But we built a stack of software
which all assumes the classic memory map so the hardware just kept
repeating it.

Fortunately for us Linux was pretty close to supporting the odd memory
map, so we got to retain compatability with the old software, keep the
hardware the same, and just patch the kernel a little bit.

Jason
