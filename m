Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7B2C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Mar 2022 02:18:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMJFs3B4Kz3bTG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Mar 2022 13:18:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=KDDOGngt;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMJF65pb8z2xXV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2022 13:18:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=KDDOGngt; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMJF6319Fz4xNq;
 Mon, 21 Mar 2022 13:18:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1647829098;
 bh=G9Z3D9SjvD8clxXZB1X/GbpS0ImJ+QU6eZ9/9CXzgVQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KDDOGngtSvemCTDNBLqCYLx3AdSwgzNgRPoExgNB4ot2SbcZiXQIDZWizS/t6GKYc
 Ta6oEtnNcjaUhn1pd1t4d/F9DNhNiLk3RTdYRjPhjkzEUgcSVggLwuryQX4ZXA3Fuh
 SAqtmHgUDHhszXejHQUoQ1+SRSMkio5/XyTAz7wQHGBJF1Vk32mkeGboCVQuIVgPiU
 MS/XNpgkiOe5l42WfXpJKx6SM5ynN1sIwC5cPjrzqc8vYfXJw7qnM7EXeBpZ/TMy7W
 2U1bLWWcNFiyfaQtHW75v2L8NZ7G/Dx9XarR4tjfKqxF6xCWAivyTPt6t9VcNtmdwh
 n1Hl2OYaT/7mw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Fix use after free in
 remove_phb_dynamic()
In-Reply-To: <6A815387-773D-413C-B0AE-2630F434FA8C@linux.ibm.com>
References: <20220318034219.1188008-1-mpe@ellerman.id.au>
 <6A815387-773D-413C-B0AE-2630F434FA8C@linux.ibm.com>
Date: Mon, 21 Mar 2022 13:18:17 +1100
Message-ID: <87sfrcgiae.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, zdai@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sachin Sant <sachinp@linux.ibm.com> writes:
>> On 18-Mar-2022, at 9:12 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> To avoid it, we can take a reference to the host_bridge->dev until we're
>> done using phb. Then when we drop the reference the phb will be freed.
>>=20
>> Fixes: 2dd9c11b9d4d ("powerpc/pseries: use pci_host_bridge.release_fn() =
to kfree(phb)")
>> Reported-by: David Dai <zdai@linux.ibm.com>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> =E2=80=94
> Verified successfully with 5.17.0-rc8-00061-g34e047aa16c0 + patch.
>
> Tested-by: Sachin Sant <sachinp@linux.ibm.com>

Thanks for testing.

cheers
