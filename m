Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7041DE0CD
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 06:34:05 +1100 (EST)
Message-ID: <4762DA95.90000@freescale.com>
Date: Fri, 14 Dec 2007 13:33:41 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 4/4] Freescale enhanced Local Bus Controller FCM NAND
	support.
References: <20071214185624.GA10584@loki.buserror.net>
	<20071214192446.GA3355@localhost.localdomain>
In-Reply-To: <20071214192446.GA3355@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Fri, Dec 14, 2007 at 12:56:24PM -0600, Scott Wood wrote:
>> +#if 0
>> +#define ELBC_NAND_DEBUG_LVL 6
>> +#endif
>> +
>> +#ifdef ELBC_NAND_DEBUG_LVL
>> +static int fcm_debug_level = ELBC_NAND_DEBUG_LVL;
>> +#define FCM_DEBUG(n, args...)		\
>> +	do {					\
>> +		if (n <= fcm_debug_level)	\
>> +			pr_dbg(args);	\
>> +	} while(0)
>> +#else
>> +#define FCM_DEBUG(n, dev, args...) do { } while(0)
>> +#endif
> 
> Only 1, 2 and 5 debug levels are used. Maybe better use dev_dbg
> and dev_vdbg instead?

Yeah, probably...

> Btw, checkpatch result:
> total: 69 errors, 14 warnings, 1236 lines checked

Most of those are errors in checkpatch, wherein it fails to understand 
the difference between aligning with spaces (good) and indenting with 
spaces (bad).  Checkpatch spits out so many of those that other things 
get lost in the noise, so I don't usually bother to run it.

I also do not understand the allergy to C99 comments in the Linux 
community, though I'll change the few that slipped in by accident.

I'll fix the few legitimate ones.

> This isn't very friendly to the people going to look into.

You should have seen what it looked like before I touched it. :-P

> Maybe this desires its own header?

It can be factored out if anything else ever uses it.

-Scott
