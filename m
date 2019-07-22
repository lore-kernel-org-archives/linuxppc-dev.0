Return-Path: <SRS0=Gm8F=VT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D986C76191
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 02:57:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC6321951
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 02:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC6321951
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sR8p4fBgzDq9D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 12:56:58 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sQyl75bxzDqDs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2019 12:48:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45sQyl56r2z9sML; Mon, 22 Jul 2019 12:48:15 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9798f4ea71eaf8eaad7e688c5b298528089c7bf8
In-Reply-To: <6ea6998b-a890-2511-01d1-747d7621eb19@kaod.org>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, Greg Kurz <groug@kaod.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: Re: Crash in kvmppc_xive_release()
Message-Id: <45sQyl56r2z9sML@ozlabs.org>
Date: Mon, 22 Jul 2019 12:48:15 +1000 (AEST)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-07-18 at 21:51:54 UTC, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= wrote:
> On 18/07/2019 15:14, Cédric Le Goater wrote:
...
> 
> Here is a fix. Could you give it a try on your system  ?
> 
> Thanks,
> 
> C.
> 
> >From b6f728ca19a9540c8bf4f5a56991c4e3dab4cf56 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
> Date: Thu, 18 Jul 2019 22:15:31 +0200
> Subject: [PATCH] KVM: PPC: Book3S HV: XIVE: fix rollback when
>  kvmppc_xive_create fails
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The XIVE device structure is now allocated in kvmppc_xive_get_device()
> and kfree'd in kvmppc_core_destroy_vm(). In case of an OPAL error when
> allocating the XIVE VPs, the kfree() call in kvmppc_xive_*create()
> will result in a double free and corrupt the host memory.
> 
> Fixes: 5422e95103cf ("KVM: PPC: Book3S HV: XIVE: Replace the 'destroy' method by a 'release' method")
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9798f4ea71eaf8eaad7e688c5b298528089c7bf8

cheers
