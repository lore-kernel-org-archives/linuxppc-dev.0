Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171EFC10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 03:51:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8447420835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 03:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5Svs29E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8447420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kSvm3CBhzDqDY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:51:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="i5Svs29E"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kSsv00D0zDqHF;
 Wed, 17 Apr 2019 13:49:36 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id y6so11326908pll.13;
 Tue, 16 Apr 2019 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9DHw/jF/PpaNCEANBTI+YbvaJ8TD0OFM8JDdklRcth0=;
 b=i5Svs29EgAr2DT9P09QaoVU5+hOc0bgN5mwiBbanAN45k97dkdovK/BlS4fOKZC3Lr
 lwf9mNnTuN85I1jny6pgpwEjB5IEWO5Kuj8Eos4vxVpkpO0Gzb3Z0FSH/Xq1HoiJufN8
 A+Swa3wFGVw0QlSyztXIkU6kYy+tkAvR5If2u2s27jGst+A+D9Td3d73uoAmTRKY7pAY
 LG1UFuWZInis7uxvtPYGuo64+eT0/prmK488l0MnP9Io6koZpzOGyRP3RA+e4TYymYGH
 nesH8Daw9NImmUEtkD+FXXdyszoAcEe2fXkhrZvPJr/EJl4yoUAJI5zn/r7VXSm8urgX
 TdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9DHw/jF/PpaNCEANBTI+YbvaJ8TD0OFM8JDdklRcth0=;
 b=Mi8CerHxDg0NbkvR/eh0xvqvq3Ln+vxA8ZTjZaa5cgsj+9Jj+yRvk/7DS0YK2gJPi+
 Y5R4AK2j5Ui6TusqeqqjaRuLoPbXCA/J3ftbbNsTmTgNZuVWK3SIHxBgKXOdPsN+Cr95
 AVnysxmC/kMcXvsNn0P5ghh/VwFoXsY2wQwjW8IWmY8gaoZkbujk3m32HlkjYk9j8R/J
 F8ZXAFINalC7RW9W9eVlTbF1dPRFrEtXPoZpZQpXh9iHRg42+Ry2aQxAkzxYzim6yUTw
 1h2QsXxscX7TL/JmlGSnLFUeodRyNRkB+X4X8WILbDsAqgAZ2zZMCkfWBr3D7sgm3g+9
 A6EA==
X-Gm-Message-State: APjAAAWp01WujlCRL5A89krHwuUoRBlYHi55JcBXPJWznTatLvRKbmKz
 8VIylqlm/Qvba1CmvAu44v8=
X-Google-Smtp-Source: APXvYqyhKYuRN96dQStz/269gpggAMU/dgElpUC3S3KlvGPU1e8KeWXhFOkxAmLa26o5YbPxKOnMcw==
X-Received: by 2002:a17:902:9341:: with SMTP id
 g1mr49225182plp.81.1555472973777; 
 Tue, 16 Apr 2019 20:49:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 a17sm96997965pfj.123.2019.04.16.20.49.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Apr 2019 20:49:32 -0700 (PDT)
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net> <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net> <20190412100451.6fe49de7@lwn.net>
 <f900adea-d231-c00d-847c-33e66e79ea30@roeck-us.net>
 <20190416141949.09b48789@lwn.net> <20190416203114.GB25517@roeck-us.net>
 <20190416225836.1d5953bc@coco.lan>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1d8a4410-4a8c-7b7a-141d-d2495cc66749@roeck-us.net>
Date: Tue, 16 Apr 2019 20:49:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416225836.1d5953bc@coco.lan>
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

On 4/16/19 6:58 PM, Mauro Carvalho Chehab wrote:
> Em Tue, 16 Apr 2019 13:31:14 -0700
> Guenter Roeck <linux@roeck-us.net> escreveu:
> 
>> On Tue, Apr 16, 2019 at 02:19:49PM -0600, Jonathan Corbet wrote:
>>> On Fri, 12 Apr 2019 20:09:16 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>    
>>>> The big real-world question is: Is the series good enough for you to accept,
>>>> or do you expect some level of user/kernel separation ?
>>>
>>> I guess it can go in; it's forward progress, even if it doesn't make the
>>> improvements I would like to see.
>>>
>>> The real question, I guess, is who should take it.  I've been seeing a
>>> fair amount of activity on hwmon, so I suspect that the potential for
>>> conflicts is real.  Perhaps things would go smoother if it went through
>>> your tree?
>>>    
>> We'll see a number of conflicts, yes. In terms of timing, this is probably
>> the worst release in the last few years to make such a change. I currently
>> have 9 patches queued in hwmon-next which touch Documentation/hwmon.
>> Of course the changes made in those are all not ReST compatible, and I have
>> no idea what to look out for to make it compatible. So this is going to be
>> fun (in a negative sense) either way.
>>
>> I don't really have a recommendation at this point; I think the best I could
>> do to take the patches which don't generate conflicts and leave the rest
>> alone. But that would also be bad, since the new index file would not match
>> reality. No idea, really, what the best or even a useful approach would be.
>>
>> Maybe automated changes like this (assuming they are indeed automated)
>> can be generated and pushed right after a commit window closes. Would
>> that by any chance be possible ?
> 
> No, those patches are hand-maid, but I can surely rebase it on the top of
> your tree. Is your tree already merged at linux-next, or should I use some
> other branch/tree for rebase?
> 

linux-next merges hwmon-next. next-20190416 is missing one patch which touches
Documentation/hwmon, but that should be easy to deal with.

Thanks,
Guenter
