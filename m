Return-Path: <linuxppc-dev+bounces-28814-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8421BCA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 06:52:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxbty73pMz2xr2;
	Sat, 03 Oct 2026 16:52:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791010362;
	cv=none; b=dyn+kVrr5GZWzKonB0hwIZstXYMK4FfMTtNliQ98BEUlnl/RpKjnkaa97d1NRsiaRj7q8cKRoYZ//agRKS2TEG7stxSp/IsZG/o6cr6eAACqSamZ5/bKs3BvKuiWCWSGk0VRmzcWBUhWg8FS1HYUoYZ50wM9ZbJBZsMr73DBm2nej2lYBz8tugg0pawBLp7aDJyQhA0AZFpvXk56U2WZggCHLTKcSaZ/34QA+iy9DXFLGB6z1fatIkGENOtnqopMnw4AOy0z3So1aqf+58exKWnOQR9DqhnQ0fFMUfs4vreG6nHSqnYZ+C9kFUmQL8VGTDWEG9J7H4Zob9imaduxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791010362; c=relaxed/relaxed;
	bh=fT+rzKFOrryCjv0z9CwPip/4lzX30T7RArz2Qd2Hmnw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Ec7flAIlV7Bfs5gD57yCEnYlWhl/Arbius02jBLUo23pqyJ1M9NQ0yWRNwG7GMkatIvkMk4GMkiULmMPaYT/SFDJeHqTR50bZZnFmLC276AT0GOZu/y9Q+KeIZaLFM4rkdHDbbTUzSh76HQlPnB258McG9RbxGkFmuO+n2NKpU5R4g+dXvu0oneV0gJRrvAhRDl6efJEcJcOOFCs0i6XKpXydLqKwIayFc1i9RmGKXX96dV59hXhwXmUcamckt3sKqtWW87R0LnY5n9MqK9vY5W8ZjR6Oc4PFAxtZlH7UBvPXL1V8xAktgM2EkmV1CejFcNkd9wFr2r/fUKNjzWNrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pnT4lUgL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pnT4lUgL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxbty176Gz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 16:52:40 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-3510f6f130bso46460eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791010358; x=1791615158; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fT+rzKFOrryCjv0z9CwPip/4lzX30T7RArz2Qd2Hmnw=;
        b=pnT4lUgLcZ7hZPw7GpW+HoJpMzr3QPsGungR71MDYumErWuTCNg+w+1zA+1zy1sdYU
         1A2uoxTNTgJKY/01W/GixmwWXPhojqz7S/KLC6o85DvyBp7X47jYNeHtmnAwlMNbHcMt
         0NJKALs3RC86TKQIlMISp72PbMUgGyoadwfXMWeYmIDc12TFskYNDIkGmaf8DQJp4D0F
         /f0CXclnWhfNZEysRkq70gzaWls7WTJwO63wmv0tKPduYAKxxShuxz0asBOwr3sEroUW
         1GpG3o1n0UpWzhC2+1o4PTLx+zTueu+WipywXfNgjMhZED0kqAXS42CCGQ1KXzcDhgya
         pLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791010358; x=1791615158;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fT+rzKFOrryCjv0z9CwPip/4lzX30T7RArz2Qd2Hmnw=;
        b=qw6KFKNCLpCCNDf2qs4iWHXgH3Qo0JH5AthR6SVRrxDVIlAEaSNw1fgpuQCMP8hkOH
         PoYSZTRwCYoCHzsticfbROGohuuJOkSXSGn7c8XsQbT3VDp3kMIIBBD3PPBGQ/IfY3hP
         50qn096K5NWWYzX+l0XP0z8CISjI48eZsD0xgHhhZHSTIAqppnBFF/ATuKYhlvaTmV2w
         0ld+rxDRqtAida+UpD/GgaDYeJX9oXOsE59rsYGnwUfupreUbUhuY2+z/PMWzx90GwZe
         S5a4c7um3bwHTPOLx9Y4fr45rN9uK0TUODLDxTd3L7RjYGLmS6kZfgyWbsxBuvBL67fa
         oFWg==
X-Forwarded-Encrypted: i=1; AKwUvBx/wAcaDWYmZOYgGkYxUnOut0YRdGSFw5zEHPDh+CxAKViyTL5f0gFzj8vUy1jUaBopIVHvLs73GPktSBw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJgiC3naCR+tbaEblBtJX6oKcFUDnpwK8rhJC7iJgnG69HS94JO
	RDCyM1Z95qQ0Q3aBdDuHH6ncsTCYu46+n8r1aExAVnADglR2C0Iv3V+q
X-Gm-Gg: AYBFou2D86nGDrNF1LHToKeFcmEgRLWiSNx6YhgOf4QW13AVb0M8Ua/SRAbJVj+LVz5
	w+XjWA66vZVpnEWSlzKxCdgMREulzmi268dB/GALi4lHIv8iQ0Mmo2a9OlbGlhvHobf+Z0sre25
	QDC/46ZKue8QDwaQ4d2tNML2KTmVgS52OqJUlVWcD4mREwqPW0cKnLooFpahYxOajwfMfZXyu54
	zPsFjLt40oJWSueoJJ+5Es6aR+G/K19JII1VLRqL87EB9hjZO2nN/MB7S4lMtPLk7zOevq+yEIc
	xw6t3yZM9zaHMvHGk8E56A84n1hQkDUSq8FdOsS8OkAdDJEeMT2Hd0l98NeKasmpVDzNvt6K+Re
	k/PQ5kVFO0yMQx4k+lyY8Je1CxsgYOh02zMCt/gSi0UEopSHXWUJXLOHwWranaic9qp7368vHbY
	eAiIP83V8T8suFNmPnowdSCId6Md+5PkWPuZ5RwdKY6eORMgXDMTQpAJnDen7FYBW3SXjhFrPHa
	J/e9nmsdd0ltCYYdHCr5ztQYCL0ec5PFMIbXHM9DN8+4KlFI5Enf13D/Z+wbq2K
X-Received: by 2002:a05:7301:1a03:b0:33b:bea7:84dd with SMTP id 5a478bee46e88-34f21994b42mr5626972eec.34.1791010358101;
        Fri, 02 Oct 2026 23:52:38 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34ef98d925csm12467103eec.0.2026.10.02.23.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 23:52:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
In-Reply-To: <asAydfQLscU6rXQL@google.com>
Date: Sat, 03 Oct 2026 12:16:01 +0530
Message-ID: <h5j3jn86.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <pkxwkffc.ritesh.list@gmail.com> <asAydfQLscU6rXQL@google.com>
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

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Sep 29, 2026, Ritesh Harjani wrote:
>> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
>> 
>> > Hi All,
>> >
>> > This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
>> > radix MMU).
>> >
>> 
>> Hello Sean,
>> 
>> Just wanted to check what's our plan on this one?
>
> At this point, I'm not going to get a pull request to Paolo before the normal
> merge window.  I was hoping/planning to get some early pull requests to Paolo
> this cycle so y'all could build on kvm/next directly, but that didn't happen.
>
>> Are we planning for both PPC pre-enablement series of yours and this one to
>> be taken for v7.4 merge? Do you think this can go in too?
>
> I'd like to get at least a subset of this series in for 7.4.  If I'm reading
> things correctly, all of the hacky changes I don't like are for the
> kvm_create_max_vcpus_test and hardware_disable_test.  And as called out in the
> final patch, "fixes" for PPC really should be ordered so that they land *before*
> the tests are enabled.
>
> Actually, better idea.  Limit patch 1 to just TEST_GEN_PROGS_COMMON, then for
> the addon tests, bundle the "fix" with the PPC enablement.  AFAICT, except for
> the kvm_create_max_vcpus changes, they're all pretty small, i.e. bundling the
> PPC support with the "fix" shouldn't be too painful, and then we don't have to
> worry about ordering.
>

Sure, will take the suggested route then. Will bundle the Makefile
enablement change and the needed fix in the same patch to avoid the
ordering issue.

Also note - I will open code the TEST_GEN_PROGS_COMMON and will skip the
kvm_create_max_vcpus (& maybe few others like vm_types_test) from that in v6.

> As for kvm_create_max_vcpus and hardware_disable_test, drop them from the initial
> enablement so we can get the core support landed, and tackle them as separate
> series post-7.4.
>

Sure. Will drop these two.

> As for actually landing this, the easiest thing at this point would probably be
> for me to grab the patches in a dedicated topic branch that's based off the
> kvm-x86/selftests branch at an appropriate point in time.  Alternatively, I
> could provide a stable tag and someone else could grab the patches, but other
> than it being a little weird taking PPC changes through kvm-x86, that's by far
> the easiest approach since I'll be sending Paolo pull requests anyways and can
> explain the dependencies and whatnot.
>
> TL;DR: what if you post a slightly trimmed-down v6 and I take it through kvm-x86?

Sure, Thanks a lot Sean!
Let me post v6 with the suggested approach.

-ritesh

