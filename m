Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CFBC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:54:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940B3206A3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="apvxgzVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940B3206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q5y45Vc7zDqXN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 02:54:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="apvxgzVO"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q5wG44mCzDqW2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 02:52:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dfaDfFq2WMrVb8w8teQDqmRHXr1poGmjBR5SGUSF5kk=; b=apvxgzVONgN/v/y+5LaL4ytTTf
 Aa8u0hZek6p+EtyIurT9iVqxNcSSG7nAeEDrOgoAuw9O6V4llL44zOETEPP5d3ntzPFIKQKVcgAnP
 7ai0Fk25T610ebHpVcR4WBFxIQKoTKNbzJZEz3JG6F9+Z9ZqCPxzTbw4XLfcRJKyzrYsD3Wy5QrKu
 ruL/a/zP2acV+7fXDKqRxByfwOs/eb1KaMUw/uZ3YDdQwSkEpkjg6xdhOjnyR6ISII0T77srkfYKD
 fO9rWmUEzvYnitf9qITragI3j2bGBreIKETC2eT81k0a29iLQI6DK2/arhQqfqu2VGH4ju9B8b/AA
 6KiX3mPA==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJL8M-0005a2-V1; Wed, 24 Apr 2019 16:52:35 +0000
Date: Wed, 24 Apr 2019 13:52:28 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx
 TOC tree
Message-ID: <20190424135228.58cdb9be@coco.lan>
In-Reply-To: <20190424101846.7cc4bad7@lwn.net>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190424101846.7cc4bad7@lwn.net>
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
Cc: fenghua.yu@intel.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-gpio@vger.kernel.org, x86@kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 24 Apr 2019 10:18:46 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 24 Apr 2019 00:28:29 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> > reST format in this serias.
> > 
> > In this version I combined ACPI and PCI docs, and added new x86 docs conversion.  
> 
> As mentioned by others, this is a lot of stuff; I would really rather see
> each of those groups as separate patch sets.

Yeah, makes sense to me, either to split into separate patchsets or to
group the changes per sub-dir (or both).

> If you can do a reasonably quick turnaround with Mauro's suggestions
> addressed and tags applied, we should be able to get at least some of this
> into 5.2.  Thanks, Mauro, for looking at all of this stuff!

Anytime! Just to make clear, I'm still reviewing it... I'm at patch 35/63
now. So, expect more comments from my side.


Thanks,
Mauro
