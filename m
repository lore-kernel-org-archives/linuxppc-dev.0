Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44399C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 12:00:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AFE2082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 12:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AFE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4342RY6xdJzDqlZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 23:00:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4342Mr2vbKzDqlK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 22:57:27 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08062316468F;
 Tue, 27 Nov 2018 11:57:25 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-114.ams2.redhat.com
 [10.36.117.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1DC219C65;
 Tue, 27 Nov 2018 11:57:23 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <877ehnbwqy.fsf@oldenburg.str.redhat.com>
 <2d62c9e2-375b-2791-32ce-fdaa7e7664fd@intel.com>
 <87bm6zaa04.fsf@oldenburg.str.redhat.com>
 <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
 <20181108201231.GE5481@ram.oc3035372033.ibm.com>
 <87bm6z71yw.fsf@oldenburg.str.redhat.com>
 <20181109180947.GF5481@ram.oc3035372033.ibm.com>
 <87efbqqze4.fsf@oldenburg.str.redhat.com>
 <20181127102350.GA5795@ram.oc3035372033.ibm.com>
Date: Tue, 27 Nov 2018 12:57:15 +0100
In-Reply-To: <20181127102350.GA5795@ram.oc3035372033.ibm.com> (Ram Pai's
 message of "Tue, 27 Nov 2018 02:23:50 -0800")
Message-ID: <87zhtuhgx0.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 27 Nov 2018 11:57:25 +0000 (UTC)
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
Cc: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-api@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Ram Pai:

> diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
> index d4a8d04..e9b121b 100644
> --- a/arch/x86/include/uapi/asm/mman.h
> +++ b/arch/x86/include/uapi/asm/mman.h
> @@ -24,6 +24,11 @@
>  		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
>  		((key) & 0x4 ? VM_PKEY_BIT2 : 0) |      \
>  		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
> +
> +/* Override any generic PKEY permission defines */
> +#undef PKEY_ACCESS_MASK
> +#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
> +				PKEY_DISABLE_WRITE)
>  #endif

I would have expected something that translates PKEY_DISABLE_WRITE |
PKEY_DISABLE_READ into PKEY_DISABLE_ACCESS, and also accepts
PKEY_DISABLE_ACCESS | PKEY_DISABLE_READ, for consistency with POWER.

(My understanding is that PKEY_DISABLE_ACCESS does not disable all
access, but produces execute-only memory.)

> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index e7ee328..61168e4 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -71,7 +71,8 @@
>  
>  #define PKEY_DISABLE_ACCESS	0x1
>  #define PKEY_DISABLE_WRITE	0x2
> -#define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
> -				 PKEY_DISABLE_WRITE)
> -
> +#define PKEY_DISABLE_EXECUTE	0x4
> +#define PKEY_DISABLE_READ	0x8
> +#define PKEY_ACCESS_MASK	0x0	/* arch can override and define its own
> +					   mask bits */
>  #endif /* __ASM_GENERIC_MMAN_COMMON_H */

I think Dave requested a value for PKEY_DISABLE_READ which is further
away from the existing bits.

Thanks,
Florian
