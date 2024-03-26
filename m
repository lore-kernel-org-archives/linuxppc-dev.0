Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8684EC54E58
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2024 07:20:26 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=a4TAbSFZ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V3h610HQ3z3dX7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2024 18:20:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=a4TAbSFZ;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V3h5B6CmLz3cGM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2024 18:19:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1711437582;
	bh=8AOT1glzJqyCf7lOrPMpn92SEwJeGYb4j0TXp1M/vgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a4TAbSFZ1Ctk9tMopXuvxY6ZnJLbG4+/xZ4IrkWUlPqygTMo29JcIRK/ndkrhQBSn
	 itZd9ZcDWTe+uGTRNpODZUDp4y/PnYXDC1Y8n2HDBgaN8BYRui+mdP1xM4q6Hrv4UP
	 Rh8LeolCR7odE6kIR4BYLSZXOxwvU2KZEGmYiAO57Q/3udl4T4QNYTFVF9y21BiwgI
	 kpvdVBQohudighrbWUqgoFwOnYfHvOnki1ApW3Y/1e/t+byXRReCumBlXJ3n5DIFrX
	 RRp+r49sXwgGpUWd02oNKwDaAJ/0tTCw39ysIkE7dnG3WRJD9rVqSrTKwaRoDEvGCx
	 vBVM2+OGhR4kA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3h5B3y4kz4wb2;
	Tue, 26 Mar 2024 18:19:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, paulmck
 <paulmck@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: Appropriate liburcu cache line size for Power
In-Reply-To: <19c3ea76-9e05-4552-8b93-6c42df105747@efficios.com>
References: <19c3ea76-9e05-4552-8b93-6c42df105747@efficios.com>
Date: Tue, 26 Mar 2024 18:19:38 +1100
Message-ID: <87ttktiho5.fsf@mail.lhotse>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> Hi,

Hi Mathieu,

> In the powerpc architecture support within the liburcu project [1]
> we have a cache line size defined as 256 bytes with the following
> comment:
>
> /* Include size of POWER5+ L3 cache lines: 256 bytes */
> #define CAA_CACHE_LINE_SIZE     256
>
> I recently received a pull request on github [2] asking to
> change this to 128 bytes. All the material provided supports
> that the cache line sizes on powerpc are 128 bytes or less (even
> L3 on POWER7, POWER8, and POWER9) [3].
>
> I wonder where the 256 bytes L3 cache line size for POWER5+
> we have in liburcu comes from, and I wonder if it's the right choice
> for a cache line size on all powerpc, considering that the Linux
> kernel cache line size appear to use 128 bytes on recent Power
> architectures. I recall some benchmark experiments Paul and I did
> on a 64-core 1.9GHz POWER5+ machine that benefited from a 256 bytes
> cache line size, and I suppose this is why we came up with this
> value, but I don't have the detailed specs of that machine.
>
> Any feedback on this matter would be appreciated.

The ISA doesn't specify the cache line size, other than it is smaller
than a page.

In practice all the 64-bit IBM server CPUs I'm aware of have used 128
bytes. There are some 64-bit CPUs that use 64 bytes, eg. pasemi PA6T and
Freescale e6500.

It is possible to discover at runtime via AUXV headers. But that's no
use if you want a compile-time constant.

I'm happy to run some benchmarks if you can point me at what to run. I
had a poke around the repository and found short_bench, but it seemed to
run for a very long time.

cheers
