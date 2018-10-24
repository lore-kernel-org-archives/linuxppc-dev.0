Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5B6ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 22:48:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869DA2082E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 22:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="n1yTQjYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869DA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gQQv0F93zDrPn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 09:48:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="n1yTQjYd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=netronome.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=jakub.kicinski@netronome.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=netronome-com.20150623.gappssmtp.com
 header.i=@netronome-com.20150623.gappssmtp.com header.b="n1yTQjYd"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gQNM1HXszDrPn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 09:46:23 +1100 (AEDT)
Received: by mail-qt1-x842.google.com with SMTP id r22-v6so7640900qtm.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netronome-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=dn0YGRDoNbTjAH4ZG5NZaQVwCZKtUjfVuIFMEzZr3z8=;
 b=n1yTQjYdW93x9b7hcjqt4fcA/inYzLGTPFi5lYkjgaZW79nsxO7jXyDgviHR94gvvI
 NgGOtSTNtdly0C4pl57vlMFtFyHYajZcDARy8KeprtbS9YAUBW9hueXEY3zFOl8Eclj9
 a+iFVnb06UCFqodjRDGp4J+kwn57Q/xN6Q0z3lgcJkPeYOKXO2oJNWI3DPH8zNYTsbTK
 H0fYuGSND6f/UyupddzfKQOZk8LstoyKRORliyANRJf70RbKbtL54z6OMzcrgxG+UaGG
 0mVbfYTpSPGBrbFDDMkJkRlTf+KCpXgZAQfaG4z/MGrsI8ZOypQANUHFCibnkqqdxdsn
 nHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=dn0YGRDoNbTjAH4ZG5NZaQVwCZKtUjfVuIFMEzZr3z8=;
 b=E+/B/eUSvmM4Sez5yYmwXXee0FPmMJmXcWIiLdSp51OSu5vHEJmah/i8SzkiyMLloy
 RAwbv259tf+Fy3Qlp54M2lRub0uFtHd4Gl+lwF/Rp1Rt7+OymSwmZ/r9nNaRH94XII6y
 bImwe2Ub7z9pcrH2cpABeK/fiSGnJMJgBH+N0k+jTXIIRnifMG2yHmJaQPRmVZJfhOTf
 BPzeAbnhGhfA+xLVs9hpcxKARo4HWmIwsYehQgOgP0DGsFtdfLAaJskE0DfA78NqqyaR
 reOkG/VU73zvI0APvSYG9rHB4qwb8t5Irfv7KJkUzeZRvFQ/8h4RaXZxTf67w7bir4kp
 H9ng==
X-Gm-Message-State: AGRZ1gKNAboHj+nTPbF1p1sfilQtbL4j/bwVGA8NEa0S0mMrhIidyDH7
 glBsuCVcbApR+zwsLx/UVGC4Cw==
X-Google-Smtp-Source: AJdET5d/DrQo5+0+Im9zOPgyl3dyBtBXC6okdzwVqfQuSOTOTyt4y8EbDAJXmK4UExJ2eWUTQ3KVHg==
X-Received: by 2002:aed:26c7:: with SMTP id
 q65-v6mr4469873qtd.282.1540421180993; 
 Wed, 24 Oct 2018 15:46:20 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
 by smtp.gmail.com with ESMTPSA id i11-v6sm5688061qtc.96.2018.10.24.15.46.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Oct 2018 15:46:20 -0700 (PDT)
Date: Wed, 24 Oct 2018 15:46:13 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH v3 2/7] include: add
 setbits_leXX/clrbits_leXX/clrsetbits_leXX in linux/setbits.h
Message-ID: <20181024154613.3ecc96dc@cakuba.netronome.com>
In-Reply-To: <1540366553-18541-3-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <1540366553-18541-3-git-send-email-clabbe@baylibre.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Gilles.Muller@lip6.fr, maxime.ripard@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-sunxi@googlegroups.com, paulus@samba.org,
 linux-amlogic@lists.infradead.org, cocci@systeme.lip6.fr,
 narmstrong@baylibre.com, airlied@linux.ie, wens@csie.org, joabreu@synopsys.com,
 agust@denx.de, alexandre.torgue@st.com, alistair@popple.id.au,
 nicolas.palix@imag.fr, oss@buserror.net, Julia.Lawall@lip6.fr,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 peppe.cavallaro@st.com, linux-arm-kernel@lists.infradead.org,
 michal.lkml@markovi.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 khilman@baylibre.com, carlo@caione.org, tj@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 24 Oct 2018 07:35:48 +0000, Corentin Labbe wrote:
> This patch adds setbits_le32/clrbits_le32/clrsetbits_le32 and
> setbits_le64/clrbits_le64/clrsetbits_le64 in linux/setbits.h header.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Did you have a look at all the functions defined in bitfield.h?
(including the magic macro-generated ones?)  Perhaps those could be
used here?

I also share the concerns about the non-atomic RMW.  Obviously correct
beats short IMHO.

> diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> new file mode 100644
> index 000000000000..c82faf8d7fe4
> --- /dev/null
> +++ b/include/linux/setbits.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SETBITS_H
> +#define __LINUX_SETBITS_H
> +
> +#include <linux/io.h>
> +
> +#define __setbits(rfn, wfn, addr, set) wfn((rfn(addr) | (set)), addr)
> +#define __clrbits(rfn, wfn, addr, mask) wfn((rfn(addr) & ~(mask)), addr)
> +#define __clrsetbits(rfn, wfn, addr, mask, set) wfn(((rfn(addr) & ~(mask)) | (set)), addr)
> +#define __setclrbits(rfn, wfn, addr, mask, set) wfn(((rfn(addr) | (set)) & ~(mask)), addr)
> +
> +#ifndef setbits_le32
> +#define setbits_le32(addr, set) __setbits(readl, writel, addr, set)
> +#endif
> +#ifndef setbits_le32_relaxed
> +#define setbits_le32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
> +					       addr, set)
> +#endif
> +
> +#ifndef clrbits_le32
> +#define clrbits_le32(addr, mask) __clrbits(readl, writel, addr, mask)
> +#endif
> +#ifndef clrbits_le32_relaxed
> +#define clrbits_le32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
> +						addr, mask)
> +#endif
> +
> +#ifndef clrsetbits_le32
> +#define clrsetbits_le32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
> +#endif
> +#ifndef clrsetbits_le32_relaxed
> +#define clrsetbits_le32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> +							   writel_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +#ifndef setclrbits_le32
> +#define setclrbits_le32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
> +#endif
> +#ifndef setclrbits_le32_relaxed
> +#define setclrbits_le32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> +							   writel_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +/* We cannot use CONFIG_64BIT as some x86 drivers use non-atomicwriteq() */
> +#if defined(writeq) && defined(readq)
> +#ifndef setbits_le64
> +#define setbits_le64(addr, set) __setbits(readq, writeq, addr, set)
> +#endif
> +#ifndef setbits_le64_relaxed
> +#define setbits_le64_relaxed(addr, set) __setbits(readq_relaxed, writeq_relaxed, \
> +					       addr, set)
> +#endif
> +
> +#ifndef clrbits_le64
> +#define clrbits_le64(addr, mask) __clrbits(readq, writeq, addr, mask)
> +#endif
> +#ifndef clrbits_le64_relaxed
> +#define clrbits_le64_relaxed(addr, mask) __clrbits(readq_relaxed, writeq_relaxed, \
> +						addr, mask)
> +#endif
> +
> +#ifndef clrsetbits_le64
> +#define clrsetbits_le64(addr, mask, set) __clrsetbits(readq, writeq, addr, mask, set)
> +#endif
> +#ifndef clrsetbits_le64_relaxed
> +#define clrsetbits_le64_relaxed(addr, mask, set) __clrsetbits(readq_relaxed, \
> +							   writeq_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +#ifndef setclrbits_le64
> +#define setclrbits_le64(addr, mask, set) __setclrbits(readq, writeq, addr, mask, set)
> +#endif
> +#ifndef setclrbits_le64_relaxed
> +#define setclrbits_le64_relaxed(addr, mask, set) __setclrbits(readq_relaxed, \
> +							   writeq_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +#endif /* writeq/readq */
> +
> +#endif /* __LINUX_SETBITS_H */

