Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC15606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 04:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4uSy8NA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPVKj5P0vz2xWR;
	Wed, 11 Nov 2026 15:05:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794369913;
	cv=none; b=gil+9oQmTTTfIJU0K7z2Pbkaps7tG3ZPB5SUWC43+ESWdSnrG9zb2q4Q1ASexBo6m9iQVbpi02AAPnzP+3aFbq4HRzB7+N8dX37K37v4CvBbguR/wfyCyjEInQeaLA6trZpIq+o8sX80Oq+aBjY55ZoSjn903HSTXkKddPLDDCJno1ZLnAfPy0KcueRqx0/xVUHbNUFm0F29zfWAKk4CXE99/qX97oYSL6084o+u7CArGaXGzjPoB+cKCY6bTe8ie9Kxtlt1TvEEdEyPmiLXiP2Nq3ZxkPznHw5o+Dt8dQFYyWY7FG1I7A2mvFAEY2QOHtotP8NiuI1p9V+87ZxOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794369913; c=relaxed/relaxed;
	bh=pqYnnRFRLqeNXaNeclAUIXtFB5ln4VyCuNDPTaVNNkw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=I6waPaVuI7xrgpj6yplcPiEC/xLG0gCItC4wR2mdSHwLmDjuN1/OePK/jUhc912BpQWwdxnHdgH0PNPSGuDn/Pzwy1yiQyAYXqZVuoGt67xBruzwLFKjGdvA4u+k0ZiPkdIN8Uudg+p/jrvXZhOFFQQTkiEww0Hg6ydMoclWowDrEm+01DXboAgaPFu7bUhWJTojqTzVQV47zIPaPS+HLWPbNDFX1GiMMjjLowX2FM8mFdq5dX8+rbzCQTlW1rDMjlEyhzro2QHRpvdVMkKehsA/jzzLQo+w9s8aJO6uL/Faq5xZHNV0Cln0MOeco1QrvT/d0oZjE+Sf9GW7PyUZMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4uSy8NA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4uSy8NA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com [IPv6:2607:f8b0:4864:20::1233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPVKh4qplz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 15:05:11 +1100 (AEDT)
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1b3ada81853so2463237c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 20:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794369909; x=1794974709; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pqYnnRFRLqeNXaNeclAUIXtFB5ln4VyCuNDPTaVNNkw=;
        b=P4uSy8NARXdI6cCpv2a8UXrZQgUq7eRVPA+SmPQs270/PnrrAsJinJl66+ZgSh1CF2
         XsaJl7PEdkf4QZn2t+I7bkh08Yay9zo2BBpXuioPOEendkWrL+cLuzFCAnh9wUCsumda
         ReEkoyb68kMfISvKi9h95FGttFbIBF0yzcQUGLv033nWKvEX39sreTl/qqS17/EKM3/w
         mEL56j8btsffpX6thCUZnDxf1ZdyYOGsAzvd3hwK5mcZ/PJzqVAtUqVbW+Ppw9i8P8kn
         pESEgORDldO4bOKOBopHONA/3Lr5HLECtfy4H/ls4ihNB/lrZTsnlQyUI6EN6jWJ1q6A
         sZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794369909; x=1794974709;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pqYnnRFRLqeNXaNeclAUIXtFB5ln4VyCuNDPTaVNNkw=;
        b=BOYr3+MCwZiHUB/kj+biSCNES9xRmXhT1JdT+8XizRt+nlVQmXF8eghFYNpzL6cp4/
         Pf2UbCZVk66dnNoeFb3SvRboXue/Z/N6yKi9GfHpTunJuzMXvAg9OTuzk1mi4PwR1Mdq
         W32Hqufcih56XnREosARnwg3rMBLKXottfdlLTa/Xz/ewC0fx0P3EfvGsvvwMqVGxKVe
         LmQ257CgQclGuyeGNQ0fAkYZRUH2/Tbx5QqXDmf2SnZUE9Pnv3R7DWYrKcOlEOtnwNcj
         WRO+uahfdrqFdeSQdiU1mY4rYCnMZv3KiMs0ozigt3vR/Z1riQoF3u6BCSIrOvXA9di4
         SKKg==
X-Forwarded-Encrypted: i=1; AL+hErERxsw2uFGTGURwCGFvFGNp57uv4SAgG1hHkHFD9bMO1Nd0hnOY4ZpyKN/FXo6QTDpdluwYNhNSjC1oS4I=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z82yuL384kqWRNND+ORs1z5uqfRhat6XhcYelXEbhg8ika3Tnyr
	GIoIB1kY7Kqwu76hqcQVpgQ1at4R6nla5mkhtaN0R1wpLBRiup1Rhu9O
X-Gm-Gg: AYBFou2JtMIPUJfKOjZuxE7QLD4n6c8kwcHCSMny+9shrv4ZPJ1Rf/zpTilKD33x3yJ
	MSI9JZW31UhCjr/NVrj0NgR8ultp8gJZKeybxshThgPuEvPRvgCU6jzGs+2JD/f+rA40kn+gqcI
	YbSmi38ewavNC8u3S+hJ7XII2GCTfw7nHze6y7qgsic9HV/YidyKo/r5JEefeXwB6zCeW3lcNsA
	RoZiY2iFYpMGRTj9pJBr9Yp2GM0eMJTZ2VSjXpz4/AVtOHXhVPoqy5AHC9UoCm5FLjMUyupzLbL
	5hDt2LskyV8J1FjVt/6J+Ybb+XvaYdeEJkrBNnvhROu51tsY8kNBabk2xOhaWB2dsc9oBX4gcUW
	rYKX2PMPHS42LvwgysQbjR+BBztm9ydf08vrEEGZprhYhL2jIlJJGS38cfzT27jAYqthSkhp7sb
	QkYlRCpIJp85hLroCVY4/Eo4uMjpf85ExHavcI/WBNk4QmbU/dO97vZQigF7QXGmA46k+Kh4EIP
	5REMaluFxZtBHYf3h2kemKmJCg36navLZHMgaF/7bY5VI3Gex71gcei0b9cKRaE28qVZGq1dnsS
	X3ldh9QGMgrUEpBcntvmLHLDnAA=
X-Received: by 2002:a05:701b:4558:10b0:1b3:9b4d:85f3 with SMTP id a92af1059eb24-1b3c030a90dmr1350639c88.19.1794369909127;
        Tue, 10 Nov 2026 20:05:09 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm10475642c88.8.2026.11.10.20.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:05:08 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: Re: [PATCH v2 0/3] KVM: PPC: BookE: Fix boot hang on preemptible kernels
In-Reply-To: <20261110053238.3794500-1-sshegde@linux.ibm.com>
Date: Wed, 11 Nov 2026 09:21:32 +0530
Message-ID: <ik2481q3.ritesh.list@gmail.com>
References: <20261110053238.3794500-1-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> Christian Zigotzky had reported that preemptible kernels don't boot on
> his FSL Cyrus+ board. The board freezes on running either full/lazy
> preemption and has been an issue for a while now (years!).
>
> https://lore.kernel.org/all/b897b0fd-90f2-4215-bcd4-3714e497d773@xenosoft.de/#t
>
> After 7.0, there is only preempt=full/lazy which removed the
> preempt=none/voluntary workaround used to mask the issue. There was
> challenge is getting the console logs which made the fixes difficult since
> one couldn't know where the issue is.
>
> Thanks to Michal for helping in getting the logs. That pointed at few
> places where the issue could be. This series is an attempt at fixing
> those.
>
> Christian, I haven't taken the tested-by tag since patches have
> changed quite a bit.
> Please help in *testing* the patches again.
>
> v1->v2:
> - Re-order to avoid preempt count dance (Narayana Murty N)
> - Do only hard_irq_disable on PPC64 to avoid second warning. On PPC32
>   use local_irq_disable to acheive the same. (Ritesh Harjani)
>
> v1: https://lore.kernel.org/all/20260928110411.844582-1-sshegde@linux.ibm.com/
>
> New API ppc_hard_irq_disable could potentially be used in other places.
> There is similar pattern of doing both local and hard irq disable and
> likely not all callsites need both. But it is a larger effort and due to
> my time limit, it will be taken up subsequently.
>
> Shrikanth Hegde (3):

Thanks Shrikanth for posting v2 based on the discussions. This is
definitely in my list of todo things - to go over the historical
reasoning behind the divergence of hard_irq_disable() and
local_irq_disable() between 32-bit and 64-bit powerpc code.

I am also interested in knowing, where else we were previously using this
pattern, like in these patches, and were they only to stop lockdep from
crying or was there more to that.

I will get back on these patches before end of this week - and hopefully
we still will have time to queue this up before -rc4. 


>   powerpc/irq: Add ppc_hard_irq_disable()
>   KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts

btw, small nit - ^^^ this patch missed to add Suggested-by from
Narayana. 

>   KVM: PPC: Use ppc_hard_irq_disable before guest entry
>
>  arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
>  arch/powerpc/kvm/booke.c          |  7 +++++--
>  arch/powerpc/kvm/powerpc.c        | 14 +++-----------
>  3 files changed, 25 insertions(+), 13 deletions(-)
>

-ritesh


