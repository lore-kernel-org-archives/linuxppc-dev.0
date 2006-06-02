Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E92D67B2E
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jun 2006 00:41:19 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] [RFC 3/8] snd-aoa: add soundbus
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115846.852128000@sipsolutions.net>
	<s5hu0734qay.wl%tiwai@suse.de>
	<1149257225.11092.22.camel@johannes.berg>
	<s5hslmn4p00.wl%tiwai@suse.de>
Date: Fri, 02 Jun 2006 16:41:14 +0200
In-Reply-To: <s5hslmn4p00.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
	02 Jun 2006 16:21:35 +0200")
Message-ID: <jeu073aad1.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Takashi Iwai <tiwai@suse.de> writes:

> At Fri, 02 Jun 2006 16:07:05 +0200,
> Johannes Berg wrote:
>> 
>> On Fri, 2006-06-02 at 15:53 +0200, Takashi Iwai wrote:
>> > > +	if (strlen(sdev->modalias)) {
>> > > +		length = snprintf (buf, 34, "%s\n", sdev->modalias);
>> > 
>> > sizeof(sdev->modalias) + 2?  But still strange if modalias has no
>> > nul-end.
>> 
>> Hm, how would I handle that if modalias has no nul?
>
> Well, I'm not sure whether modalias is always nul-terminated.

If modalias is not nul-terminated then strlen will already fail.

> Otherwise (if not nul-terminated), I'd implement like:
>
> 	strlcpy(buf, sdev->modalias, sizeof(sdev->modalias) + 1);
> 	strcpy(buf, "\n");

strcat?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
