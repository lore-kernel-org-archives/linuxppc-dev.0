Return-Path: <linuxppc-dev+bounces-27268-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234CAC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 00:02:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkMdW2mZ2z2yDm;
	Tue, 15 Sep 2026 10:02:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=185.125.188.122 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789430527;
	cv=pass; b=oOkp4av+KjaPeliJi59Afqpl9Pi3GtW7/S7K4UDMsGbHIG3hoE8srGmlGHUpjmeFn4Xn6MnyJXI26ilTpIEvS3BzwzZf8GsZ43LkmC5j3FPXZdakj8V8BmbY4Fs9XsTN0hp/2JfGnwQd5XrGyERI+KUPdtlOECXjWHXAJ9FBSBYIeg6RWh5f28R+nQfkmRVJRi6o+v+D/3KFb+122Z7ShSItsuGA1IXaM5357RYGxU6Od47uF2FsJKNAj6JtHDyDspYfi0QuAFyzSOjPcR6yHmCzM1McPkffH1vqV3j1rnaehN8tyyU2DtfpTzde6lf1J0xqFCtCP0SwK1pS9tZtMA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789430527; c=relaxed/relaxed;
	bh=r0hasLCz57GpF7SAqU2aNVEVHGPKn0sNjTbrv00rd/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6fdZezcG8/5xT4ULYfXp2+A5h53NVBjrmyKvlzs0TZ33omVK2BI2zufG1cUna0v/StuBNoQbzoNCPHmzp03DuBFCu6oZhNjAB3ZPKF5kGU8peROwarDeKmkbGvNgjTGnDJOCQNYGwZ4KVqRYgWNX6ZmUlhxd58B2au9ly8RdTO+5wjkmfEX2XUDB8WFWlGBMqEhidvqta2/SZMPbDf5MyAgwEZNyp9aMMSK4TV7jDxufcFCfwXAMIMSJLhWvgc2HdfY0g/wsU5y/hzpM6sEodrK6pRgZm2gn1k/lMkcpXEguQh7lldo4CNRUNXRCCBtbobPjAvOpm+JmEWy3cPvSA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=NHezCk6V; dkim-atps=neutral; spf=pass (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=chris.chiu@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=NHezCk6V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=chris.chiu@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkMdS0KMdz2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 10:02:02 +1000 (AEST)
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A97DF3F1E4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 00:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1789430518;
	bh=r0hasLCz57GpF7SAqU2aNVEVHGPKn0sNjTbrv00rd/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=NHezCk6Vot4mOEr0muRzuwZ3RESXVja7HmFQJDjKq58ulO5ypCFrJEFkoWpHYNe6M
	 O4IJ3BEw1zJ5LY0qatQ1rw7pwz/8xqhAkeA1oXkis9HI3HrfY2SDJk3meVC0jKwoxD
	 vicl5xtIh/mfKFKi04JDyva+kEPd5Wvcyt9iCAuT3/Rc5nB3WSeWK613nobzx+9xDm
	 e0brVb/14AYq8afSEqqOPcgtLMNvKILI0nVCE+uV6ofoCFbQj2wEJmXn8PrpeIC56N
	 kpEM/0mf20B/2gtnSRIh4yJmULAchlMGgzOSxCz7ETGSZ7LdfwriPQrHGsI63lJfNH
	 /BQynQEI0qUJdeeDvSAPywdalNciJr4m6c1qOU3zow0wiE3DnNpFXYLR8R/sX6dXIl
	 gxSA7Lc3Tw/TYGjHyEeXzbtT2GsPLsukuhfIj3pyq9ezWeibEr13EH1Q6Sgg88kdVV
	 DEloh8bd0SeeLAyk4l7kREWji75yOZwU3gGAzUnY3clFSnPlTIRPfUR4m+AZ8WTUwI
	 sXhgN+uGjt0lZ4Xa3fj2IKOFRPfdWbYnndsOu6sWqDQePsmTXdOiJ2nsumaJJOcAtZ
	 xbxBPLesvKf4I0dyoJIBm588+bbxMdb8P8HYb71tJgylISkBn17kS8F4powsBWEO/u
	 ohrtGN9xAVqxhIUS7TqST+rc=
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-671519f7e7cso972768d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789430517; cv=none;
        d=google.com; s=arc-20260327;
        b=R8bP+N7RmtX5Rj/EKm1dyyGByQGh50mzlXPRTpxfRLXKZsbg9y2U4HrIYqPPAIirS+
         37bbOZWCmru2sMsYbvXAdXqrvIzFuE9uoPAf4CtYpZnHXY9Les/KPJKeObxy5NAfPTR6
         2QXTudCbaIT17eeuHUjqmveYPT8Ds8PpbJjhjl2qB3JMrC+EFKUj484m/q0yYbtADaAl
         +j3o7t+J56JJAkxgzLGhKpN1Ik3IJLbg/waWxTTqvUEliuzeE5erctNYYZA5EIFvjfHY
         PfMNfZ6SY5+QAH3MEQ7m7WTmOBgyzLHeeXZYzc46EP7OjSKiBc36H7tKnWB3ANtrTKsr
         IuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=r0hasLCz57GpF7SAqU2aNVEVHGPKn0sNjTbrv00rd/c=;
        fh=OfjdsSDmN1RGtwSq5GmVy+Vv0095qDsNWOVAhXw0PU8=;
        b=mlQg5/RRA6TSLH+enFHGEAQZb6eNiRe/AvIOc8qCn0dEaJxO/sz20rSbEK31xs1mzP
         H0kXHxlzhylyzHksKxxOcgxWcE4N/Y5OkzQN/vH+baY17xjjfcFXKgekuLl16LGxJwlP
         SU43cPJValLCBLQ4h/4ClYTVbt7p7pwEcQ/HCsqECF6gHts0jaRKZVZgVh9UuDEC8GIz
         fFbV7jcziKP6WBZlz77XSKiayPDfKslC5lPeA4fOcmpAcw8RmOo695CDUHDRnUhJe4IK
         J0r1qtLTX6iXjzdpnoWXO3UXwhsm5mJ4FR863L3HB6Og4K/MIptOMcKA/O1EZi/zbkP9
         XqDg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789430517; x=1790035317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0hasLCz57GpF7SAqU2aNVEVHGPKn0sNjTbrv00rd/c=;
        b=jrw2HllJUdnCzXB0Eryo6TVs0fv5iuqzuPJmR6onPMY9AZ2xSxxDOVW/80D9KdAnp0
         pTqDxyaWcu9o0qj9wfDHgGQAMfBih2beaUUbudRcHMpFkf6JdJlhKH27qWdJK1ndsK9r
         gyqEh/roU5Q1sw/M5lHFDEoMHRg5g2e7EQXKU0EO9m9H9GNO2iDKkAWdSvGzLPMWifUe
         WEFmMj578Ruokal1vvESvLyUSVIKl1e6ybpua6CVQf7ciTS0xjtJwjnKjiYYMDSlmrf3
         PiMDYxKnNECAL7HW43Sr6xzFC1AJ556+Dds+2IsLIoPEANh49xQUOyMyn/s695q+Cu2S
         hQRA==
X-Forwarded-Encrypted: i=1; AKwUvBwWi8D29LvhlsR41zarsI10JPAEl4G9hW2M8Ft9zD0hLbfHjU7Khzvvo8MG5/U1Z5itYjLuxs+Z0hayspU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++knGbIrMnZStOsepG+NOLDnGtEnDt/5Dx7P63aRSCGEnMpTauJO
	vhGhaOne0pzKvAawD9tZewdhcrJxWsJ6AegJuy4cDjZELga+QGTUgqwdvtrAt6Z0pk9Ju+kFOrt
	nZEm4jOOFYmf1NiHy1nmZxvUwn7WYjz4O2/PkUBFUIGiEN1r3TXtPpmayP86swlY3ZfvXsdAeoC
	hoOugc3dBuWQqKjnMalXj2fPQJBI+zmslkAoQ3IzjUtlD5NPnkJYtnNGPeYg==
X-Gm-Gg: AYBFou0alo9xtDg5x2v3AO3NPEjwQUxjF5nJIytY9RQ+S9GDGgXIRd04KGSEaeeJxvg
	jQMCVCkdG8eJ5uBOy5gHg5ec1a8pF0qc3BwHZ/SXeBWxGiQcwG8AK7vWdx7QgPH4x2zDAZvPsup
	PsySMLtia/BCbuMkF+q2i8c0L7lh49I18BnCNFHpIDSzgUGpPssLqh4RWg11OIZoSYmUlpYmv8u
	wzm
X-Received: by 2002:a05:690e:108a:10b0:671:548e:f17a with SMTP id 956f58d0204a3-671548f09fbmr575140d50.6.1789430517560;
        Mon, 14 Sep 2026 17:01:57 -0700 (PDT)
X-Received: by 2002:a05:690e:108a:10b0:671:548e:f17a with SMTP id
 956f58d0204a3-671548f09fbmr575131d50.6.1789430517076; Mon, 14 Sep 2026
 17:01:57 -0700 (PDT)
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
MIME-Version: 1.0
References: <20260909050919.3344699-1-chris.chiu@canonical.com>
In-Reply-To: <20260909050919.3344699-1-chris.chiu@canonical.com>
From: Chris Chiu <chris.chiu@canonical.com>
Date: Tue, 15 Sep 2026 08:00:00 +0800
X-Gm-Features: AcwNN1XVh1ezSC4ybotZKbIiPQmqAdnlb_DFgEiPNeX7teBjdDq_YCIHyZaRa4Q
Message-ID: <CABTNMG0+rpiqAckYqizUQHU_9rfdt21drC8Y5t1SmOonwYGSBQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Fix exec_prot test failure on Hash MMU
To: maddy@linux.ibm.com, shuah@kernel.org
Cc: sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 1:09=E2=80=AFPM Chris Chiu <chris.chiu@canonical.com=
> wrote:
>
> Hash MMU maps execute-only pages as readable at the PTE level, so reading
> from a PROT_EXEC-only mapping does not fault there. The exec_prot test
> currently treats that as a failure, while the rest of the permission
> checks are still valid.
>
> Use the existing using_hash_mmu() helper and skip only the read-on-
> execute-only subtest on Hash MMU. Keep the rest of the test unchanged so
> the fix stays local to the unsupported execute-only-read expectation.
>
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  .../testing/selftests/powerpc/mm/exec_prot.c  | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/mm/exec_prot.c b/tools/testi=
ng/selftests/powerpc/mm/exec_prot.c
> index db75b2225de1..bd44f49d8449 100644
> --- a/tools/testing/selftests/powerpc/mm/exec_prot.c
> +++ b/tools/testing/selftests/powerpc/mm/exec_prot.c
> @@ -108,11 +108,14 @@ static int check_exec_fault(int rights)
>  static int test(void)
>  {
>         struct sigaction segv_act, trap_act;
> +       bool hash_mmu;
>         int i;
>
>         /* Skip the test if the CPU doesn't support Radix */
>         SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
>
> +       FAIL_IF(using_hash_mmu(&hash_mmu));
> +
>         /* Check if pkeys are supported */
>         pkeys_supported =3D pkeys_unsupported() =3D=3D 0;
>
> @@ -167,13 +170,17 @@ static int test(void)
>          * Read an instruction word from the address when the page
>          * is execute only. This should generate an access fault.
>          */
> -       fault_code =3D -1;
> -       remaining_faults =3D 1;
> -       printf("Testing read on --x, should fault...");
> -       FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) !=3D 0);
> -       i =3D *fault_addr;
> -       FAIL_IF(remaining_faults !=3D 0 || !is_fault_expected(fault_code)=
);
> -       printf("ok!\n");
> +       if (!hash_mmu) {
> +               fault_code =3D -1;
> +               remaining_faults =3D 1;
> +               printf("Testing read on --x, should fault...");
> +               FAIL_IF(mprotect(insns, pgsize, PROT_EXEC) !=3D 0);
> +               i =3D *fault_addr;
> +               FAIL_IF(remaining_faults !=3D 0 || !is_fault_expected(fau=
lt_code));
> +               printf("ok!\n");
> +       } else {
> +               printf("Testing read on --x, skipped on Hash MMU\n");
> +       }
>
>         /*
>          * Write an instruction word to the address when the page
> --
> 2.43.0
>

Gentle ping.

