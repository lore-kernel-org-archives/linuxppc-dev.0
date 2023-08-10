Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1622DC001B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Aug 2023 06:24:42 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VZSvdTym;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLxjN2PNbz3cHv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Aug 2023 16:24:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VZSvdTym;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLxhN3pvbz2ygx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2023 16:23:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1691648628;
	bh=+TYDQF4gFd96ccfrWjufrvQOFIeyCG4Q5lehMbfQqog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VZSvdTymJAcg2dhkhY6LCgYsVwsw9A5QrnKpL6dMKn7HNGZ6GWxfjRNQUN6ZDxzxV
	 DPJpT8u2JghUGDAUE/u8DerstDePcocOZXK5c5gRR7Mxry3J9GOqU6wwp71+DIlMiU
	 JNQr6Q6HPsGvVXNEuwrZfbnUKDK1ulIb/Fx+oEvAy49cJPDALhgOCLffbx1fHQs53Q
	 zIE5adQjKK/70sfhrB/Swg2bneIF1RrGqhtjMrJCyALL46jg7H5uvDxUTTMRgemcIh
	 8whjhcq/X7Y1S0KQ1qB54die4eM3UsFEN8J07EPwjkXyJUb2A15cDzEMAGRFjnFktN
	 oyADssb8SVH6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLxhL5cHsz4wbP;
	Thu, 10 Aug 2023 16:23:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>, Laurent Dufour
 <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 00/10] Introduce SMT level and add PowerPC support
In-Reply-To: <87tttoqxft.ffs@tglx>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
 <87tttoqxft.ffs@tglx>
Date: Thu, 10 Aug 2023 16:23:46 +1000
Message-ID: <87msyzbekt.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-arch@vger.kernel.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, npiggin@gmail.com, rui.zhang@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thomas Gleixner <tglx@linutronix.de> writes:
> Laurent, Michael!
>
> On Wed, Jul 05 2023 at 16:51, Laurent Dufour wrote:
>> I'm taking over the series Michael sent previously [1] which is smartly
>> reviewing the initial series I sent [2].  This series is addressing the
>> comments sent by Thomas and me on the Michael's one.
>
> Thanks for getting this into shape.
>
> I've merged it into:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
>
> and tagged it at patch 7 for consumption into the powerpc tree, so the
> powerpc specific changes can be applied there on top:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-for-ppc-23-07-28

Thanks. I've merged this and applied the powerpc patches on top.

I've left it sitting in my topic/cpu-smt branch for the build bots to
chew on:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/cpu-smt

I'll plan to merge it into my next in the next day or two.

cheers
