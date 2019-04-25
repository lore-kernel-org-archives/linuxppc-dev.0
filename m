Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E11C43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:32:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA9C20717
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 16:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIxieLUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA9C20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qjPx0RF9zDqY6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 02:32:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIxieLUP"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qhJY1XJXzDqYW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 01:42:20 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id k19so58141pgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fdGRNyUQlpc4HjiFlwZawue24kiF5g7GyMltLZfo7cE=;
 b=YIxieLUPcMA5EY/ryz/w3MSDrHtVKhB0buP5Ib9v2TtDcrgrLatRkRvmwcaFgImjog
 rxhPiSaeNOz5dkfMh7ZHxpqoA4NqsqKw89f3Z+JMEyoau91GLZmMdnvke0dUQAZcO7J+
 O0lfbBVh/k3/SnSW3V8u8M2e5//l8DeJXd2AKiB7uaMwWIXoQ5gOvC5If6VwBDVWffzL
 V+flPXi9xp3Dj5DOxTJjJDjnHOChw+HGMGDQebfCEq5LNIgNeMAKxqLq+Taa/fdxXpve
 H/LlHOz/jS+mZ1iN7+bGG1Jfb1a1EwwCRpNnJlHmjTnmhbfUozKFuMCCbJ5YXwtJ5ksW
 0rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fdGRNyUQlpc4HjiFlwZawue24kiF5g7GyMltLZfo7cE=;
 b=iPaguDuy6lqQUP6OLVqZqbp0dfiall+QLU+cVvRj0Rsygf/e6HkMdqMHsLPtGdZgT2
 T5oExW3tCKLUt11/kiqO0SMOdKXG/ucaJiAhEUW96I422zVIV02sGhX88d0pnDPXNAU0
 sFmUVk+s4Bb5ErW85yvBoDVjbFiAAv+OYRdI969i8zC5sKPXYCb7/+rrXwruHL1YQczb
 Q33hZ7oviDpArfwVrsv63pa1WEK2ZKF+K0/q49zI5CH/5MkTSekTwe0k1t6qC8FNvvds
 alIqWa4xI7X4pz1fsy7BOzVLngdf2U1iqFEobfGUa1mC4DyMozWD0WwmuNHv2I/Id604
 H3kQ==
X-Gm-Message-State: APjAAAWeuoN+uuch4FLeYfeqzYO/U5e+i2zjayRfk8aKQ7eH0Cbro54v
 hgsVFvC2yvLJ3/8iRNGo6fz3hfm3
X-Google-Smtp-Source: APXvYqyeeWmVX0kg2+bRmqQrJjqbejE5dDoGnKIs4kkB8kuPCsHm+s3GgBBlCTp7tZUOrfb0T+9NTg==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr40431342pff.35.1556206938879; 
 Thu, 25 Apr 2019 08:42:18 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id z22sm23504071pgv.23.2019.04.25.08.42.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 25 Apr 2019 08:42:17 -0700 (PDT)
Date: Thu, 25 Apr 2019 23:42:08 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 25/63] Documentation: add Linux PCI to Sphinx TOC tree
Message-ID: <20190425154207.admsorr4ztmqxqv2@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-26-changbin.du@gmail.com>
 <20190424120336.4f66cbb8@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424120336.4f66cbb8@coco.lan>
User-Agent: NeoMutt/20180716
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
Cc: fenghua.yu@intel.com, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 24, 2019 at 12:03:43PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:54 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > Add a index.rst for PCI subsystem. More docs will be added later.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  Documentation/PCI/index.rst | 9 +++++++++
> 
> On a past discussion at docs ML, we've agreed to use lowercase for new
> stuff. My suggestion here would be to use lowercase for "pci".
> 
> Also, there's already a pci directory under driver-api, added on this
> commit:
> 
> 	commit fcc78f9c22474d60c65d522e50ea07006ec1b9fc
> 	Author: Logan Gunthorpe <logang@deltatee.com>
> 	Date:   Thu Oct 4 15:27:39 2018 -0600
> 
> 	    docs-rst: Add a new directory for PCI documentation
> 
> I would just add a new section at Documentation/driver-api/pci/index.rst
> with something like:
> 
> 	Legacy PCI documentation
> 	========================
> 
> 	.. note::
> 
> 	   The files here were written a long time ago and need some serious
> 	   work. Use their contents with caution.
> 
> 	.. toctree::
> 	    :maxdepth: 1
> 
> 	    <files converted from Documentation/PCI>
> 
> And add those documents from Documentation/PCI into it.
>
Bjorn, Jonathan,
Do you agree with this? By this all Documentation/PCI/* will be moved to
Documentation/driver-api/pci.

> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
