Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079A1C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 22:12:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E41217F5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 22:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E41217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43W2Gf5618zDqMt
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 09:12:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43W2F16jXGzDq8x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 09:11:17 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 647F82A185;
 Thu,  3 Jan 2019 17:11:15 -0500 (EST)
Date: Fri, 4 Jan 2019 09:11:16 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v8 22/25] powerpc: Remove CONFIG_GENERIC_NVRAM and adopt
 CONFIG_HAVE_ARCH_NVRAM_OPS
In-Reply-To: <20190103080514.GC11147@infradead.org>
Message-ID: <alpine.LNX.2.21.1901040909020.658@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <22b3299016531a7a05c9c45b36d43565c794e67d.1545784679.git.fthain@telegraphics.com.au>
 <20190103080514.GC11147@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 3 Jan 2019, Christoph Hellwig wrote:

> >  # All PPC32s use generic nvram driver through ppc_md
> > -config GENERIC_NVRAM
> > +config HAVE_ARCH_NVRAM_OPS
> >  	bool
> >  	default y if PPC32
> 
> Symbols like this really should be defined in common code, and then
> just selected by the users.
> 

I'll move it to arch/Kconfig.

Thanks.

-- 
