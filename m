Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE4AC282DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 17:45:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131A22173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 17:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqA4BWkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131A22173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kqQ33j9MzDqLy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 03:45:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BqA4BWkJ"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kqNJ6SZGzDqG8;
 Thu, 18 Apr 2019 03:43:44 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id v12so12351826pgq.1;
 Wed, 17 Apr 2019 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Xb4dDY8Ht5vsPhb6Ii7KBS3ZH6iBZMm1tLBFEdnq7bo=;
 b=BqA4BWkJoVPi6+PwGHhsOWzyFx1IDgxa5Fcya+P9/nbqlF4qTwByIkuHJDpBRgFzZG
 Dk+74/3mVzCPZfvxNNRQvWkX70qwNGeXcKaEbXz6BKcmH2XeB3G/kdyrnWVLPt+kW6Wt
 1a9U1GGZXUx0/2JRaWXGb8DZWDMJKSGqI/LZvzcjOP1g4ZYBGRO16VfnxVq1jGgKi+U4
 Tvc5cy8hGYUvO7UMKvSpJSQ6aijiJq31topFVQKEyX0vC5LixXp3Eal6IYknXQlXnre7
 BStMbDJvw8IC71pT+zb4EnNcUAvRB1aEPOiuShfbKutdrVnGNaoPGw5jxTn0J7VZ20UQ
 9U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=Xb4dDY8Ht5vsPhb6Ii7KBS3ZH6iBZMm1tLBFEdnq7bo=;
 b=tWg23Aa7keT1WhqR/tnRhNlM6iYw0hv40wbU77o3ORVc/AV2wS8FIZApWDnsJL2JUb
 znX0I1bzHRGLDkjHc5MJObb6i8Rk1rXGmB0uUjuO8MTVbt0yLllug6xoMvpck3e5YGVy
 0Cm13Ujav5QW0yDObJ9GXrjQupKQ5Yy/fG8/x68xdYknIgdkuGwsR6aA0Txx8fYYKyfX
 eOq7SpmCEQ4eHxBF0Ktc93KRlmAJQ9P+OGrtJjyFOmv7LOsLPjlwRCPWlI8POgmVHg0I
 b+uCfmRyxDD4GbevSxJAbZVmwIHB1ONhr4LwDbtJfQotk5YQRR3dQIjiPbgqwzrbgtIP
 VrnA==
X-Gm-Message-State: APjAAAWzgF28EPPnzjomEp079K7pqOLLda9q4y9vZLdskA6+0OoPRbZi
 tfc3UKc1LGxAstYPvKgyggY=
X-Google-Smtp-Source: APXvYqx3fuy7b8UJvMM0ooV7d7Bhu13mTndtGcb1/KeBvuhFe0R+J0MnnnXU3Buj0QbQJnti18Lv8g==
X-Received: by 2002:a63:30c5:: with SMTP id w188mr83242355pgw.76.1555523019795; 
 Wed, 17 Apr 2019 10:43:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id x28sm62632792pgl.38.2019.04.17.10.43.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Apr 2019 10:43:38 -0700 (PDT)
Date: Wed, 17 Apr 2019 10:43:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH v3 21/21] docs: hwmon: Add an index file and rename docs
 to *.rst
Message-ID: <20190417174337.GA16749@roeck-us.net>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
 <20190417164741.GA12147@roeck-us.net>
 <20190417141352.3225bbb3@coco.lan>
 <20190417142215.791df5e7@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417142215.791df5e7@coco.lan>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Dirk Eibach <eibach@gdsys.de>,
 linux-aspeed@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Clemens Ladisch <clemens@ladisch.de>, Kamil Debski <kamil@wypas.org>,
 Marc Hulsman <m.hulsman@tudelft.nl>, devicetree@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>,
 Jim Cromie <jim.cromie@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Joel Stanley <joel@jms.id.au>,
 Steve Glendinning <steve.glendinning@shawell.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Rudolf Marek <r.marek@assembler.cz>,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Support Opensource <support.opensource@diasemi.com>,
 George Joseph <george.joseph@fairview5.com>,
 Andreas Werner <andreas.werner@men.de>, Andrew Jeffery <andrew@aj.id.au>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Juerg Haefliger <juergh@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 17, 2019 at 02:22:15PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 17 Apr 2019 14:13:52 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> 
> > Em Wed, 17 Apr 2019 09:47:41 -0700
> > Guenter Roeck <linux@roeck-us.net> escreveu:
> > 
> > > On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:  
> > > > Now that all files were converted to ReST format, rename them
> > > > and add an index.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > > Acked-by: Liviu Dudau <liviu.dudau@arm.com>    
> > > 
> > > I applied all patches except this one, which fails due to a conflict in
> > > ab8500. I also notice that this file has not been touched by your series,
> > > which is odd. At the same time, patch 20/21 is missing from your series,
> > > and has been missing all along. Does the missing patch possibly touch
> > > Documentation/hwmon/ab8500 ?  
> > 
> > Patch 20/21 is the biggest one. Maybe vger rejected it either due to
> > its size or due to the number of c/c.
> > 
> > Just bounced it to you. Please let me know if you didn't receive it
> > yet.
> 
> Btw, LKML got it:
> 
> https://lore.kernel.org/lkml/cccc2a52363a5aaeea10e186ead8570503ea648e.1555494108.git.mchehab+samsung@kernel.org/
> 
patchwork didn't get it (or didn't accept it). I got it now.
All patches applied, and pushed out to hwmon-next.

We have one (new) unconverted file left - Documentation/hwmon/lochnagar.
Can you by any chance have a look into that as well ?

Thanks!
Guenter
