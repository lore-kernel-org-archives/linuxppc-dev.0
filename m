Return-Path: <SRS0=scNv=AI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A564C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2020 15:13:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BBC20FC3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Jun 2020 15:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIkYsAjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BBC20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49vHLy6WFxzDqrF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Jun 2020 01:13:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::341;
 helo=mail-wm1-x341.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=IIkYsAjs; dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49vH3b3gGYzDr0v
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2020 00:59:55 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id f139so12006155wmf.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2020 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=wdLyniBgRhGvcPSWodPXRkUHWf+cL8Zwo2freFFNrwY=;
 b=IIkYsAjs3O8Ze+lMtA++914lTKyOOZhWrKkOhgqTuhbnpF7w/G14n70dx5d5tYLx5O
 F5EZ211rUkkGtQnxien32nXYqn+01OgW2HIO9imS/oQHQsMsFw3gTzJtYyNdqO4T6EHU
 AWTGh5/yqV8ZAukEgARp8jbVbzXop593ZxYQLU2tCz8ekmGPXyKg7kQj6ymOpX5wCCY0
 a342V7SQU2QElOO3EZLVUGo0f4o11n2znPTyMhlp/15Q607qErTD/waVa4bh/mjBtP8N
 AimFSFh/IQwKr1hSoeY4xVENXCCrEMbxjjPbU3NTOWaMiS9yos7v5cM26oYxGVr8gfCZ
 sOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=wdLyniBgRhGvcPSWodPXRkUHWf+cL8Zwo2freFFNrwY=;
 b=GuymyGL0NIMAJqnbIhyNC4L1C5P/qHbAHb9FQ2wix+lqfZoVopIoa6TC2qW96Fgfgt
 gxWZmwbLloVKkJWuuA4cgDA2R0fTRbCSRHIe3NB0ep6V+CbVjKWOzLpY0A3k23OEjzwS
 4dK5slMx4JgSc9c+li2yP/iyl8YnXiusD0zCxUOsJBbiMAz3E4b/sHpjCQ0uVk4wo0rd
 /QOMqadgrHjOdDWWM2xrBhjmL9QfpCcKFXNqV8xSnFBL0aDxSs+LLp3HAKWzXxwxxI/C
 7zRcn0ReKaSSylv8yNHb/cvrK9zImwERCU6Wkrh51sN39GKRszAT2EzluPB9cCuWCMjp
 PQ5Q==
X-Gm-Message-State: AOAM530z2TQKakb2f5xXwpUCbqQMJXHl3bOOMsHpemJoDZ7NPOhga8uF
 F12Oi/qfre2KghkZxLSRn2U=
X-Google-Smtp-Source: ABdhPJz6dCmPxPqY/YqnbJ1xaKiGwByNa14CTNgluVJnQPt++a+zuNhtzKRgCuOAyVxwBCTGC0xnEQ==
X-Received: by 2002:a1c:f608:: with SMTP id w8mr8306425wmc.78.1593269985454;
 Sat, 27 Jun 2020 07:59:45 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
 by smtp.gmail.com with ESMTPSA id l132sm21512156wmf.6.2020.06.27.07.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2020 07:59:44 -0700 (PDT)
Date: Sun, 28 Jun 2020 00:59:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/pseries: Use doorbells even if XIVE is available
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20200624134724.2343007-1-npiggin@gmail.com>
 <87r1u4aqzm.fsf@mpe.ellerman.id.au>
 <af42c250-cf4b-0815-c91c-9363445383e7@kaod.org>
In-Reply-To: <af42c250-cf4b-0815-c91c-9363445383e7@kaod.org>
MIME-Version: 1.0
Message-Id: <1593269745.ooncxk6m0x.astroid@bobo.none>
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
Cc: Anton Blanchard <anton@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from C=C3=A9dric Le Goater's message of June 26, 2020 5:17 pm:
> Adding David,=20
>=20
> On 6/25/20 3:11 AM, Michael Ellerman wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>> KVM supports msgsndp in guests by trapping and emulating the
>>> instruction, so it was decided to always use XIVE for IPIs if it is
>>> available. However on PowerVM systems, msgsndp can be used and gives
>>> better performance. On large systems, high XIVE interrupt rates can
>>> have sub-linear scaling, and using msgsndp can reduce the load on
>>> the interrupt controller.
>>>
>>> So switch to using core local doorbells even if XIVE is available.
>>> This reduces performance for KVM guests with an SMT topology by
>>> about 50% for ping-pong context switching between SMT vCPUs.
>>=20
>> You have to take explicit steps to configure KVM in that way with qemu.
>> eg. "qemu .. -smp 8" will give you 8 SMT1 CPUs by default.
>>=20
>>> An option vector (or dt-cpu-ftrs) could be defined to disable msgsndp
>>> to get KVM performance back.
>=20
> An option vector would require a PAPR change. Unless the architecture=20
> reserves some bits for the implementation, but I don't think so. Same
> for CAS.
>=20
>> Qemu/KVM populates /proc/device-tree/hypervisor, so we *could* look at
>> that. Though adding PowerVM/KVM specific hacks is obviously a very
>> slippery slope.
>=20
> QEMU could advertise a property "emulated-msgsndp", or something similar,=
=20
> which would be interpreted by Linux as a CPU feature and taken into accou=
nt=20
> when doing the IPIs.

What I'm going to do is detect KVM here (we already have a KVM detection
test using that dt property). The IPI setup code already has KVM hacks=20
in it, so I don't really see the problem with puting them behind a KVM
test.

I think doing cpu ftrs or some specific entry for msgsndp in particular
is the right way to go, but in the interests of making existing KVM work
I'll do this.

Thanks,
Nick
