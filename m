Return-Path: <SRS0=XOTo=LL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191C3C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 05:22:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC396128C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 05:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC396128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G59RC5yjYz30Ff
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 15:22:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=M4DsVPWi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b;
 helo=mail-pj1-x102b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=M4DsVPWi; dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G59Qd6kxjz306n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2021 15:21:44 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id
 fy24-20020a17090b0218b029016c5a59021fso5423433pjb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=IiEIjleBusGBa/AVKIhB+ojZDFic8IqFpbVO6kSE2bs=;
 b=M4DsVPWi6V9ABVD4/wFHuv+DtK7vdPAeuGt4q68xjhSO+27cxKtMKV6eFaDsUwXxE8
 sNCnMWFgnh2TiYqv8T2YiRTfJNpFBRgdpY2amsy1JgdkP+AVEQEEblnsTrBr1/i6M232
 sc7HaBi1vN7BKaEMM7Ol+6TxXIwj415XBEGu+9OhJ1Qrc19NMT6w6NTbH+X+XDaiUE8W
 QZiBJHopzLXOwxepkcpl/dWbDWNVzXYFYKOEXc++VBvm2xZ1zwz7C34aBkQ5yflGd4a4
 J+lEQwF5ftbL/hXQqkolhPTLn2IFXl8mrY/aJCDPd0rt08qTMWum+5dP5X0RXSMvlFAe
 Jo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=IiEIjleBusGBa/AVKIhB+ojZDFic8IqFpbVO6kSE2bs=;
 b=F105N/Eslg2/rX+dCEJD9UWo4u3kYoAsyrPem2eWSCeUmXF4BHINxeLnnhXnqKPOxu
 sqjkNPp1wA6G90hUfHhq2Sw+eSzbx5WaI8KKdcbIUuFl5tp18n4ZdCSzYtAV1giwHB8M
 THkOMupuAPoVLW3sZlHEJ57DfFjS/2FLCIyTbAKM4NJ8x6+XvbM2+4Ol+eGSZgOhe6YD
 q3fzm+e7P6H4H+fAHEkl0W4ACso64rxnlcm17UCoJK8YoW31+wRvCoc6WnM8O9m0E3wL
 Px7RdFfp39+B8jCZNng2cuKfa508xj+/zj1TCYwfTrTsjgzTuTOfJRYZIpuzBJm6TDtS
 ar4w==
X-Gm-Message-State: AOAM531clH34vDTnDGf0cuRrBeStTGDmLYjQH/p5YoepO0gUtPsFUAOM
 b7dGqyJZKluWezQDkMOnh/s=
X-Google-Smtp-Source: ABdhPJzBkr0iJz5bdOnzNSpA9OOHOaTorvnhWBgBCxf7FNmiUP5c7fPfcObhierQgxNTP26VcJWpJw==
X-Received: by 2002:a17:902:8493:b029:11a:faa6:5bf6 with SMTP id
 c19-20020a1709028493b029011afaa65bf6mr2979254plo.42.1623907301768; 
 Wed, 16 Jun 2021 22:21:41 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id d6sm4011456pgq.88.2021.06.16.22.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 22:21:41 -0700 (PDT)
Date: Thu, 17 Jun 2021 15:21:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
To: Jessica Yu <jeyu@kernel.org>
References: <20210611093959.821525-1-npiggin@gmail.com>
 <20210611093959.821525-2-npiggin@gmail.com>
 <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <1623722110.amu32mwaqs.astroid@bobo.none>
 <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <1623805495.qdikm5ks8v.astroid@bobo.none> <YMn0cvhTyRtsE7xu@linux.fritz.box>
In-Reply-To: <YMn0cvhTyRtsE7xu@linux.fritz.box>
MIME-Version: 1.0
Message-Id: <1623907147.4k0ms3i41v.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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
Cc: Michal =?iso-8859-1?q?Such=E1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Jessica Yu's message of June 16, 2021 10:54 pm:
> +++ Nicholas Piggin [16/06/21 11:18 +1000]:
>>Excerpts from Jessica Yu's message of June 15, 2021 10:17 pm:
>>> +++ Nicholas Piggin [15/06/21 12:05 +1000]:
>>>>Excerpts from Jessica Yu's message of June 14, 2021 10:06 pm:
>>>>> +++ Nicholas Piggin [11/06/21 19:39 +1000]:
>>>>>>The elf_check_arch() function is used to test usermode binaries, but
>>>>>>kernel modules may have more specific requirements. powerpc would lik=
e
>>>>>>to test for ABI version compatibility.
>>>>>>
>>>>>>Add an arch-overridable function elf_check_module_arch() that default=
s
>>>>>>to elf_check_arch() and use it in elf_validity_check().
>>>>>>
>>>>>>Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>>>>[np: split patch, added changelog]
>>>>>>Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>>>---
>>>>>> include/linux/moduleloader.h | 5 +++++
>>>>>> kernel/module.c              | 2 +-
>>>>>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>>diff --git a/include/linux/moduleloader.h b/include/linux/moduleloade=
r.h
>>>>>>index 9e09d11ffe5b..fdc042a84562 100644
>>>>>>--- a/include/linux/moduleloader.h
>>>>>>+++ b/include/linux/moduleloader.h
>>>>>>@@ -13,6 +13,11 @@
>>>>>>  * must be implemented by each architecture.
>>>>>>  */
>>>>>>
>>>>>>+// Allow arch to optionally do additional checking of module ELF hea=
der
>>>>>>+#ifndef elf_check_module_arch
>>>>>>+#define elf_check_module_arch elf_check_arch
>>>>>>+#endif
>>>>>
>>>>> Hi Nicholas,
>>>>>
>>>>> Why not make elf_check_module_arch() consistent with the other
>>>>> arch-specific functions? Please see module_frob_arch_sections(),
>>>>> module_{init,exit}_section(), etc in moduleloader.h. That is, they ar=
e
>>>>> all __weak functions that are overridable by arches. We can maybe mak=
e
>>>>> elf_check_module_arch() a weak symbol, available for arches to
>>>>> override if they want to perform additional elf checks. Then we don't
>>>>> have to have this one-off #define.
>>>>
>>>>
>>>>Like this? I like it. Good idea.
>>>
>>> Yeah! Also, maybe we can alternatively make elf_check_module_arch() a
>>> separate check entirely so that the powerpc implementation doesn't
>>> have to include that extra elf_check_arch() call. Something like this m=
aybe?
>>
>>Yeah we can do that. Would you be okay if it goes via powerpc tree? If
>>yes, then we should get your Ack (or SOB because it seems to be entirely
>>your patch now :D)
>=20
> This can go through the powerpc tree. Will you do another respin
> of this patch? And yes, feel free to take my SOB for this one -
>=20
>      Signed-off-by: Jessica Yu <jeyu@kernel.org>

You're maintainer so let's go with your preference. We can always adjust=20
the arch hooks later if a need comes up. And yes I'll re post with you=20
cc'ed.

Thanks,
Nick
