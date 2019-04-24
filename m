Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE29C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:52:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8B8208E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 18:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHPgs9VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8B8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q8Z80tfszDqbX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 04:52:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="eHPgs9VB"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q7WL6tyHzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 04:04:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QQxjRBbmdgAM9Bh3kBDiayTByaZ8rOIgL5n86+QEto4=; b=eHPgs9VBSJ+I8+KqGmbMTju2lr
 c0xcIJhkO2M5DD563NVO7255UOmAOc+vpo2IvNPVwyqe69ZqXkx9iioAWr9eJ4b2LMu+rhf8rYyUo
 mtQXyGjUMNv/lFhjz4jaEpC7/Tp0UkNaMIXXlAM2xteretCYdUOIlYuRI08ZjgbyPhkjYAtk47b7m
 OA0nNjLt5UlGU5fFoI53mMacP+QpIDgHjTG4uSifigHWhQfA2mF9d0P2n0WuaAsakliiGpFMUgQjo
 rvB17MoDNgV16L/zRs1kMRB1oFucBzRHljfN9aiZfld7RN8Wcr4XEM55inxhU1IiOVWlqKJ5tLTjt
 pHQcNoMQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJMG2-0001jj-TS; Wed, 24 Apr 2019 18:04:35 +0000
Date: Wed, 24 Apr 2019 15:04:28 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 21/63] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Message-ID: <20190424150428.7eb70014@coco.lan>
In-Reply-To: <20190424172232.qtzogm6sweaa4gva@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-22-changbin.du@gmail.com>
 <20190424114844.5de4cfa5@coco.lan>
 <20190424172232.qtzogm6sweaa4gva@mail.google.com>
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

Em Thu, 25 Apr 2019 01:22:34 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> On Wed, Apr 24, 2019 at 11:48:44AM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 24 Apr 2019 00:28:50 +0800
> > Changbin Du <changbin.du@gmail.com> escreveu:
> >   
> > > This converts the plain text documentation to reStructuredText format and
> > > add it to Sphinx TOC tree. No essential content change.
> > > 
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > ---
> > >  .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
> > >  Documentation/admin-guide/acpi/index.rst      |  1 +
> > >  2 files changed, 40 insertions(+), 32 deletions(-)
> > >  rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
> > > 
> > > diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > > similarity index 51%
> > > rename from Documentation/acpi/cppc_sysfs.txt
> > > rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
> > > index f20fb445135d..a4b99afbe331 100644
> > > --- a/Documentation/acpi/cppc_sysfs.txt
> > > +++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > > @@ -1,5 +1,11 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > >  
> > > -	Collaborative Processor Performance Control (CPPC)
> > > +==================================================
> > > +Collaborative Processor Performance Control (CPPC)
> > > +==================================================
> > > +
> > > +CPPC
> > > +====
> > >  
> > >  CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
> > >  performance of a logical processor on a contigious and abstract performance
> > > @@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
> > >  
> > >  http://uefi.org/specifications
> > >  
> > > -Some of the CPPC registers are exposed via sysfs under:
> > > -
> > > -/sys/devices/system/cpu/cpuX/acpi_cppc/
> > > -  
> > 
> >   
> > > -for each cpu X  
> > 
> > Hmm... removed by mistake?
> >  
> I comfirmed that no content removed.

At this patch, it looks that you removed the line: "for each cpu X"
(or am I reading it wrong?)

> 
> > > +Some of the CPPC registers are exposed via sysfs under::
> > >  
> > > ---------------------------------------------------------------------------------
> > > +  /sys/devices/system/cpu/cpuX/acpi_cppc/  
> > 
> > Did you parse this with Sphinx? It doesn't sound a valid ReST construction
> > to my eyes, as:
> > 
> > 1) I've seen some versions of Sphinx to abort with severe errors when 
> >    there's no blank line after the horizontal bar markup;
> > 
> > 2) It will very likely ignore the "::" (I didn't test it myself), as you're
> >    not indenting the horizontal bar. End of indentation will mean the end
> >    of an (empty) literal block.
> > 
> > So, I would stick with:
> > 
> > 
> > 	Some of the CPPC registers are exposed via sysfs under:
> > 
> > 	  /sys/devices/system/cpu/cpuX/acpi_cppc/
> > 
> > 	---------------------------------------------------------------------------------
> > 
> > 	for each cpu X::
> > 
> > 
> > or:
> > 
> > 	Some of the CPPC registers are exposed via sysfs under:
> > 
> > 		/sys/devices/system/cpu/cpuX/acpi_cppc/
> > 
> > 	for each cpu X
> > 
> > 	--------------------------------------------------------------------------------
> > 
> > 	::
> > 
> > (with is closer to the original author's intent)
> > 
> > Same applies to the other similar changes on this document.
> >  
> I didn't seen any warning here and the generated html is good. So I think it is
> ok.

Basically, what you're doing is:

<rst>

::

foo
   literal-block bar

</rst>

(where "foo" is the horizontal bar markup)

I would avoid such pattern for two reasons:

1) it sounds a violation of ReST syntax to format an in
   indented paragraph some non-blank lines after a non-indented
   line. As such, I won't doubt that different versions of Sphinx
   would handle it differently. I'm even tempted to open a BZ
   to Sphinx in order for them to provide a fix for that, if the
   latest version of Sphinx accepts such crazy markup.

2) It is very confusing for any human reading it.

Thanks,
Mauro
