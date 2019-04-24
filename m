Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2938C282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:59:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D6A20652
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y8nxckKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D6A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q7Pl6Y4nzDqJP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 03:59:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Y8nxckKt"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7H13NSczDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:54:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B4WEGbnCyfW0Q3Xttpd8TsmO+qZt8FAt27+U8RemGZY=; b=Y8nxckKtP/K4PlyahScpltMG7l
 +mEFwN711HmK/Gaw8WY/PvSMElTYdfrb3bYool6kSS5bMv7B/2CAWM1F+Lhd6FGfzAqPkG94taHjT
 g0I3j8sjV49VSGPRWSZof+iKL9ajYk9yCFEHbiz2scV9DQjsMexUowd+vD1QhgDjJ+kLH0gYqivPo
 5P69F7ffYMR+3mmzLHz+yr92ujdYHOnjG91H8ITHr6JXhrOggoQ/V8G6mVsRFVOQscGf3JRvoNCLe
 A3JpC0ZAWesWhGt+x+ZlctOKT8vtO6/Iqz7ZtF6yLXRfOwjqTTNVRSlcjND/SrAxvStsV9JX2IZ0t
 H3sf8hMw==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJM5j-0000Pd-7c; Wed, 24 Apr 2019 17:53:55 +0000
Date: Wed, 24 Apr 2019 14:53:48 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 09/63] Documentation: ACPI: move
 method-customizing.txt to firmware-guide/acpi and convert to reST
Message-ID: <20190424145348.0631c8a1@coco.lan>
In-Reply-To: <20190424162850.g5ripuixdkvvzsjm@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-10-changbin.du@gmail.com>
 <20190423180316.7f042bc4@coco.lan>
 <20190424162850.g5ripuixdkvvzsjm@mail.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: fenghua.yu@intel.com, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Thu, 25 Apr 2019 00:28:52 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> On Tue, Apr 23, 2019 at 06:03:16PM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 24 Apr 2019 00:28:38 +0800
> > Changbin Du <changbin.du@gmail.com> escreveu:
> >   

> > > +.. note:: Only ACPI METHOD can be overridden, any other object types like
> > > +   "Device", "OperationRegion", are not recognized. Methods
> > > +   declared inside scope operators are also not supported.
> > > +.. note:: The same ACPI control method can be overridden for many times,
> > > +   and it's always the latest one that used by Linux/kernel.
> > > +.. note:: To get the ACPI debug object output (Store (AAAA, Debug)),
> > > +   please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".  
> > 
> > Hmm... this may work (not sure if Sphinx would warn or not), but it
> > is visually bad on text mode. I would code it, instead, with something 
> > like:
> > 
> > .. note::
> > 
> >     - Only ACPI METHOD can be overridden, any other object types like
> >       "Device", "OperationRegion", are not recognized. Methods
> >       declared inside scope operators are also not supported.
> > 
> >     - The same ACPI control method can be overridden for many times,
> >       and it's always the latest one that used by Linux/kernel.
> > 
> >     - To get the ACPI debug object output (Store (AAAA, Debug)),
> >       please run::
> > 
> > 		echo 1 > /sys/module/acpi/parameters/aml_debug_output
> > 
> > As this would make it visually better on both text and html formats.
> >  
> No warnings given.

Interesting. I'm now wondering if it did the right thing or if it produced
some weird output... Maybe the answer depends on the Sphinx version one
would be using.

> Your suggested style is better so applied it. Thanks!

Thank you!

Thanks,
Mauro
