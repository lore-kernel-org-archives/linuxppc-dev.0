Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AFAC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 17:49:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B22F2173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 17:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGHfEQCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B22F2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kqW71NZ7zDqFY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 03:49:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bGHfEQCN"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kqSj57glzDqLX;
 Thu, 18 Apr 2019 03:47:33 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id ck15so12391100plb.3;
 Wed, 17 Apr 2019 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=o9APsGckmzihOO9dqTe6ALmt4jv1tDX1soBQUw6e5hQ=;
 b=bGHfEQCN0sNNZq0deH317oh7k+UaZPbNhUBnNuhANveMoegF7dVk5f50xemkg+4xU3
 Pf8EmyPghGz6BwS3+Iawo+QqZ9rrWTGBT9h1aAUyNPMkl15pBaejRuX3BqJljACjtIVe
 FM71ZmV6D3aK5NhMMeaXeldPA79bGRRyeoKgruq7tZE6anxo4+363JyoyqYxU+x8WwDk
 VxbqLIYeqoc1gZRi5BsyyAhSFBECYzEgpXLuXePLaUnPAcU9+4I4mxbPGEZBlTqWO0C6
 ylXhBGlgmCHScUYrikSLD0SJxqzFll0rdVG8+JRiig9+l/OLqpo2NGVyodo1O7m2e41T
 67hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=o9APsGckmzihOO9dqTe6ALmt4jv1tDX1soBQUw6e5hQ=;
 b=E7vFc2PWu0w4n4PCg01q6WaQCRDioy2Pj+oeMVIGy5zrSiluc+SFr3Utfa9xTNHgRO
 h5L2wx40yQx7ts2vZJoKO1eRGEwHHjfcIIeWw/NIxQYh+QUBVnjH0P7UcV7aAQqQ3O+8
 JN/JpfOgVINXUbayd0C9CNHdk9C5gRoQR8Iio1llNeQJp5llaqrBm53k01cv7tnTbCGz
 9iW6jFQNnAZ/vlLXudxdR3i2Pw8NHFZ3qBE4T4aQL3jH8LsJjDDCzYr+iGuQlw1h0hTb
 wYQBg2lMmkYNqqW92L2bbjtDTc5v3gWKv8yvJySxqr54VIzvHfTsqdaSzD2tfoUuHAPq
 6Ncw==
X-Gm-Message-State: APjAAAW6FYy/dwFP3iLebZbc+B4X2v+m56nj0sPTfCCzf+pzaD4vB3ve
 lDtGUZzlG0Nqgi/Bu7ey9d4=
X-Google-Smtp-Source: APXvYqxRA8oDzw1zSMNBhh6VDHqVLxshxm8y+1iglurRc82RrTB98wBD9PHrPjXzlQ4awxP2H07u+A==
X-Received: by 2002:a17:902:22f:: with SMTP id
 44mr87135181plc.175.1555523250263; 
 Wed, 17 Apr 2019 10:47:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id x6sm86682439pfb.171.2019.04.17.10.47.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Apr 2019 10:47:29 -0700 (PDT)
Date: Wed, 17 Apr 2019 10:47:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH v3 21/21] docs: hwmon: Add an index file and rename docs
 to *.rst
Message-ID: <20190417174728.GA17706@roeck-us.net>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
 <20190417164741.GA12147@roeck-us.net>
 <20190417141352.3225bbb3@coco.lan>
 <20190417142215.791df5e7@coco.lan>
 <20190417174337.GA16749@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417174337.GA16749@roeck-us.net>
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

On Wed, Apr 17, 2019 at 10:43:37AM -0700, Guenter Roeck wrote:
> On Wed, Apr 17, 2019 at 02:22:15PM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 17 Apr 2019 14:13:52 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> > 
> > > Em Wed, 17 Apr 2019 09:47:41 -0700
> > > Guenter Roeck <linux@roeck-us.net> escreveu:
> > > 
> > > > On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:  
> > > > > Now that all files were converted to ReST format, rename them
> > > > > and add an index.
> > > > > 
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > > > Acked-by: Liviu Dudau <liviu.dudau@arm.com>    
> > > > 
> > > > I applied all patches except this one, which fails due to a conflict in
> > > > ab8500. I also notice that this file has not been touched by your series,
> > > > which is odd. At the same time, patch 20/21 is missing from your series,
> > > > and has been missing all along. Does the missing patch possibly touch
> > > > Documentation/hwmon/ab8500 ?  
> > > 
> > > Patch 20/21 is the biggest one. Maybe vger rejected it either due to
> > > its size or due to the number of c/c.
> > > 
> > > Just bounced it to you. Please let me know if you didn't receive it
> > > yet.
> > 
> > Btw, LKML got it:
> > 
> > https://lore.kernel.org/lkml/cccc2a52363a5aaeea10e186ead8570503ea648e.1555494108.git.mchehab+samsung@kernel.org/
> > 
> patchwork didn't get it (or didn't accept it). I got it now.
> All patches applied, and pushed out to hwmon-next.
> 
> We have one (new) unconverted file left - Documentation/hwmon/lochnagar.

Plus ir38064 and isl68137. Lots of new drivers recently.

Guenter
