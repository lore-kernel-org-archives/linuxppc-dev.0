Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92654C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:08:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA14207ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA14207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h06Z4SdbzDqgF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:08:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzF85RxhzDqRZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:29:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzF70kkGz9sTH; Tue,  9 Jun 2020 15:28:58 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Alexios Zavras <alexios.zavras@intel.com>, Leonardo Bras <leobras.c@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Enrico Weigelt <info@metux.net>
In-Reply-To: <20200512214533.93878-1-leobras.c@gmail.com>
References: <20200512214533.93878-1-leobras.c@gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/crash: Use NMI context for printk when
 starting to crash
Message-Id: <159168034498.1381411.5705399954174028060.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:28:58 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 12 May 2020 18:45:35 -0300, Leonardo Bras wrote:
> Currently, if printk lock (logbuf_lock) is held by other thread during
> crash, there is a chance of deadlocking the crash on next printk, and
> blocking a possibly desired kdump.
> 
> At the start of default_machine_crash_shutdown, make printk enter
> NMI context, as it will use per-cpu buffers to store the message,
> and avoid locking logbuf_lock.

Applied to powerpc/next.

[1/1] powerpc/crash: Use NMI context for printk when starting to crash
      https://git.kernel.org/powerpc/c/af2876b501e42c3fb5174cac9dd02598436f0fdf

cheers
