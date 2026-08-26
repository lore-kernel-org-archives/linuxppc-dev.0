Return-Path: <linuxppc-dev+bounces-26119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00868C61DBD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 15:23:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVT1X1WJlz2y32;
	Thu, 27 Aug 2026 01:23:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787757792;
	cv=none; b=fnnn94gUTk21Vy+lFf8H3Ry4sQd+KTToIz3UhuBApEwPtEwgOELc9LhS1Pr8VvIW8YEDKKd/cg2FDsj9yLJ64+jxjUShFKWi4fFiusuwb1G5BHzdk7BnIIv5VUyKnJ1niCaeJ+dV6g0NMQ/aAOf5NTDYVw17CNkUkOcsL+rG9pyMSq5smxaw7UDMnDz/Pa91ph+mRVoF/9vDXvmHWuxJqts4OL8q3Hop5UsHcYG6N8NXGbthnDyXpA9xXKLNx+zGoMX+EOI0V2KKGFzp6hcVd/qrowdHKwj/zf74TSCn657PiXg6Rn69rRBBDdBT8WfTaCWPYeGy3Yx67CIFboQrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787757792; c=relaxed/relaxed;
	bh=wRj0uj9GZiMrgmL+sFJXueJii2G0GOkZPQmknD0UhOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkvQDaKkHm8wH/PLEeS4AOueCMJw2LrDiiGZ+bH2NSyRRj08zt4vxEDv59vb50tFVH0Byug1ns5FTB1NZOVU+mDWKxL9/KNW0PY6Wj6W0lze31oyN9pqfAYu/+gRO7A/sNQiTFR9YG6LA8sl8WfJvz2KDvIU1qY9h1qTDajvrJpmvc3PQQyVQZeMs4DKq8ZTIvsrAjkfEexDDlq4DqMtAKoTiAitGa5/PYcStkXdx+ErYOVXT9XD5UM3JOqE7u+LFVCq91LRhnBQ1vpNNRStjTVd/LXS0KO56Ds6CPZ/fL8yzUInEUBaxrO8PSodmoNL2hzyl5CWEVQ0m6LmdmKavQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OefjY9An; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8suBEat6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LNYFaQ5k; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LNcY5c+N; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OefjY9An;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8suBEat6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LNYFaQ5k;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LNcY5c+N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVT1V6tyjz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 01:23:10 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 646CF21163;
	Wed, 26 Aug 2026 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787757783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wRj0uj9GZiMrgmL+sFJXueJii2G0GOkZPQmknD0UhOY=;
	b=OefjY9An+4H95T9LtnRFK7VS3H5sNee9U1by3UPdx6ah/xyHzckGd0ODrQoes+QCJBlp14
	ZZ9KvE2Ntv7y0yn95dnaZBnHk0akwyX10Ex7nYGqF2ooHY9klnh7KhYKOK82UkuiUlXasb
	D/hGnWaeIU/LCxoUsekPJ3Jms51EhxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787757783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wRj0uj9GZiMrgmL+sFJXueJii2G0GOkZPQmknD0UhOY=;
	b=8suBEat6nEOyrHGETiZ1JdIm6dQvFMd0FOl029kA089+DSdDOY0R/0Amxpo6wHBk60go3q
	Ingbu78Qg5FPwqDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787757779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wRj0uj9GZiMrgmL+sFJXueJii2G0GOkZPQmknD0UhOY=;
	b=LNYFaQ5kKzWjowvNRj4lQkTM4xBh6y4Ioheke9IdjCz87o6yehPByl77miBbwM3yhSKTA+
	OjCTCOhhKHXV3CqwU61ixHEXDfLKflZrmUcys7IGpE0ZvX1J6y4At9SllvoEJ+sdiyMPRv
	v/RsIJt/5zVhpfiFA4i/v9SRQmu4zO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787757779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wRj0uj9GZiMrgmL+sFJXueJii2G0GOkZPQmknD0UhOY=;
	b=LNcY5c+NeLMKUGtRwxFRm8JLavoJXaR1VyAuM++FxYGgUYdE88EclXWAUoeOtYpf0+6cbv
	wPMG9XmjemiMHXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 357E213533;
	Wed, 26 Aug 2026 15:22:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3g7cC9MEj2qMWgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Aug 2026 15:22:59 +0000
Message-ID: <1fe9c172-c12c-4827-b9a5-2870c45e67af@suse.de>
Date: Wed, 26 Aug 2026 17:22:58 +0200
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
 <6c265d1e-c301-4095-83e2-0e669222469a@suse.de>
 <0ac66673-034b-4fa0-089d-788ca7fde899@xenosoft.de>
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
In-Reply-To: <0ac66673-034b-4fa0-089d-788ca7fde899@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,xtra.co.nz,yahoo.com.au];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,xtra.co.nz,yahoo.com.au,gmail.com,xenosoft.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid]

Hi

Am 26.08.26 um 17:07 schrieb Christian Zigotzky:

> Hello Thomas,
>
> Thank you for your patch. Unfortunately the card doesn't work with the 
> patched kernel.
>
> dmesg | grep -i mga
>
> [    2.307195] [drm] Initialized mgag200 1.0.0 for 0001:05:00.0 on 
> minor 1
> [    2.308649] mgag200 0001:05:00.0: [drm] Cannot find any crtc or sizes
> [    2.309551] mgag200 0001:05:04.0: Invalid PCI ROM header signature: 
> expecting 0xaa55, got 0xffff
> [    2.310305] [drm] Initialized mgag200 1.0.0 for 0001:05:04.0 on 
> minor 2
> [    2.312660] mgag200 0001:05:04.0: [drm] Cannot find any crtc or sizes
> [    2.313177] mgag200 0001:05:00.0: [drm] Cannot find any crtc or sizes
> [    2.313640] mgag200 0001:05:08.0: Invalid PCI ROM header signature: 
> expecting 0xaa55, got 0xffff
> [    2.314357] [drm] Initialized mgag200 1.0.0 for 0001:05:08.0 on 
> minor 3
> [    2.317630] mgag200 0001:05:08.0: [drm] Cannot find any crtc or sizes
> [    2.318185] mgag200 0001:05:0c.0: Invalid PCI ROM header signature: 
> expecting 0xaa55, got 0xffff
> [    2.318840] mgag200 0001:05:04.0: [drm] Cannot find any crtc or sizes
> [    2.319345] [drm] Initialized mgag200 1.0.0 for 0001:05:0c.0 on 
> minor 4
> [    2.321014] mgag200 0001:05:0c.0: [drm] Cannot find any crtc or sizes
> [    2.322400] mgag200 0001:05:08.0: [drm] Cannot find any crtc or sizes
> [    2.327215] mgag200 0001:05:0c.0: [drm] Cannot find any crtc or sizes
>
> lspci -vvv
>
> 0001:05:00.0 VGA compatible controller: Matrox Electronics Systems 
> Ltd. MGA G200 AGP (rev 03) (prog-if 00 [VGA controller])
>     Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
>     Interrupt: pin A routed to IRQ 18
>     Region 0: Memory at c20000000 (32-bit, prefetchable) [size=16M]
>     Region 1: Memory at c21000000 (32-bit, non-prefetchable) [size=16K]
>     Region 2: Memory at c21800000 (32-bit, non-prefetchable) [size=8M]
>     Expansion ROM at c21010000 [disabled] [size=64K]

Could be that we have to enable access to the ROM first. That's why it 
returns only 0xffff. Does the card display output when you switch on the 
computer?

Best regards
Thomas


> Capabilities: [dc] Power Management version 1
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [f0] AGP version 1.0
>         Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
> 64bit- FW- AGP3- Rate=x1,x2
>         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
> Rate=<none>
>     Kernel driver in use: mgag200
>
> 0001:05:04.0 Display controller: Matrox Electronics Systems Ltd. MGA 
> G200 AGP (rev 03)
>     Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
>     Interrupt: pin A routed to IRQ 18
>     Region 0: Memory at c22000000 (32-bit, prefetchable) [size=16M]
>     Region 1: Memory at c23000000 (32-bit, non-prefetchable) [size=16K]
>     Region 2: Memory at c23800000 (32-bit, non-prefetchable) [size=8M]
>     Expansion ROM at c21020000 [disabled] [size=64K]
>     Capabilities: [dc] Power Management version 1
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [f0] AGP version 1.0
>         Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
> 64bit- FW- AGP3- Rate=x1,x2
>         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
> Rate=<none>
>     Kernel driver in use: mgag200
>
> 0001:05:08.0 Display controller: Matrox Electronics Systems Ltd. MGA 
> G200 AGP (rev 03)
>     Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
>     Interrupt: pin A routed to IRQ 18
>     Region 0: Memory at c24000000 (32-bit, prefetchable) [size=16M]
>     Region 1: Memory at c25000000 (32-bit, non-prefetchable) [size=16K]
>     Region 2: Memory at c25800000 (32-bit, non-prefetchable) [size=8M]
>     Expansion ROM at c21030000 [disabled] [size=64K]
>     Capabilities: [dc] Power Management version 1
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [f0] AGP version 1.0
>         Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
> 64bit- FW- AGP3- Rate=x1,x2
>         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
> Rate=<none>
>     Kernel driver in use: mgag200
>
> 0001:05:0c.0 Display controller: Matrox Electronics Systems Ltd. MGA 
> G200 AGP (rev 03)
>     Subsystem: Matrox Electronics Systems Ltd. G200 Multi-Monitor
>     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 128 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
>     Interrupt: pin A routed to IRQ 18
>     Region 0: Memory at c26000000 (32-bit, prefetchable) [size=16M]
>     Region 1: Memory at c27000000 (32-bit, non-prefetchable) [size=16K]
>     Region 2: Memory at c27800000 (32-bit, non-prefetchable) [size=8M]
>     Expansion ROM at c21040000 [disabled] [size=64K]
>     Capabilities: [dc] Power Management version 1
>         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [f0] AGP version 1.0
>         Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
> 64bit- FW- AGP3- Rate=x1,x2
>         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
> Rate=<none>
>     Kernel driver in use: mgag200
>
> xrandr
>
> VGA-4-4 disconnected (normal left inverted right x axis y axis)
> VGA-3-3 disconnected (normal left inverted right x axis y axis)
> VGA-2-2 disconnected (normal left inverted right x axis y axis)
> VGA-1-1 disconnected (normal left inverted right x axis y axis)
>
> lspci -nnk | grep VGA
>
> 0001:05:00.0 VGA compatible controller [0300]: Matrox Electronics 
> Systems Ltd. MGA G200 AGP [102b:0521] (rev 03)
>
> Thanks,
> Christian
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)



