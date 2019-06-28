Return-Path: <SRS0=ywKm=U3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74458C4321A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 03:41:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE90208CB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 03:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE90208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZjHQ11GjzDqlr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 13:41:38 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ZjDj6X2NzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2019 13:39:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45ZjDj5KWCz9s3l;
 Fri, 28 Jun 2019 13:39:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/3] powerpc/pseries: Update SCM hcall op-codes in
 hvcall.h
In-Reply-To: <20190626140404.27448-2-vaibhav@linux.ibm.com>
References: <20190626140404.27448-1-vaibhav@linux.ibm.com>
 <20190626140404.27448-2-vaibhav@linux.ibm.com>
Date: Fri, 28 Jun 2019 13:39:17 +1000
Message-ID: <87h88as7iy.fsf@concordia.ellerman.id.au>
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
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Vaibhav Jain <vaibhav@linux.ibm.com> writes:
> Update the hvcalls.h to include op-codes for new hcalls introduce to
> manage SCM memory. Also update existing hcall definitions to reflect
> current papr specification for SCM.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Change-log:
>
> v3:
> * Added updated opcode for H_SCM_HEALTH [Oliver]
>
> v2:
> * None new patch in this series.
> ---
>  arch/powerpc/include/asm/hvcall.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index 463c63a9fcf1..11112023e327 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -302,9 +302,14 @@
>  #define H_SCM_UNBIND_MEM        0x3F0
>  #define H_SCM_QUERY_BLOCK_MEM_BINDING 0x3F4
>  #define H_SCM_QUERY_LOGICAL_MEM_BINDING 0x3F8
> -#define H_SCM_MEM_QUERY	        0x3FC
> -#define H_SCM_BLOCK_CLEAR       0x400
> -#define MAX_HCALL_OPCODE	H_SCM_BLOCK_CLEAR
> +#define H_SCM_UNBIND_ALL        0x3FC
> +#define H_SCM_HEALTH            0x400
> +#define H_SCM_PERFORMANCE_STATS 0x418
> +#define MAX_HCALL_OPCODE	H_SCM_PERFORMANCE_STATS

How can we be changing the meaning of HCALL numbers without breaking all
existing usages?

Where are these hypervisor calls documented?

cheers
