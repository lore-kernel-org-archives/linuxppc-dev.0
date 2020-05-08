Return-Path: <SRS0=nAOP=6W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD665C38A2A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 16:14:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F151206B9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 16:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iN9Em3ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F151206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Jb4l0JZJzDrF5
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 02:14:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=alien8.de (client-ip=2a01:4f8:190:11c2::b:1457;
 helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256
 header.s=dkim header.b=iN9Em3ee; dkim-atps=neutral
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JZzL3JgwzDr9L
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2020 02:09:47 +1000 (AEST)
Received: from zn.tnic (p200300EC2F0C9800329C23FFFEA6A903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0c:9800:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00FBC1EC008F;
 Fri,  8 May 2020 18:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1588954179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=UqLtVT0FeQmzUfsO+zZA7Gur4b3vfPoCKM3UXxWw5Nc=;
 b=iN9Em3ee7IKvXVDRD1gnQ6cbvugr2wQhogKP7eXqD67gtswC7rOOtpxi2IILZZn8R6GhhB
 cq1F/95hEoQ9cUrVJvKxF3tw7BPxTL6iOodu1idhke6d6zMWH302H08EUQxncJtOq0ikzO
 weWQiPe2GP+hHs2/d+mxS9W+ZmcBJLY=
Date: Fri, 8 May 2020 18:09:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v7 2/5] seq_buf: Export seq_buf_printf() to external
 modules
Message-ID: <20200508160935.GB19436@zn.tnic>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com>
 <20200508104922.72565-3-vaibhav@linux.ibm.com>
 <20200508113100.GA19436@zn.tnic> <87blmy8wm8.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87blmy8wm8.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 08, 2020 at 05:30:31PM +0530, Vaibhav Jain wrote:
> I am referring to Kernel Loadable Modules with MODULE_LICENSE("GPL")
> here.

And what does "external" refer to? Because if it is out-of-tree, we
don't export symbols for out-of-tree modules.

Looks like you're exporting it for that papr_scm.c thing, which is fine.
But that is not "external".

So?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
