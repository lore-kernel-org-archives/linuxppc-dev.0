Return-Path: <SRS0=31b2=KF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CC9C433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 May 2021 10:30:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096BE61971
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 May 2021 10:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096BE61971
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fdy4f28KQz309N
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 May 2021 20:30:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.47; helo=mail-lf1-f47.google.com;
 envelope-from=kswilczynski@gmail.com; receiver=<UNKNOWN>)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fdy4D5cFDz2yRG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2021 20:30:18 +1000 (AEST)
Received: by mail-lf1-f47.google.com with SMTP id x20so22605377lfu.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 May 2021 03:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C1bGqFoAr3Dm/nAsPYbR3i3yRqydV4li4lsV6x+0ahU=;
 b=mQHaSZe1J6KpHRDDBOdNApA5HxfhngSLFq5mUm6OMi/RlSx8rVxiMxCpxeD2dNuoPX
 oe6KNLEtlLafyBYd5DDJ0XDGySzMoVNL0p1KAyiuHKRzLlNEkxqcTBQYvn84qNV7eGOw
 IB81bwm6AqhEm73DhSF/SCnJkyeKSJvC1ldMjBzxVyWtBE84X99yXeh9NcYpH/etgns+
 +legY+eK/cmstN42iYDthY6s5+YISmi+XJBQfsrA8P5Pg2hr2nXchjALuoYT+athBmAa
 zQgDw4aK+s42MuuEUmw0vYfvB/Nm2qmpSx3CaduDfidqS9WnudHif4SlruZUAtM72o1f
 DhgQ==
X-Gm-Message-State: AOAM530O0agE/XpdN0qx6AePZT2/S3iEcuYomodGGSply0lHwusvJgTF
 /tIpEneDQwx+FPFV3wgz6Fk=
X-Google-Smtp-Source: ABdhPJy6GbuSSAPp2pAx8zY67AVdFL8jT0JHBy6DiCzbVrHD4aswUk/VpnHqkQU4/IOS2CMNUPWApw==
X-Received: by 2002:a19:385c:: with SMTP id d28mr16254059lfj.13.1620642614189; 
 Mon, 10 May 2021 03:30:14 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
 by smtp.gmail.com with ESMTPSA id w4sm3201658ljo.1.2021.05.10.03.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 03:30:13 -0700 (PDT)
Date: Mon, 10 May 2021 12:30:12 +0200
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 01/11] PCI: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
Message-ID: <20210510103012.GA76437@rocinante.localdomain>
References: <20210510041424.233565-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
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
 linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>,
 Joe Perches <joe@perches.com>, Paul Mackerras <paulus@samba.org>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[+cc Joe for visibility]

[...]
>  	spin_lock(&resource_alignment_lock);
>  	if (resource_alignment_param)
> -		count = scnprintf(buf, PAGE_SIZE, "%s", resource_alignment_param);
> +		count = sysfs_emit(buf, "%s", resource_alignment_param);
>  	spin_unlock(&resource_alignment_lock);

Following the work that Joe did recently, see:

  https://lore.kernel.org/lkml/aa1819fa5faf786573df298e5e2e7d357ba7d4ad.camel@perches.com/

I think we ought to also add the missing newline to our sysfs_emit() and
sysfs_emit_at() users, like the one above and the following:

  drivers/pci/pci-sysfs.c
  540:	return sysfs_emit(buf, "%pOF", np);

To keep things correct and consistent.

Bjorn, I can follow-up with a small patch after this one, or send a v2,
or, if that would be OK with you, then you could fix it during merging,
provided you decide to merge things as-is.

Krzysztof
