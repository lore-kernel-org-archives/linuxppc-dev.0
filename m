Return-Path: <linuxppc-dev+bounces-22620-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B33CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:26:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gf4W76Xs9z3bqD;
	Mon, 15 Jun 2026 19:26:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1131" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781515587;
	cv=pass; b=O4slGxA02Akn1xoll1oA0WwD+5k1GI0S+xZJ+yDKnOyy/vrHLLll39y/Pkx5jgtHP1FDpZAb44p4IlA0hOh53WcjgY0CwRDKTPH4kwEK3c19/eA40Xslkzwgsas6pwnGimCBLNDL4kdcjHS/c8eAZEUltyubpTX/0XEE5394+5/UUjFBz31w5iLJNPPdKlp+0Gy5rz4SltjrGRkGLZ1Gm0Lf08MP3KvtgfOuppQrh9MSSLIYWQM8g81c5jR75k78urppUnXsS0rYZXIFl63kMBRxN8J9woimK2yes+jeplt23fbRHX2bei33UkGRiCs80RsgRu3YMbP2HxlC+9As/w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781515587; c=relaxed/relaxed;
	bh=uJ5DDakusGy1O6hTlTfZiWDHUUwVCLIjNiA8C12PH6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KREP2rEr+c7tlvKJS7kNeN0N8Jc/FNfDl0t63MVVw/8s2npL4l0auYfVJWHwQCrZqGLzgrjSVZ1yy5R1iFEDWcNnl+xK3ha9mySFwX3wr/bxDiRI17gnwATisAZ5fAr/1aFqxrflQ3ZZsyw7kmL5pv0NJGylXrDQbQTBBGuU/OG4ONwxdXp3H/JBZW8QxkwpaAijwpsFNfwxR2Ybx8xV/VZJhmIWj2xJW8qfuqbfdtaCVa8/S0J1HUpczkwJfmWxrIeCLTARQZ+bSl2BWUGOHhy+YI5Jssq00gak8iZZjtt+dGuqn5C70jhtFuI10/M/QxuWwSK0dEgnroLoVre7xw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bbsQVn4R; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=randrianasulu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bbsQVn4R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=randrianasulu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gf4W4662tz30gJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 19:26:24 +1000 (AEST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-7ea6923cc94so30311767b3.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 02:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781515577; cv=none;
        d=google.com; s=arc-20240605;
        b=gXGolh1MrtoXMKdYdb8MYHEKB60i+hWot9i3tuvlOkVRpJUzKjTRxltky6HsccwGSL
         f9Kn38ibyXCP0k+lFlR9v+8QEVj/VHDXa19htubYgZtwpntJhFzMzakLjFDZ/cRf3clP
         BsrvLDMwDVXy+VmSHpokK/Q2us1A53zxUn16i1iHPEj2BBj4lhH9EZ71JPSaSIRINS81
         hw4Gcpib607FdMjqASZ2Y9Nmj0ttbI0vHCwX0y5jrST1rgkqN9VGZDj0bCOsTxfatJby
         jCDCZwp5tSbaKLTncwfi8pb66tB7F6fQOlbamXzRVwG/RDFfRGbv/S6ieosueHASiGGH
         vLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uJ5DDakusGy1O6hTlTfZiWDHUUwVCLIjNiA8C12PH6U=;
        fh=ZWK9I7o4x0Fi00GScP8gTsfxX3AwAQY21CuJWZrCUGQ=;
        b=Kz34c8+h2yXy9mOrwdZP74R6gk2nHi0WPy6d4L1Wz3MiC0A+iVFo06s/IQLNcILqLV
         M/5B9hbyuHnuBBEwycaKD8lZWbYxyFQMQXpimByxMv0HB0nc/sdHk324GEpRylPDxJdg
         vWwtJqNU7Z10+Ny0bSKqvmwGeirB6gMik+0Tcb3FqQ9NaBb7yIuotAQGBoFZ87IvO2p9
         rQ7N8DP0pSFSDwDGXowAhqppsR9WYn4w4SbSwb8LGU0NJ3s6p59nAzoTc7uOnogr/Da5
         lvEmN4xxtW/o6Vjy/jbJPou9oJksmu+Dv3IVSWiwCudSusfFVNNZHeWezEuonhRocdhU
         mYpA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781515577; x=1782120377; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ5DDakusGy1O6hTlTfZiWDHUUwVCLIjNiA8C12PH6U=;
        b=bbsQVn4RD+aNrExwZByccRmcv/Sxe44cdrV6TFP2aXGvRFW3qf3EE2tvkaX/KoucQX
         ani1z5r68e50oiSXAKCWnFOtzC2yQQ5PZA5Jzo5twW5+ApzO10y0ONU6eiNGaoxR6PAS
         pyPFy1Y8e+FKxfVHMQTA5xierNlF7Kz87a1QJl2b0zjYli4E2ilOt83MJ/G0Iw/WmfuB
         fejfNtMgG9tS72tmIRi+bIfYS+FpT/ytd06FJ/PK90dfM769SyjeXaGppsRzdwmEj3lZ
         med2Pea4Qf+uYiGn4np6un1db5o6bCEZqtMOBjtSwZ2Dv/4uFW2NGlWmSdROGGOO4SiY
         bhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781515577; x=1782120377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ5DDakusGy1O6hTlTfZiWDHUUwVCLIjNiA8C12PH6U=;
        b=jLqezCU0tH2FF3o+swZxUmP5REruBSJUUnETltbb7BC950PQbMHYDeW6CGFPerjA+z
         W/5SVRmESxiuZ1qN3tOCQX9TBEASl2QqLIN3P2r/pew2R347noCAWdU0b0e2qMSR4MJw
         gngys41lU3aUdE6E52WSAGnsITUoKVBk7UVUWPMfqovdnnrRuRHIJ2Lf5ULW/TMKw6Rm
         UoriTpkUzoLIAhJMb4nLldqDPrOohYbqzSF0LbDCfrKMSd+iMoO6Ts26XoV86R/ypIUN
         kOuNB8Yyut4beWtGEvWf2esb+ybuQhl5GLLVp2xY59z1eMPO2VFAdCZAAO/V22C2pfBg
         iarQ==
X-Forwarded-Encrypted: i=1; AFNElJ9P2VIe/iPl7AscFgSxS5mbHPUC8/pSl7EAqKXGrnIo8zyfF8kuHq27t6danp6+6ffld9iPa6kG8OxmKoQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxr0e9Zws+rc/lyp2RU4h9dVh3+PQPwx8J2gCBWYHoQE9aKb0aD
	bACT9mNBXGi2tJ/I0RFITyAXy1fly+tNqwlLuhcONNVI8uw8I/c6cJ0df+5muGcZMLeF7RvGTsP
	ydMWKhXgHfJ3O7pzeRsGMcURqLY5i5sUpWUxh
X-Gm-Gg: Acq92OEjQ5LRpneuKfnMVhAu/FdHcvWGfllPAemI1zIS6tF6nXXo9pvFP8Q/mlQhwKa
	x16xTUTAiW9jrq9mhQQQZcgtmE88UYfrw4StHyDS5+NhnfjoqrwRJGt5eD3TUwq4xusvlAjwjj4
	/KAoFwrUUK7XLz+EfAErdFWiCbdTKp1esiGsjH/droaLrLD4w8VY+nKkEHnyjZlIZoAED08f/wB
	pPT6dExPU87m/YQn4ROmEuPRfXiYwCP2PmXS6L46Rr78AhNyJqXxslW+E5UjC9G/sBCuOjP/NH3
	7VbehbiUaZZj6J0p21Xc
X-Received: by 2002:a05:690c:7242:b0:7b2:136d:2436 with SMTP id
 00721157ae682-7f7b5e4b8eemr118792367b3.8.1781515576785; Mon, 15 Jun 2026
 02:26:16 -0700 (PDT)
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
 <fb610033-efd3-6fa6-bd80-c5dccc9296eb@eik.bme.hu>
In-Reply-To: <fb610033-efd3-6fa6-bd80-c5dccc9296eb@eik.bme.hu>
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Mon, 15 Jun 2026 12:26:03 +0300
X-Gm-Features: AVVi8CfF7eocWKIGG0P7BryNrHQZ8o02uJQ_4MViJXP5WwWPs0ws20fAmjj9fV0
Message-ID: <CA+rFky4nea6VPhYuVhH2SwSAgP0QC5LMrHqfWAwKNMNHpQ7aYg@mail.gmail.com>
Subject: Re: Does kvm_pr work on G5 mac with host kernel 6.12.xx ?
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000001dc0380654476bd9"

--0000000000001dc0380654476bd9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=81, 14 =D0=B8=D1=8E=D0=BD. 2026 =D0=B3., 23:35 BALATON Zoltan <ba=
laton@eik.bme.hu>:

> On Sun, 14 Jun 2026, Andrew Randrianasulu wrote:
> > =D0=B2=D1=81, 14 =D0=B8=D1=8E=D0=BD. 2026 =D0=B3., 17:29 BALATON Zoltan=
 <balaton@eik.bme.hu>:
> >> On Sun, 14 Jun 2026, Andrew Randrianasulu wrote:
> >>> I tried qemu 10.0.10 (qemu-system-ppc) compiled as ppc32 binary - fai=
l
> >>>
> >>> I tried qemu 2.2.0 compiled as ppc64 binary (qemu-system-ppc and ppc6=
4
> >>> variants) -fail
> >>>
> >>> I tried qemu 5.0.0 compiled as 32bit ppc (qemu-system-ppc) - fail.
> >>>
> >>> I tried qemu 6.1.1 compiled as 32bit ppc binary - qemu-system-ppc.
> Fail.
> >>>
> >>> I tried recompiling host kernel without preemtion - still fail.
> >>>
> >>> :(
> >>>
> >>> fail like this in dmesg
> >>>
> >>> [75573.287328] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> >>>                        [75573.287334] kvmppc_exit_pr_progint: emulati=
on
> >> at
> >>> 100 failed (00000000)
> >>>
> >>>
> >>> lscpu output:
> >>> Architecture:                ppc64
> >>>
> >>> CPU op-mode(s):            32-bit, 64-bit
> >>> Byte Order:                Big Endian
> >>> CPU(s):                      2
> >>>
> >>> On-line CPU(s) list:       0,1
> >>>
> >>> Model name:                  PPC970MP, altivec supported
> >>> Model:                     1.1 (pvr 0044 0101)
> >> [...]
> >>> Why so old qemu? Well, it worked on OSX Leopard 10.5.8 on same machin=
e,
> >> so
> >>> I compiled it as 64bit ppc64 binary - new qemu grow a lot  ... and
> >> keeping
> >>> effectively 3 different dev systems makes this 160 gb hdd look small =
:)
> >>
> >> I don't know about it but I think the only combination that ever worke=
d
> >> was ppc on ppc (i.e. KVM on G4 Macs) or maybe ppc64 on ppc64. Running
> ppc
> >> on ppc64 is known not to work and I haven't heard about anybody fixing
> >> that. There was a blog entry about running MacOS on Power10:
>
> Actually I meant POWER9 not POWER10.
>
> >>
> https://www.talospace.com/2018/08/making-your-talos-ii-into-power-mac_29.=
html
> >> but I think that was on ppc64le (which does not work on G5 as that's b=
ig
> >> endian only) and you still needed a guest kernel that could handle the
> G5
> >> due to different cache line size that affects at least dcbz which is
> used
> >> to clear memory so unless that's correctly emulated by KVM it may clea=
r
> >> more bytes than intended and break.
> >>
> >
> > https://forum.hyperion-entertainment.com/viewtopic.php?t=3D4736&start=
=3D1410
> >
> > I thought this picture showed ppc64 kernel at host (not mac, neo amiga)
> and
> > qemu-system-ppc with non-obvious bitness?
>
> But that's BookE e500 not the BookS POWER4 variant G5 you have so KVM may
> work differently on that and maybe it even has HV which probably works
> better than PR.


oh yes, I noticed another "hidden" option in Kconfig about kvm pr on
E5500/E6500

It was hidden because I did not select such machine in config, I guess.


I think KVM was used on G4, e500 and newer POWER mostly
> with HV but I'm not sure if KVM PR on G5 was ever well supported. Did you
> try running the same Linux version that you have on your host under KVM P=
R
> first to verify that at least that works? I think that's where everybody
> should start with KVM before trying to boot other guest OSes.
>
> >> So considering the above, what may work is if you run a 32 bit ppc
> kernel
> >> (G4 version) on your G5 for the host not using it as 64 bit instead of
> >> ppc64 kernel and try a guest kernel that detects G5 CPU and knows how =
to
> >> handle the different cache line size.
> >
> >
> > Are you saying 32bit *Linux* ppc kvm as host can handle 64bit guest
> kernel ?
>
> No I meant trying a 32 bit host with 32 bit guest but the cache line size
> issue may still get in the way so maybe this does not help but for
> debugging may worth a try.
>
> > I am not ever sure firmware here can load 32bit ppc Linux .. I'll try o=
f
> > course.
>
> Since G5 is backwards compatible with PPC32 maybe it should work but I
> know nothing about real PowerPC machines.
>
> > Or find and fix the emulation of
> >> different instructions on ppc64 in Linux KVM when running 32 bit ppc
> code
> >> on 64 but host. There supposed to be some support for that but maybe
> it's
> >> broken or never finished.
>

I found this email msg today:


https://lkml.iu.edu/1605.1/03841.html

checked

linux-6.12.92/arch/powerpc/kvm/emulate.c and there seems to be ifdef only
for

#ifdef CONFIG_PPC_BOOK3S
                       kvmppc_core_queue_program(vcpu, SRR1_PROGTRAP);

#else
                        kvmppc_core_queue_program(vcpu,
                        arch.shared->esr | ESR_PTR);

#endif


may be this ifdef should include CONFIG_PPC_BOOK3S_64 as well ?

I also tried to see "info registers" as you showed in another email from
2021 where you tried to use kvm-pr on qemu-emulated G5 and it showed

info registers
                NIP 0000000000000700   LR 0000000000000000 CTR
0000000000000000 XER 0000000000000000 CPU#0
MSR 8000000000000000 HID0 0000000060000000  HF 8000000000000000 iidx 3 didx
3                      TB 00000000 00000000 DECR 0
                                              GPR00 0000000000000000
0000000000000000 0000000000000000 0000000000000000
GPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
                        GPR08 0000000000000000 0000000000000000
0000000000000000 0000000000000000                          GPR12
0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
                        GPR20 0000000000000000 0000000000000000
0000000000000000 0000000000000000                          GPR24
0000000000000000 0000000000000000 0000000000000000 0000000000000000
                  GPR28 0000000000000000 0000000000000000 0000000000000000
0000000000000000
CR 00000000  [ -  -  -  -  -  -  -  -  ]             RES ffffffffffffffff
                        FPR00 0000000000000000 0000000000000000
0000000000000000 0000000000000000                          FPR04
0000000000000000 0000000000000000 0000000000000000 0000000000000000
                  FPR08 0000000000000000 0000000000000000 0000000000000000
0000000000000000
FPR12 0000000000000000 0000000000000000 0000000000000000 0000000000000000
                        FPR16 0000000000000000 0000000000000000
0000000000000000 0000000000000000                          FPR20
0000000000000000 0000000000000000 0000000000000000 0000000000000000
                  FPR24 0000000000000000 0000000000000000 0000000000000000
0000000000000000                          FPR28 0000000000000000
0000000000000000 0000000000000000 0000000000000000
FPSCR 0000000000000000
                        SRR0 0000000000000100  SRR1 8000000000080000    PVR
00000000003c0301 VRSAVE 0000000000000000      SPRG0 0000000000000000 SPRG1
0000000000000000  SPRG2 0000000000000000  SPRG3 0000000000000000      SPRG4
0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SPRG7
0000000000000000
 SDR1 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000

(qemu) q

not sure if instruction pointer moved or not ...

looking at some scroll buffer in Termux (I ssh into powermac ) it was at
700 all 3 times I typed "info registers" into qemu monitor.

but this debug msg

[154992.595845] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
[154992.595859] kvmppc_exit_pr_progint: emulation at 100 failed (00000000)


fills logs FAST!


>>
> >> But as I said I don't know this and don't have PPC hardware to try, no=
r
> >> interest to do it so it's just my understanding and guess, which may b=
e
> >> wrong, but that's probably where you should start looking. Hopefully
> there
> >> are others here with more knowledge about it or who want to look at it=
.
> >> You should also look at how to enable KVM debug logs in Linux kernel a=
nd
> >> see if you get any errors in the syslog. The usual QEMU debug options
> are
> >> not that helpful with KVM and you should look for KVM logs instead.
> >>
> >
> > In theory I subscribed to linux-ppc (kernel) list. May be I should cc
> them
> > ? (added to cc)
> >
> > I tried kvm-unit-tests but they apparently require qemu (to my surprise=
!)
> > and mostly focus on pseries / kvm HV (not surprisingly)?
> >
> > Is there anything smaller to test kvm_pr specifically?
> >
> > I even tried to d/l svn version of Mac on Linux but this one failed to
> > compile with gcc 15.
> >
> > svn checkout svn://svn.code.sf.net/p/mac-on-linux/code/trunk
> > mac-on-linux-code
>
> I think you may have better luck trying an older Linux distro from the
> time this was still used and had MoL as a package as that may have been
> tested back then on real machines and used to work. Anything newer is
> likely untested and thus could be broken without anybody noticing and
> fixing it so finding something older that worked at least would give a
> baseline to find regressions against.
>


Yeah, it will require some work/time on my end.

If simple hack like adding ifdef case as I speculated above will not work
.. will try harder  route  : )

>
> Regards,
> BALATON Zoltan

--0000000000001dc0380654476bd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">=D0=B2=D1=81, 14 =D0=B8=D1=8E=D0=BD. 2026 =D0=B3., 23:=
35 BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" rel=3D"noreferr=
er noreferrer noreferrer noreferrer" target=3D"_blank">balaton@eik.bme.hu</=
a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Sun, 14 Jun 2026, Andrew=
 Randrianasulu wrote:<br>
&gt; =D0=B2=D1=81, 14 =D0=B8=D1=8E=D0=BD. 2026 =D0=B3., 17:29 BALATON Zolta=
n &lt;<a href=3D"mailto:balaton@eik.bme.hu" rel=3D"noreferrer noreferrer no=
referrer noreferrer noreferrer" target=3D"_blank">balaton@eik.bme.hu</a>&gt=
;:<br>
&gt;&gt; On Sun, 14 Jun 2026, Andrew Randrianasulu wrote:<br>
&gt;&gt;&gt; I tried qemu 10.0.10 (qemu-system-ppc) compiled as ppc32 binar=
y - fail<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I tried qemu 2.2.0 compiled as ppc64 binary (qemu-system-ppc a=
nd ppc64<br>
&gt;&gt;&gt; variants) -fail<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I tried qemu 5.0.0 compiled as 32bit ppc (qemu-system-ppc) - f=
ail.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I tried qemu 6.1.1 compiled as 32bit ppc binary - qemu-system-=
ppc. Fail.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I tried recompiling host kernel without preemtion - still fail=
.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; :(<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; fail like this in dmesg<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; [75573.287328] Couldn&#39;t emulate instruction 0x00000000 (op=
 0 xop 0)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 [75573.287334] kvmppc_exit_pr_progint: emulation<br>
&gt;&gt; at<br>
&gt;&gt;&gt; 100 failed (00000000)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; lscpu output:<br>
&gt;&gt;&gt; Architecture:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ppc64<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; CPU op-mode(s):=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32-bi=
t, 64-bit<br>
&gt;&gt;&gt; Byte Order:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Big Endian<br>
&gt;&gt;&gt; CPU(s):=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 2<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On-line CPU(s) list:=C2=A0 =C2=A0 =C2=A0 =C2=A00,1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Model name:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 PPC970MP, altivec supported<br>
&gt;&gt;&gt; Model:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01.1 (pvr 0044 0101)<br>
&gt;&gt; [...]<br>
&gt;&gt;&gt; Why so old qemu? Well, it worked on OSX Leopard 10.5.8 on same=
 machine,<br>
&gt;&gt; so<br>
&gt;&gt;&gt; I compiled it as 64bit ppc64 binary - new qemu grow a lot=C2=
=A0 ... and<br>
&gt;&gt; keeping<br>
&gt;&gt;&gt; effectively 3 different dev systems makes this 160 gb hdd look=
 small :)<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t know about it but I think the only combination that ev=
er worked<br>
&gt;&gt; was ppc on ppc (i.e. KVM on G4 Macs) or maybe ppc64 on ppc64. Runn=
ing ppc<br>
&gt;&gt; on ppc64 is known not to work and I haven&#39;t heard about anybod=
y fixing<br>
&gt;&gt; that. There was a blog entry about running MacOS on Power10:<br>
<br>
Actually I meant POWER9 not POWER10.<br>
<br>
&gt;&gt; <a href=3D"https://www.talospace.com/2018/08/making-your-talos-ii-=
into-power-mac_29.html" rel=3D"noreferrer noreferrer noreferrer noreferrer =
noreferrer noreferrer" target=3D"_blank">https://www.talospace.com/2018/08/=
making-your-talos-ii-into-power-mac_29.html</a><br>
&gt;&gt; but I think that was on ppc64le (which does not work on G5 as that=
&#39;s big<br>
&gt;&gt; endian only) and you still needed a guest kernel that could handle=
 the G5<br>
&gt;&gt; due to different cache line size that affects at least dcbz which =
is used<br>
&gt;&gt; to clear memory so unless that&#39;s correctly emulated by KVM it =
may clear<br>
&gt;&gt; more bytes than intended and break.<br>
&gt;&gt;<br>
&gt;<br>
&gt; <a href=3D"https://forum.hyperion-entertainment.com/viewtopic.php?t=3D=
4736&amp;start=3D1410" rel=3D"noreferrer noreferrer noreferrer noreferrer n=
oreferrer noreferrer" target=3D"_blank">https://forum.hyperion-entertainmen=
t.com/viewtopic.php?t=3D4736&amp;start=3D1410</a><br>
&gt;<br>
&gt; I thought this picture showed ppc64 kernel at host (not mac, neo amiga=
) and<br>
&gt; qemu-system-ppc with non-obvious bitness?<br>
<br>
But that&#39;s BookE e500 not the BookS POWER4 variant G5 you have so KVM m=
ay <br>
work differently on that and maybe it even has HV which probably works <br>
better than PR. </blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">oh yes, I noticed another &quot;hidden&quot; option in Kconfig =
about kvm pr on E5500/E6500</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">It was hidden because I did not select such machine in config, I guess.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I think KVM =
was used on G4, e500 and newer POWER mostly <br>
with HV but I&#39;m not sure if KVM PR on G5 was ever well supported. Did y=
ou <br>
try running the same Linux version that you have on your host under KVM PR =
<br>
first to verify that at least that works? I think that&#39;s where everybod=
y <br>
should start with KVM before trying to boot other guest OSes.<br>
<br>
&gt;&gt; So considering the above, what may work is if you run a 32 bit ppc=
 kernel<br>
&gt;&gt; (G4 version) on your G5 for the host not using it as 64 bit instea=
d of<br>
&gt;&gt; ppc64 kernel and try a guest kernel that detects G5 CPU and knows =
how to<br>
&gt;&gt; handle the different cache line size.<br>
&gt;<br>
&gt;<br>
&gt; Are you saying 32bit *Linux* ppc kvm as host can handle 64bit guest ke=
rnel ?<br>
<br>
No I meant trying a 32 bit host with 32 bit guest but the cache line size <=
br>
issue may still get in the way so maybe this does not help but for <br>
debugging may worth a try.<br>
<br>
&gt; I am not ever sure firmware here can load 32bit ppc Linux .. I&#39;ll =
try of<br>
&gt; course.<br>
<br>
Since G5 is backwards compatible with PPC32 maybe it should work but I <br>
know nothing about real PowerPC machines.<br>
<br>
&gt; Or find and fix the emulation of<br>
&gt;&gt; different instructions on ppc64 in Linux KVM when running 32 bit p=
pc code<br>
&gt;&gt; on 64 but host. There supposed to be some support for that but may=
be it&#39;s<br>
&gt;&gt; broken or never finished.<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">I found this email msg today:</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><a href=
=3D"https://lkml.iu.edu/1605.1/03841.html" rel=3D"noreferrer noreferrer nor=
eferrer noreferrer" target=3D"_blank">https://lkml.iu.edu/1605.1/03841.html=
</a></div><div dir=3D"auto"><br></div><div dir=3D"auto">checked</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">linux-6.12.92/arch/powerpc/kvm/emul=
ate.c and there seems to be ifdef only for</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">#ifdef CONFIG_PPC_BOOK3S=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0kvmppc_core_queue_program(vcpu, SRR1_PROGTRAP);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0</div><div dir=3D"auto">#else=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 kvmppc_core_queue_program(vcpu,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arch.shared-&gt;esr | ESR_PTR=
);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0</div><div dir=3D"auto">#endif</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">may be this ifdef shoul=
d include CONFIG_PPC_BOOK3S_64 as well ?</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">I also tried to see &quot;info registers&quot; as you show=
ed in another email from 2021 where you tried to use kvm-pr on qemu-emulate=
d G5 and it showed</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
dir=3D"auto">info registers=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 NIP 0000000000000700=C2=A0 =C2=A0LR 0000000000000000 CTR 00000000000000=
00 XER 0000000000000000 CPU#0</div><div dir=3D"auto">MSR 8000000000000000 H=
ID0 0000000060000000=C2=A0 HF 8000000000000000 iidx 3 didx 3=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TB 00000000 =
00000000 DECR 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GPR00 0000000000000000 000000=
0000000000 0000000000000000 0000000000000000</div><div dir=3D"auto">GPR04 0=
000000000000000 0000000000000000 0000000000000000 0000000000000000=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 GPR08 0000000000000000 0000000000000000 0000000000000000 0000000=
000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 GPR12 0000000000000000 0000000000000000 0000000000=
000000 0000000000000000</div><div dir=3D"auto">GPR16 0000000000000000 00000=
00000000000 0000000000000000 0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GPR20 000000=
0000000000 0000000000000000 0000000000000000 0000000000000000=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 GPR24 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 GPR28 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000</div><div dir=3D"auto">CR 00000000=C2=A0 [ -=C2=A0 -=C2=A0=
 -=C2=A0 -=C2=A0 -=C2=A0 -=C2=A0 -=C2=A0 -=C2=A0 ]=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RES ffffffffffffffff=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FPR00 000000000=
0000000 0000000000000000 0000000000000000 0000000000000000=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 F=
PR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 FPR08 0000000000000000 0000000000000000 0000000000000000 0000=
000000000000</div><div dir=3D"auto">FPR12 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FPR16 0000000000000000 00=
00000000000000 0000000000000000 0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FPR20 00000=
00000000000 0000000000000000 0000000000000000 0000000000000000=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 FPR24 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 FPR28 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FPSCR 0000000000000000=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SRR0 0000000000000100=C2=A0 SRR1 8000000000=
080000=C2=A0 =C2=A0 PVR 00000000003c0301 VRSAVE 0000000000000000=C2=A0 =C2=
=A0 =C2=A0 SPRG0 0000000000000000 SPRG1 0000000000000000=C2=A0 SPRG2 000000=
0000000000=C2=A0 SPRG3 0000000000000000=C2=A0 =C2=A0 =C2=A0 SPRG4 000000000=
0000000 SPRG5 0000000000000000=C2=A0 SPRG6 0000000000000000=C2=A0 SPRG7 000=
0000000000000</div><div dir=3D"auto">=C2=A0SDR1 0000000000000000=C2=A0 =C2=
=A0DAR 0000000000000000=C2=A0 DSISR 0000000000000000=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0</div><div dir=3D"auto">(qemu) q</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">not sure if instruction pointer moved or not ...</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">looking at some scroll bu=
ffer in Termux (I ssh into powermac ) it was at 700 all 3 times I typed &qu=
ot;info registers&quot; into qemu monitor.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">but this debug msg=C2=A0</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div dir=3D"auto">[154992.595845] Couldn&#39;t emulate =
instruction 0x00000000 (op 0 xop 0)</div><div dir=3D"auto">[154992.595859] =
kvmppc_exit_pr_progint: emulation at 100 failed (00000000)=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">fills logs FAST!</d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt;&gt;<br>
&gt;&gt; But as I said I don&#39;t know this and don&#39;t have PPC hardwar=
e to try, nor<br>
&gt;&gt; interest to do it so it&#39;s just my understanding and guess, whi=
ch may be<br>
&gt;&gt; wrong, but that&#39;s probably where you should start looking. Hop=
efully there<br>
&gt;&gt; are others here with more knowledge about it or who want to look a=
t it.<br>
&gt;&gt; You should also look at how to enable KVM debug logs in Linux kern=
el and<br>
&gt;&gt; see if you get any errors in the syslog. The usual QEMU debug opti=
ons are<br>
&gt;&gt; not that helpful with KVM and you should look for KVM logs instead=
.<br>
&gt;&gt;<br>
&gt;<br>
&gt; In theory I subscribed to linux-ppc (kernel) list. May be I should cc =
them<br>
&gt; ? (added to cc)<br>
&gt;<br>
&gt; I tried kvm-unit-tests but they apparently require qemu (to my surpris=
e!)<br>
&gt; and mostly focus on pseries / kvm HV (not surprisingly)?<br>
&gt;<br>
&gt; Is there anything smaller to test kvm_pr specifically?<br>
&gt;<br>
&gt; I even tried to d/l svn version of Mac on Linux but this one failed to=
<br>
&gt; compile with gcc 15.<br>
&gt;<br>
&gt; svn checkout svn://<a href=3D"http://svn.code.sf.net/p/mac-on-linux/co=
de/trunk" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer nor=
eferrer" target=3D"_blank">svn.code.sf.net/p/mac-on-linux/code/trunk</a><br=
>
&gt; mac-on-linux-code<br>
<br>
I think you may have better luck trying an older Linux distro from the <br>
time this was still used and had MoL as a package as that may have been <br=
>
tested back then on real machines and used to work. Anything newer is <br>
likely untested and thus could be broken without anybody noticing and <br>
fixing it so finding something older that worked at least would give a <br>
baseline to find regressions against.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah, it =
will require some work/time on my end.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">If simple hack like adding ifdef case as I speculated above =
will not work .. will try harder=C2=A0 route=C2=A0 : )=C2=A0</div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Regards,<br>
BALATON Zoltan</blockquote></div></div></div>

--0000000000001dc0380654476bd9--

