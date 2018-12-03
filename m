Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA58C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:01:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C042920850
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 21:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK2EQLqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C042920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437y923LXczDqd2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:01:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eK2EQLqr";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=richard.weiyang@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="eK2EQLqr"; 
 dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437y5X31ZwzDqW4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 07:58:40 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id x30so12036679edx.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 12:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3TjY3JWxdN3/18b9FENgNpkOG6/DFzbiy3Q1rL9wrR4=;
 b=eK2EQLqrqT3U6tTkIigQ3nYIi9V+OJ9VoHQ72VljO5poz2VGk8+kJ8bmuXe650t1zs
 FAMYs6LUkL1DoBh+OV6D43igmhMAIjASg1eeGp32mJx+lUP4TKfQXlvdu5m3h3SvH5Hf
 gxNSRYKrOFEr8WpFftNNlJOwn5OUhMP3GiMH5UvcTz9Icgef7JfcbYlESseblzAyWdoN
 K5D84KrPmTzUCOY2XNaxUFBowoWUsV4cvRyGBjRrpCoKJ0xv7arXNu+iOR7g9Cvb2X0z
 acbwa8EzzLeilIVT1asrlBv0Ca+Sa+w5WnyFmPrsSkOtyqEhAUPevOa83ooUAkqd5qqe
 WwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=3TjY3JWxdN3/18b9FENgNpkOG6/DFzbiy3Q1rL9wrR4=;
 b=TMwyPNY9+7KJb7uALMSgOVCDg6km93r+pYz9i1c0YS6JKS/MCs48stLKrlscEiy8vy
 hyvXAghCsqkpDgCml8f6Xy/rdouszuZkkLX+G545OVgElPnKMM+2rHVeROBCCZ53D5M5
 lHtsmg/XV67J+aInnLXmg/eQkNwst7yTbi0kw8Robty8LvZ2c2SYxMR4xWAzByLJtYu8
 KkVMPrfOYlqzrp5ds6lSQPAAmOryE88WeEZ5nbWBtuCXIgW4zsAITOUzvMcINvQqIucm
 ApVPViRYJUjHnzo/O/Jyuep23yYQrodFpWAEwSim/zyPM7FyVUsvDCz2LmQqaXInUZTf
 G+VA==
X-Gm-Message-State: AA+aEWZFFGIXgzjkn+htoHkH6q8O686RyPGOippK1AXeJTOPlwAlUnPE
 Yr8/VmcPDB5lyNDJYNQcqXA=
X-Google-Smtp-Source: AFSGD/WMWTB2dTi58E5OxTsZF0JX6bmZAQwXQEDEvQe7PJaAaMdeaoN76UoT5tHsUZM+pBBwzOrllw==
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr14813776edd.188.1543870717497; 
 Mon, 03 Dec 2018 12:58:37 -0800 (PST)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id e53sm4158738ede.90.2018.12.03.12.58.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 12:58:36 -0800 (PST)
Date: Mon, 3 Dec 2018 20:58:36 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 1/4] mm/memory_hotplug: Introduce memory block types
Message-ID: <20181203205836.7xpab6ljc3kngrqm@master>
References: <20181130175922.10425-1-david@redhat.com>
 <20181130175922.10425-2-david@redhat.com>
 <20181201012507.lxfscl6ho3gc6gnn@master>
 <af797dbb-0537-19ec-ef31-d72a3f979791@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af797dbb-0537-19ec-ef31-d72a3f979791@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Oscar Salvador <osalvador@suse.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org, x86@kernel.org,
 Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Michal Such??nek <msuchanek@suse.de>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andrew Banman <andrew.banman@hpe.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[...]
>>>
>>> +	if (type == MEMORY_BLOCK_NONE)
>>> +		return -EINVAL;
>> 
>> No one will pass in this value. Can we omit this check for now?
>
>I could move it to patch nr 2 I guess, but as I introduce
>MEMORY_BLOCK_NONE here it made sense to keep it in here.
>

Yes, this make sense to me now.

>(and I think at least for now it makes sense to not squash patch 1 and
>2, to easier discuss the new user interface/concept introduced in this
>patch).
>
>Thanks!
>
>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
