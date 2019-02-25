Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F96FC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 03:52:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A897220684
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 03:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A897220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477Lv38H0zDqQt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 14:52:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477J95bzxzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:50:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 4477J901fYz9s71;
 Mon, 25 Feb 2019 14:50:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 kvm-ppc@vger.kernel.org, Stewart Smith <stewart@linux.ibm.com>
Subject: Re: [PATCH v2 01/16] powerpc/xive: add OPAL extensions for the XIVE
 native exploitation support
In-Reply-To: <20190222112840.25000-2-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-2-clg@kaod.org>
Date: Mon, 25 Feb 2019 14:50:16 +1100
Message-ID: <87y364jzlz.fsf@concordia.ellerman.id.au>
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
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> The support for XIVE native exploitation mode in Linux/KVM needs a
> couple more OPAL calls to configure the sPAPR guest and to get/set the
> state of the XIVE internal structures.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/asm/opal-api.h           | 11 ++-
>  arch/powerpc/include/asm/opal.h               |  7 ++
>  arch/powerpc/include/asm/xive.h               | 14 +++
>  arch/powerpc/sysdev/xive/native.c             | 99 +++++++++++++++++++
>  .../powerpc/platforms/powernv/opal-wrappers.S |  3 +
>  5 files changed, 130 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/a=
sm/opal-api.h
> index 870fb7b239ea..cdfc54f78101 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -186,8 +186,8 @@
>  #define OPAL_XIVE_FREE_IRQ			140
>  #define OPAL_XIVE_SYNC				141
>  #define OPAL_XIVE_DUMP				142
> -#define OPAL_XIVE_RESERVED3			143
> -#define OPAL_XIVE_RESERVED4			144
> +#define OPAL_XIVE_GET_QUEUE_STATE		143
> +#define OPAL_XIVE_SET_QUEUE_STATE		144
>  #define OPAL_SIGNAL_SYSTEM_RESET		145
>  #define OPAL_NPU_INIT_CONTEXT			146
>  #define OPAL_NPU_DESTROY_CONTEXT		147
> @@ -209,8 +209,11 @@
>  #define OPAL_SENSOR_GROUP_ENABLE		163
>  #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
>  #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
> -#define	OPAL_NX_COPROC_INIT			167
> -#define OPAL_LAST				167
> +#define OPAL_HANDLE_HMI2			166
> +#define OPAL_NX_COPROC_INIT			167
> +#define OPAL_NPU_SET_RELAXED_ORDER		168
> +#define OPAL_NPU_GET_RELAXED_ORDER		169
> +#define OPAL_XIVE_GET_VP_STATE			170

You should only be defining the calls you need, leaving gaps for other
things, and you need to retain OPAL_LAST. So it should look more like:

 -#define OPAL_LAST				167
 +#define OPAL_XIVE_GET_VP_STATE		170
 +#define OPAL_LAST				170


Also I can't merge this until it's merged into skiboot.

cheers
