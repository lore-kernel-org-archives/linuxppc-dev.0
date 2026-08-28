Return-Path: <linuxppc-dev+bounces-26161-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8520C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:58:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWSNS0Zw7z2xlw;
	Fri, 28 Aug 2026 15:58:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787896679;
	cv=none; b=e3Wt9GJbJGVajkizYqnW8hUFpvdXpxFBEeKJPiiu/pOV9EdV9Ze+nIu9s/zp5OC28q+sO4z01GV/yHmjanfqJxBS9QYIaRZrnNEty5ra/+ZYuEz2bdMsDZ5SsPnyRPk4XzBBLaH1cE/8NgCS89Qaeyv35ji3a3u4tqEAYJT9sCVLpl2bM/ypzbBRKdyv08GCIfZ/NUPMoLx3X/qdXJLg6iL2SptuNAYwWGlbhfNQJ6CCovZNt7C8kZ8SKvzdbfYn7Iui7YNOWraWiCe7dB1GOW8dia3xMelQ5GMmDm3gSJqJaqxpsE2GubzSLnG/nJGJ9+2JVCDplbwKMhOtB3KtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787896679; c=relaxed/relaxed;
	bh=gOzJQA78G5vOr3DmIWZ3YoMpy/bFvw5rRv962o8idC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovpWMwIyX9we3gTBA+fklnL7iUm1xvXtk4LzvVgeDB5lOnX/uT14YMT+3CjhRnSoxoU9iswX5v9WSojLPgQKuoh7k28f2QgdmPWmeaCbjrSggvIFj/c+L70jDwyjc55omhZdk9LqTpZet9OSurhcAtSu3EgbTHb+9tg3342+UdPkcXGg7mtLpx/W8opwIJwOOGRKGhX6Ox19PL054wC2QqqQn0JQn7dBsVQ4SeZGR89yfCKc3m9g+9PUBSR7TrY4/g0FozwqaS+PIKvxxKNNLlONoTvnKmXTafYZGQzJWxPAmBHDHOT9t/QxVJnh2P9s+r75ALeMv6cneH88jQsQMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWSNQ4C51z2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 15:57:58 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 312781F7CB;
	Fri, 28 Aug 2026 05:57:53 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D94EA1352D;
	Fri, 28 Aug 2026 05:57:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XWWzM2AjkWqAKgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 28 Aug 2026 05:57:52 +0000
Message-ID: <a2d102b6-033d-49c9-96a6-a9edda26b4bd@suse.de>
Date: Fri, 28 Aug 2026 07:57:52 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/mgag200: Fix big-endian support
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: rene@exactco.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <1fe9c172-c12c-4827-b9a5-2870c45e67af@suse.de>
 <A1B9BBC7-0CBA-45DC-8DA1-EEC6776CDA62@xenosoft.de>
 <4ba35195-5421-4c52-bbe5-ed88e15e394d@suse.de>
 <8ff12e31-2677-c554-cc3d-1bade8138876@xenosoft.de>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <8ff12e31-2677-c554-cc3d-1bade8138876@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 312781F7CB
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

Hi

Am 27.08.26 um 18:38 schrieb Christian Zigotzky:
> On 27/08/26 08:36, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 26.08.26 um 19:30 schrieb Christian Zigotzky:
>>> On 26 August 2026 at 05:23 pm, Thomas Zimmermann 
>>> <tzimmermann@suse.de> wrote:
>>>
>>> ﻿Hi
>>>
>>> Could be that we have to enable access to the ROM first. That's why 
>>> it returns only 0xffff. Does the card display output when you switch 
>>> on the computer?
>>>
>>> Best regards
>>> Thomas
>>>
>>> - - -
>>>
>>> Hello Thomas,
>>>
>>> No, the card doesn’t display output when I switch on the computer.
>>
>> Attached you'll find another patch that also enables ROM access in 
>> the PCI config options.  I took the code out of the old matroxfb 
>> driver without further testing. Please try and report back on the 
>> results.
>>
>> Best regards
>> Thomas
>>
>
> Hello Thomas,
>
> Thank you for your effort to solve the problem. Unfortunately, your 
> new patch doesn't solve the problem either. The error outputs are the 
> same as before.

Oh well. I assume it's a ROM for x86?   I guess the PPC firmware doesn't 
POST the graphics card, so the driver has to.  The power-up logic is 
given in Sec 4.3.3 of the MGA200 spec.  But TBH I won't have the time to 
work on it.  At best, I can help a bit if someone wants to address the 
problem.

Best regards
Thomas

>
> Cheers,
> Christian
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)



