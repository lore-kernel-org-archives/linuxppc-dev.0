Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FC6EE4993
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 12:14:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW4s66Py5z3dXP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 22:14:34 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW4cw40Cwz3c8n
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2023 22:04:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cw2bgnz4x2V;
	Wed, 23 Aug 2023 22:04:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, Gautam Menghani <gautam@linux.ibm.com>
In-Reply-To: <20230731115543.36991-1-gautam@linux.ibm.com>
References: <20230731115543.36991-1-gautam@linux.ibm.com>
Subject: Re: [PATCH v2] arch/powerpc: Remove unnecessary endian conversion code in XICS
Message-Id: <169279175568.797584.10256881719025771730.b4-ty@ellerman.id.au>
Date: Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 31 Jul 2023 17:25:39 +0530, Gautam Menghani wrote:
> Remove an unnecessary piece of code that does an endianness conversion but
> does not use the result. The following warning was reported by Clang's
> static analyzer:
> 
> arch/powerpc/sysdev/xics/ics-opal.c:114:2: warning: Value stored to
> 'server' is never read [deadcode.DeadStores]
> server = be16_to_cpu(oserver);
> 
> [...]

Applied to powerpc/next.

[1/1] arch/powerpc: Remove unnecessary endian conversion code in XICS
      https://git.kernel.org/powerpc/c/984b07b428994d9e83c6de9a5f1307948188fe71

cheers
