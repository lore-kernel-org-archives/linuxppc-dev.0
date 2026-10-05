Return-Path: <linuxppc-dev+bounces-28905-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC3CCA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 05:31:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyp0s1WlGz2yjw;
	Mon, 05 Oct 2026 16:31:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791178317;
	cv=none; b=PeJ8TXcJlPFinefqN3BLIXV/rwn4AlyicfZhDw/Zr+se9WaFT5jafafxxZx4ijvt7MvLehgPdfhad3JTyhNKnxSmwT0DJYICbUCreM4/by1AH8Cx5ovaWR2Mm9cD1xVdZfPBCXvvPrOkQw5P7fE5Xv53XDdnykZzgX+q1Es47Q/F/hlBfPIhMUNaLIF1DIUWO6D+j2Vno1fmQfsuyunam9m0yJ9sPsQko8i9bVrPATtfFMzq+dk44oaqOhQrm67xaYfR3OndHxHWSFpErR5jw0anWWR2M/6kJ7HELd9sGpPmQvC5wlSRTN1SSFAEziouo0TXEg1Vfj9sH8SFyaX0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791178317; c=relaxed/relaxed;
	bh=cIbXE6R67m8wmmcQnF+5IRKqUHaCj3Oi7gyWQv3055A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Yw6D9Z9H2vmuGXFyiMTYBYtvpQpvbKTPhMn52n3dhZj+ng4IZVE6vLlmXuvW+UOpbDu1qWoQB99VCyBo30aEzqVzzuBh/w/W6uLQy9xAnlqfQbCnBOdbbhJsqVv3Z39Jn3QuegAM5LZMwtRXbpWMikhXP04eAZuZjyTMy7sgHVoskfhd+a2vQSmsR1flYFBJGM6O8/LDk3fB7vIQamnMspxEupfwG+tlnEd0hf32GOwyPpamSnl3G7xrAhN5P7wuvlykCXXnfzapOT2DSr3oNHZMek8MzzskAJQTxTB9s7NjoLKw15EgFnDa8o/LCqe6CO0yocKvAIkZNvgaGTe8yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DVCNkQtE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DVCNkQtE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyp0p5FYdz2yf9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 16:31:53 +1100 (AEDT)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33e46a15703so1675300eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 22:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791178310; x=1791783110; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cIbXE6R67m8wmmcQnF+5IRKqUHaCj3Oi7gyWQv3055A=;
        b=DVCNkQtEWrMfcSZuM0RLCNyL6whEvLWoIQyaUYpwgh4wiBp7qW7noYYIR/SaWUTFT5
         maWiWMjfU5lGuUAyq7FlGWUq0QU2PFB93LZVmiNu6Gs4y/xC4CTCOemdJeMvZQ4H6ZvF
         GiQCcy5kseLSPApJqq/EPxfrep1DN9oIMXGXEQvMejJZ4Msz1m0nlgh+YvhPZNnKaMlU
         U5+e4fIzUCapp2UBOb5nGVGGaLEBVweK1hnE7J7hsS93ebqgCnzk1R3R2Jql+dyVprX6
         SaCpuQ1vzPKfOiwRI1Y+XSBF4CJYa8fHQ3qlYCyhB9zUSK2GKzhhpOLetYdMi/fNPY4R
         ZUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791178310; x=1791783110;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIbXE6R67m8wmmcQnF+5IRKqUHaCj3Oi7gyWQv3055A=;
        b=LcCwv932CnFgs8037AoOwnLkqddnIrH8ZNF/uXA5hpS0BwMut0Wqn6Ep4kynp9zXlA
         NmEZNbjCpdXqTEdD/ar/0+PINNMfJOEg7azhjdiGfaeQisoJDKmglyW3s2/Fs0MiJkyS
         pwA4bvKhAr2jyFMjqwYHZhtyKo1rU5tqAkpfx+O+JFxxhqA2vWHhsem7n1S3LIk8iWJ9
         AOnts3aKebkVXbTa2f9Vbq2pcxieI7DwRsDAC22M/Ut8AEsuUU+u5nJ2zFtJLilt+i7D
         waXoO+jIhN7MPCyX/Wu40BEO7MkkfP38+Loq9Pz9plQ2bXEfJM6oIJ3ju2iEi5GQoF1G
         F1fg==
X-Forwarded-Encrypted: i=1; AKwUvBwV2ww05mC8F9PU2GhZfFDOLhIR8RNtRL9qK5EHwuYd+1NrH5yrL+jWu9+LpfD3wKxK2/P0DO449UGqS1g=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lPkCHxxXGwGS1Tx592QfSf6HWCCoV6v7v8mgkBfF07WPAmcIJX
	dgO+mhZkGYGviBbBfw47lyMyVP5VNzlxJdpb4R7qsFx/jxUBycJXxS3/
X-Gm-Gg: AYBFou3A8AZvhKqTwTsT7WOcQuHC+VMmaDiDdJSK8k7S9hfSzvVi6N2o8YrZT4z3NE4
	5+1sCiyIwsclHW868d47c52MBKXNarwxVnyPewdLWh58K926XA3C4dOpIdoyUKnDS3akPGrtA4V
	KBrj2mCUl+AIlpmITpm4yyK7zDUNxgKIaoFx81pV8NH6VdJInaPB3GK43zZAiys7YshUg22tBYI
	SnLjRiccF/stNDoVHG560kp0s7wameYNMirkdusHHNm1GjYnqHyNT6Z6JgPv9wVRcNOY8ueHUZp
	BVET9TFsSxc+vV0fSPViozcsCP/SajFFIB/BT64CBh+Qdxx1lJMhTpdYonpW8SRnJ8H1QIvObaT
	WvAz0S6JWyntgMzSKvGIKthiYbpxCTdVPt97J/hPsjQPxdNis35q40gfecFoIHc/DeIk70hMCCb
	E6UvWcT/3kvkvTzbfe17upJCP9rHRoKRuY0J9jkDVigB75sdrM/CVHJ4IxRVuMvh4zSe6eEaaNq
	lFe85rnSImM9MkInY8l9Tm0OEu6cdKGSARn69ezBGGYNt47z2VDGNI/xEp9XoU4
X-Received: by 2002:a05:693c:69c5:b0:34c:45da:9b5 with SMTP id 5a478bee46e88-34f150c28c4mr12369259eec.20.1791178309882;
        Sun, 04 Oct 2026 22:31:49 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351271612e9sm10257390eec.12.2026.10.04.22.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 22:31:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
In-Reply-To: <asMN_TAX-1_J3jiP@google.com>
Date: Mon, 05 Oct 2026 09:55:36 +0530
Message-ID: <fqykkc3j.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com> <asAydfQLscU6rXQL@google.com> <h5j3jn86.ritesh.list@gmail.com> <asMN_TAX-1_J3jiP@google.com>
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


Hi Sean,

Sorry I didn't see this email before sending out v6.
I think we can ignore v6, once the discussion here is sorted - I can
share a v7.

Sean Christopherson <seanjc@google.com> writes:

> On Sat, Oct 03, 2026, Ritesh Harjani wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> Also note - I will open code the TEST_GEN_PROGS_COMMON and will skip the
>> kvm_create_max_vcpus
>
> Oh, right, kvm_create_max_vcpus is a common test.  Can userspace detect that it's
> running KVM-on-PowerVM (in a not completely unpleasant way)?  If so, an alternative
> would be to keep the KVM_CAP_PPC_SMT change in v6 (patch 2) as a prep patch (before
> adding PPC support to Makefile.kvm), and then add a
> TEST_REQUIRE(!kvm_is_on_ppc_powervm()) or whatever.
>

So stictly speaking there is no simple check like that - however, I
think we can skip the test when we are running on pseries LPAR (meaning
trying to run a nested guest). We already have the check
is_pseries_lpar() for access_tracking_perf_test. I think we can re-use
the same check here as well.

> I think I'd even prefer to take on an #ifdef (to scope it to PPC if necessary)
> over open coding TEST_GEN_PROGS_COMMON.

Sure, so will add this check for kvm_create_max_vcpus()

#ifdef __powerpc64__
       TEST_REQUIRE(!is_pseries_lpar());
#endif 


Actually I was thinking we may as well use the same check for now for
skipping hardware_disable_test on pseries. Because there also we suffer
from the same resource limitation. Let me know if that sounds ok to you
or do you want us to skip kvm_create_max_vcpus() only for now, since it
is part of TEST_GEN_PROGS_COMMON?

> LoongArch open coded its full test list
> for some reason, and in less than a year it has started missing out on new common
> tests.
>
>> (& maybe few others like vm_types_test) from that in v6.
>
> What's wrong with VM types test?  That one really should Just Work on all
> architectures.  It doesn't run on LoongArch, but I assume that's
> oversight?

So the test doesn't fail (it gets skipped). However this cap
"KVM_CAP_VM_TYPES" is only supported on x86 and since I was planning to
open code all common tests, hence I thought I may as well not add this
in the first place.


BTW, based on this discussion, I think I will re-arrange the patches in
the following order and send a v7. (The Makefile.kvm changes will only
get added after the main patch which adds powerpc support).

cfabdb049bd7 2026-10-05 [Ritesh Harjani (IBM)] (HEAD -> feat-ppc-kvm-selftests-new-sean-v7) KVM: selftests: Skip hardware_disable_test on pseries
2b51fab87b95 2026-09-22 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
f5d1de1be4e9 2026-10-05 [Ritesh Harjani (IBM)] KVM: selftests: Skip kvm_create_max_vcpus on pseries
e45ba15cea25 2026-10-03 [Ritesh Harjani (IBM)] KVM: PPC: selftests: Add helper for checking if running nested
178c9bca0e20 2026-09-22 [Nicholas Piggin] KVM: PPC: selftests: add support for powerpc
22320662e776 2026-09-11 [Ritesh Harjani (IBM)] KVM: selftests: Fix kvm_create_max_vcpus test for powerpc
11b5712b213b 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Move memslot_perf_test off the 256M ELF load address
63c900860b5f 2026-09-22 [Ritesh Harjani (IBM)] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x


Please let me know if this sounds ok?

-ritesh


