Return-Path: <linuxppc-dev+bounces-26519-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ABBC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:04:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmBG04TLz2xfj;
	Fri, 04 Sep 2026 16:04:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788500594;
	cv=none; b=Jnhdxh6nrVbq30i8po5u140FwT+mhJ7aVnqGKG0Eu7+LBrc7tLsLDNVtUucm9Q/vNswDpUDldwowcwHurCqHeJlqb7ksDmTRGkzjV/zaWyc7XXyIhirHY5faIDa1GhUPH3vG/JqiMneCEHG3F2yi9Lj/EmaPgsMM9vUxoB97EKonzkQQYtHMo7cqueJMmCfvg57hLwktRdbQeHfpeP/UPT1gyMUy0QDDBFycTdPw74qfIEhU9Rxi0AKft4jXiEbyj88AYUM+SVCNKpW78PpTHwIFhmxWzttOOdGnWXTBjOme5ODSbwQQz6oTorjoOXxmzUbnnk9UhpfokhP3oUhs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788500594; c=relaxed/relaxed;
	bh=fyaQ4vR8zK9HgI6ETSL4jxpRT+46yI+OILInPbjhckM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM4NrMvq+o2GnS+6BPxSslV37oLGeQG9SRnR6+czTbxmSBcX2hBcusp1Wj/X69STUdh9ZbW8UBUr4Rw0ci1Fthh3P0I49jJ68yXmh+T1mcUmamjUfn+OwhYLcMqrbvhq5bOxPcU11zNkhBkcHtaeXgqkpVdJjKACN2o7yy9XQXaJx+weH9TfwpPFAiClHc0aqpkyXILbWoScIMDcsQ0LQpA4Eo+7Z9DNHDtXgeVR6AVIM7crg6co9jH+4t0tQi0RQEsJZNTyCRIz4lIhV98ulutkEYcEy+spLGS8L1BUFlVAZ0cBaQ2zsyo/1+Bgc194UFCTxx59azaON8qkxSBW4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G3lIJUkD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G3lIJUkD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hblk834qHz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 15:43:11 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-39927410578so859665a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 22:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788500588; x=1789105388; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fyaQ4vR8zK9HgI6ETSL4jxpRT+46yI+OILInPbjhckM=;
        b=G3lIJUkD3JfukQZAi5gyOyxyJzDNQM6ex+VeZ/ChNcsTg1y0aevTg0YICbsTObcxFm
         TcoBKZGHOYIoQ3spGsV7NHQmZdOuTltuSJqpQLJu3JwYCH64RKHBXxcPViFnpgGc2qEJ
         AoaoSQG3FPwcSKXNSLEjHJEZlYVWLpDuFlRw2hmsZ7oCXc2rLsBi8tMbAp/A+mfjgcqU
         vsmiJ4YwGPdX4Tfq/1tNa0wMy+84nTJihMyOPAfbU9eVPznFIWgcKLrQcjFOiRFKQlbX
         i1L8ixBmq63pozboxAtGU4H+Iu7o0PT/CXGWWzVnX640aF5lITonTuNKzNT82PjdAnOY
         htzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788500588; x=1789105388;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fyaQ4vR8zK9HgI6ETSL4jxpRT+46yI+OILInPbjhckM=;
        b=GvpAFCXk7v2jxZUtKRQQedPImETHJO3CaR1pBDqDogGluNtAQEYSlddiDtMVoVStRC
         QzIhXlqRI9+bgBZNUdouIzWE7e69nRhyQJNpF/qV/BqlO7lbvIS3xXMRWQihFYagAqVd
         5OJ7hpo/klsP8rHIuLk9/XxRK+nCizYoGk43GzKJOlcT7Y2HNsJIcHLE2Kq34L60Vbuj
         wAMLDbyeDoHzr6AHD1k5xUGNibWFuHT+5hTlfKz/GzxUyCtNy7qzLDShxbPPSFpzNRVe
         ZYOtmHGgp3odo/tjvOMe7exJ/VVb74umA9FBQh4Tz0QVXMfX92SuFYuATY3VK4ps/+yL
         8HOQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5f2X8EtNdI4sglr1tHukmAeoLilfxNdXMgRI4w3r8b6yjnwbE7hVh1UnLs7lA/p2zQdmFmOLLFLoTajo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mXvhW+QwzxZsYTBfD0n/EPBh6Qr8+dsj7DeIJwU9XogDqADOLk
	/t/Ht6ps04tpxoJ2KYAXXy4I4jfp08lT4QAJboQnUIC8EkpVuf+48dQb
X-Gm-Gg: AYBFou0A5zDt7C+XT/NGKzonnqzY5/MBM5AaJbCbKbIzcGyQtGnL22JuxbwsZPiLOYs
	E2xTcPea8Jv38sQyO3Z4oFZU2mzvWkMl+fqGUzvo8SCj+Aj4iDQ97bh4ndjcUUPl50PiozMQ+EO
	V1Zl5w8dmFByxVLiByZzBCrOXed8iucalj33Rv8eNU4c0TL0js53WxYJf6hMLrdg9kk3ahAn4N0
	hxrvsQKXSyvAq5cnW7waT+DDdOhNf/qjW35VIsyz0/pqclr15sAxjAB+nlctTpSdtLLceJsIHxl
	9AFbByaojRSQYGyEatimqL4PRJIsUNCR9c1utn4gp3DWqVNqvDyc1Ui6f7iPRFbCIZAgPfdMFkK
	PILi+tn/PMVue29pPyOE/IUoH7Q+V6l5Izp6IQBYRctXnQG0Es1t9gfntG8BlHcAm3qyh1quxbf
	fvT4vPp4YgxKpt3gbHNBRDxyqZM4oiENtH2uzxRgPD6V4ZU6c3sqd4yb9TVrYdThi97a7qOMbM9
	5HGdaJBjSZWlt9a0QDHO4yjkfPqSE2eot6B
X-Received: by 2002:a17:90b:4a49:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39b26100cd2mr5232253a91.2.1788500588005;
        Thu, 03 Sep 2026 22:43:08 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.52.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2615039asm2556683a91.15.2026.09.03.22.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 22:43:07 -0700 (PDT)
Date: Fri, 4 Sep 2026 11:13:01 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Power9 pseries boot hang in v7.2-rc6, narrowed to
 PowerPC GENERIC_ENTRY conversion window
Message-ID: <appZ1UB1tzKz3IY9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com>
 <e27eeaf4-c2c9-4ef7-9e1c-0a5fb45755d0@linux.ibm.com>
 <6d1b5f38-f4e4-46ca-88b4-7c18dd6c6280@linux.ibm.com>
 <anq72IebDSu-wWbb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <ansZjSJMWMV8DDF-@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <2f7e6c34-7258-4b20-a38e-cedebccb835f@linux.ibm.com>
 <985770a7-e488-456a-a9fa-aa71f1cbafd5@leemhuis.info>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985770a7-e488-456a-a9fa-aa71f1cbafd5@leemhuis.info>

On Thu, Sep 03, 2026 at 01:22:35PM +0200, Thorsten Leemhuis wrote:
> On 8/12/26 07:16, Venkat Rao Bagalkote wrote:
> > On 11/08/26 6:16 pm, Mukesh Kumar Chaurasiya wrote:
> >> On Tue, Aug 11, 2026 at 11:37:45AM +0530, Mukesh Kumar Chaurasiya wrote:
> >>> On Mon, Aug 10, 2026 at 05:19:27PM +0530, Venkat Rao Bagalkote wrote:
> >>>> On 04/08/26 8:23 pm, Shrikanth Hegde wrote:
> >>>>> On 8/4/26 2:04 PM, Venkat Rao Bagalkote wrote:
> >>>>>>
> >>>>>> I'm seeing a boot regression on a Power9 pseries LPAR. The system
> >>>>>> hangs very early during boot after:
> >>>>>>
> >>>>>> Quiescing Open Firmware ...
> >>>>>> Booting Linux via __start() ...
> >>>>>>
> >>>>> That is strange. not sure where to look at without any logs.
> >>>>> Is it a specific config that fails or this specific LPAR that fails?
> >>>>>
> >>> Is this a specific lpar or all power9 pseries are exhibiting same
> >>> behaviour?
> > Its specific to a lpar.
> >>
> >> Can you try the below fix?
> > [...]
> >
> > I tired this fix, but issue still persists.
> This regression made it to my list of tracked regression -- and it looks
> like this stalled. Is that the case? Or was this resolved meanwhile?
> 
> Ciao, Thorsten

Hey Thorsten,
I am working on this, as of now I have a theory that the RMA size
boundry is being crossed by something and causing this thing.

For now the workaround is disabling KASAN. Can you also confirm the
same.
Can I also know the compiler version you are using?

Regards,
Mukesh

