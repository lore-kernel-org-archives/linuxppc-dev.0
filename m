Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEA3C10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CA42083D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 13:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG9xiBJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CA42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lKvv6Yh9zDqSG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 23:39:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UG9xiBJu"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lKrj2G5pzDqR7;
 Thu, 18 Apr 2019 23:36:36 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id e24so1116807pfi.12;
 Thu, 18 Apr 2019 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A3qEJxG71mV/MtOf4z6uQrRXkxG1lxjXuCfRlYLAv7A=;
 b=UG9xiBJuTZdQiPCaf+FajXBT+7nZRfAoNmTX8g9dpC0/oC1LH9qxdyWT1MKLanTzpA
 FLhx3F7qFv2MgUnwLoemztMXLFxSC5+O36L4177m1gLxkolhNuuTbqi242SbWgqAr5L/
 Dd67KQvZ3ISY24w3qmmdK1Sx+29U3Z0CCUXZCnUHVbFFy0GKDbeQKmmFy/Iglmgi13Ov
 1UYcd+VPeKavqGbHLvG339Cbp4i9PW+gXa0jp7lMY8S+QfKmeVvYTa7vYwmqEdokxblc
 3LgqA70Bzt//aNMD3l31CjJzynXzKLwBdbsDr8/nXTcAkh+2blUbU+MCxKDoW9qDugWS
 j81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A3qEJxG71mV/MtOf4z6uQrRXkxG1lxjXuCfRlYLAv7A=;
 b=c0CUGfs3v4MfPLXU0DvbYyJV4K58qxmn7kmpFt8zClNuuVQnuYidrbBglllcO+HFma
 cpMgAGEPX5wqPnNHOtjplzJtd8/Fs/f5An1kxC6Bq9Vz2Bw6/CiV1AozrJ77+fQA/WCi
 5kCS0/xNJ1SiokkI+dTnVGBxXYjTVSpRA3V6uV7dpIO3V8DQV8n8TiIVKRD9f3ro0Z+O
 S7rHfhQpzyUKfY3WZguNnMujUnFvwUrsdpH9DxRyfQFOf1rPhwYyabyTpEl8K+iJRMix
 3c1UXRxPZ12/Q5GP6aCRW0SmC9BZcupWyBBWfyBCQZguHV6tEx5a9RCEDV2ajFPhfUWK
 /Cyg==
X-Gm-Message-State: APjAAAXArRn1TUSIVBTW2MGXhet7B542Y+/O7N/wHHSA0IAPj+CChX4J
 jkN8Sq1pt/bX6aPTU2fwNNA=
X-Google-Smtp-Source: APXvYqzgjypd+v1qREA+odD5pdg0Ei3jnzbcdRlqFEDNryZG+QNyXDJ8tKREvIl5Fa1doKkjK6qipA==
X-Received: by 2002:a65:44c6:: with SMTP id g6mr37427292pgs.157.1555594593200; 
 Thu, 18 Apr 2019 06:36:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 a17sm5416860pfj.123.2019.04.18.06.36.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 06:36:31 -0700 (PDT)
Subject: Re: [PATCH v3 21/21] docs: hwmon: Add an index file and rename docs
 to *.rst
To: Mauro Carvalho Chehab <mchehab@infradead.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
 <20190417164741.GA12147@roeck-us.net> <20190417141352.3225bbb3@coco.lan>
 <20190417142215.791df5e7@coco.lan> <20190417174337.GA16749@roeck-us.net>
 <20190417174728.GA17706@roeck-us.net> <20190418064436.1803bf3a@coco.lan>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <55790eec-a81e-75af-dbab-e4f15ad14274@roeck-us.net>
Date: Thu, 18 Apr 2019 06:36:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418064436.1803bf3a@coco.lan>
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

On 4/18/19 2:44 AM, Mauro Carvalho Chehab wrote:
> Em Wed, 17 Apr 2019 10:47:28 -0700
> Guenter Roeck <linux@roeck-us.net> escreveu:
> 
>> On Wed, Apr 17, 2019 at 10:43:37AM -0700, Guenter Roeck wrote:
>>> On Wed, Apr 17, 2019 at 02:22:15PM -0300, Mauro Carvalho Chehab wrote:
>>>> Em Wed, 17 Apr 2019 14:13:52 -0300
>>>> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
>>>>    
>>>>> Em Wed, 17 Apr 2019 09:47:41 -0700
>>>>> Guenter Roeck <linux@roeck-us.net> escreveu:
>>>>>    
>>>>>> On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:
>>>>>>> Now that all files were converted to ReST format, rename them
>>>>>>> and add an index.
>>>>>>>
>>>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>>>>>>> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
>>>>>>
>>>>>> I applied all patches except this one, which fails due to a conflict in
>>>>>> ab8500. I also notice that this file has not been touched by your series,
>>>>>> which is odd. At the same time, patch 20/21 is missing from your series,
>>>>>> and has been missing all along. Does the missing patch possibly touch
>>>>>> Documentation/hwmon/ab8500 ?
>>>>>
>>>>> Patch 20/21 is the biggest one. Maybe vger rejected it either due to
>>>>> its size or due to the number of c/c.
>>>>>
>>>>> Just bounced it to you. Please let me know if you didn't receive it
>>>>> yet.
>>>>
>>>> Btw, LKML got it:
>>>>
>>>> https://lore.kernel.org/lkml/cccc2a52363a5aaeea10e186ead8570503ea648e.1555494108.git.mchehab+samsung@kernel.org/
>>>>    
>>> patchwork didn't get it (or didn't accept it). I got it now.
>>> All patches applied, and pushed out to hwmon-next.
>>>
>>> We have one (new) unconverted file left - Documentation/hwmon/lochnagar.
>>
>> Plus ir38064 and isl68137. Lots of new drivers recently.
> 
> Ok, just sent a patch for those three new files. I wrote a more
> detailed description about what steps I followed at the conversion
> of those tree files, and why I did it.
> 
Did the patches get lost ?

> Hopefully, this would help hwmon developers
> that may already be preparing a new driver for submission.
> 

That would be very useful.

Thanks,
Guenter
