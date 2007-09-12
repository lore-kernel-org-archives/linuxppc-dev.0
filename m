Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] powerpc: add new required termio functions 
In-reply-to: <alpine.LFD.0.999.0709111915350.16478@woody.linux-foundation.org>
References: <8018.1189562679@neuling.org>
	<alpine.LFD.0.999.0709111915350.16478@woody.linux-foundation.org>
Date: Wed, 12 Sep 2007 12:34:08 +1000
Message-ID: <10146.1189564448@neuling.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Cox <alan@redhat.com>, akpm@linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, 12 Sep 2007, Michael Neuling wrote:
> >
> > The "tty: termios locking functions break with new termios type" patch
> > (f629307c857c030d5a3dd777fee37c8bb395e171) breaks the powerpc compile.
> 
> Really?
> 
> It shouldn't. The use of kernel_termios_to_user_termios_1() is conditional 
> on the architecture having a define for TCGETS2, and I think they match 
> up. I see:
> 
> 	[torvalds@woody linux]$ git grep -l kernel_termios_to_user_termios_1 in
clude | wc -l
> 	10
> 	[torvalds@woody linux]$ git grep -l TCGETS2 include | wc -l
> 	10
> 
> and in neither case is ppc in that list of architecures.
> 
> So maybe you just read the patch without actually testing whether it 
> actually broke powerpc?

Not, I actually compiled it.

> Or is something subtler going on?

Looks like those new calls are not protected by the TCGETS2 define.
Adding those ifdefs seems like the correct fix.  

Mikey
