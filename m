Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 3E858DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:59:54 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1228963uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 15:59:52 -0700 (PDT)
Date: Thu, 1 May 2008 02:59:51 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 4/6] [POWERPC] QE: implement support for the GPIO LIB
	API
Message-ID: <20080430225951.GA10361@zarina>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190045.GD21203@polina.dev.rtsoft.ru>
	<20080430193040.GA9239@polina.dev.rtsoft.ru>
	<4818CB8B.9010106@freescale.com> <20080430224726.GA5529@zarina>
	<4818F7C2.2030408@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4818F7C2.2030408@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2008 at 05:50:42PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > Per Grant Likely's comments, "fsl,qe-pario-bank" considered as a made up
> > stuff. MPC8323 is the first QE chip, so every next QE chips should be
> > compatible.
> 
> Ok.
> 
> >> Return value should be "u32", not "int".
> > 
> > gpio.h disagree
> > 
> > $ cat include/asm-generic/gpio.h  | grep \*get
> >         int                     (*get)(struct gpio_chip *chip,
> > 
> 
> In that case, perhaps you should return this:
> 
> 	return in_be32(&regs->cpdata) & pin_mask ? 1 : 0;

What is the problem with returning (int)(u32 & u32) value?

You've asked to remove "!!" stuff and now purposing exactly the
same... :-?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
