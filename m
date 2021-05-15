Return-Path: <SRS0=MZVM=KK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EDEC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 06:01:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D946613BE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 06:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D946613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fhvsv4GDVz2yxP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 16:01:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.221.52; helo=mail-wr1-f52.google.com;
 envelope-from=kswilczynski@gmail.com; receiver=<UNKNOWN>)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FhvsR3L2Pz2xv0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 May 2021 16:01:15 +1000 (AEST)
Received: by mail-wr1-f52.google.com with SMTP id d11so1154717wrw.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2021 23:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JkSeLIOi1XsqvtB3PIN4CWiYL7hLWk6kcS/roE9DJ7s=;
 b=pa0KoSocsrfxlJAGXUFIbtL/eQrt28RUDgiyhTthSTqZSRtHQFhDti1dWQ3wgltr9Y
 5A7ny9kILrSqMZdh9A4C1aKV1ccn6PmuvZCvduGv8jJHDJuKyWWhALvruQmGjPOv+H1t
 lb4n4BsU+RbWvzgNb4OjRmoY35pAZL0hoj9hRf58BifCEUxj7SmNuuP/cufcpSk6VFtc
 RwsMooDYUgc0fyC8e552vTfLeRHtlPZ++ViZGI8gEIKwM3toRtP6zYLUX02Kzcu1YEhI
 Brv2dLKSr0HtrcV+4OxDQBxBE9XSYxoI/6QD7icBfBgE64eQ3STIcCxOxbs1rVhLKnks
 bDpg==
X-Gm-Message-State: AOAM531Pudd1wQK7V8PNn9MoHqolptA4TDtRDBDbxAKXS4YaFMQ8kl1K
 FgztPPkWsEI5XCONtaJMPew=
X-Google-Smtp-Source: ABdhPJxHpUO8jCc/3XDGsSvDOb3m3mGWo5EJbgLdFGqxSSCd5zfY0gS/R12Oz3bbIYAWMo1NwHxbjA==
X-Received: by 2002:adf:e944:: with SMTP id m4mr20272312wrn.10.1621058472167; 
 Fri, 14 May 2021 23:01:12 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
 by smtp.gmail.com with ESMTPSA id d15sm5238372wrv.84.2021.05.14.23.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 23:01:11 -0700 (PDT)
Date: Sat, 15 May 2021 08:01:10 +0200
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 04/14] PCI/MSI: Use sysfs_emit() and sysfs_emit_at()
 in "show" functions
Message-ID: <20210515060110.GB73551@rocinante.localdomain>
References: <20210515052434.1413236-1-kw@linux.com>
 <20210515052434.1413236-4-kw@linux.com>
 <d156a893bae41967e9fadddb3397cf47bcdde239.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d156a893bae41967e9fadddb3397cf47bcdde239.camel@perches.com>
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Vidya Sagar <vidyas@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Paul Mackerras <paulus@samba.org>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Joe,

[...]
> >  	if (entry)
> > -		return sprintf(buf, "%s\n",
> > -				entry->msi_attrib.is_msix ? "msix" : "msi");
> > +		return sysfs_emit(buf, "%s\n",
> > +				  entry->msi_attrib.is_msix ? "msix" : "msi");
> >  
> > 
> >  	return -ENODEV;
> >  }
> 
> trivia: reversing the test would be more common style
> 
> 	if (!entry)
> 		return -ENODEV;
> 
> 	return sysfs_emit(...);
> }

Excellent point.  I will send v3 later that includes this style change.

Thank you!

Krzysztof
