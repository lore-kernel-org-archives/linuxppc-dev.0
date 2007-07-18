Return-Path: <drow@false.org>
Received: from nan.false.org (NaN.false.org [208.75.86.248])
	by ozlabs.org (Postfix) with ESMTP id 33C46DE24F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jul 2007 05:00:23 +1000 (EST)
Date: Wed, 18 Jul 2007 14:31:43 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Gdbserver syscall clobber
Message-ID: <20070718183143.GA25324@caradoc.them.org>
References: <469B922D.3050701@billgatliff.com>
	<20070716155348.GA5281@caradoc.them.org>
	<469E550E.5080905@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <469E550E.5080905@billgatliff.com>
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2007 at 12:59:42PM -0500, Bill Gatliff wrote:
> Now, I'm a little rusty on PPC asm (I've been doing a lot of ARM
> lately), but it looks to me like the kernel is setting bit 0 in CR0
> (oris r10, r10, 0x1000) a.k.a LT, but the user side is looking at CR0
> (bnslr+) bit 3 a.k.a. SO.  Or maybe the other way around, I'm not sure
> after reading Sections 1.2 and 2.1 of the Programming Environments manual.

It's not checking for restart here - userspace isn't supposed to have to.
It's probably checking for error.  Check for the bit of kernel code
that's supposed to back you up two instructions.

-- 
Daniel Jacobowitz
CodeSourcery
