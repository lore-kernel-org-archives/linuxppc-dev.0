Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A7C282CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972C82186A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 21:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwWIdpSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972C82186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gDDT5gfzzDqSf
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 07:09:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="NwWIdpSg"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gDBL1hC7zDqS2;
 Fri, 12 Apr 2019 07:07:35 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id i2so4072177pgj.11;
 Thu, 11 Apr 2019 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8QoNjccgba2liRazhiXGtqN9gYFAnXX0AWzdPDl8NkQ=;
 b=NwWIdpSgYRaMTZTU9y+/4NO/PZdDflMH5TZPEoovewndnSXv5wWys54Yv27xbBieIE
 0H5Jv5+eLbeJuiZ7J8oqVPneGeCPFudUnsSQontJdKa4nPMHpNjarTPzirb+rG2QXbo2
 wOt5VeshQ2fFU/P32wnfYhu5ekPXKTJkppCVYDBebWW1ySafeFVWXY99rIq2Nv/Jd86G
 7BXjb70htCT8tRke6nbOb6faHMZ8CqJcZkooUj4fSh0+ErHTwHH7t7lu/hv65siFEyUV
 74RxRXd1glNl/mrGIAJ91+fAdSRxxPWjjrXq55wtIUWxKQg4ZohhC8uJcC0FiBVpkZXZ
 6uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=8QoNjccgba2liRazhiXGtqN9gYFAnXX0AWzdPDl8NkQ=;
 b=J0fmIIafROODt2yPiXvZlgB4ztN0nWqSYHpWAVIHpO63qwGuCImQ9lVrO5Nksk5Zkn
 Zky8+lApPFFQtESM53BtJP9SlfovA4qeGRBMtQXsEPA7in1rG1GY5a+VPJnzIgoKg93u
 cuYfgLXBccuamtiEv2m71vVSuz+0E+S5hXD78WrEA3wDGwF9md/LlWqDGVbTEYTdEJwZ
 blL5MroS+Owc/3fPPsgVJ1/8dSpH6P7S8VzDcN9A3UtFENnUpqHSTElmysoOzc72ccyk
 nXbXGwjcvEUTPTBjVB+HsJJM28Ph2O+tOX9PAWBLq5wdN/+KMzkDg6UuilXXDjqHE/1C
 i0LQ==
X-Gm-Message-State: APjAAAUR6bDJ1SXanFDTWHxAdj2DXhF0PvmIHNgQSPSHk3C4q9X4dMh+
 uiMuod30B5kDFiNcwTCQEjc=
X-Google-Smtp-Source: APXvYqxu2TSmC4/JxGq7Qq4fzyWNHJUPxpDT+BVQpAKIQ8eBBRLGjWm8DqgaMIkYpmUCgWHaQrKP7g==
X-Received: by 2002:a63:e845:: with SMTP id a5mr50493631pgk.246.1555016853736; 
 Thu, 11 Apr 2019 14:07:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id p3sm56709579pfn.167.2019.04.11.14.07.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Apr 2019 14:07:32 -0700 (PDT)
Date: Thu, 11 Apr 2019 14:07:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
Message-ID: <20190411210731.GA29378@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net>
 <20190411174357.251904f5@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411174357.251904f5@coco.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 linux-aspeed@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Andrew Jeffery <andrew@aj.id.au>, Jonathan Corbet <corbet@lwn.net>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org, Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 11, 2019 at 05:43:57PM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 11 Apr 2019 12:43:24 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > On Wed, 10 Apr 2019 16:22:37 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > 
> > > This series converts the contents of Documentation/hwmon to ReST
> > > format.
> > > 
> > > PS.: I opted to group the conversion files per groups of maintainer
> > > set, as, if I were to generate one patch per file, it would give around
> > > 160 patches.
> > > 
> > > I also added those patches to my development tree at:
> > > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=hwmon
> > > 
> > > If you want to see the results, they're at:
> > > 	https://www.infradead.org/~mchehab/hwmon/  
> > 
> > This set seems generally good and could probably be applied as-is.  But I
> > have to ask...is there a reason to not take the last step and actually
> > bring this stuff into the Sphinx doc tree?
> > 
> > We seem to be mostly documenting sysfs files and such.  I am *guessing*
> > that perhaps the set should move to Documentation/admin-guide/hwmon?  Or
> > have I misunderstood the intended audience here?
> 
> :-)
> 
> Yeah, I'd say that 80% of the contents there are user-faced.
> 
> Yet, the main issue with this (and other driver subsystems) is that there's
> a mix of userspace and Kernelspace stuff. One somewhat simple case is
> the abituguru: it has a "datasheet" file:
> 
> 	abituguru-datasheet
> 
> This contains programming information for the corresponding drivers,
> while abituguru and abituguru3 contains mostly userspace
> stuff (still, it also contains the I2C address, with shouldn't mean
> anything for the user).
> 
> However, if you take a look at w83781d, you'll see a mix of both
> userspace and driver developer info there... it has a chapter called
> "Data sheet updates", for example, with is probably meaningless for
> anyone but the hwmon driver developers.
> 
> That's, btw, a pattern that happens a lot inside device driver
> documents on almost all subsystems I checked: driver-specific
> documentation is usually not split into user-facing/kernel-facing.
> 
> While nobody does such split, IMHO, the best would be to keep the
> information outside Documentation/admin-guide. But hey! You're
> the Doc maintainer. If you prefer to move, I'm perfectly fine
> with that.
> 

Same here, but please don't move the files which are kernel facing only.

How do you want to handle this series ? Do you expect it to be pushed
through hwmon, or through Documentation, or do you plan to push yourself ?

If the series isn't pushed through hwmon, we'll likely have a couple of
conflicts against hwmon-next.

Thanks,
Guenter
