Return-Path: <paubert@iram.es>
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9C5167BFB
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jul 2005 22:14:15 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 18 Jul 2005 14:14:04 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050718121404.GB27534@iram.es>
References: <20050715160115.GA22990@janus> <1121535588.14393.18.camel@gaston>
	<jeackmbped.fsf@sykes.suse.de> <1121538297.14393.20.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121538297.14393.20.camel@gaston>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: bug in arch/ppc/kernel/misc.S: __ashrdi3?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 17, 2005 at 04:24:57AM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2005-07-16 at 20:02 +0200, Andreas Schwab wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> > 
> > > On Fri, 2005-07-15 at 18:01 +0200, Frank van Maarseveen wrote:
> > >> I don't really grok the code but an operand seems to be missing and the
> > >> assembler makes something out of it I don't trust:
> > >> 
> > >> _GLOBAL(__ashrdi3)
> > >> 	...
> > >> 	rlwinm  r8,r7,0,32      # t3 = (count < 32) ? 32 : 0
> > >
> > > This is equivalent to r8 = r7 & 32. It will definitely not do what the
> > > comment says though. If (count < 64), however, it will do something
> > > like r8 = (r7 < 32) ? 0 : 32. Paul, maybe we should dbl check what's
> > > going in there ?
> > 
> > r7 is count + 32, and ((count + 32) & 32) is equivalent to the expression
> > above if count < 64.
> 
> Ok, with some context it makes more sense :)

Well, I wrote this code, to be fair I actually took most of these 
code sequences from the multi precision shift appendix found in
all good PPC instruction set books. The exception is __ashrdi3 
which I modified slightly to eliminate a conditional branch.

I tested it fairly exhaustively before submitting it. So the 
comments might be wrong (and they will definitely look wrong
without the correct context), but the code very likely gives 
the correct result. After all it has been used for quite some 
time now without any complaint. 

Now obviously the function only works for shift counts below 
64, since the C language specification clearly states that 
the result is undefined for shift counts equal or larger than 
the bit size of the operand (but I felt against rebooting the
machine for an operand outside the allowed range, although
a simple "twlgti count,63" might do it).

Maybe this last point should be clearly stated in a comment.

	Regards,
	Gabriel
