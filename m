Return-Path: <SRS0=KSz9=SP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638BAC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 03:11:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D6820850
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 03:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDiyHGnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D6820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44h0CG0Wx5zDqTy
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 13:11:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tDiyHGnK"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44h09J0H93zDqTq;
 Sat, 13 Apr 2019 13:09:23 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id h5so6019092pfo.0;
 Fri, 12 Apr 2019 20:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DFdelcsbDZnOoLCXquw1TPsIVEBVeGOXBP7F50+M7gY=;
 b=tDiyHGnKxP2xeh7wnf15wHLTb/s7fb0OGOB97fAviK1Xr3LrkKLuFSRGbKrU8mXpri
 t+cD7v4ScdsaHXynvJm5O5Uj3JmyKQw3qZfSlGIU2p2c09lXRWBz4bLqqyRn9Cv5ER6T
 K/nmUg4FLHGlpFAO7q8k8XQMFOVvhBnqS28c31pAsWgzIfqyiazn2zND5p3NYS7RVfTP
 Kxg+jgEiECO5W5QcuMoTSCXDJuh+5TfmEthOw/qSSbyPrxvXBpzdRti3zXGgULnpFthw
 mPnMMlTbG4BaiLZKu6YIcZml0T2cMCtMfZM723lVW1qJyNefE4TELy5ayJJYnoPJfra8
 ZMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DFdelcsbDZnOoLCXquw1TPsIVEBVeGOXBP7F50+M7gY=;
 b=e9Hrx7ajWKSPGzQKkVWexxfRASKbAYBM3b9j+0X+MGhF40AI523l3AHmQwrd4uYxC6
 tmfwRB+Ps2Q/01MzqyXmNfDEjWJOtrpRXM6xVTUngl8EW0Rlbi1mWI3ZBNMctLogQlJU
 2HDLO80nrMGdwLUIWa5XgpPshlHNwVB1KOmTKrsIEFk2fOI2ytd5R+t7s0RRktRtAxEq
 zYJkze2EwGTaFDirwJe4e3Un1rczeuyB5aMLqfUAs6Iki8p5DHz9qbS/4zuKg53ZZY0g
 /IKziBMAWyBRBgiJm2MGSuBi1slr8vsntQ2Xq/o9kFckCPf0bBj/tOiA0FuNfq6V8urQ
 k2fg==
X-Gm-Message-State: APjAAAUEtQ6VuqvzFZeOUs6nIxgT4xkvifKM/2dRp4brdVTTZYHPQeV+
 Xt4PJ32A6tUpvmbZfp6r2+0=
X-Google-Smtp-Source: APXvYqys27IV7eEME8zssn8b1sPRVx90pSTxxQ4us1eyyXmJinya5HOqYOULNI0gOho4ApmkZ+qXuA==
X-Received: by 2002:a62:1c54:: with SMTP id c81mr18715786pfc.122.1555124960165; 
 Fri, 12 Apr 2019 20:09:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 u6sm40106601pfm.10.2019.04.12.20.09.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Apr 2019 20:09:19 -0700 (PDT)
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
To: Jonathan Corbet <corbet@lwn.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net> <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net> <20190412100451.6fe49de7@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f900adea-d231-c00d-847c-33e66e79ea30@roeck-us.net>
Date: Fri, 12 Apr 2019 20:09:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412100451.6fe49de7@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 Andrew Jeffery <andrew@aj.id.au>, Sudeep Holla <sudeep.holla@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/12/19 9:04 AM, Jonathan Corbet wrote:
> On Thu, 11 Apr 2019 14:07:31 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> While nobody does such split, IMHO, the best would be to keep the
>>> information outside Documentation/admin-guide. But hey! You're
>>> the Doc maintainer. If you prefer to move, I'm perfectly fine
>>> with that.
>>>    
>>
>> Same here, but please don't move the files which are kernel facing only.
> 
> Well, let's step back and think about this.  Who is the audience for
> these documents?  That will tell us a lot about where they should really
> be.
> 
> What I would prefer to avoid is the status quo where *everything* is in
> the top-level directory, and where documents are organized for the
> convenience of their maintainers rather than of their readers.  But
> sometimes I feel like I'm alone in that desire...:)
> 

The big real-world question is: Is the series good enough for you to accept,
or do you expect some level of user/kernel separation ?

Guenter
