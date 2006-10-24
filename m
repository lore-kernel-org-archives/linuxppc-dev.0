Return-Path: <andrea.galbusera@teamware.it>
Received: from smtp4.aruba.it (smtpd1.aruba.it [62.149.128.206])
	by ozlabs.org (Postfix) with SMTP id 5BC1E679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 20:14:33 +1000 (EST)
Subject: Re: Re: JFFS2 on Lite5200
From: Andrea Galbusera <andrea.galbusera@teamware.it>
To: avolkov@varma-el.com, dwmw2@infradead.org, dedekind@infradead.org
Content-Type: text/plain
Date: Tue, 24 Oct 2006 12:15:05 +0200
Message-Id: <1161684905.4556.56.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-mtd@lists.infradead.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!
First let me thank you all for your quick and kind help... I was out for
a few days so I take the time to reply only now.

On Tue, 2006-10-17 at 17:20 +0400, Andrey Volkov wrote:
> OMG, again same question,

Sorry Andrey for my too superficial search in the ml archive... Anyway
it seems this issue is somehow still open. ;-)

At moment I'm going with Andrey's patch (it works!) but I'd like to
understand better and maybe to help solving the problem. I see that
patching include/asm-ppc/io.h may not be the right way...
I'm pretty new to kernel hacking/developing so I got confused by your
discussion about the right place to patch things.

So a few questions arise. Do we need to change the physmap driver? Is
this somehow dependent on the target platform. If so can we put some
changes for Lite5200 only?

On Tue, 2006-10-17 at 17:54 +0400, Andrey Volkov wrote:
> There are two modes of operation for JFFS2 scan. Either it can use the
> MTD device's read() function to read from the flash into memory and
> scan
> from there, or -- IF the flash can be accessed as if it were normal
> memory -- it can use the point() method and skip the read() call by
> using a pointer directly into the flash.
> 
> In your case, the flash cannot be accessed directly as if it were
> normal
> memory. So your map driver probably shouldn't be allowing point() to
> succeed.
> 
> Having said that, I'm not entirely sure we have the code set up so
> that
> 'simple' map drivers _can_ prevent point(). We may need to fix that.

Looking at David's explanation about mapping driver... What does exacly
mean preventing point()/unpoint() to succeed? As a simple MTD _user_
(never digged inside the code) I don't see any hook to these functions
in drivers/mtd/maps/physmap.c so no easy way to set them to NULL.


-- 
Andrea Galbusera <andrea.galbusera@teamware.it>
