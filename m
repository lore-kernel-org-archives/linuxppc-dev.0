Return-Path: <linuxppc-dev+bounces-26263-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2D9C624C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:21:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMPt6JVhz2ytT;
	Mon, 31 Aug 2026 18:20:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164450;
	cv=none; b=BT20LqAwHO7f7vNVCkPaiuTb6fHImU+bfue6vn9bg+CvqEMxShsiARDkROYNpFlO09Ah4Mie5UnTw2FzYcCyVBvnF6OrnEcGnpM6h+y8lmXGmG9uOUw33lRYpDKJ9sZbgmirnQkf+cU+Dk09oU4Hhfrix1iXaCIlkn81ba8CQlJ5jBBXS+1GJnwKfsNQMpgY0ZDZR5lVHooJst/ynh21SG5RZD+f727RsIk0fuznoY13hF0j5TLn5EwvPTXand0pRIRzHK86JQnBruZwcHv29+mPxl3BIf2wbCgRQ/wBfDAwgaIMm4iX21MNxw0GYZXE+lkBq1OxMdq4GlseAbFj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164450; c=relaxed/relaxed;
	bh=8MhaLmZPp4KLl6FJKDOv4LZLkIzyw4q4TX09F3wk/yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFLDJm5adh+X780zrupVqr/6sJyQuAO1sYr1WlJzEu/RswwYnKz9zdqm9ofCflCE13a7xs8izkuBFi/OgzrYaDoobhtc3rSd9/HtAuq6orQX/++2ufp8YNSCHmrZbHAdQJ8S9h//+ButhOQi1ZUqlHYt87NIXyZE1YQs6v9mYtkpNaLe1Mn0yniKBd2vUbJJ4HxkCK2dgoKV6hIWEFaXZ0XftR0pdcx66Cti3P0e6rlL/GhS7XRp/TJ0JZxa/vb6Sq0FQItafNj+WSqGx/2chYQ9YTetda7QjUNZiSfaq58LgbCIykhllAgKKlC8pSQL0Zr/Zepd1KmyCPjHpoNfNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZgAAjPyJ; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=21lSuVNo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qpUiYkXp; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a/ayIUtG; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZgAAjPyJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=21lSuVNo;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qpUiYkXp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=a/ayIUtG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMPr4dmcz305P
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:20:48 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9E0122429;
	Mon, 31 Aug 2026 08:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788164441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8MhaLmZPp4KLl6FJKDOv4LZLkIzyw4q4TX09F3wk/yE=;
	b=ZgAAjPyJzOC7ZaJMV4UXAskuMD6o8axDtO5HoqQzBX83ukXAT878B9x95Rdd8bvjAczGon
	4QPaEwl5t6uU5BzopDIU1R7lHc8pqve5sa64CqGRqzvLDZQu0UCEyrbJgwP3D9GGzQAQNZ
	hV/WZzisC7xxfP8/DGn4Ps2Zp2S6dV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788164441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8MhaLmZPp4KLl6FJKDOv4LZLkIzyw4q4TX09F3wk/yE=;
	b=21lSuVNoJENI1MyqHcl+QmrrOMUcqN9H4cKInYCpeTIFtT8Wbgmc/nckGFOwxi1Ln0TyN0
	ZELnJETjo7D/09Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788164436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8MhaLmZPp4KLl6FJKDOv4LZLkIzyw4q4TX09F3wk/yE=;
	b=qpUiYkXpn+w7Apjwpa/fqv5FVTpoMYOfvfSf0oKHKotJcWNI1ZTAUK+xw4OJII/9PzFaW0
	eIaV2lKWNOmqFDSPQfbiZzjmE4KtsnBctzEbz9ow60kXZ20owv6bDFpk1i5yT0bfNrLaLg
	Dv656v6RrSKpH7xVKP0TyyWQJTebji4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788164436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8MhaLmZPp4KLl6FJKDOv4LZLkIzyw4q4TX09F3wk/yE=;
	b=a/ayIUtG7LRfl3ZMnRBOfLYINLojkjvhePH18CNlK4O25Z1eFoHiAee+YIw4KTQNjwWq8G
	z4Azgv8A822mOZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D7C913694;
	Mon, 31 Aug 2026 08:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GME1IVQ5lWqVDAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 31 Aug 2026 08:20:36 +0000
Message-ID: <43e1427b-fe7d-42e3-8615-226d1d87b9dd@suse.de>
Date: Mon, 31 Aug 2026 10:20:36 +0200
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
References: <a2d102b6-033d-49c9-96a6-a9edda26b4bd@suse.de>
 <1805E6A7-52E7-403F-8E57-7ED951DCB1CA@xenosoft.de>
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
In-Reply-To: <1805E6A7-52E7-403F-8E57-7ED951DCB1CA@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	FREEMAIL_CC(0.00)[exactco.de,lists.ozlabs.org,xtra.co.nz,yahoo.com.au,gmail.com,xenosoft.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]

Hi

Am 28.08.26 um 12:19 schrieb Christian Zigotzky:
> On 28 August 2026 at 07:58 am, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> ﻿Hi
>
> Oh well. I assume it's a ROM for x86?   I guess the PPC firmware doesn't POST the graphics card, so the driver has to.  The power-up logic is given in Sec 4.3.3 of the MGA200 spec.  But TBH I won't have the time to work on it.  At best, I can help a bit if someone wants to address the problem.
>
> Best regards
> Thomas
>
> - - -
>
> Hi,
>
> Are there any Matrox cards with PowerPC roms?

To my knowledge there exist Matrox cards from old PPC Macs, but I don't 
know if any of them is a G200 that this driver would support.

Best regards
Thomas

>
> Have a nice weekend,
>
> Christian

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)



