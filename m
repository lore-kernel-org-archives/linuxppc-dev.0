Return-Path: <SRS0=KSz9=SP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C938CC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 00:53:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB2C20850
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 00:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH1Zelfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB2C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gx8h1tz7zDqWw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 10:53:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WH1Zelfw"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gx6w3wqkzDqVM;
 Sat, 13 Apr 2019 10:52:08 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id n8so5872270plp.10;
 Fri, 12 Apr 2019 17:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FAOFcqGmAyWqRgqK+hze86G4KUWhAcKaMXCl1prsD7U=;
 b=WH1ZelfwVnWq8wfRpDlMD10uUdU4Yzwvl2MVee4roCocPTsQszssvpu7mYqNa7S26u
 hqkFJQYJZLikHqgzZ7GxIYc25grjdbXDF92YLkUCGkFIy6fj+f8c/63ver9r867/734G
 FgP+MqH/EjOOnF6DrHfr5w1JXmds0Rvo98YNl3tc67TRnEKqfgoshit9eXFZ+2eWfaCe
 FtJg1pyFnhHK/T7VzvYSZjcWMtOrLxkRFTT2fj+VUa3EuPZC9WzzsexiAH1PB7UbjsfU
 iGa42KAtl0SWUaxzxebYjUV5Tk/rzCAihMnzZAL+0hSTK3AssYuDL+VAR/DVBEsYAnkT
 uxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FAOFcqGmAyWqRgqK+hze86G4KUWhAcKaMXCl1prsD7U=;
 b=FqfizJ17cIlcH2a+N61v+GFgAlvbBbBDa/L4EUhdbWXNVcee6GSYSG+TlBfKMYls3A
 mAwwredCoQN2vF2mra4O7Z1jGgY1PNbg9w7i0xcjCAqVXoHOd56Jq300Gdg5QuGWQi4x
 vQqvF8p3pKKctMvo7AFslduzbL4eNzHO3tV/dRxAJ3TT2FgiVgMPuuorKLQlbW5hhIck
 +CtuuIV4NrGQvgU9RFJAtOSWO/8E3pInXx4PyD/Ul1ntWkbtnZtMA/MaFu1YuWHuNA+K
 Ee3MEQ4Bl+HXAEJIAk/i8oTH0V6Y6V7ZRw74m8rdW/hr7OFeDukbc3w6tok7j6Z//MTW
 lTEw==
X-Gm-Message-State: APjAAAXjumvY0/3IkuPQWUJKAeReCPheidL8HwO9xgyLqC69HIetL4Qx
 8FHVv3LokNjcBWCU0cliTNM=
X-Google-Smtp-Source: APXvYqw/Lx/YxaORzJCKB74OjskQexdw6lmOnEtqKF2cGzIqRN9VZsE8gDodjoH8h/y4lpDS8vTpAw==
X-Received: by 2002:a17:902:bf07:: with SMTP id
 bi7mr31595426plb.87.1555116725223; 
 Fri, 12 Apr 2019 17:52:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 i24sm58250206pfo.85.2019.04.12.17.52.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Apr 2019 17:52:04 -0700 (PDT)
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net> <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net> <20190412100451.6fe49de7@lwn.net>
 <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
 <20190412212541.0cde9452@coco.lan>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f1b5ebcd-bd8c-817f-1394-fd2742c5d8b3@roeck-us.net>
Date: Fri, 12 Apr 2019 17:52:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412212541.0cde9452@coco.lan>
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

On 4/12/19 5:25 PM, Mauro Carvalho Chehab wrote:
> Em Fri, 12 Apr 2019 09:12:52 -0700
> Guenter Roeck <linux@roeck-us.net> escreveu:
> 
>> On 4/12/19 9:04 AM, Jonathan Corbet wrote:
>>> On Thu, 11 Apr 2019 14:07:31 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>    
>>>>> While nobody does such split, IMHO, the best would be to keep the
>>>>> information outside Documentation/admin-guide. But hey! You're
>>>>> the Doc maintainer. If you prefer to move, I'm perfectly fine
>>>>> with that.
>>>>>       
>>>>
>>>> Same here, but please don't move the files which are kernel facing only.
>>>
>>> Well, let's step back and think about this.  Who is the audience for
>>> these documents?  That will tell us a lot about where they should really
>>> be.
>>>    
>>
>> Most of them are for users, some of them are for driver developers. A few
>> are for both, though that is generally not the intention (and one may argue
>> that driver internal documentation should be moved into the respective
>> driver source).
> 
> The big issue is really those files that contain both kernel internals
> and userspace stuff.
> 
> This is a common pattern. I just finishing converting a lot more
> documents to ReST and I found the same thing on almost all document
> directories I touched.
> 
>>> What I would prefer to avoid is the status quo where *everything* is in
>>> the top-level directory, and where documents are organized for the
>>> convenience of their maintainers rather than of their readers.  But
>>> sometimes I feel like I'm alone in that desire...:)
>>>    
>> I am fine with separating user pointing from kernel API/driver developer
>> guides, and I agree that it would make a lot of sense. As I said, please
>> just make sure that kernel facing files don't end up in the wrong directory.
> 
> I like the idea of splitting user faced documents from the rest, but
> this is not an easy task. On several cases, there are just a couple
> of paragraphs with things like sysfs entries in the middle of a big
> file with Kernel internals.
> 

Yes, I know. I don't think that cleanup is going to happen anytime soon.

Guenter

