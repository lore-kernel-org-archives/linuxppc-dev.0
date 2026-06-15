Return-Path: <linuxppc-dev+bounces-22649-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DE5CD98E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 15:38:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfDmP106vz3bxH;
	Tue, 16 Jun 2026 01:38:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1135" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781537909;
	cv=pass; b=cgvRNM7ABNLssDvtD9RLWE5LJoYTDApy0wS9hJGWbWcVGhJPjo85CaCi4/mWZMSe1CCxuLPkbRUxs62TJfw6tO7ZPXc5xV1wbNTQmqnXgtRF7hxJGA5FPYaNb0uxXvoc6L/8OITX1KxUmO3sNFfJJtd3Lg6eNtAV46J8S1qBarB3ujhLS58E+OXbko8aXNSn0XPLuf2NZ6AJOaxYlYBBgt/63j/mTQTLNR5LIrzM2MCO3q5jqHoCyayVZOnag+kWWWQNxxYe5JA6s+QaHFZEiL6YM48ptuS6LpkRkslOkM6nLVM8RovtcfSKHEqLPpbsHRjeSrga7DnWbZtfTtaMfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781537909; c=relaxed/relaxed;
	bh=84xYQktEtoYUQcIRE7ERmXH/KggFpDsCx2KmUXy7yzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIjUPsa2Z2VGx9aZ35hxarMQ351Ke3ZSq2mBem9B5/Sx2wGJOEhvdmKPGK0gWyk+RuJJSkeqNOgSjFMiPiH5AktcH046pn8mZhS7Y1nsIYK5B21ToO9NBC/ahwe82sNIbpng8Ohfc2+DZgXcPSTfOVrWcNs3I9PTzRdeMH6jhmx098y2ARCcI8L8mpnsOVs5zC2Y0UGSeiESbqmSCwQNSOvMkPhUAPyKyZswzP/qo1d147tFOf3YhWaP7AlwXO0rC+PyaLci9R+8lcPRuiS9IbseF8SC8x99kRLOAOpozU3UAz5UFif4mo6m4+q8PyidhbEC/a1OjHkNa7+0QkI3qA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hh2NE56F; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com; envelope-from=randrianasulu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hh2NE56F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com; envelope-from=randrianasulu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfDmM3JGjz3bxC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 01:38:26 +1000 (AEST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-7e8833c99fcso37595547b3.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 08:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781537904; cv=none;
        d=google.com; s=arc-20240605;
        b=eZ8sVRodsj/RcULInazN3y7Ye5YTK9buYt0KdrWf7ufqljDMEqT/ljkubMFPEuKZQP
         HaGSuEoDb20SvnNVwjacAsQESCzBn+kClBYIISFp5mwqAxCzXcTvmnVrlciTpekLBqfo
         DLub9gmPhftJGFAkoequuF8Bhrmj9P70a6EHw0FQ9f0akQqmKpEiFUpvS0cdDrz+pk32
         zEdIlkdDnddOIVsT93IdlLVgl9uKVV+U4/ZLZZjAITgIHfiSwT8xRUVNMGzud+/z9BBd
         wh10CrukEEYeUQLTV7bqU6a/MvkzD/jhcQJWmO5XPS/RqylKzI3C7MYV9MyFI0FtJJMi
         jVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=84xYQktEtoYUQcIRE7ERmXH/KggFpDsCx2KmUXy7yzE=;
        fh=hLzpPbFe7FBh2DhP4pNX/m0Ecw4+jwYqhdpcsK0HAJ0=;
        b=UG/Pr6RKXhpjZ551NvdYeB7FRGfQTGeViQ1XcbPOUgTGc3uBPdqXTCruMnETwXoawv
         nm5iSmcume5etH1dz5GsIpjm5IabYk3n5PYSWOCPqShm0NVSdCc7pKNb0P7+FxRkzyMc
         v3O3iiJUBKLM48TLrapX/+FGt8drAoVPxhcsHdbB7aR53wceV9jChaT6azHKIjM6y4DR
         RIiCfHb2RPuh7X+YrtBGC17/OsD2NCxA166l52DKNcgwccxY9jz5rrtTMUqkcq6uFLru
         J82B8djHSABX8Mpvzjrg0K/1MvNx9untgNoAdaVAb64o3t6ImG3eAc76LxwmIp/XDbkC
         L2qg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781537904; x=1782142704; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=84xYQktEtoYUQcIRE7ERmXH/KggFpDsCx2KmUXy7yzE=;
        b=Hh2NE56FdVO+KQsZ7TSFSeVPCiYNS96EdCcrtVcjRNnDb6/eRLyxFYH6IEbCtEW/h8
         VhjiC8xvGDiMa5K3CYBbbQe9CWUG98lI0wN55L0TAgTUucrUTlPiYI37bwq6FJGhI+AJ
         kL+E+GDmjO7kwSMTFus8u3eMJUCr1TOwTUyx+YmhoREn+LoFhk4S5kq5970+DlnDAQKZ
         adu6+W1rv2nGyd8zN2DorTNDa7pE6PTQmhpt7GzN/zR4Rjpuo9F9e4vKEIkGh7w47T30
         SpHI7AuNiht7fAvf33cc600ktWIvnpPf4kmCE/M6BolRKjzv9r7EgbPyRpfE1jnxdALW
         65Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537904; x=1782142704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84xYQktEtoYUQcIRE7ERmXH/KggFpDsCx2KmUXy7yzE=;
        b=WdGh6pPLagqGxr1DHlXQNskR1WNzo5l+e52J30hESGrfoFTEW0XHBPYjquHDp/emmL
         dNPfYQ9tb0O6I70gM2ASYFZH8izpSGBeVQJ3YiO/5l/M4MZseYRM0LmMlABkTM2NXAwU
         6A/Gunw6MF7ycO5W10zEEWGJqUY5V8RBJjfrlLkVGV1fnYSruxeorCJHNCPRMDTJ1blE
         ZOIIHwDG6GmFq+WzgUatz3RDQicpFIQeKYJ7sWcCaA6nWcYMoTAt4yQNBeiKxpbKBS16
         gw5Lt1COTkjDxG5w1lMviPd7nWba+z+3oOZFRZG0FTZuL+jCoZl0S3buA0Ee8hKN6Y2L
         6+1w==
X-Forwarded-Encrypted: i=1; AFNElJ+yft73jla1r+Ay0VXnfzsDRx9XlA1sujLDsCD4ZVACKuu+lKPQbnepznodsJ2LroTuq0CMFYbwsnRUpPc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz85g4V2LEb5ROMLCS99l7KTIuGirCLkv8KwEHlvuwPQmgewIGc
	iybHCwvwrbxpICIJaPid3hb/hBOWVxL9ZSjW7w62IoKSqK0cu8XLAQZ/3zVuD5G+pYloaPLnSHp
	5hSdvbYeBrf1FMT9FUI/jifpVc1csC/Y=
X-Gm-Gg: Acq92OGZkTZ4TARV8Z+k6ip6swuEAMC20L4VIe+jiVQJPAZJNL9mQ8z70QceVcXMo7L
	DeCM6ulrX6dBDCHDDV5Uciw9g5OsGspwjqA37yzyT0Bah35s8FzSEvZp+xResGPxTC7Op2MUKmq
	c4oEh07qC4kc+vEDAQummKK1QpvMaKbCNh+e52G7h6hxLiY+ZQ04+csCfnSMvaV8aafeszIIXGI
	Y0p4U2uhv+QYN7w+32RO4Ge9xKtAMQd9uTc384Su+2pxrX55nKsHNGaHFm1tSuzNqs5sNYgSHtv
	GbtGdawlVA==
X-Received: by 2002:a05:690c:6304:b0:7cf:f14e:bf5a with SMTP id
 00721157ae682-7f7bbd0f69bmr148788727b3.20.1781537903876; Mon, 15 Jun 2026
 08:38:23 -0700 (PDT)
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
References: <CA+rFky7UDpHYFXvEiq91dpnfLuKCiaONctmW-q2jONmNG25Wow@mail.gmail.com>
 <418f045e-7aaf-c48b-4f08-018625b2c3e6@eik.bme.hu> <CA+rFky73KGYwJRBuEBqFA1dKkDk0_W+u4VQL9bg2n1_AkeOU3g@mail.gmail.com>
 <fb610033-efd3-6fa6-bd80-c5dccc9296eb@eik.bme.hu> <CA+rFky4nea6VPhYuVhH2SwSAgP0QC5LMrHqfWAwKNMNHpQ7aYg@mail.gmail.com>
 <8f2fb26e-f406-261a-f9b7-8a1a032bf4df@eik.bme.hu>
In-Reply-To: <8f2fb26e-f406-261a-f9b7-8a1a032bf4df@eik.bme.hu>
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Mon, 15 Jun 2026 18:38:10 +0300
X-Gm-Features: AVVi8CevycKENjsJOOf4UylDIwlfOJ0FbmH2yujVYP4740sZ2XQBpg_droamLio
Message-ID: <CA+rFky7mpZx+3h8HFBeQAfj6=xLcTdKMdSe=tzjfv1EYQQqHTg@mail.gmail.com>
Subject: Re: Does kvm_pr work on G5 mac with host kernel 6.12.xx ?
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000ea1efb06544c9da1"

--000000000000ea1efb06544c9da1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 15 =D0=B8=D1=8E=D0=BD. 2026 =D0=B3., 16:33 BALATON Zoltan <ba=
laton@eik.bme.hu>:

> On Mon, 15 Jun 2026, Andrew Randrianasulu wrote:
> > I also tried to see "info registers" as you showed in another email fro=
m
> > 2021 where you tried to use kvm-pr on qemu-emulated G5 and it showed
> >
> > info registers
> >                NIP 0000000000000700   LR 0000000000000000 CTR
> > 0000000000000000 XER 0000000000000000 CPU#0
> > MSR 8000000000000000 HID0 0000000060000000  HF 8000000000000000 iidx 3
> didx
> > 3                      TB 00000000 00000000 DECR 0
> >                                              GPR00 0000000000000000
> > 0000000000000000 0000000000000000 0000000000000000
> > GPR04 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> >                        GPR08 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000                          GPR12
> > 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > GPR16 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> >                        GPR20 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000                          GPR24
> > 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> >                  GPR28 0000000000000000 0000000000000000 00000000000000=
00
> > 0000000000000000
> > CR 00000000  [ -  -  -  -  -  -  -  -  ]             RES ffffffffffffff=
ff
> >                        FPR00 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000                          FPR04
> > 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> >                  FPR08 0000000000000000 0000000000000000 00000000000000=
00
> > 0000000000000000
> > FPR12 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
> >                        FPR16 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000                          FPR20
> > 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> >                  FPR24 0000000000000000 0000000000000000 00000000000000=
00
> > 0000000000000000                          FPR28 0000000000000000
> > 0000000000000000 0000000000000000 0000000000000000
> > FPSCR 0000000000000000
> >                        SRR0 0000000000000100  SRR1 8000000000080000
> PVR
> > 00000000003c0301 VRSAVE 0000000000000000      SPRG0 0000000000000000
> SPRG1
> > 0000000000000000  SPRG2 0000000000000000  SPRG3 0000000000000000
> SPRG4
> > 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SPRG7
> > 0000000000000000
> > SDR1 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000
> >
> > (qemu) q
> >
> > not sure if instruction pointer moved or not ...
> >
> > looking at some scroll buffer in Termux (I ssh into powermac ) it was a=
t
> > 700 all 3 times I typed "info registers" into qemu monitor.
> >
> > but this debug msg
> >
> > [154992.595845] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> > [154992.595859] kvmppc_exit_pr_progint: emulation at 100 failed
> (00000000)
> >
> >
> > fills logs FAST!
>
> NIP=3D0x700 is illegal instruction exception due to trying to execute 0
> opcode at 0x100 which is the reset vector but shouldn't it try to start a=
t
> 0xfff00100? Maybe there's some issue with setting up KVM correctly? You
> can trace what is executed in TCG with -d in_asm but that does not work
> for KVM as it's a TCG debug option. I don't know how to trace execution
> with KVM but probably there are some trace points for that. Maybe you get
> some info with -trace enable=3D"kvm*" but I don't know how to understand
> that output.
>

-trace *kvm* (on qemu 6.1.1) ends with

kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8080

kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8080

kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8080

kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8080
kvm_vcpu_ioctl cpu_index 0, type 0x84d0ae84, arg 0xe81a7b78

kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8018

kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8018
kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8018

kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8018
kvm_failed_spr_set Warning: Unable to set SPR 1013 to KVM: Invalid
argument
kvm_vcpu_ioctl cpu_index 0, type 0x2000ae80, arg (nil)

kvm_vcpu_ioctl cpu_index 0, type 0x2000ae80, arg (nil)

My hack idea  about adding || defined CONFIG_PPC_BOOK3S_64 to two statement
in

arch/powerpc/kvm/emulate.c

also did not improve situation :(

but at least I know I am running with patched kvm_pr module because I
commented this kernel printk about "failed to emulate instruction" and this
line disappeared from dmesg.




> Regards,
> BALATON Zoltan
>

--000000000000ea1efb06544c9da1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">=D0=BF=D0=BD, 15 =D0=B8=D1=8E=D0=BD. 2026 =D0=B3., 16:=
33 BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blan=
k" rel=3D"noreferrer">balaton@eik.bme.hu</a>&gt;:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">On Mon, 15 Jun 2026, Andrew Randrianasulu wrote:<br>
&gt; I also tried to see &quot;info registers&quot; as you showed in anothe=
r email from<br>
&gt; 2021 where you tried to use kvm-pr on qemu-emulated G5 and it showed<b=
r>
&gt;<br>
&gt; info registers<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NIP 00000000000=
00700=C2=A0 =C2=A0LR 0000000000000000 CTR<br>
&gt; 0000000000000000 XER 0000000000000000 CPU#0<br>
&gt; MSR 8000000000000000 HID0 0000000060000000=C2=A0 HF 8000000000000000 i=
idx 3 didx<br>
&gt; 3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 TB 00000000 00000000 DECR 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 GPR00 0000000000000000<br>
&gt; 0000000000000000 0000000000000000 0000000000000000<br>
&gt; GPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 GPR08 0000000000000000 0000000000000000<br>
&gt; 0000000000000000 0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GPR12<br>
&gt; 0000000000000000 0000000000000000 0000000000000000 0000000000000000<br=
>
&gt; GPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 GPR20 0000000000000000 0000000000000000<br>
&gt; 0000000000000000 0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GPR24<br>
&gt; 0000000000000000 0000000000000000 0000000000000000 0000000000000000<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GPR28 00=
00000000000000 0000000000000000 0000000000000000<br>
&gt; 0000000000000000<br>
&gt; CR 00000000=C2=A0 [ -=C2=A0 -=C2=A0 -=C2=A0 -=C2=A0 -=C2=A0 -=C2=A0 -=
=C2=A0 -=C2=A0 ]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RES fffffff=
fffffffff<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 FPR00 0000000000000000 0000000000000000<br>
&gt; 0000000000000000 0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FPR04<br>
&gt; 0000000000000000 0000000000000000 0000000000000000 0000000000000000<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FPR08 00=
00000000000000 0000000000000000 0000000000000000<br>
&gt; 0000000000000000<br>
&gt; FPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 FPR16 0000000000000000 0000000000000000<br>
&gt; 0000000000000000 0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FPR20<br>
&gt; 0000000000000000 0000000000000000 0000000000000000 0000000000000000<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FPR24 00=
00000000000000 0000000000000000 0000000000000000<br>
&gt; 0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FPR28 0000000000000000<br>
&gt; 0000000000000000 0000000000000000 0000000000000000<br>
&gt; FPSCR 0000000000000000<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 SRR0 0000000000000100=C2=A0 SRR1 8000000000080000=C2=A0 =C2=
=A0 PVR<br>
&gt; 00000000003c0301 VRSAVE 0000000000000000=C2=A0 =C2=A0 =C2=A0 SPRG0 000=
0000000000000 SPRG1<br>
&gt; 0000000000000000=C2=A0 SPRG2 0000000000000000=C2=A0 SPRG3 000000000000=
0000=C2=A0 =C2=A0 =C2=A0 SPRG4<br>
&gt; 0000000000000000 SPRG5 0000000000000000=C2=A0 SPRG6 0000000000000000=
=C2=A0 SPRG7<br>
&gt; 0000000000000000<br>
&gt; SDR1 0000000000000000=C2=A0 =C2=A0DAR 0000000000000000=C2=A0 DSISR 000=
0000000000000<br>
&gt;<br>
&gt; (qemu) q<br>
&gt;<br>
&gt; not sure if instruction pointer moved or not ...<br>
&gt;<br>
&gt; looking at some scroll buffer in Termux (I ssh into powermac ) it was =
at<br>
&gt; 700 all 3 times I typed &quot;info registers&quot; into qemu monitor.<=
br>
&gt;<br>
&gt; but this debug msg<br>
&gt;<br>
&gt; [154992.595845] Couldn&#39;t emulate instruction 0x00000000 (op 0 xop =
0)<br>
&gt; [154992.595859] kvmppc_exit_pr_progint: emulation at 100 failed (00000=
000)<br>
&gt;<br>
&gt;<br>
&gt; fills logs FAST!<br>
<br>
NIP=3D0x700 is illegal instruction exception due to trying to execute 0 <br=
>
opcode at 0x100 which is the reset vector but shouldn&#39;t it try to start=
 at <br>
0xfff00100? Maybe there&#39;s some issue with setting up KVM correctly? You=
 <br>
can trace what is executed in TCG with -d in_asm but that does not work <br=
>
for KVM as it&#39;s a TCG debug option. I don&#39;t know how to trace execu=
tion <br>
with KVM but probably there are some trace points for that. Maybe you get <=
br>
some info with -trace enable=3D&quot;kvm*&quot; but I don&#39;t know how to=
 understand <br>
that output.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">-trace *kvm* (on qemu 6.1.1) ends with=C2=A0</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div dir=3D"auto">kvm_vcpu_ioctl cpu_index=
 0, type 0x8010aeac, arg 0xe81a8080=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div dir=3D"auto">kvm_vcpu_ioctl cpu=
_index 0, type 0x8010aeac, arg 0xe81a8080=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div dir=3D"auto">kvm_vcpu_ioctl=
 cpu_index 0, type 0x8010aeac, arg 0xe81a8080=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div dir=3D"auto">kvm_vcp=
u_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8080</div><div dir=3D"auto"=
>kvm_vcpu_ioctl cpu_index 0, type 0x84d0ae84, arg 0xe81a7b78=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div dir=3D=
"auto">kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8018=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div=
 dir=3D"auto">kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe81a8018</=
div><div dir=3D"auto">kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg 0xe8=
1a8018=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0</div><div dir=3D"auto">kvm_vcpu_ioctl cpu_index 0, type 0x8010aeac, arg=
 0xe81a8018</div><div dir=3D"auto">kvm_failed_spr_set Warning: Unable to se=
t SPR 1013 to KVM: Invalid argument=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div dir=3D"auto">=
kvm_vcpu_ioctl cpu_index 0, type 0x2000ae80, arg (nil)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><di=
v dir=3D"auto">kvm_vcpu_ioctl cpu_index 0, type 0x2000ae80, arg (nil)</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">My hack idea=C2=A0 about addi=
ng || defined CONFIG_PPC_BOOK3S_64 to two statement in</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">arch/powerpc/kvm/emulate.c=C2=A0</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">also did not improve situation :(</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">but at least I know I am =
running with patched kvm_pr module because I commented this kernel printk a=
bout &quot;failed to emulate instruction&quot; and this line disappeared fr=
om dmesg.</div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Regards,<br>
BALATON Zoltan<br>
</blockquote></div></div></div>

--000000000000ea1efb06544c9da1--

