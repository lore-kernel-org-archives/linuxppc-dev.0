Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E21C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44172218B0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SPdkI3i9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44172218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q7FS0LLLzDqKy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 03:52:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="SPdkI3i9"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q78v05jhzDqX3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:48:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C+jH5MB5a2swmKkEdfeQTYpVl5aRBU1fzkhBf76AiTM=; b=SPdkI3i9xCTD0C8C2HRlxJ8DA3
 JcezKeaj8JAP8fVRdaJDeDKK6RloQJbb2BuU60+tFeE+UcWTi3KN495/SKkSEmK6o7cBGYmc92V5x
 PS8zILU/LaafDfuxLVLUPv5FSILDR6mIvL43565SCPSLnLL6LLWHSl8PKlnVoJOl0Vom5bsBe3yYZ
 pwoy2EiUJKa+UumDtWbeWLGKyY8rT2SXc50+0g54tUYaCfaJgVjPDrhqj9/VsBCLoM+nNuVjx94pV
 50qmTl+wEPN4xduztx1gI1Obywoh/vh1cgjUSRM857lTM4O0Rq2E9pFGBojPJnHI8CuJ1Vg1iU2c7
 y9GU4zyQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJM0a-0000B8-TV; Wed, 24 Apr 2019 17:48:37 +0000
Date: Wed, 24 Apr 2019 14:48:30 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx
 TOC tree
Message-ID: <20190424144830.3fe92640@coco.lan>
In-Reply-To: <20190424154617.kowr5aamjkeceltr@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
 <20190423173644.GA14616@google.com>
 <20190424154617.kowr5aamjkeceltr@mail.google.com>
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
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 the arch/x86 maintainers <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Linux PCI <linux-pci@vger.kernel.org>, linux-gpio@vger.kernel.org, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 24 Apr 2019 23:46:18 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> On Tue, Apr 23, 2019 at 12:36:44PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 23, 2019 at 06:39:47PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Apr 23, 2019 at 6:30 PM Changbin Du <changbin.du@gmail.com> wrote:
> > > > Hi Corbet and All,
> > > > The kernel now uses Sphinx to generate intelligent and beautiful
> > > > documentation from reStructuredText files. I converted all of the Linux
> > > > ACPI/PCI/X86 docs to reST format in this serias.
> > > >
> > > > In this version I combined ACPI and PCI docs, and added new x86 docs
> > > > conversion.
> > > 
> > > I'm not sure if combining all three into one big patch series has been
> > > a good idea, honestly.
> > 
> > Yeah, if you post this again, I would find it easier to deal with if
> > linux-pci only got the PCI-related things.  63 patches is a little too
> > much for one series.
> >
> sure, so I will resend them respectively.

I reviewed up to patch 39. There are too many files on x86 that seems
to be mangled by some tab->whitespace conversion, with caused
very big diffs and lots of broken ascii artwork.

Please ensure that the diffs will contain the minimal amount of stuff
that would be required for them to be properly formatted as ReST
files there.

Ah, perhaps next time you could format the patches with a lower
merge similarity logic (using, for example, the parameter -M10).

Regards,
Mauro

> 
> > Bjorn
> 



Thanks,
Mauro
