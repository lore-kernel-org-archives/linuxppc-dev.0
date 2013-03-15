Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76D932C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 23:57:01 +1100 (EST)
Message-ID: <1363360926.8656.5.camel@jlt4.sipsolutions.net>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
From: Johannes Berg <johannes@sipsolutions.net>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <1363279961.28440.4@snotra>
References: <1363232178-29938-1-git-send-email-dongsheng.wang@freescale.com>
 <1363250273.4833.1.camel@jlt4.sipsolutions.net> <1363279961.28440.4@snotra>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Mar 2013 16:22:06 +0100
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-03-14 at 11:52 -0500, Scott Wood wrote:
> > > +#ifdef CONFIG_PPC_BOOK3S_64
> > >  	/* can't use RESTORE_SPECIAL(MSR) */
> > >  	ld	r0, SL_MSR(r11)
> > >  	mtmsrd	r0, 0
> > 
> > Unfortunately, I forgot the reason for this comment, and didn't put a
> > better one (almost 6 years ago!!)

> If it's because book3s needs mtmsrd instead of mtmsr, that doesn't  
> apply to booke.

Indeed, looking at the code again now that seems pretty obvious.

Looking at the patch again, I'd be a little concerned about the lack of
cache flushing, seems a bit odd but I'm sure you know what you're doing
(and I don't know book3e at all, and hardly remember book3s -- or even
that name...) :-)

johannes
