Return-Path: <linuxppc-dev+bounces-22704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84C3CD98E7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:35:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfmfc4Lrzz3c5W;
	Tue, 16 Jun 2026 22:35:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781613320;
	cv=none; b=YaSUDLJADotqSorcHYhIzNqt7ou2sNTN5KWgsQtUXxONtLqf2pZ8KDUTxWfS3IAd+nW7nJdNURoG/ey0jKMpWpcXpLXE52Q6q0ULfN2bt+o+hasMFMhfwqL+gsMIWhlmCOf4AWEnjkamZOKshJ8G+kf39rXd3pWf6RdQ/EBFov+eStH0kwVomayCnHrA32AxKFT8OZnNwdFdrqswEoYXEE7k+oYCqeHhp6rXUQ4BdIZ5hNOltrPgXTK/F3DUd+8poihOJm66seywXUQ2XusoMdtrI0W+p4IhvDub80tN/p9AhEXi9YA1H91fmH4cl7kI59CDz4lECTWFodwYHg7dPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781613320; c=relaxed/relaxed;
	bh=BAYzqTyjLrIOI8jk2lCoOCBWo5ysdxV0s0gT6irQrOA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=SYo9ldFTMCSTls4yVzm7KzuQ2qg4RwV+rYVrwqmHBw28kmd/YGB42TOJpum0tuFCLZXalqi4zTcfeps5D4TksVavDp/J/ipPt5riaHKRnmM3P4VgXHZHVj9bfyphDW5z/J87FnFQqxGCQkNRN9+GokdfWRhSHtPfX4Q+7HJimQ5cN6tgEFANLF/Z3JyzhMwBovlvLPD8D+sRK/Ip4bJtksF8Ujn01OjJEwJAZmH7anllhsnLHQnN1etcfp+ALUuY4pYqCNKTbXvNnQfgswPAv523nE71SfREYwZhBR7eu+DXOXvGy3iDI6fT4zC8q2RPKENo1cLL9PV7Ok7YBi6F1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YVuRjgop; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YVuRjgop;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfmfZ6nQfz3brH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 22:35:18 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-84232e83ca9so2149807b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613317; x=1782218117; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BAYzqTyjLrIOI8jk2lCoOCBWo5ysdxV0s0gT6irQrOA=;
        b=YVuRjgopt1aO506mCcoNqPLt4Vrqgq+YG241JKhsGlFbklNi52MdZzkOFN2srueXp1
         mpM7OG3VjTD9qM4fnGvwK/T16W2IOt5jt4htZe+2R3jRD9oq+R4E6bJ+cOnZ8LCURr/w
         Cx53p9EdxXSHu3r7qQKRKbIORJSCRL4VM66rw/2UWkOXf+GcYHe7FF1xGpOBMwzBj80R
         ruh2tb02I89lw081MoS4vyAPv8+lacotDnEIfJPyAtlPGdUKNoRgw6yFzXVLrXe3rvS7
         y45Ak6044O/HVq0Jsu6jG6N4TQ7ouTwcVWtaV8EFp/U53BFMgxleZwBQZtAbyBwqiL6k
         AS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613317; x=1782218117;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAYzqTyjLrIOI8jk2lCoOCBWo5ysdxV0s0gT6irQrOA=;
        b=WBroNcZlJGXaFgqnhn5nXq58M7Lo7d893xSXWELzVzQpUo0LXVJ4cSUwo4qOJwNwZX
         ZUtG8UmqOSW3OV/TfIq8gp4R3copcVf274tR3Ps5EHTspriBbUehbi5QwiOgGHIT6xW+
         Lyl6lFPHfncGZjcf8RCexumG6KcGpfu97u1Ad9XE6xF4kPC/efnrX0Zt0wD9VB18QLJm
         WRqwpPUghz38EqGp6OeuM9f2u/bhQ2uS1bqZ56umnIJKjFHHst0IatPlJmOZVp/zWp02
         LZRuuPKqsMs43QrAP+TNJ/4IMFuMqV3SjUMxaqMMChDGy3q3zpRTCSxbRU2WMULtxC3q
         ggQA==
X-Forwarded-Encrypted: i=1; AFNElJ+MQiXEc4viDOGEfxjctUhx2cnWtmmuR9k297sQq/KVWQS1zz3ziCrhoOE/7xnTMysX/4ylLcdXU289G1s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxe66ZkNPB+9aXMtozLPbhSMsgI/iSMBLm2LNdpJzC1jpUk8l/G
	5TEZMqp4Lw6N8aKm4jEgH91pBF3ewbmhXAm3x4iFoly+rj7cN/HOoa0r
X-Gm-Gg: Acq92OFdnmJl9+IX76aTre/RJgFXgkgsWLLf6ZH1jpJAAQYQiEzEsBu6nslmpbpvmqH
	ruid4y2LgJjUHKCeQP8NzbVGVhNPXmYuZt0mPGMySav1C41Ij0gousDqpRIg7bIgVEqW1qi+oyC
	JCsqREoEqgjWMTvXRyVP2MKXyMDQQp0KLV2yyNjiJ60SOEYt1uwbn/CgzaLLXZ7G6zNl6SkZ/sc
	KqgoHOm5+V9JWLVPRPoAX6zjXxhTR/nrc8BwNJLZUQwylezzS3PcpRb57jkH1x8Vl6k9aEzTmbG
	aZ89K84AXIQORrXXmQk4+9BsLWYAeRJARFDX+iZYbQuHpv+7zjJCYByWWIFt23fV6mu22XAOB5P
	lLQZQUTZ2M5gob6grXRufXg0+OFs5iQPBOMbXn13ekvtCcaUIgyTVZrZ7ipj02aeIOZYJN1Mv1s
	QJ7zLMLBPHZ2NDRcjAJoNWojfGSw==
X-Received: by 2002:a05:6a00:8d6:b0:842:688f:3089 with SMTP id d2e1a72fcca58-8434ce832c2mr18655919b3a.30.1781613316626;
        Tue, 16 Jun 2026 05:35:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c4c0sm11794275b3a.3.2026.06.16.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:35:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260616161011.835c90f0-38-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 17:38:37 +0530
Message-ID: <a4suelh6.ritesh.list@gmail.com>
References: <20260609053327.61563-1-amachhiw@linux.ibm.com> <cxxqerzk.ritesh.list@gmail.com> <20260616161011.835c90f0-38-amachhiw@linux.ibm.com>
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

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

>> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> > index 3449dd2b577d..7472b9522f71 100644
>> > --- a/arch/powerpc/include/asm/reg.h
>> > +++ b/arch/powerpc/include/asm/reg.h
>> > @@ -1356,6 +1356,7 @@
>> >  #define PVR_ARCH_300	0x0f000005
>> >  #define PVR_ARCH_31	0x0f000006
>> >  #define PVR_ARCH_31_P11	0x0f000007
>> > +#define PVR_ARCH_INVALID	0xffffffff
>> 
>> Logical processor version is defined as part of the PAPR spec. We should
>> ensure that this invalid PVR is also documented in the PAPR spec.
>> 
>> If you have already taken care of that, then please confirm and feel free to add:
>
> Regarding the PAPR specification documentation: The PAPR spec documents
> the valid Processor Version Register (PVR) values for each processor
> generation (POWER8, POWER9, POWER10, POWER11, etc.). However, the
> PVR_ARCH_INVALID value (0xffffffff) introduced in this patch series is a
> KVM implementation detail used internally to mark invalid compatibility
> mode requests - it's not an architectural value that would be defined in
> PAPR itself.
>
> The validation logic and the use of PVR_ARCH_INVALID as a sentinel value
> are documented in the kernel code and commit message.
>

But that still worries me on what if PAPR wants to re-use this value for
some other purpose in future. 

BTW, thinking more about it, if we purely want this to be in kernel only,
can we instead add, something like:

     bool kpvr_compat;   /* Does kernel supports this PVR */

rather than re-using & overloading arch_compat which has values that
comes from PAPR spec?

Thoughts?

-ritesh

