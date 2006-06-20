Return-Path: <trueskew@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id 06EA367B14
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Jun 2006 10:49:00 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id z6so1448510nzd
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Jun 2006 17:48:59 -0700 (PDT)
From: "Trueskew" <trueskew@gmail.com>
To: "'John Rigby'" <jcrigby@gmail.com>
Subject: RE: Using bestcomm in an external module (MPC5200B to be exact)
Date: Mon, 19 Jun 2006 17:48:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4b73d43f0606191432n332a23d0se0f93e2204e47dd9@mail.gmail.com>
Message-ID: <449745fa.427398dd.5764.ffffdf84@mx.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John, would you happen to know where I'd find the latest?  The LTIB I have
is using 
BestComm API v2.2 20041209.

Regards,
Sal

-----Original Message-----
From: John Rigby [mailto:jcrigby@gmail.com] 
Sent: Monday, June 19, 2006 2:33 PM
To: Trueskew
Cc: Andrey Volkov; linuxppc-embedded@ozlabs.org
Subject: Re: Using bestcomm in an external module (MPC5200B to be exact)

The next LTIB bsp for 5200b will use the Sylvain's bestcomm api.

On 6/19/06, Trueskew <trueskew@gmail.com> wrote:
> Hi Andrey,
>
> Thanks for the reply.  I did notice that a few weeks ago and was 
> waiting for the patch state to be changed from "New" to "Accepted".  
> Can you give me more details on how you found out bestcomm won't be 
> included in 2.6?  The latest downloadable LTIB from Freescale for the 
> Lite5200b includes bestcomm in several places, and the mpc52xx fec 
> driver uses it, along with the ATA driver that Sylvain provided a patch
for.
>
> As for http://www.246tNt.com/mpc52xx/, it's been coming up "page not
found"
> for me for those same few weeks when I've tried it off an on, and 
> www.246tNt.com just has a Welcome line in it.
>
> Sal
>
> -----Original Message-----
> From: Andrey Volkov [mailto:avolkov@varma-el.com]
> Sent: Monday, June 19, 2006 6:15 AM
> To: Trueskew
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Using bestcomm in an external module (MPC5200B to be 
> exact)
>
> Trueskew wrote:
> > I should've let you all know, I'm more of a 2.4 person than a 2.6
person.
> > So I read what I could on 2.6 difference with 2.4, and it looked 
> > like my easiest choice was to modify the bestcomm code to export a 
> > couple tables and its API functions.  I found that kallsyms has 
> > almost all of the functions I needed to resolve (with 'T' next to 
> > them), but they were
> still not working.
> > I added EXPORT_MODULE(TaskBDReset) and similar declarations in the 
> > bestcomm api code, but that still didn't do the trick for me.  So 
> > what is
> the trick?
> > I think I'm on the right track, I can insmod a module that my driver 
> > needs, see kallsyms get updated, and access the functions directly 
> > in my driver.  I hope I'm close to doing something similar with the 
> > bestcomm functions, can anyone offer me some advice on what else I 
> > need to
> do?
> >
> > Thanks.
> Please, check Sylvain's patchset (http://www.246tNt.com/mpc52xx/) 
> _before_ you will do anithing. If be more shortly - Freescale's 
> BestcommAPI _deprecated_ and will _not_ included to 2.6.xxx.
>
> --
> Regards
> Andrey Volkov
>
>
> >
> > ________________________________
> >
> > From: Trueskew [mailto:trueskew@gmail.com]
> > Sent: Friday, June 16, 2006 9:47 PM
> > To: 'linuxppc-embedded@ozlabs.org'
> > Subject: Using bestcomm in an external module (MPC5200B to be exact)
> >
> >
> > I'm writing a driver for a TI codec attached to the MPC5200B PSC3 
> > codec lines on a Lite5200b.  It's an external module, and I'd like 
> > to use Bestcomm with it.  I've already tried a bunch of horrible 
> > things to
> get it to work.
> > I could say it's close, but by close I mean the FEC still runs, my 
> > stuff doesn't.
> >
> > 1. Can the Bestcomm I/F be used by an external module, or is the 
> > module required to be built in if built-in drivers use Bestcomm?
> > TasksInitAPI (no so bad) and TasksLoadImage (yeah, bad) aren't 
> > really supposed to be called more than once from what I've read, and 
> > the kernel loads them for ethernet and ATA (no disk in my system if 
> > that
> matters).
> >
> > 2. If it can be used by an external module, how would I do it?  I've 
> > tried compiling the source into my module and replicating the 
> > initialization the kernel does in addition to my own stuff.  It's 
> > not too bad, though I don't get any interrupts yet.
> >
> > The LTIB from Freescale includes AIC23 and AC97 drivers that use
Bestcomm.
> > I built my kernel with them set as modules, and they had the same 
> > unresolved problems that my driver has on insmod, so I'm pessimistic.
> > If someone could put me out of my misery one way or another, I'd
> appreciate it.
> >
> > Thanks.
> > Sal
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
