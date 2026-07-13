Return-Path: <linuxppc-dev+bounces-24087-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305ABC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 04:24:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz8Tb1Wj1z2xjN;
	Mon, 13 Jul 2026 14:24:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783916659;
	cv=none; b=YqmK3LGPOYCDKg7HWFaxgckefkedqnTXpj+Zt0/8fz9vKANp4Ypn2hOFBi85VA1pqywA1mTaX+Sp7BaaULXmVFna0VzvnA3ebUA6aRN5P3SRsIPW/c1tFrJA8S0RvTZC+kwnRcPO8mdw5Fji+LEULGpJe7EJJy5ifwwt6H+6GBawUZ6MQFP9J+J2MGX6z9SoS+zK2yqAhGrp42Fe5+ZkQHLuAx8p58I1qp9H3GjwVswW15P9SiQ9LynZ0c4zRQODWmKGmEGtejRo5c6Rxqrunnq2EX80+RFTLLXKGdSSdtU4+Z8mbH61Izm9IkLZLJjTvMptTWQ/YvR+EICq37Iw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783916659; c=relaxed/relaxed;
	bh=C58B2cKbjinGkAAF6rks5KVUbvwkNc4eqillvWc3cV4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=gADmyBoRldgN1+rYd5YPHECFnXw8aCHMTbOFE3uXVhP1SVXKQ+vZ7BtMBNyNhc0oISps+i+iwIJMRkkPoXXdQX3GmDy+SrjkfQq6dGRHtsqYfs4AlBNrAKJWwyzbpcvSH8/sBNsLOK8bGSCwe4MsCm/4YSsp+sjmOjwo8Iby92DzGZQs2kP3xzisk0a0akOGgAef93RITi86RcWjH3o/Vm2xbZiap0x/V/d0O/2IYk1Utv97BIq8WmknWo908e4ckv2tJ9LC+98eKSIiec+hkwAuFY/KOJ60/8nWCrxECx+fdMD13XijUxbXMPZEN+6ucF95v/NLlscBaWBnOCynSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qqAGTTf0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qqAGTTf0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz8TY3wxxz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:24:16 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso1724669a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 21:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783916654; x=1784521454; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C58B2cKbjinGkAAF6rks5KVUbvwkNc4eqillvWc3cV4=;
        b=qqAGTTf0gms4e6qq7PRRDe3SzmgFo9wbMAeDFW7btxkwTzU1FJmif2HZLWiR/dky1x
         R047Vl9I16jFi568GD7D9Y4Qant5kug2Wgn35WN7hoMik2Vl2M/nAw+Gn/eYsb/8rjF5
         35Y/JzgfqrGIPINsWXUZD9ON0eYWPE0eb2vmxml7T3VFK95Q0tDFEXDDuBUoM/Tr9drJ
         oXHqPR1V7OmRRwN09wJGw8u9iTVu2z/S8k9KZhRaDwLs59uAGACaISYW5GYOJ2JK9qaj
         xWC9BlvFYF8EghdW6TNZlZzM0c0t6ZxLAsjNgpBW4Mya8FdYHrhwfRsm9RoMvCvEwHa0
         9iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783916654; x=1784521454;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C58B2cKbjinGkAAF6rks5KVUbvwkNc4eqillvWc3cV4=;
        b=jeEM6Ci5LsmfWFNBgiHf6j/7/6zmUQSPZwQkMe624tUqjCMLI9jG6AEAX9bML1JUdY
         UEU5Vg52f1XSgHGjtyj7DA0zfx1N5Xf9OoT0wwLE+Xi7AsPaHWiueYK/ljWitrE12WB/
         tQP5zi+B9DlqlAmqMdfEUlyBsLdLuws7IrdObOkgeIpGsA9ZYcu+bXtfmcIvbf/3PEpR
         2v2MILl3e7qk3wTr1ilnqKDkZnxmIi8ZcZR+ToDeR+NcFbFabP8RnhUbMZ35u17ScCf+
         eW8NXJ3MXN7l2hEq6TwFdk6num+SPDxZ7CSrPXZggqgqryD01NaLrsBPg14OT6PEp1GF
         iziQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQyInon2n8FvQVSTbGR7A70QJ4b+14is5DELwRbUzRj5QxWj3NzjgR0WjNgUFIB9ZcuwoFLmDd5ICYQWU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyiZAne8mMBGaOq6z3LXRZXn/VXBqAlR31PQyIRfMXKIS4scM5t
	k6vHxX2wczeEdAvJB/frPSEB/iiefbu203P8K9sHZLSCWfiePlsJWgH4
X-Gm-Gg: AfdE7cmyuZGsb69Qk47hqRxcE1beVfL5LVPJ90aHOLdNw1S32qx+nfkpIY3zPGnaQhI
	nJz6gbo7E9BgC215ip/6D4W3Wqb3V5AIRENbp//Zr5opt/Td4Kub4edrWH+vXMwFcP7iCHKoSb8
	1b3WVWKMXyFbPw7KhUl0ioUWxq1TtBiph08Jz3g2l9aCWBnCpG3zh4ZMgaqeV8UPIRmw9VBjDn/
	cVuEAdJCWWfnggDlDXMz+fSqTN25bnCpS2FmtWNRhtadxgVtRz3x/gSwszTKmx7sJYDEOxz0wPi
	ThmAJd0pxD+/iMynTlbLpTXOAYk+J+nAFrMzume46q/SuD+ZBGPE5NVTT8iyG8L93SO6h89hB05
	KzmjNN0iVU/LPF8mFT1ibGRkJ/6nj7Snl+WM+FPnTeRswHI22XEKuz++tg2JnaFbRW5xzYI1LHH
	81HXYJYmaZPcY=
X-Received: by 2002:a05:6a20:e292:b0:3bf:e449:3316 with SMTP id adf61e73a8af0-3c110a17884mr7791913637.14.1783916654109;
        Sun, 12 Jul 2026 21:24:14 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm14773232c88.0.2026.07.12.21.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 21:24:13 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] powerpc/pseries: Move H_WATCHDOG definitions to a common header
In-Reply-To: <20260713035954.1559605-2-sourabhjain@linux.ibm.com>
Date: Mon, 13 Jul 2026 09:48:57 +0530
Message-ID: <se5nv7wu.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <20260713035954.1559605-2-sourabhjain@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> The H_WATCHDOG input and output definitions are currently local to the
> pseries watchdog driver. The next patch in this series also needs these
> definitions to issue H_WATCHDOG hypercalls outside the watchdog driver.
>
> Move the H_WATCHDOG definitions to a new common header,
> asm/papr-watchdog.h, so they can be shared without duplicating the
> PAPR watchdog definitions.
>
> No functional changes.
>
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/papr-watchdog.h | 58 ++++++++++++++++++++++++
>  drivers/watchdog/pseries-wdt.c           | 53 +---------------------
>  2 files changed, 59 insertions(+), 52 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/papr-watchdog.h
>
> diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
> new file mode 100644
> index 000000000000..fb3a511aa861
> --- /dev/null
> +++ b/arch/powerpc/include/asm/papr-watchdog.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _ASM_POWERPC_CRASHDUMP_PPC64_H
> +#define _ASM_POWERPC_CRASHDUMP_PPC64_H

should be _ASM_POWERPC_PAPR_WATCHDOG_H

> +
> +/*
> + * H_WATCHDOG Input
> + *
> + * R4: "flags":
> + *
> + *         Bits 48-55: "operation"
> + */
> +#define PSERIES_WDTF_OP_START	0x100UL		/* start timer */
> +#define PSERIES_WDTF_OP_STOP	0x200UL		/* stop timer */
> +#define PSERIES_WDTF_OP_QUERY	0x300UL		/* query timer capabilities */
> +
> +/*
> + *         Bits 56-63: "timeoutAction" (for "Start Watchdog" only)
> + */
> +#define PSERIES_WDTF_ACTION_HARD_POWEROFF	0x1UL	/* poweroff */
> +#define PSERIES_WDTF_ACTION_HARD_RESTART	0x2UL	/* restart */
> +#define PSERIES_WDTF_ACTION_DUMP_RESTART	0x3UL	/* dump + restart */
> +
> +/*
> + * H_WATCHDOG Output
> + *
> + * R3: Return code
> + *
> + *     H_SUCCESS    The operation completed.
> + *
> + *     H_BUSY	    The hypervisor is too busy; retry the operation.
> + *
> + *     H_PARAMETER  The given "flags" are somehow invalid.  Either the
> + *                  "operation" or "timeoutAction" is invalid, or a
> + *                  reserved bit is set.
> + *
> + *     H_P2         The given "watchdogNumber" is zero or exceeds the
> + *                  supported maximum value.
> + *
> + *     H_P3         The given "timeoutInMs" is below the supported
> + *                  minimum value.
> + *
> + *     H_NOOP       The given "watchdogNumber" is already stopped.
> + *
> + *     H_HARDWARE   The operation failed for ineffable reasons.
> + *
> + *     H_FUNCTION   The H_WATCHDOG hypercall is not supported by this
> + *                  hypervisor.
> + *
> + * R4:
> + *
> + * - For the "Query Watchdog Capabilities" operation, a 64-bit
> + *   structure:
> + */
> +#define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
> +#define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
> +
> +#endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */

ditto

-ritesh

