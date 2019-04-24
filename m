Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55682C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30CA218B0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZ1Z/g/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30CA218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q6rS4hkGzDqYC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 03:34:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tZ1Z/g/N"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q6nf5yrqzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:32:06 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id 10so9661828pfo.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CbYpFcJey7cXt44hlm0PtSFow9IzRhVJ39cQCZIMB6w=;
 b=tZ1Z/g/NUbcJ5JLgQk6wa3NUDP0+Tc/L3qLGwbcf220tv1onTOX5hiMlXWnP7vNOhY
 XazbGPyEH/4Hjr3qhCXefQcKxFuMMgrpu/XwBwMtO4950I3dvdhXDP9BNdF4kTAFkprZ
 44tHGnaDQhnMLVZgB805iIYqAQDdfqmh/qQWNy2lThTzITCwBpXEdmVNtpH1jq0HPm2s
 hVCxxy2CiZnki7fOWDDJ0HplG9Xtjv7Nnuq9f1TujYR9fUVsjHgkcnWOxMVk8UE/+l7G
 BvzV+NFVxiwyEF6hExnE5WsOo9yjodQxP74KHo7aVjD/ouFwlw71gUMDi1pa0ILwAWdF
 7GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CbYpFcJey7cXt44hlm0PtSFow9IzRhVJ39cQCZIMB6w=;
 b=SxO5CRbzgGMQyDPgAZQ76VGOFo3NVNf90/5NFiR4gkgBkccqMebPem1muOSV/sGFpT
 cY+W1YA7iqnfbV0NUO1bHtPkTtZzZ/cGWwoOTPNnVVq4uDcNnZgfy7UvxCpzAqsFHtyT
 8l3l+y0jkLScMOYjEtEIolXcMVKv3UMtoy9gGZAbJT3GEB/uOGH3/G2NqNT11kwRzAJC
 +UEKmZSVxUEfdX/gW/s7/hSQDGXOmACio0TwE7vkZUzWSIZRP0FeKtSVPZGRSrShKlbS
 XPV1LQGiZ5tdH/RUGua2lc5g+BhRqdZxCif6OvAVOc26XIgzHHTXtoKeihymG/riDwmw
 2ttQ==
X-Gm-Message-State: APjAAAUakb47l+LfvH0F2kHp+bj1YO9TEZSY3UW03RqRCkOQaRpI/LPh
 tyRYzWnsF1cCF0cPaQD/lD0=
X-Google-Smtp-Source: APXvYqzGVEu1O4QjGym5wcVjh3X9UjZwdUOk/9kxw5zuv8U4q0pmtazlcsapKkYpt4n8XV3gIzgrnQ==
X-Received: by 2002:a63:7d03:: with SMTP id y3mr30805177pgc.8.1556127122646;
 Wed, 24 Apr 2019 10:32:02 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id u5sm28827202pfm.121.2019.04.24.10.31.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Apr 2019 10:32:01 -0700 (PDT)
Date: Thu, 25 Apr 2019 01:31:47 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 24/63] Documentation: ACPI: move video_extension.txt
 to firmware-guide/acpi and convert to reST
Message-ID: <20190424173146.b7vwdswl3btxyq7p@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-25-changbin.du@gmail.com>
 <20190424115647.092dec38@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424115647.092dec38@coco.lan>
User-Agent: NeoMutt/20180716
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 24, 2019 at 11:56:47AM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:53 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/firmware-guide/acpi/index.rst   |  1 +
> >  .../acpi/video_extension.rst}                 | 63 ++++++++++---------
> >  2 files changed, 36 insertions(+), 28 deletions(-)
> >  rename Documentation/{acpi/video_extension.txt => firmware-guide/acpi/video_extension.rst} (79%)
> > 
> > diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> > index 0e60f4b7129a..ae609eec4679 100644
> > --- a/Documentation/firmware-guide/acpi/index.rst
> > +++ b/Documentation/firmware-guide/acpi/index.rst
> > @@ -23,3 +23,4 @@ ACPI Support
> >     i2c-muxes
> >     acpi-lid
> >     lpit
> > +   video_extension
> > diff --git a/Documentation/acpi/video_extension.txt b/Documentation/firmware-guide/acpi/video_extension.rst
> > similarity index 79%
> > rename from Documentation/acpi/video_extension.txt
> > rename to Documentation/firmware-guide/acpi/video_extension.rst
> > index 79bf6a4921be..06f7e3230b6e 100644
> > --- a/Documentation/acpi/video_extension.txt
> > +++ b/Documentation/firmware-guide/acpi/video_extension.rst
> > @@ -1,5 +1,8 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=====================
> >  ACPI video extensions
> > -~~~~~~~~~~~~~~~~~~~~~
> > +=====================
> >  
> >  This driver implement the ACPI Extensions For Display Adapters for
> >  integrated graphics devices on motherboard, as specified in ACPI 2.0
> > @@ -8,9 +11,10 @@ defining the video POST device, retrieving EDID information or to
> >  setup a video output, etc.  Note that this is an ref. implementation
> >  only.  It may or may not work for your integrated video device.
> >  
> > -The ACPI video driver does 3 things regarding backlight control:
> > +The ACPI video driver does 3 things regarding backlight control.
> >  
> > -1 Export a sysfs interface for user space to control backlight level
> > +1. Export a sysfs interface for user space to control backlight level
> > +=====================================================================
> >  
> >  If the ACPI table has a video device, and acpi_backlight=vendor kernel
> >  command line is not present, the driver will register a backlight device
> 
> Hmm... you didn't touch on this part of the document:
> 
> 	And what ACPI video driver does is:
> 	actual_brightness: on read, control method _BQC will be evaluated to
> 	get the brightness level the firmware thinks it is at;
> 	bl_power: not implemented, will set the current brightness instead;
> 	brightness: on write, control method _BCM will run to set the requested
> 	brightness level;
> 	max_brightness: Derived from the _BCL package(see below);
> 	type: firmware
> 
> You should touch it. My suggestion here is:
> 
> 	And what ACPI video driver does is:
> 
> 	actual_brightness:
> 		on read, control method _BQC will be evaluated to
> 		get the brightness level the firmware thinks it is at;
> 	bl_power:
> 		not implemented, will set the current brightness instead;
> 	brightness:
> 		on write, control method _BCM will run to set the requested
> 		brightness level;
> 	max_brightness:
> 		Derived from the _BCL package(see below);
> 	type:
> 		firmware
>
Thanks, done.

> > @@ -32,26 +36,26 @@ type: firmware
> >  
> >  Note that ACPI video backlight driver will always use index for
> >  brightness, actual_brightness and max_brightness. So if we have
> > -the following _BCL package:
> > +the following _BCL package::
> >  
> > -Method (_BCL, 0, NotSerialized)
> > -{
> > -	Return (Package (0x0C)
> > +	Method (_BCL, 0, NotSerialized)
> >  	{
> > -		0x64,
> > -		0x32,
> > -		0x0A,
> > -		0x14,
> > -		0x1E,
> > -		0x28,
> > -		0x32,
> > -		0x3C,
> > -		0x46,
> > -		0x50,
> > -		0x5A,
> > -		0x64
> > -	})
> > -}
> > +		Return (Package (0x0C)
> > +		{
> > +			0x64,
> > +			0x32,
> > +			0x0A,
> > +			0x14,
> > +			0x1E,
> > +			0x28,
> > +			0x32,
> > +			0x3C,
> > +			0x46,
> > +			0x50,
> > +			0x5A,
> > +			0x64
> > +		})
> > +	}
> >  
> >  The first two levels are for when laptop are on AC or on battery and are
> >  not used by Linux currently. The remaining 10 levels are supported levels
> > @@ -62,13 +66,15 @@ as a "brightness level" indicator. Thus from the user space perspective
> >  the range of available brightness levels is from 0 to 9 (max_brightness)
> >  inclusive.
> >  
> > -2 Notify user space about hotkey event
> > +2. Notify user space about hotkey event
> > +=======================================
> >  
> >  There are generally two cases for hotkey event reporting:
> > +
> >  i) For some laptops, when user presses the hotkey, a scancode will be
> >     generated and sent to user space through the input device created by
> >     the keyboard driver as a key type input event, with proper remap, the
> > -   following key code will appear to user space:
> > +   following key code will appear to user space::
> >  
> >  	EV_KEY, KEY_BRIGHTNESSUP
> >  	EV_KEY, KEY_BRIGHTNESSDOWN
> > @@ -82,7 +88,7 @@ ii) For some laptops, the press of the hotkey will not generate the
> >      about the event. The event value is defined in the ACPI spec. ACPI
> >      video driver will generate an key type input event according to the
> >      notify value it received and send the event to user space through the
> > -    input device it created:
> > +    input device it created::
> >  
> >  	event		keycode
> >  	0x86		KEY_BRIGHTNESSUP
> 
> Perhaps making this as a table would work better:
> 
>     input device it created:
> 
> 	=====		===================
> 	event		keycode
> 	=====		===================
> 	0x86		KEY_BRIGHTNESSUP
> 	0x87		KEY_BRIGHTNESSDOWN
> 	etc.
> 	=====		===================
> 
> 
Done.

> > @@ -94,13 +100,14 @@ so this would lead to the same effect as case i) now.
> >  Once user space tool receives this event, it can modify the backlight
> >  level through the sysfs interface.
> >  
> > -3 Change backlight level in the kernel
> > +3. Change backlight level in the kernel
> > +=======================================
> >  
> >  This works for machines covered by case ii) in Section 2. Once the driver
> >  received a notification, it will set the backlight level accordingly. This does
> >  not affect the sending of event to user space, they are always sent to user
> >  space regardless of whether or not the video module controls the backlight level
> >  directly. This behaviour can be controlled through the brightness_switch_enabled
> > -module parameter as documented in admin-guide/kernel-parameters.rst. It is recommended to
> > -disable this behaviour once a GUI environment starts up and wants to have full
> > -control of the backlight level.
> > +module parameter as documented in admin-guide/kernel-parameters.rst. It is
> > +recommended to disable this behaviour once a GUI environment starts up and
> > +wants to have full control of the backlight level.
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
