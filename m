Return-Path: <linuxppc-dev+bounces-26092-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45B4C61DC2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:07:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVJgc06Hqz2y32;
	Wed, 26 Aug 2026 19:07:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787735227;
	cv=none; b=lSeFRm5EpWK92TNA/RcOygNNgnyPzSzg6TWimUN6T6lDIeMGTwZb0ZF61B/xWT7KjhCVDmebYvRM4pRya9qLKoenM23tcpAEUZ1y/h0Vx8Z74O17AsuM/XSj5OCpIOpGE98G6uepScNfl18xZAUos9a3y3FHjv5P2dBaExzQsZdbSljvzr5NRFjmqdYl6pJygTxaGenB42gFbPtavs/MLZ/G8CH4E6xP9Mtiaxri6OKR5DkOtGfi72XuMC55EMHY5lYOdiRQYq5h4ajYGlJ9PzTAbezwg+Sty2cArm2wzIzvvTG+S+J9lH5lbo8DPGOUJGFUZxobttKouwUhGfFvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787735227; c=relaxed/relaxed;
	bh=AFDAxEEcSBnP3htNJlaxx4eHI2vwNOSg2gl3t20uXgQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=HyH9BUwIvxFbVXM9DOwYwIjDJ7JVMdd6nCRfDP+vSDyClhQp3/39mdgf3HzEfVVCvi4+M5cURwkVR2gux2ZutOPK8jiKSDUYLiQhNLYoUCOYy4WQ3ROMH8r9EKFtw4+WOMz/LxyoEm7+PI42NFGbn6WrgiVnefWqrSTBVCSSWNOOpIPZSyjqMQxbd4MfWEeds3NpU4zLmt3ypb6BdNTsa5NoT2jOZ2vTZOEvH1zZru89A7Wj66EmHhPqzg0NHH7x38jVUNYdbTyP8ThdUAXjMJcaeNCZ6k5IvGGS/JKMtX4oHLnmG6NCzkUhq6hd8zrsNH3ELpkIWK+ay690WYoI+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=F7Zi16mq; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WOmsEN1Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MPXN/heY; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qOjaHTzN; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=F7Zi16mq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WOmsEN1Y;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MPXN/heY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qOjaHTzN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVJgZ3BLWz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 19:07:06 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B02DA1F809;
	Wed, 26 Aug 2026 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787735218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AFDAxEEcSBnP3htNJlaxx4eHI2vwNOSg2gl3t20uXgQ=;
	b=F7Zi16mqDjsrAfgcDxIV3uMs0sIo/tkc2f4Bna3QtBHpbM3DgZx1ZUY31ILJQ8DlvNxq8H
	SEAa1ioX4RiSnirPz/TgopaI0z+z4lHV5aJX7B1hkvCjkQ6ZpOM4bZNaWHdxHx1fVUg5BV
	aKwGH30BZf5aDijWtra2hQF34l2rHfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787735218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AFDAxEEcSBnP3htNJlaxx4eHI2vwNOSg2gl3t20uXgQ=;
	b=WOmsEN1YAJlVqBU6IzSv0HOOi35polXxA25pFo30UzsxpTj+w6ljYCInOBrFzvHdhENRcH
	S6CG6gwsK2noHtAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787735214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AFDAxEEcSBnP3htNJlaxx4eHI2vwNOSg2gl3t20uXgQ=;
	b=MPXN/heYm8pgqnXLjQm/ZqINVqnAPBJPj1EqSNoeB7WYCKnK2WvfqWBRlYg18kSn7aglRN
	858YbhDNpHsXsLbD8TjnigO7Vx9fLBuYpCMJOU2t/rtvOWWepPVbQwGLuGt5q4U0D7HwaC
	wKFl8O9v945S2egk4nR8Zj79L13h43k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787735214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AFDAxEEcSBnP3htNJlaxx4eHI2vwNOSg2gl3t20uXgQ=;
	b=qOjaHTzN+0U7OBYti3WnNuhRxHAE1A9uDhtunB79Xogo4OGdy609NRM7KJOdRFcYWPFmD1
	GKLxHb6Bq+DhOZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DA9C13533;
	Wed, 26 Aug 2026 09:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2zNFHa6sjmrHWgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Aug 2026 09:06:54 +0000
Content-Type: multipart/mixed; boundary="------------dfgPoO6LY1IoWYyn4ox8ymBV"
Message-ID: <6c265d1e-c301-4095-83e2-0e669222469a@suse.de>
Date: Wed, 26 Aug 2026 11:06:54 +0200
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
To: Christian Zigotzky <chzigotzky@xenosoft.de>, rene@exactco.de
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <4ACA9FCA-683C-44D0-B31F-CE70C40070BB@xenosoft.de>
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
In-Reply-To: <4ACA9FCA-683C-44D0-B31F-CE70C40070BB@xenosoft.de>
X-Spamd-Result: default: False [-3.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xtra.co.nz,yahoo.com.au];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,xtra.co.nz,yahoo.com.au,gmail.com,xenosoft.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	HAS_ATTACHMENT(0.00)[]

This is a multi-part message in MIME format.
--------------dfgPoO6LY1IoWYyn4ox8ymBV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Am 02.08.26 um 20:06 schrieb Christian Zigotzky:
> Hello René,
>
> Many thanks for your patch. [1]
>
> I have bought the PCI graphics card Matrox G200 G2+/QUADP-PL/7 32MB with 4x DVI. It is an AGP card connected via PCI.
>
> We use the new DRM driver MGAG200 since the kernel 7.2.0-rc4 and the old DRM legacy driver for Matrox g200/g400 graphics cards since the stable long-term kernel 5.10.260.
>
> I tested it with the RC5 of kernel 7.2 in my PowerPC machine (e5500) today. Unfortunately, the DRM driver mgag200 can't read the PCI ROM. Maybe only an x86 ROM?
>
> xrandr detects the ports but reports that they are not connected, even though the cables are plugged in.
>
> I also tested it with the stable long-term kernel 5.10.261 with the old legacy DRM drivers for Matrox graphics cards.
> I installed the Xorg MGA server xf86-video-mga-2.0.0_3 for the old legacy DRM driver but unfortunately I get only a black screen.
>
> Is it possible to use this card with PPC Linux?

Attached is the patch I promised.  Please apply it and test it on your 
machine. Does it make the card work?

Best regards
Thomas

>
> More information:
>
> lspci -vvv
>
> 0001:05:00.0 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200 AGP (rev 03) (prog-if 00 [VGA controller])
> 	Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
> 	Interrupt: pin A routed to IRQ 18
> 	Region 0: Memory at c20000000 (32-bit, prefetchable) [size=16M]
> 	Region 1: Memory at c21000000 (32-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at c21800000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at c21010000 [disabled] [size=64K]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [f0] AGP version 1.0
> 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
> 	Kernel driver in use: mgag200
>
> 0001:05:04.0 Display controller: Matrox Electronics Systems Ltd. MGA G200 AGP (rev 03)
> 	Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
> 	Interrupt: pin A routed to IRQ 18
> 	Region 0: Memory at c22000000 (32-bit, prefetchable) [size=16M]
> 	Region 1: Memory at c23000000 (32-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at c23800000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at c21020000 [disabled] [size=64K]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [f0] AGP version 1.0
> 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
> 	Kernel driver in use: mgag200
>
> 0001:05:08.0 Display controller: Matrox Electronics Systems Ltd. MGA G200 AGP (rev 03)
> 	Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
> 	Interrupt: pin A routed to IRQ 18
> 	Region 0: Memory at c24000000 (32-bit, prefetchable) [size=16M]
> 	Region 1: Memory at c25000000 (32-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at c25800000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at c21030000 [disabled] [size=64K]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [f0] AGP version 1.0
> 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
> 	Kernel driver in use: mgag200
>
> 0001:05:0c.0 Display controller: Matrox Electronics Systems Ltd. MGA G200 AGP (rev 03)
> 	Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
> 	Interrupt: pin A routed to IRQ 18
> 	Region 0: Memory at c26000000 (32-bit, prefetchable) [size=16M]
> 	Region 1: Memory at c27000000 (32-bit, non-prefetchable) [size=16K]
> 	Region 2: Memory at c27800000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at c21040000 [disabled] [size=64K]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [f0] AGP version 1.0
> 		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
> 		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
> 	Kernel driver in use: mgag200
>
>
> dmesg | grep -i mga
>
> [    2.302206] [drm] Initialized mgag200 1.0.0 for 0001:05:00.0 on minor 1
> [    2.303761] mgag200 0001:05:00.0: [drm] Cannot find any crtc or sizes
> [    2.304697] mgag200 0001:05:04.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
> [    2.305792] [drm] Initialized mgag200 1.0.0 for 0001:05:04.0 on minor 2
> [    2.308281] mgag200 0001:05:04.0: [drm] Cannot find any crtc or sizes
> [    2.308802] mgag200 0001:05:08.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
> [    2.309319] [drm] Initialized mgag200 1.0.0 for 0001:05:08.0 on minor 3
> [    2.309785] mgag200 0001:05:00.0: [drm] Cannot find any crtc or sizes
> [    2.310900] mgag200 0001:05:08.0: [drm] Cannot find any crtc or sizes
> [    2.311895] mgag200 0001:05:0c.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
> [    2.312633] [drm] Initialized mgag200 1.0.0 for 0001:05:0c.0 on minor 4
> [    2.312844] mgag200 0001:05:04.0: [drm] Cannot find any crtc or sizes
> [    2.315512] mgag200 0001:05:0c.0: [drm] Cannot find any crtc or sizes
> [    2.317178] mgag200 0001:05:08.0: [drm] Cannot find any crtc or sizes
> [    2.323318] mgag200 0001:05:0c.0: [drm] Cannot find any crtc or sizes
>
> xrandr
>
> …
>
> VGA-4-4 disconnected (normal left inverted right x axis y axis)
> VGA-3-3 disconnected (normal left inverted right x axis y axis)
> VGA-2-2 disconnected (normal left inverted right x axis y axis)
> VGA-1-1 disconnected (normal left inverted right x axis y axis)
>
> …
>
> lspci -nnk | grep VGA
>
> 0001:05:00.0 VGA compatible controller [0300]: Matrox Electronics Systems Ltd. MGA G200 AGP [102b:0521] (rev 03)
>
> Thanks,
> Christian
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/mgag200/mgag200_mode.c?id=6cb31fba137d45e682ce455b8ea364f44d5d4f98

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


--------------dfgPoO6LY1IoWYyn4ox8ymBV
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-mgag200-go-looking-for-PInS-in-the-video-BIOS-ROM-on.patch"
Content-Disposition: attachment;
 filename*0="0001-mgag200-go-looking-for-PInS-in-the-video-BIOS-ROM-on.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxOTg5ZTA4ODJmZTkwODM5ZDJlOTE4OGYwN2I4MDEyNTlkMTcxOWFiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4KRGF0ZTogV2VkLCAyNiBBdWcgMjAyNiAxMTowMzoxMSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIG1nYWcyMDA6IGdvIGxvb2tpbmcgZm9yIFBJblMgaW4gdGhlIHZpZGVvIEJJ
T1MgUk9NIG9uIG5vbi14ODYKCi0tLQogZHJpdmVycy9ncHUvZHJtL21nYWcyMDAvbWdhZzIw
MF9nMjAwLmMgfCAyNCArKysrKysrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfZzIwMC5jIGIvZHJpdmVycy9ncHUvZHJtL21n
YWcyMDAvbWdhZzIwMF9nMjAwLmMKaW5kZXggOWU2YjQ2MThmYWRkLi4xNTllYzU4YTY1NDEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfZzIwMC5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfZzIwMC5jCkBAIC0yMzksNyAr
MjM5LDcgQEAgc3RhdGljIHZvaWQgbWdhZzIwMF9nMjAwX2ludGVycHJldF9iaW9zKHN0cnVj
dCBtZ2FnMjAwX2cyMDBfZGV2aWNlICpnMjAwLAogCX07CiAJc3RydWN0IG1nYV9kZXZpY2Ug
Km1kZXYgPSAmZzIwMC0+YmFzZTsKIAlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gJm1kZXYt
PmJhc2U7Ci0JY29uc3QgdW5zaWduZWQgY2hhciAqcGluczsKKwljb25zdCB1bnNpZ25lZCBj
aGFyICpwaW5zID0gTlVMTDsKIAl1bnNpZ25lZCBpbnQgcGluc19sZW4sIHZlcnNpb247CiAJ
aW50IG9mZnNldDsKIAlpbnQgdG1wOwpAQCAtMjUwLDE2ICsyNTAsMzQgQEAgc3RhdGljIHZv
aWQgbWdhZzIwMF9nMjAwX2ludGVycHJldF9iaW9zKHN0cnVjdCBtZ2FnMjAwX2cyMDBfZGV2
aWNlICpnMjAwLAogCWlmIChtZW1jbXAoJmJpb3NbNDVdLCBtYXRyb3gsIHNpemVvZihtYXRy
b3gpKSAhPSAwKQogCQlyZXR1cm47CiAKKyNpZiBkZWZpbmVkKENPTkZJR19YODYpCiAJLyog
R2V0IHRoZSBQSW5TIG9mZnNldC4gKi8KIAlpZiAoc2l6ZSA8IE1HQV9CSU9TX09GRlNFVCAr
IDIpCiAJCXJldHVybjsKIAlvZmZzZXQgPSAoYmlvc1tNR0FfQklPU19PRkZTRVQgKyAxXSA8
PCA4KSB8IGJpb3NbTUdBX0JJT1NfT0ZGU0VUXTsKKwlpZiAoc2l6ZSA8IG9mZnNldCArIDYp
CisJCXJldHVybjsKIAogCS8qIEdldCBQSW5TIGRhdGEgc3RydWN0dXJlLiAqLworCXBpbnMg
PSBiaW9zICsgb2Zmc2V0OworI2Vsc2UKKwkvKgorCSAqIE9uIE9wZW5GaXJtd2FyZSBzeXN0
ZW1zIChQUEMsIE1JUFMsIFNQQVJDKSB0aGUgb2Zmc2V0IGlzbid0IHN0b3JlZAorCSAqIGF0
IHRoZSBlbmQgb2YgdGhlIEJJT1MgaW1hZ2UuIExvb2sgZm9yIHRoZSBQSW5TIGhlYWRlciBp
bnN0ZWFkLgorCSAqLworCWZvciAob2Zmc2V0ID0gMCA7IG9mZnNldCA8IHNpemUgLSA2OyAr
K29mZnNldCkgeworCQljb25zdCB1bnNpZ25lZCBjaGFyICpidWYgPSBiaW9zICsgb2Zmc2V0
OworCisJCWlmIChidWZbMF0gPT0gMHgyZSAmJiBidWZbMV0gPT0gMHg0MSAmJiAoKGJ1Zlsy
XSA9PSA2NCkgfHwgKGJ1ZlsyXSA9PSAxMjgpKSkgeworCQkJcGlucyA9IGJ1ZjsKKwkJCWJy
ZWFrOworCQl9CisJfQogCi0JaWYgKHNpemUgPCBvZmZzZXQgKyA2KQorCWlmICghcGlucykK
IAkJcmV0dXJuOwotCXBpbnMgPSBiaW9zICsgb2Zmc2V0OworI2VuZGlmCisKIAlpZiAocGlu
c1swXSA9PSAweDJlICYmIHBpbnNbMV0gPT0gMHg0MSkgewogCQl2ZXJzaW9uID0gcGluc1s1
XTsKIAkJcGluc19sZW4gPSBwaW5zWzJdOwotLSAKMi41NS4wCgo=

--------------dfgPoO6LY1IoWYyn4ox8ymBV--

