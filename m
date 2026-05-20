Return-Path: <linuxppc-dev+bounces-21258-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7650CD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 21:53:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLQK73RJ6z2yFh;
	Thu, 21 May 2026 07:53:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779314011;
	cv=none; b=WS8Id/4C0/ELqGw/FZdV5UxzCDCHkIEfXf0EbBiUpOw0EqunWwPizb4pGWqC4cnz2gMQO4WONJZizOmlXYwS5wWH7Lco7q4wOe6fe+smgGYwZI66aZvT3q1bX+UQpc1pSB67x7VN0wYQNgomOoX77J1CvMXZFu13bgl92RqnbJxIk6gacOdH/b3PS8Wrkc4YnQqHYRRm94pZhiaM9n3Ve7hobQeaiObqh71ybevYmx9pbyKLWh5EZnXNWS47j4QrwJhGsWyKJrfY2rIidbAzOY4X7ApfEWNXKGKqjqzTp/JFTE40o0Vrrl2FXVDoSTtmZ/gfU4JF+czq6AbVr3rjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779314011; c=relaxed/relaxed;
	bh=xPV2dKwaE2Vd6MXTyx7rLZbYWuBOQncN75Rd2vCx2ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9PHPdAhq9tZ9EK6IfWKHmUsbml3+QD2Aozh8qYI8FTdpHrMmOYkJ4PNzX7xv6Hs8s8ZSVvoP6A97t2G9rFyZe7i3IfdIrU5F2hk/E/J86NcrnLy+oVT6JVa6tKBi2FiFpb54waV7BO7DpkkTrsgM3UQ91RhfIiQS94c/0dn2QFhRbRMtYKWloCtjT6LmHNQY8lllXKdzur2CN3s7NVERfmyNBtiodqYLsRLQ2QKQzm65kixc6MXdxvs1VG8pEM1qhN4ZB9yUC9yA1/UDq1k9U2ovKVRcflgo3BXO2l7T7Hufj48EXZidKWq/oW6qcu2M6zgFEoLgbWvuaSx69ckRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lITw4wyv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lITw4wyv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLQK65zGxz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 07:53:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 421E340DB5;
	Wed, 20 May 2026 21:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AF61F000E9;
	Wed, 20 May 2026 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779314008;
	bh=xPV2dKwaE2Vd6MXTyx7rLZbYWuBOQncN75Rd2vCx2ro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lITw4wyvZjTzkXXF5BIabqkOsAkkTnk8NhyhWVUYyUzfg8BYN44UNob3dHZktS4jb
	 0rY1QfWGESKKYfKb35cHc9ouS6SRzDNrtDqOyXSwStx4n5IqrLOIUg4NqxJ+3l+P4Z
	 hJ+Sif5F4oRLchBTgqzGD0vCKxDN9sjh96QZoas3YsExzAGbOJvSQOlB3jvMsjTY2u
	 vhMi7dUtv/xuNIXN5QmfBJA1F0VJAiw0ADJ4fw7+WuBG2qxJVFj7W7HeH7wPo1EClo
	 3bDRRGlRvuSwHcqF9y/LfpaiXl8c222ySl6UJAjoAKo2AP3HuWYctiHwggEKw8RhmQ
	 unjGGhixMCQZQ==
Message-ID: <1e0bc483-ed98-41ae-a5a1-a6ac5069c010@kernel.org>
Date: Wed, 20 May 2026 23:53:21 +0200
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
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 simona@ffwll.ch, airlied@gmail.com, lukas@wunner.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260520160744.130841-1-tzimmermann@suse.de>
 <20260520160744.130841-2-tzimmermann@suse.de>
 <0ce59eaf-1124-48c5-b812-c8e6b58e01d0@gmx.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <0ce59eaf-1124-48c5-b812-c8e6b58e01d0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/05/2026 à 20:51, Helge Deller a écrit :
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
>> @@ -533,6 +533,8 @@ extern int fb_set_var(struct fb_info *info, struct 
>> fb_var_screeninfo *var);
>>   extern int fb_pan_display(struct fb_info *info, struct 
>> fb_var_screeninfo *var);
>>   extern int fb_blank(struct fb_info *info, int blank);
>> +int fb_set_var_from_user(struct fb_info *info, struct 
>> fb_var_screeninfo *var);
>> +
> 
> "extern" int fb_set_var_from_user(...) ?

No, 'extern' is pointless for function prototypes and 'checkpatch 
--strict' will complain about it.

See following link, search for extern : 
https://docs.kernel.org/dev-tools/checkpatch.html



> 
> Other than that the series is a nice cleanup!
> 
> Thanks!
> Helge


