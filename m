Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 45565688D1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 10:04:52 +1100 (EST)
Date: Fri, 16 Dec 2005 16:04:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20051216230450.GR3757@smtp.west.cox.net>
References: <20051104180605.GA3271@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051104180605.GA3271@logos.cnet>
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Required functions for relocating not part of relocate section
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Nov 04, 2005 at 04:06:05PM -0200, Marcelo Tosatti wrote:
> Hi Paul,
> 
> Recent 2.6-git (from Wednesday) tree fails to boot on 8xx due to:
>                                                                                                                                               
> BDI>i             
>     Target state      : debug mode
>     Debug entry cause : trace
>     Current PC        : 0x005ba8e8
> BDI>md 0x005ba8e8 
> 005ba8e8 : 00000000 00000000 00000000 00000000  ................
> 005ba8f8 : 00000000 00000000 00000000 00000000  ................
> 005ba908 : 00000000 00000000 00000000 00000000  ................
> 005ba918 : 00000000 00000000 00000000 00000000  ................
> 005ba928 : 00000000 00000000 00000000 00000000  ................
> ...
> BDI>go 
> - TARGET: stopped
> BDI>i 
>     Target state      : debug mode
>     Debug entry cause : software emulation exception
>     Current PC        : 0x005ba8e8
> 
> Problem is that flush_instruction_cache (and flush_data_cache)
> from boot/common/util.S are not being copied to the relocate section,
> even though the file contains the proper entry:

So while I don't know why, someone else noted this problem to me
recently, as hit on I believe the Walnut (405GP Eval), saying that
flush_instruction_cache worked prior to relocation, but failed
afterwards.  And if the function was put into the .data section, all was
well (_GLOBAL changed meaning 'recently' which changed this behavior).
No solution, but hopefully more hints..

-- 
Tom Rini
http://gate.crashing.org/~trini/
