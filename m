Return-Path: <linuxppc-dev+bounces-28895-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEEBCA5FF1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 02:40:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hykBZ0tpjz2yjw;
	Mon, 05 Oct 2026 13:40:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791168006;
	cv=none; b=I4YSG51cE2nM5f/ffSXX4OIuHqY/2EUjwh279njnAs1MmV8BVlKn2EgECNQEHvN13iQo047Bgt1BGJxNA5vRfubvFQKdsvkslRmr/vaq1B73DxQ2cubjzza7qi5+PZOJhSZYcS1AOftkGbfEh/825vk/x/6rnL3xILh9KvTsTtSdoDrvQ/ZPqmU6De8VlOBku3FI5f5UwSYKzNRNkTpYxWaqliZVe5nzbHAO14Q3sXqsgegOZ+DLZhYDR0WiDdUKa5scCEukEiBM8koCnqs8mUJE9wCz6CUEd2Gtsxlf0Lv9YEcxIuH1iCc0cpe2Vhxi6T2/PNVpKl/3Z1CvhrWivA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791168006; c=relaxed/relaxed;
	bh=o9HTQO2rUlDTOnGrtLyq1XH041/gAEdrB3b/I0PgRl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOWxbL1DPDus0lVJc8/gsUfHweCJ7m/Yalkk+qFqua+uBh4urvk+KMNR1h8lA9aIynNQupfSmhbeRJeSaUkwMCGtPRsDuLZAwC1UfBHy57RcwEvy7we3tDonW2fH2ACbM8gj8QvQbjBQuu20QGGXaYWiecOBVL8qrn5RTp2Tr/SB/CV4Esr4SBF78Mqh9ylNDpRc/Oq8E/hGG/RdWW1xvIRpA7ucnKYQ9WOlRXp9W2OS+pNz8aeaRCcZ1FuAi+CMXrVlctm3L9+Zid/NI2T/H2llsej88ZDnowkgjwqD7TRg+jHrWmXNtn5wH5+TZ+yua/H+e56UVJJeRHiTREBNXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ShnDnsHW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3aa7dagykdiu1njwslpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ShnDnsHW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3aa7dagykdiu1njwslpxxpun.lxvurw36yyl-mn4ur121.x8ujk1.x0p@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hykBX1lKWz2yf9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 13:40:03 +1100 (AEDT)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso1515754a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 19:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791168001; x=1791772801; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9HTQO2rUlDTOnGrtLyq1XH041/gAEdrB3b/I0PgRl8=;
        b=ShnDnsHWyds1nFq6hLCU8DpJ+TVLZIudTGJoR4NX03sKUP4zRg0oF21BqJCB7H9CY7
         dFK4plYSpbbKgv3uAc3jwrSy187lr8+0PKdhuLtsfM3MHnBh2x5N0m19OKV5ENZcIw49
         ru6aSS/ctry3LzbTxDZaSUxn5VMnS3IIRTxCc0+yNSxdHvaH55XkxETx00gmYaBFaonQ
         PoLHy84AcxwQBzU8/v6e8bHmOziyINeXhJuH6NQjQZN0Qxs055PPfoSdmh0Gq3AygLfW
         StUpXCtOzNM3ZmFiqYBicXFWkCknAbWd+slVXB8ow900ZwviXjyUHEhNIlDgV+Zjhp8r
         laEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791168001; x=1791772801;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9HTQO2rUlDTOnGrtLyq1XH041/gAEdrB3b/I0PgRl8=;
        b=ZEaQP00aXgvrJpvilNxH4v2nT7x4S2aiiO/i0MLHxe6tSgbEKdxEaXM/RlQRPpH/Ni
         sRPeibIOaArECuSxcoH2iaR6ADxxYLjhGFFCIvbyiRbcU3pSKMUVIMw1SyLA3eVBbjzc
         dtYL/9JXr4xbKF0y4KaFBh54F0Lha3BAv/kaifD8bHrqh/n35Z0r5IyTFPHwH77fsQVv
         fzXtLK7ivSDKQySU3Uarc1oHRiQls0A/oTC9OsFifNwZ+9x/1J5A84iQBGjlhkH8CxfG
         9uApCX9wc1OEK3W/OKwA5OZuvG3PBCZbOuqo90t7H8TYnluBirGFv/CsMcCvtJWcaWbT
         B+7w==
X-Forwarded-Encrypted: i=1; AKwUvBzhDpcvG1c5UngcqRkzWrGUxiTG/n37/an5lzKdBKY9AYlDoTSZku+NkcSom1ENsrcbDH3YzTsvPcoaUWQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++loIEwiBo0nF3k4NIyDl00mxOh5C63t0eF3DXV4oZoamgTEzl8f
	OUYrL/ZCprGsL4cOz2wRFrETXYfVI8NGvKXnf9vKvl1c88rKvFaz1q6Gdvr6gW6OmIHzSe6b7U3
	wpW8gHA==
X-Received: from pfm17.prod.google.com ([2002:a05:6a00:731:b0:88f:62f8:bdbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e92:b0:3e0:651a:d150
 with SMTP id adf61e73a8af0-3e0d6b1e9damr5767266637.43.1791168000327; Sun, 04
 Oct 2026 19:40:00 -0700 (PDT)
Date: Sun, 4 Oct 2026 19:39:57 -0700
In-Reply-To: <h5j3jn86.ritesh.list@gmail.com>
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
Mime-Version: 1.0
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com>
 <asAydfQLscU6rXQL@google.com> <h5j3jn86.ritesh.list@gmail.com>
Message-ID: <asMN_TAX-1_J3jiP@google.com>
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 03, 2026, Ritesh Harjani wrote:
> Sean Christopherson <seanjc@google.com> writes:
> Also note - I will open code the TEST_GEN_PROGS_COMMON and will skip the
> kvm_create_max_vcpus

Oh, right, kvm_create_max_vcpus is a common test.  Can userspace detect that it's
running KVM-on-PowerVM (in a not completely unpleasant way)?  If so, an alternative
would be to keep the KVM_CAP_PPC_SMT change in v6 (patch 2) as a prep patch (before
adding PPC support to Makefile.kvm), and then add a
TEST_REQUIRE(!kvm_is_on_ppc_powervm()) or whatever.

I think I'd even prefer to take on an #ifdef (to scope it to PPC if necessary)
over open coding TEST_GEN_PROGS_COMMON.  LoongArch open coded its full test list
for some reason, and in less than a year it has started missing out on new common
tests.

> (& maybe few others like vm_types_test) from that in v6.

What's wrong with VM types test?  That one really should Just Work on all
architectures.  It doesn't run on LoongArch, but I assume that's oversight?

