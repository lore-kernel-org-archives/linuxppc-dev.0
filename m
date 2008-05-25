Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-76-245-85-235.dsl.pltn13.sbcglobal.net
	[76.245.85.235]) by ozlabs.org (Postfix) with ESMTP id 94963DDFB9
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 12:44:21 +1000 (EST)
Date: Sun, 25 May 2008 14:31:25 -0700
From: Brad Boyer <flar@allandria.com>
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: questions
Message-ID: <20080525213125.GB24479@cynthia.pants.nu>
References: <483A051D.1010108@hypersurf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <483A051D.1010108@hypersurf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 25, 2008 at 05:32:29PM -0700, Kevin Diggs wrote:
> Hi,
> 
> 	In idle_6xx.S one finds instructions like:
> 
> 	lis   r4,powersave_nap@ha
> 	lwz   r4,powersave_nap@l(r4)
> 
> Can someone explain what this is doing? Presumably the first is loading 
> an address and the second a value. What do the '@ha' and '@l' do?

The @ha and @l are modifiers to turn a 32 bit constant into a 16 bit
constant that would be useful in particular contexts. The @l takes
the low halfword, while the @ha takes the high halfword and modifies
it so that if you add in the low halfword you get the full 32 bit
value. There are other modifiers for other uses. You need these in
ppc assembly because there isn't any way to directly use a 32 bit
immediate value. In this particular case, it's taking advantage of
the indirect addressing modes to load a word from a constant 32 bit
address. It loads the high halfword of the pointer into r4 with the
lis instruction, then the low halfword is added during the effective
address calculation. The value at that constant address is loaded
into r4. Normally a 32 bit constant gets loaded with lis and addi,
but this is a way to avoid the extra instruction because it intends
to use the result as a pointer. The indirect addressing gives you
a free addi as long as you don't need to save the result.

> 	Also, is there any performance difference between:
> 
> 	lbz rD,d(rA)
> 	lhz rD,d(rA)
> 	lwz rD,d(rA)

Normally you would use the one you need. I'd be surprised if there was
any difference in performance, but I also can't think of any reason
you would choose one over another for performance reasons even if there
was a difference.

> 	While I'm wasting your time, I picked up an ADB infrared wireless 
> keyboard. I think it works. But not under Linux. Should it?

If it acts like a normal ADB keyboard, it should work. Does it need a
special driver with the MacOS? If so, then it would probably need a
custom driver in Linux as well.

	Brad Boyer
	flar@allandria.com
