Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9848CC3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 11:53:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6F82186A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 11:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6F82186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NhzM5hdNzDqv1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 21:53:19 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NhxR4LC8zDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 21:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 46NhxR3kdfz9sDQ; Wed,  4 Sep 2019 21:51:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46NhxR06zlz9sDB;
 Wed,  4 Sep 2019 21:51:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 19/31] powerpc/fadump: Update documentation about OPAL
 platform support
In-Reply-To: <156630278711.8896.9799921270260662672.stgit@hbathini.in.ibm.com>
References: <156630261682.8896.3418665808003586786.stgit@hbathini.in.ibm.com>
 <156630278711.8896.9799921270260662672.stgit@hbathini.in.ibm.com>
Date: Wed, 04 Sep 2019 21:51:38 +1000
Message-ID: <87y2z4p9dh.fsf@mpe.ellerman.id.au>
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
Cc: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>, Oliver <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hari Bathini <hbathini@linux.ibm.com> writes:
> With FADump support now available on both pseries and OPAL platforms,
> update FADump documentation with these details.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  Documentation/powerpc/firmware-assisted-dump.rst |  104 +++++++++++++---------
>  1 file changed, 63 insertions(+), 41 deletions(-)
>
> diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
> index d912755..2c3342c 100644
> --- a/Documentation/powerpc/firmware-assisted-dump.rst
> +++ b/Documentation/powerpc/firmware-assisted-dump.rst
> @@ -72,7 +72,8 @@ as follows:
>     normal.
>  
>  -  The freshly booted kernel will notice that there is a new
> -   node (ibm,dump-kernel) in the device tree, indicating that
> +   node (ibm,dump-kernel on PSeries or ibm,opal/dump/mpipl-boot
> +   on OPAL platform) in the device tree, indicating that
>     there is crash data available from a previous boot. During
>     the early boot OS will reserve rest of the memory above
>     boot memory size effectively booting with restricted memory
> @@ -96,7 +97,9 @@ as follows:
>  
>  Please note that the firmware-assisted dump feature
>  is only available on Power6 and above systems with recent
> -firmware versions.

Notice how "recent" has bit rotted.

> +firmware versions on PSeries (PowerVM) platform and Power9
> +and above systems with recent firmware versions on PowerNV
> +(OPAL) platform.

Can we say something more helpful here, ie. "recent" is not very useful.
AFAIK it's actually wrong, there isn't a released firmware with the
support yet at all, right?

Given all the relevant firmware is open source can't we at least point
to a commit or release tag or something?

cheers
