Return-Path: <linuxppc-dev+bounces-26088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B0CC61DBD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 07:49:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVGxf1qB2z2y32;
	Wed, 26 Aug 2026 17:49:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787730550;
	cv=none; b=nVurEo3aXxAZPGgAdMYW2yhUtbYXmn4dZtBIINvnoRNoUGFBEmlMyBnWW+iJjtbYIt09g+9BXqte6IjBGr7oD5efBowKzKFzUU+/EVDHifdxhDhUNjXTW1UkoIF47lD9FLRpIQLz6yAOeRwQusB1nmCZVah8L9NOcoL0qyhCsTRvTVW7IELUB7T2oB11q5f85nCJ6N7+ICQhHdsfadIu83t5m09hjWgPs1yueeXdwxdoYFDlCbRNc3xN/YfUQXIOQcpvQ9ND0WMuVxkU+FiDhb4pL6B9gStfvXTiEAe7MyP//4XOKvJ7uG+uceSZKM1C8a0DKVVkxDA5x3oPOU4DyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787730550; c=relaxed/relaxed;
	bh=hoWkuKjU03v8tAOnqF97TgILj6WMwg0JgvxnuGhDs1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jhe3esxkdx54aFBg+5kavCVqHfNZ+OOHigutGHiqAQc6PH/mE2bRbv/CV0tmh5CU8tMp38h1fBI1v9RYW7E+yqIeVqZjAn1QFfWxAm7vg9I/hXnJo6pEOEE05vVVCMCiJ7H9VLg2OBW+d9gGjQesiUdWYKQ7XEIrIk/KEDg+9UhYSqbdFJrlWyzNFxygsX9fvxfA6c0quom+71avhEtvruad72QJ5oSPUy5Fpbi5T2bubjbNCKCSLuofVsgKPKK7oDHLtU2Fz8/NdXVqOMbMFfPYf7HQHTrE6TFZz7Y2v5b6HAnVNyLhCBx3sGaZvx8TrHlW+J6jMwZrV6qQ0lGnJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=awtlP0DZ; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IDuFzKBd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gyVgowIn; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kbFfDp5e; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=awtlP0DZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IDuFzKBd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gyVgowIn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kbFfDp5e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVGxc0q3fz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 17:49:08 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D73F4872A4;
	Wed, 26 Aug 2026 07:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787730540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hoWkuKjU03v8tAOnqF97TgILj6WMwg0JgvxnuGhDs1k=;
	b=awtlP0DZDPG9mgvIozOtI4IvXgA347PtG4otnwv6wfDG/yQ+t4Y6XpO+meW8DavjN6O1ye
	knfw3iM5AWsKmYbbOhJMc+W6u+BwsiwiZciyPV6MsGTrUncBmw7BF7pwZZf5MM3vc4eIo4
	uC5lmGvZX7KoVWXji5p18RdhwNodgOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787730540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hoWkuKjU03v8tAOnqF97TgILj6WMwg0JgvxnuGhDs1k=;
	b=IDuFzKBdhwmpVSyRsFpVnlCoUnWMDvtiM8XjrJSBGsUIufd2QX1VsoLwRimaTh8hk1w2+T
	kvpDvGmwQDlLpzCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gyVgowIn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kbFfDp5e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787730535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hoWkuKjU03v8tAOnqF97TgILj6WMwg0JgvxnuGhDs1k=;
	b=gyVgowIn4D5xNp2B5wT29pwWUYuCK8IlvVo0HhCL69x7cMjAVybkYIWADsAH7GOs2eyozM
	oaBLuNrtK+fb4ANv4z3bHzSqWiuJonViYiOX6xJMnQtBXhCIUmYfyg2hlkl5Y/gw8+eGvN
	vNSY5rIBBpRxMqcUTEmqgDxr6RVqzGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787730535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hoWkuKjU03v8tAOnqF97TgILj6WMwg0JgvxnuGhDs1k=;
	b=kbFfDp5evI9mQx/7lvBIxtMG3rRgEsdccBoYOZWCEsX1uXW2vG6qcbwQ1zRA9jhNxv1n+M
	m6Aq1aWxxx7OkkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA8CA13533;
	Wed, 26 Aug 2026 07:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5zGeKGeajmoLCwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Aug 2026 07:48:55 +0000
Message-ID: <0c7199e9-9abc-4b39-8a5c-9c95f0dd0b04@suse.de>
Date: Wed, 26 Aug 2026 09:48:55 +0200
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xtra.co.nz,yahoo.com.au];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,xtra.co.nz,yahoo.com.au,gmail.com,xenosoft.de];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,bootlin.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D73F4872A4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

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

This comment in the rsp fbdev driver might explain what's happening here:

https://elixir.bootlin.com/linux/v7.2/source/drivers/video/fbdev/matrox/matroxfb_misc.c#L501

>
> xrandr detects the ports but reports that they are not connected, even though the cables are plugged in.
>
> I also tested it with the stable long-term kernel 5.10.261 with the old legacy DRM drivers for Matrox graphics cards.
> I installed the Xorg MGA server xf86-video-mga-2.0.0_3 for the old legacy DRM driver but unfortunately I get only a black screen.
>
> Is it possible to use this card with PPC Linux?

Doing ROM-parsing as the same as old driver does could possibly resolve 
the issue.  If nothing else shows up, I'll take a look at it.

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



