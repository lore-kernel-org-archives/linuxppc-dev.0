Return-Path: <SRS0=hLaT=A7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88895C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2020 01:44:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351132250E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2020 01:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBjd6AuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351132250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B94KQ6RZBzDqgw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2020 11:44:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::342;
 helo=mail-ot1-x342.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lBjd6AuI; dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B94Hc6ny9zDqdD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2020 11:43:08 +1000 (AEST)
Received: by mail-ot1-x342.google.com with SMTP id 72so10988876otc.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2020 18:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/V56vpG6VmCA46P7nYwbFvH9ch6Jbn81Eu33ezKH4EQ=;
 b=lBjd6AuIheNnitCvLHRoWZ2oDqbEwOMjIx+QaJMcGw6X0fBlzO8TUsb9YNZJmWi0qe
 WhFmGOdgOj0RDBHIg69RfwnvOAjoOFMIVmGOdiPS/wo5GKMfoh7MgRopanvbxvSVkVgN
 lEw/WIITspqQd9FW7KwnuUFVoxyBh/4B3wZ4VgwPJQKpqsz5mE5HPW0hKlYaPVHwA81F
 9xP4IPmxaEfWrVs8bruRr4kQkx9LcNla/scNRe4eVtu4panA3FQ//eYdpi/rMZ8i7ksK
 815vh4RaKZsJpbg1eWLwgTHGrYkVdfSwUsIA5MKvcGpNRHvGf2vCZBUOxFv1xDSj+d2u
 uwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/V56vpG6VmCA46P7nYwbFvH9ch6Jbn81Eu33ezKH4EQ=;
 b=VbJBWDrh0+sTE/fpYNGdO/+EUsnNdog6GYcN2ggT2f/BnQaHsuxbbJMiwRMRqSMBP1
 MlXoAPZKgiIjqajvSHMM7/a5Osw+9hWAnD5dhbKpXHS3hWBahbTJorwIo3hhTzlDNehw
 hisH99ptY47czzVvwFmNzVrgE1gOe5OIxmJVQjn/RDhp8xPYNuPB8vMk6lziaJAOVisS
 1p+5FxqsNgvPWAUODpCqAnhcFdUo1xObP6A43Mw4MzhowmnOy0a0/g8a/b0oidlUF22a
 7mxtKHuablbsiugqx0ddmz2ujRlcvVweUp54nRHaJCscCK9iw0Pwhk6AU9eV+yh+jmdF
 M5ig==
X-Gm-Message-State: AOAM532VfuePPN0zcjeU+K2Tza/Bt3JmQ+7/uodTUo7fgPBlmD27OHGN
 yqnAnBu3vNAs9ihW7lL5NGwHdOoV+L9UfV83WWs=
X-Google-Smtp-Source: ABdhPJz0T2XPbt6RJEE+xqKozWMd00jTLrYdaAnuVRYhHFryyIp8su5E3iKVJSzCuUeSsae1swlIbST9HW09gA1o24c=
X-Received: by 2002:a9d:6a12:: with SMTP id g18mr19272580otn.155.1595209384681; 
 Sun, 19 Jul 2020 18:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com>
 <20200717040958.70561-7-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200717040958.70561-7-ravi.bangoria@linux.ibm.com>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Mon, 20 Jul 2020 11:39:49 +1000
Message-ID: <CACzsE9oEB7Gs5bMatvoOs66vFkaFEBwJvj_nhBg2P8zVH8maaQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] powerpc/watchpoint: Set CPU_FTR_DAWR1 based on
 pa-features bit
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, apopple@linux.ibm.com,
 mikey@neuling.org, miltonm@us.ibm.com, peterz@infradead.org, oleg@redhat.com,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, jolsa@kernel.org, fweisbec@gmail.com,
 pedromfc@br.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jul 17, 2020 at 2:10 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> As per the PAPR, bit 0 of byte 64 in pa-features property indicates
> availability of 2nd DAWR registers. i.e. If this bit is set, 2nd
> DAWR is present, otherwise not. Host generally uses "cpu-features",
> which masks "pa-features". But "cpu-features" are still not used for
> guests and thus this change is mostly applicable for guests only.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
I checked those PAPR values are correct and checked running a powernv
kernel in p10 mambo with dt_cpu_ftrs=off and it does set the
CPU_FTR_DAWR1 bit.
(using p10 skiboot).
Tested-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  arch/powerpc/kernel/prom.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 9cc49f265c86..c76c09b97bc8 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -175,6 +175,8 @@ static struct ibm_pa_feature {
>          */
>         { .pabyte = 22, .pabit = 0, .cpu_features = CPU_FTR_TM_COMP,
>           .cpu_user_ftrs2 = PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_HTM_NOSC_COMP },
> +
> +       { .pabyte = 64, .pabit = 0, .cpu_features = CPU_FTR_DAWR1 },
>  };
>
>  static void __init scan_features(unsigned long node, const unsigned char *ftrs,
> --
> 2.26.2
>
