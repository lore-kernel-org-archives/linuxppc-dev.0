Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69463C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 16:14:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FD920850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 16:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY/6cV7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FD920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gjdw5BV5zDqV5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 02:14:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VY/6cV7j"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gjbx5mcPzDqRM;
 Sat, 13 Apr 2019 02:12:59 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id 8so5378547pfr.4;
 Fri, 12 Apr 2019 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2j8BUcng0BwJmxMELQ9fVczmlAT/WBCK6nxFe8uX3w4=;
 b=VY/6cV7jFXJN+VI5kQu6aV/UCQZSuHhpb1UjdxNg/19uFHouW3/2HKjdLP/YC/Zdfn
 YFWXi4yQh4PxSXpjESu6wOJnT35Q6mGwwVKk5LvB6G0A1YokNZS9r0fLlKMwsv9OGblS
 olQZZWt2JhcWvuktRIHWCeql/J93l5RAAB/eRi4Pf2tOIu0TZGjTeGTnh/1UboeCu8+Y
 WxFCLCmReITPgXQm7bmobYDjHLcLq6lZw4rew+2q7mzwEO+otZhdeH+IFM4CSTvhS8gu
 pda6lSymDtbwxDV8Zw24AFcVgTJTlrTnOBZTDuEkM8jpY2AXcwCuGzf0bRS0SNsUswFG
 NMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2j8BUcng0BwJmxMELQ9fVczmlAT/WBCK6nxFe8uX3w4=;
 b=mUetv+pM0Vks999q+eJE445Oialbyrbu8IRLOT56Z4nhWPoNmVL5EtlLnMt+uVCsOB
 2PjLtqLHPiyaaM0RPN9Z0LBAYtGqkBxJJMGWzm45CU5yIc1EI2NNw0C8osxOh3oMvEm3
 HklR8N1a0Xz18bmdawIZRbygSCESwkYrtNIW8NQMEae8Q8IXv5AKtJs1p8CS7ERdpv99
 EOyOGamlTmPat97jgYSay090ZCO1ddaNUeNsYUFiiSM/RrYlBfp45ZSZ2vgaSLJXoWdZ
 R1Nht8H8Vw7jhejybBBgFdFewXAJ/P5AY2oCijYI8MmMRHjs+5mMi52a5hCrSsszWFkX
 NXvA==
X-Gm-Message-State: APjAAAVjMRlZIHZKC0rgUBUpN5Ep55JiVdjnfW3UkNqzUTDTFZ5/9Zwg
 NT266rSqFJFIN+HoDQYrN5U=
X-Google-Smtp-Source: APXvYqzlgQhXj11v8hPpOVHEl0vgqSzx0/7UQt1zJcBa3dDhwLJ+RJGk8OJeGm5efqOOlmZjVXglnQ==
X-Received: by 2002:a63:7c45:: with SMTP id l5mr54506453pgn.303.1555085575990; 
 Fri, 12 Apr 2019 09:12:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 b7sm123353710pfj.67.2019.04.12.09.12.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Apr 2019 09:12:54 -0700 (PDT)
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
To: Jonathan Corbet <corbet@lwn.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net> <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net> <20190412100451.6fe49de7@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
Date: Fri, 12 Apr 2019 09:12:52 -0700
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

Most of them are for users, some of them are for driver developers. A few
are for both, though that is generally not the intention (and one may argue
that driver internal documentation should be moved into the respective
driver source).

> What I would prefer to avoid is the status quo where *everything* is in
> the top-level directory, and where documents are organized for the
> convenience of their maintainers rather than of their readers.  But
> sometimes I feel like I'm alone in that desire...:)
> 
I am fine with separating user pointing from kernel API/driver developer
guides, and I agree that it would make a lot of sense. As I said, please
just make sure that kernel facing files don't end up in the wrong directory.

Thanks,
Guenter
