Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 5463E685E5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 18:10:55 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 19 Oct 2005 10:10:47 +0200
References: <200510141135.47186.david.jander@protonic.nl>
	<1129552672.3830.249.camel@baythorne.infradead.org>
In-Reply-To: <1129552672.3830.249.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510191010.47799.david.jander@protonic.nl>
Cc: linux-mtd@lists.infradead.org, linuxppc-embedded@ozlabs.org
Subject: Re: jffs2 robustness against powerfailure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 17 October 2005 14:37, David Woodhouse wrote:
> On Fri, 2005-10-14 at 11:35 +0200, David Jander wrote:
> > We have a custom embedded linux board, based on a MPC852T processor,
> > running 2.4.25 kernel from denx. Jffs2 has certain backported patches
> > after cvs from 03/2005.
>
> That sounds like a recipe for pain. March 2005 wasn't a good time to
> take a snapshot from CVS; that just happens to be the time that we
> stopped bothering to make it build in obsolete kernels.

That's why I posted to the linuxppc-embedded list, because I know there are 
quite some people using the same version (denx CVS kernel), and might have 
had issues of this kind also, although I mostly hear that it seems pretty 
stable and doesn't give problems.

> If you want _stable_ JFFS2 code, you should use the code which is in the
> 2.4.31 kernel, or use the code which is in the 2.6 kernel (perhaps
> updated from current CVS).

2.6 is not an option yet for mpc8xx architecture, so I'll have to stick with 
either what I have now or 2.4.31, but I fear the tradeoff of using vanilla 
2.4.31 jffs2 will be much slower fs, prohibitively long mount-times, etc... 
am I right?

>[...]
> Please could you reproduce on a sane kernel and show the output of the
> checkfs program during your test just before the power down, and also if
> possible take an image of the contents of the flash _before_ mounting it
> again after the power cycle. I'd like to see precisely the log nodes
> which were present on the flash. If it's difficult to take a snapshot
> before remounting, then running with CONFIG_JFFS2_FS_DEBUG=1 and
> capturing all the KERN_DEBUG output via a serial console would suffice.

I am still busy doing experiments, please have a little patience.
Until now I have turned on debug info in the same kernel as before, and get 
literally tons of log info. My monitor script had a bug, so the board was 
reset a little to soon in several occasions (shouldn't harm, should it), so 
now I have an image of jffs2 which on boot of the system produces a BUG() in 
gc.c line 139. This is not what I am looking for right now, and I still have 
to discard any possibilities that this could have happened due to other 
problems (RAM issues, etc). Once I finish sorting this out, I'd be glad to 
send you a few megabytes of debug output along with a "broken" jffs2 image if 
you like. Actually I'd be very grateful if you could take some time to look 
at it and give me your opinion, because I am still slightly clueless about 
jffs2.

Greetings,

-- 
David Jander
