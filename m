Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802C7C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 17:21:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CB22073D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 17:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CB22073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Vvpd4lqvzDqLf
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 04:21:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Vvmq3z0kzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 04:19:54 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Vvmh3chSz9v0Nw;
 Thu,  3 Jan 2019 18:19:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id KgJptQ9uLWmH; Thu,  3 Jan 2019 18:19:48 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Vvmh2wb7z9v0Nv;
 Thu,  3 Jan 2019 18:19:48 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 38ABFC67; Thu,  3 Jan 2019 18:19:47 +0100 (CET)
Received: from 37-171-82-241.coucou-networks.fr
 (37-171-82-241.coucou-networks.fr [37.171.82.241]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Thu, 03 Jan 2019 18:19:47 +0100
Date: Thu, 03 Jan 2019 18:19:47 +0100
Message-ID: <20190103181947.Horde.sGoDsMMUO3-VuetfCM1WTw7@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v3 1/2] selftests/powerpc: Add MSR bits
In-Reply-To: <1546531862-11926-1-git-send-email-leitao@debian.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Breno Leitao <leitao@debian.org> a =C3=A9crit=C2=A0:

> This patch simply adds definitions for the MSR bits and some macros to
> test for MSR TM bits.
>
> This was copied from arch/powerpc/include/asm/reg.h generic MSR part.

Can't we find a way to avoid duplicating such defines ?

Christophe

>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/powerpc/include/reg.h | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tools/testing/selftests/powerpc/include/reg.h=20=20
>=20b/tools/testing/selftests/powerpc/include/reg.h
> index 52b4710469d2..b67a85404255 100644
> --- a/tools/testing/selftests/powerpc/include/reg.h
> +++ b/tools/testing/selftests/powerpc/include/reg.h
> @@ -77,6 +77,51 @@
>  #define TEXASR_TE	0x0000000004000000
>  #define TEXASR_ROT	0x0000000002000000
>
> +/* MSR register bits */
> +#define MSR_SF_LG       63              /* Enable 64 bit mode */
> +#define MSR_ISF_LG      61              /* Interrupt 64b mode valid=20=
=20
>=20on 630 */
> +#define MSR_HV_LG       60              /* Hypervisor state */
> +#define MSR_TS_T_LG     34              /* Trans Mem state: Transactiona=
l */
> +#define MSR_TS_S_LG     33              /* Trans Mem state: Suspended */
> +#define MSR_TS_LG       33              /* Trans Mem state (2 bits) */
> +#define MSR_TM_LG       32              /* Trans Mem Available */
> +#define MSR_VEC_LG      25              /* Enable AltiVec */
> +#define MSR_VSX_LG      23              /* Enable VSX */
> +#define MSR_POW_LG      18              /* Enable Power Management */
> +#define MSR_WE_LG       18              /* Wait State Enable */
> +#define MSR_TGPR_LG     17              /* TLB Update registers in use *=
/
> +#define MSR_CE_LG       17              /* Critical Interrupt Enable */
> +#define MSR_ILE_LG      16              /* Interrupt Little Endian */
> +#define MSR_EE_LG       15              /* External Interrupt Enable */
> +#define MSR_PR_LG       14              /* Problem State /=20=20
>=20Privilege Level */
> +#define MSR_FP_LG       13              /* Floating Point enable */
> +#define MSR_ME_LG       12              /* Machine Check Enable */
> +#define MSR_FE0_LG      11              /* Floating Exception mode 0 */
> +#define MSR_SE_LG       10              /* Single Step */
> +#define MSR_BE_LG       9               /* Branch Trace */
> +#define MSR_DE_LG       9               /* Debug Exception Enable */
> +#define MSR_FE1_LG      8               /* Floating Exception mode 1 */
> +#define MSR_IP_LG       6               /* Exception prefix 0x000/0xFFF =
*/
> +#define MSR_IR_LG       5               /* Instruction Relocate */
> +#define MSR_DR_LG       4               /* Data Relocate */
> +#define MSR_PE_LG       3               /* Protection Enable */
> +#define MSR_PX_LG       2               /* Protection Exclusive Mode */
> +#define MSR_PMM_LG      2               /* Performance monitor */
> +#define MSR_RI_LG       1               /* Recoverable Exception */
> +#define MSR_LE_LG       0               /* Little Endian */
> +
> +#ifdef __ASSEMBLY__
> +#define __MASK(X)       (1<<(X))
> +#else
> +#define __MASK(X)       (1UL<<(X))
> +#endif
> +
> +/* macros to check TM MSR bits */
> +#define MSR_TM          __MASK(MSR_TM_LG)     /* Transactional Mem=20=20
>=20Available */
> +#define MSR_TS_S        __MASK(MSR_TS_S_LG)   /* Transaction Suspended *=
/
> +#define MSR_TS_T        __MASK(MSR_TS_T_LG)   /* Transaction=20=20
>=20Transactional */
> +#define MSR_TS_MASK     (MSR_TS_T | MSR_TS_S) /* Transaction State bits =
*/
> +
>  /* Vector Instructions */
>  #define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
>  				 ((rb) << 11) | (((xs) >> 5)))
> --
> 2.19.0


