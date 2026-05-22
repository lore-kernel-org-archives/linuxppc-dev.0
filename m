Return-Path: <linuxppc-dev+bounces-21390-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F34CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 12:15:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMPNy674vz2yHT;
	Fri, 22 May 2026 22:15:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779452114;
	cv=none; b=LY2q2KA7IqNPmHM78JwIwRItzKTcJ4cWDJW8Nw+iAk2mYw8PCuUFocJsOSjpFugSf5BiEGUM9LmzFax8w47yGEjif49i88eIahj6GIR2AmcG88zchokmmTn93BO4FP2diNK2X3l4aE8M/X/NxkHoobTS1I5wz/lg5Jr6yg0Lx1JDio/N2dU2WDBcXXaZ+HOBYMntcVifWHUda50kYrxWTkDEAORUaBGaGl5Tfcx6w8VBIKcQxn07N0ud0VKgtPpwfjq7wcUiVz1lJjOE3icwBqRYLrRDX9HbGnznHjXRabLMrI2utFKep23CR5X58LmB34uytiAwZmNe9XaSxQ3AHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779452114; c=relaxed/relaxed;
	bh=ptY1IlspQTpMQ6DhwpPWv/BlY7Z7SGGDn6x0AktbKSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kI4bTESQGmD3GypC2MvJQ8VKbMA+Yy7iS6y+meGYtNdhJK2VypHjp6e+qKkauTZeDjZY8RtYwbtiQhosXOpcr8ywDGIvkwv3zMAJnMORL6Wdq4AdZm0rINPG++XygQhz+Us9cDpsCu6dgZjKAMDSet6aUmUouTVOrR6XMgMJkCVJ6YvM3FeFlALCTDOQ348ayVBSqU188jPj5o/FnCURHUFXsK7hZw0Luadf07mRYRfAn98N3qb5S+76HQfx/Wc+Xfs2q58RHpLN6mAnfwYgRPfj+kUf3IzrOc9loMnYHwzRjHm4g8j/8A/YDZ6/a04OeZk2+975SwKGe1v2Rkbg6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s7uwSOTh; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8D/Une9L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EIHpDw5S; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/sk5BZ2J; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=s7uwSOTh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8D/Une9L;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EIHpDw5S;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/sk5BZ2J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 158824 seconds by postgrey-1.37 at boromir; Fri, 22 May 2026 22:15:08 AEST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMPNr6v4Vz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 22:15:08 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE22D6BC97;
	Fri, 22 May 2026 12:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779452099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ptY1IlspQTpMQ6DhwpPWv/BlY7Z7SGGDn6x0AktbKSI=;
	b=s7uwSOThtont8ctCoMaTl8NbQzDBohiFXKCSr/HvC/+bbgpmFeXxjgPtHREoaP3yzSRcjE
	dnBtnE4TkVXSy2mceL6ewAszEbl9EfppsknNWJHIHiXVUsXWdtdE6/0G0o5EFcEHiXPvq+
	Hz+QdJJvul62wQbLP8f10jdCRFjxBpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779452099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ptY1IlspQTpMQ6DhwpPWv/BlY7Z7SGGDn6x0AktbKSI=;
	b=8D/Une9LmgDGdy0IttGePqT651aAsFFqw8VslqF89AndnIQ/sNcscTpm0KzHmkUS9K3NTy
	SXIXzKXBRa6CMaBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EIHpDw5S;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/sk5BZ2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779452098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ptY1IlspQTpMQ6DhwpPWv/BlY7Z7SGGDn6x0AktbKSI=;
	b=EIHpDw5SSbfvjckHwKA/TRjiH1dJhEcE2l/rFum3c2/4qvaRgjHXBg0xGwUWUFv/9rdSYM
	V7jFEIz+3zPbnnwQJPWbLsq9z+WkC0Ed27vvy/dGIK+uART3DLlUs/jzvrh/yRh1mJSR/9
	RG5XBZDxKrGduDKnPA5VRNOOSMZINYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779452098;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ptY1IlspQTpMQ6DhwpPWv/BlY7Z7SGGDn6x0AktbKSI=;
	b=/sk5BZ2JTYnAWaYAlREzf0aZoneb4E6Zi0wUizoiPTQmk7LtEk2vFt4l8qy/kFkVJGNEpS
	MvB71mbMmFCSRvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A19E8593A8;
	Fri, 22 May 2026 12:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bo9eHsJIEGqpagAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 22 May 2026 12:14:58 +0000
Message-ID: <3ffcf348-94dd-449b-a672-450b45a4c7cc@suse.de>
Date: Fri, 22 May 2026 14:14:57 +0200
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
Subject: Re: [PATCH 1/4] fbdev: Wrap user-invoked calls to fb_set_var() in
 helper
To: Helge Deller <deller@gmx.de>, simona@ffwll.ch, airlied@gmail.com,
 lukas@wunner.de, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260520160744.130841-1-tzimmermann@suse.de>
 <20260520160744.130841-2-tzimmermann@suse.de>
 <0ce59eaf-1124-48c5-b812-c8e6b58e01d0@gmx.de>
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
In-Reply-To: <0ce59eaf-1124-48c5-b812-c8e6b58e01d0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE22D6BC97
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.com:url]
X-Rspamd-Action: no action

Hi

Am 20.05.26 um 20:51 schrieb Helge Deller:
> On 5/20/26 18:00, Thomas Zimmermann wrote:
>> Handle fbcon during display updates in fb_set_var_from_user(). Check
>> with fbcon if the mode change is possible, update hardware state and
>> finally update fbcon. Update all callers.
>>
>> Only the FBIOPUT_VSCREENINFO ioctl currently does all steps. Other
>> mode-changes callers in sysfs and driver code are missing fbcon-related
>> steps.
>>
>> With the new helper, ps3fb and sh_mobile_lcdcfb no longer maintain
>> fbcon state themselves.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/video/fbdev/core/fb_chrdev.c   |  6 +-----
>>   drivers/video/fbdev/core/fbcon.c       |  2 --
>>   drivers/video/fbdev/core/fbmem.c       | 13 +++++++++++++
>>   drivers/video/fbdev/core/fbsysfs.c     |  4 +---
>>   drivers/video/fbdev/ps3fb.c            |  5 +----
>>   drivers/video/fbdev/sh_mobile_lcdcfb.c |  5 +----
>>   include/linux/fb.h                     |  2 ++
>>   7 files changed, 19 insertions(+), 18 deletions(-)
>>
>> ...
>> diff --git a/include/linux/fb.h b/include/linux/fb.h
>> index 5178a33c752c..88680a7cabd5 100644
>> --- a/include/linux/fb.h
>> +++ b/include/linux/fb.h
>> @@ -533,6 +533,8 @@ extern int fb_set_var(struct fb_info *info, 
>> struct fb_var_screeninfo *var);
>>   extern int fb_pan_display(struct fb_info *info, struct 
>> fb_var_screeninfo *var);
>>   extern int fb_blank(struct fb_info *info, int blank);
>>   +int fb_set_var_from_user(struct fb_info *info, struct 
>> fb_var_screeninfo *var);
>> +
>
> "extern" int fb_set_var_from_user(...) ?

As Christophe ointed out, not having extern is correct. I think, if 
anything, we should remove the existing externs from the headers.

>
> Other than that the series is a nice cleanup!

Thanks. I'll send you an updated series with the #ifdef fix for patch 
3.  Sending just fixup patches can confuse the tracker bots and services 
(say patchwork), so I'd avoid that.

Best regards
Thomas


>
> Thanks!
> Helge

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



