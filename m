Return-Path: <dean@bong.com.au>
Received: from smtp.pnc.com.au (belinda.pnc.com.au [203.13.174.10])
	by ozlabs.org (Postfix) with SMTP id B9ECE2BF07
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 11:21:42 +1100 (EST)
Message-ID: <41CA0E0D.908@bong.com.au>
Date: Thu, 23 Dec 2004 11:15:09 +1100
From: Dean Hamstead <dean@bong.com.au>
MIME-Version: 1.0
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
References: <Pine.LNX.4.21.0412230130510.5692-100000@hal.pp.fishpool.fi>
In-Reply-To: <Pine.LNX.4.21.0412230130510.5692-100000@hal.pp.fishpool.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

the pmac driver has issues on my imac dv, it works but alas
it doesnt know what to do when plugging in headphones
not to mention lack of input sensors for my ibook (clamshell)

i realise though that if you cant get specs and no one
wants to tinker around stuff wont get implemented.
but if its in OSS...

*shrug*

ben (and others) do a great job though.

Dean

Martin-Éric Racine wrote:
> Nice to know that work is being done on the pmac ALSA driver. :)
> 
> However, I still cannot get ALSA to work at all on this iMac's Burgundy:  
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=306
> 
> The old OSS driver still works, so I know that the hardware is not at
> fault; this is clearly an ALSA driver problem.
> 
> Has anybody managed to get this to work on similar hardware?
> 
> 
> On Wed, 22 Dec 2004, Benjamin Herrenschmidt wrote:
> 
> 
>>This patch (which will be send upstream separately by the Alsa folks) fixes
>>an signed vs. unsigned char problem in Alsa which was the cause of the Oops
>>people were experiencing on ppc with OSS emulation and possibly other issues.
>>
>>Index: linux-work/sound/core/pcm_misc.c
>>===================================================================
>>--- linux-work.orig/sound/core/pcm_misc.c	2004-11-22 01:51:09.000000000 +0100
>>+++ linux-work/sound/core/pcm_misc.c	2004-12-22 19:11:26.297518336 +0100
>>@@ -26,10 +26,10 @@
>> #define SND_PCM_FORMAT_UNKNOWN (-1)
>> 
>> struct pcm_format_data {
>>-	char width;	/* bit width */
>>-	char phys;	/* physical bit width */
>>-	char le;	/* 0 = big-endian, 1 = little-endian, -1 = others */
>>-	char signd;	/* 0 = unsigned, 1 = signed, -1 = others */
>>+	signed char width;	/* bit width */
>>+	signed char phys;	/* physical bit width */
>>+	signed char le;		/* 0 = big-endian, 1 = little-endian, -1 = others */
>>+	signed char signd;	/* 0 = unsigned, 1 = signed, -1 = others */
>> 	unsigned char silence[8];	/* silence data to fill */
>> };
>> 
>>
>>
>>
>>
> 
> 
