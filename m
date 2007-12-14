Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 639C6DE116
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 06:56:30 +1100 (EST)
Date: Fri, 14 Dec 2007 22:59:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 4/4] Freescale enhanced Local Bus Controller FCM NAND
	support.
Message-ID: <20071214195917.GA18616@localhost.localdomain>
References: <20071214185624.GA10584@loki.buserror.net>
	<20071214192446.GA3355@localhost.localdomain>
	<4762DA95.90000@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4762DA95.90000@freescale.com>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 14, 2007 at 01:33:41PM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
> >On Fri, Dec 14, 2007 at 12:56:24PM -0600, Scott Wood wrote:
> >>+#if 0
> >>+#define ELBC_NAND_DEBUG_LVL 6
> >>+#endif
> >>+
> >>+#ifdef ELBC_NAND_DEBUG_LVL
> >>+static int fcm_debug_level = ELBC_NAND_DEBUG_LVL;
> >>+#define FCM_DEBUG(n, args...)		\
> >>+	do {					\
> >>+		if (n <= fcm_debug_level)	\
> >>+			pr_dbg(args);	\
> >>+	} while(0)
> >>+#else
> >>+#define FCM_DEBUG(n, dev, args...) do { } while(0)
> >>+#endif
> >
> >Only 1, 2 and 5 debug levels are used. Maybe better use dev_dbg
> >and dev_vdbg instead?
> 
> Yeah, probably...
> 
> >Btw, checkpatch result:
> >total: 69 errors, 14 warnings, 1236 lines checked
> 
> Most of those are errors in checkpatch, wherein it fails to understand 
> the difference between aligning with spaces (good) and indenting with 
> spaces (bad).  Checkpatch spits out so many of those that other things 
> get lost in the noise, so I don't usually bother to run it.
> 
> I also do not understand the allergy to C99 comments in the Linux 
> community, though I'll change the few that slipped in by accident.
> 
> I'll fix the few legitimate ones.
> 
> >This isn't very friendly to the people going to look into.
> 
> You should have seen what it looked like before I touched it. :-P

I have seen that. ;-) Its previous name was fsl_fcm, and I shuddered
from it, honestly. I must admit that you've done great work on this!

> >Maybe this desires its own header?
> 
> It can be factored out if anything else ever uses it.

It's just confusing to parse lbc-specific and nand-specific code
placed in the same file.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
