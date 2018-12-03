Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B2BC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 00:09:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A42A2054F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 00:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+EDOSqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A42A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437QMy1DnlzDqY5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 11:09:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F+EDOSqU";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="F+EDOSqU"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437QKJ4fH2zDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 11:06:57 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id g9so5507557plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Dec 2018 16:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:date:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VxXYlWNT8earf+JTvsyBbF6w33dswccpFK1H0CBc/tE=;
 b=F+EDOSqU6HG0sHLqaz003mjjDHj2tW90cynHhljxnB1BOEb0a6h5ZB0ZI2jmBunfMr
 x8yEBrtAG2h/AhDUbKdApZz6FsoTsekJE8zYch3DxwGYD4l6puNS+kx4NB9NP/k4oVdJ
 SZngTFmJCKxKR3QyCqA1kxpOiPsffrYxHRAiFfE+55dLms96Kl6wwXNfANBZ6GI4cSFO
 FTAnGzZ0fCjXWbFv21FoC4sn0o+KKXAKiUgbpaUhqcO3lepfh86gOwX8VKN/rm3Z/oC5
 i3mMLdNstStZm/fTKzG3MuJTIboqWnAILqDOzxHsGJJ7hvKzxEaKdrSWAKB7Xr4AxS9G
 sfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VxXYlWNT8earf+JTvsyBbF6w33dswccpFK1H0CBc/tE=;
 b=qYqKY8MWGAUAQm9YSSznHy5pitU+tesPCghDKJ9ce3Z12ucnDQI+4SBiLm9dGQMDVu
 H3vNEVMOA3yJVc22sGVj6v4vSXPfF1NAlCvrxFKN1idNK0X5sHD5Aia1eP0VnJ5uuXEd
 SprRNgqz9egOiWpxusWtJVjol/XLd5INMx7V3nofmLHdDJwBte7cw64qC2huMSFwH0Tx
 hpQPJ/63xAy34oKJEJbzDv1PriKspvInfZuOCiBQp8t3XTl8ZuelJ+Zi7O9S4iBea23S
 AGtKg9iLFjzJSDnbBuWHuYyKM1SsIXAwLo2770pSvkY9OVcp7ck9oFrCLnm5vqnyV6CE
 nZPg==
X-Gm-Message-State: AA+aEWb4mwdEVVBRdIRoUll/LXgJ7khNefp90gokUh4GNy6259stuDQZ
 Vw6ict4qYmKGK3ViSw6pniI=
X-Google-Smtp-Source: AFSGD/VIwhzJADVbXXeG1rhQP+GicVlfw7aLqW9PttImvpxgHk2Rv7xFdbd6b6syRuntaS4HjneR+w==
X-Received: by 2002:a17:902:ba89:: with SMTP id
 k9mr14055351pls.189.1543795615698; 
 Sun, 02 Dec 2018 16:06:55 -0800 (PST)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id 12sm11113999pgd.35.2018.12.02.16.06.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 16:06:54 -0800 (PST)
Message-ID: <1543795610.7535.2.camel@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: NULL check before some freeing
 functions is not needed.
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Thomas Meyer <thomas@m3y3r.de>, paulus@ozlabs.org,
 benh@kernel.crashing.org,  mpe@ellerman.id.au, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Mon, 03 Dec 2018 11:06:50 +1100
In-Reply-To: <1543760930051-2094322096-1-diffsplit-thomas@m3y3r.de>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
 <1543760930051-2094322096-1-diffsplit-thomas@m3y3r.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2018-12-02 at 21:52 +0100, Thomas Meyer wrote:
> NULL check before some freeing functions is not needed.

Technically true, however I think a comment should be added then to
make it clearer to someone reading the code why this is ok.

See below.

Suraj.

> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/arch/powerpc/kvm/book3s_hv_nested.c
> b/arch/powerpc/kvm/book3s_hv_nested.c
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -1252,8 +1252,7 @@ static long int __kvmhv_nested_page_faul
>  	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
>  	ret = kvmppc_create_pte(kvm, gp->shadow_pgtable, pte, n_gpa,
> level,
>  				mmu_seq, gp->shadow_lpid, rmapp,
> &n_rmap);
> -	if (n_rmap)
> -		kfree(n_rmap);
> +	kfree(n_rmap);

e.g.
/* n_rmap set to NULL in kvmppc_create_pte if reference preserved */

>  	if (ret == -EAGAIN)
>  		ret = RESUME_GUEST;	/* Let the guest try
> again */
>  
