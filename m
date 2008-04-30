Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 7C34BDDF27
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 09:24:34 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1232113uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 16:24:32 -0700 (PDT)
Date: Thu, 1 May 2008 03:24:30 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 4/6] [POWERPC] QE: implement support for the GPIO
	LIB API
Message-ID: <20080430232430.GA14233@zarina>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190045.GD21203@polina.dev.rtsoft.ru>
	<20080430193040.GA9239@polina.dev.rtsoft.ru>
	<4818CB8B.9010106@freescale.com> <20080430224726.GA5529@zarina>
	<4818F7C2.2030408@freescale.com> <20080430225951.GA10361@zarina>
	<4818FAD1.8020808@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4818FAD1.8020808@freescale.com>
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

On Wed, Apr 30, 2008 at 06:03:45PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > What is the problem with returning (int)(u32 & u32) value?
> 
> Technically, a signed int is smaller than an unsigned int, so a value of
> 0x80000000 won't fit in an 'int'.

They're of the same size. And because of that, we'll not lose
information, so (int)(0x80000000U) still != 0, it is just negative.

> > You've asked to remove "!!" stuff and now purposing exactly the
> > same... :-?
> 
> The !! stuff was because the function was returning a boolean value, so non-zero
> == TRUE.  I don't think the return value from 'get' is a technically a boolean,
> so I'm assuming that the spec says the return value should be 0 or 1, to reflect
> the value of that GPIO pin.

No. The spec indeed says that 0 for low, non-0 for high.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
