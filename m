Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444F2C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 09:59:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB533206B8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 09:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="SVHocj+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB533206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sdf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Xnr60kv3zDq67
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 20:59:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sdf.org
 (client-ip=205.166.94.20; helo=mx.sdf.org; envelope-from=lkml@sdf.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sdf.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sdf.org header.i=@sdf.org header.b="SVHocj+q"; 
 dkim-atps=neutral
Received: from mx.sdf.org (ol.sdf.org [205.166.94.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XnpC6NZHzDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 20:57:55 +1100 (AEDT)
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
 by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x319u8Fl017367
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO); 
 Mon, 1 Apr 2019 09:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
 t=1554112582; bh=nfyrQ8GwYN1dR+36K+w2KJmeeTK++gvNmVw4hbCgtQ4=;
 h=Date:From:To:Subject:Cc:In-Reply-To:References;
 b=SVHocj+qYv7EIPnLIfPgOVaNlCkoSdLXLVw6GFrl9DCOnxhLWUjOM9vbGSgCCoGcp
 D1nD66gIhO4CU+TNaRxHv3p9OlqQMQLiL6LH5yenIMo9bJvE6E7MQYstcxd8XbGkjb
 GywuxAxfIpYFvEK00nepx2+Z/kokFUYZ+IxaQyMI=
Received: (from lkml@localhost)
 by sdf.org (8.15.2/8.12.8/Submit) id x319u70q021113;
 Mon, 1 Apr 2019 09:56:07 GMT
Date: Mon, 1 Apr 2019 09:56:07 GMT
From: George Spelvin <lkml@sdf.org>
Message-Id: <201904010956.x319u70q021113@sdf.org>
To: andriy.shevchenko@linux.intel.com, st5pub@yandex.ru
Subject: Re: [PATCH v2 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
In-Reply-To: <20190401093555.GD9224@smile.fi.intel.com>
References: <19606671554056883@myt3-1179f584969c.qloud-c.yandex.net>,
 <23051461554058370@iva6-3ac3de5fcc31.qloud-c.yandex.net>,
 <20190401093555.GD9224@smile.fi.intel.com>
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
Cc: peterz@infradead.org, dchinner@redhat.com, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, hpa@zytor.com, jslaby@suse.cz,
 sfr@canb.auug.org.au, darrick.wong@oracle.com, mark@fasheh.com, x86@kernel.org,
 mingo@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
 linux-snps-arc@lists.infradead.org, jannh@google.com, bp@alien8.de,
 jlbec@evilplan.org, jpoimboe@redhat.com, tglx@linutronix.de, lkml@sdf.org,
 ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, dedekind1@gmail.com,
 adrian.hunter@intel.com, vgupta@synopsys.com, richard@nod.at, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 1 Apr 2019 at 12:35:55 +0300, Andy Shevchenko wrote:
> Hmm... If (*swap)() is called recursively it means the change might increase
> stack usage on 64-bit platforms.
> 
> Am I missing something?

Under what conceivable circumstance would someone write a recursive
(*swap)() function?

You're technically right, but the precondition is more fantastical
than "if the U.K.'s parliament get their shit together before the
12th", so I have a hard time worrying about it.

But you did make me think of something: the whole reason swap()
takes a size argument is for the benefit of the (no longer existing)
generic swap functions.  All of the custom swap functions ignore
it.

So how about *deleting* the parameter instead?  That simplifies
everything.
