Return-Path: <linuxppc-dev+bounces-28785-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C3ACA5FE6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 22:38:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxNx71T73z2y2T;
	Sat, 03 Oct 2026 08:38:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::446"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790980731;
	cv=none; b=G+0N87+5VdYIfGvZUmGVEwf5oOzxs9hcPo+vugc+nRqvewXmgz2WgGKYrXzHefcRqFRQl9gyfdIbMEC1g/7hwll4G2PXSMhV5HRTuCmbaputQHxGim9ul8yoRUZ/Gz4a8S3NwAAewqJ8AWySXYCt2P3pk/Bv2ZGk9QMAoP8pwSolwB/h+RXYtQHEmS0Bi+SpwnmzCr6tnMip8wY0i5mGkw+v1uO9htNOWQ4fscfzsW8AeaKsL3gGSQIEfOy+vds6lXEGUCS0XNbV2xd2kImDvn4zeWNB7t43t7ok0D2GRodje1Nth5hFRIIkNXnuD1HG++quC4RubxqoGrVCpsVq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790980731; c=relaxed/relaxed;
	bh=8FKzhc6JuX9pGuBJ5sRMzCjJd9/g4im8E9bMuOULVOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kpgkaftO0VYU3z+PYaUUz9h3wmDioWu1nobx4trupfKLKjFOu1scekhqW9wIimaQcn82wmWga5cUh+gNAl0PRlqWBfdQaILmcLiBGIvNCrAARkeeLRRkVZaawOGKfoBIMlZsiqI0ySBFl1boA0Q4ozDUTq853cesaP/pHxyzwZ2wuomAix0NWQGpUMnR881X6CsOWJBZWyISA6UGVx5QSxALCPbqvHtYHP6yiIXl+yykPJLirUS6OhiTedSlX40fPz9tSJbyQeiPf1YulUIhGqJ5qiQ35yUmq4b0rqoOOJ1kbzTO0GaZ1MOqAoOqBN74g/NPBLnMSatMbPY3+2bOVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vHRgQUFo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::446; helo=mail-pf1-x446.google.com; envelope-from=3djlaagykddknzviexbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vHRgQUFo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::446; helo=mail-pf1-x446.google.com; envelope-from=3djlaagykddknzviexbjjbgz.xjhgdipskkx-yzqgdnon.jugvwn.jmb@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x446.google.com (mail-pf1-x446.google.com [IPv6:2607:f8b0:4864:20::446])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxNx60MHtz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 08:38:49 +1000 (AEST)
Received: by mail-pf1-x446.google.com with SMTP id d2e1a72fcca58-88a2c5d7ef1so106592b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790980727; x=1791585527; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8FKzhc6JuX9pGuBJ5sRMzCjJd9/g4im8E9bMuOULVOQ=;
        b=vHRgQUFord3xAUP0Bn/XX6JfypFMYuINmHJYNLX0LAEf2MJgbWfw7ckwbvHN4StAzr
         C5sI5ImtWU+dGDcEO11ykeZKpa6NwgeV2w1vVdNPVBWdQjrCgjWcaRHDXqnlgsZeOxhB
         VrWnFxVD7/iHRVklkMauV7QIoNJIXVEV6Yun/RTbEuWsaXh9JM1+9DltYGh6rdWuZ+0s
         B06+83Q9Akk6cNSQ1oHABMax/04erzmxVMgxQPVbsut04gM9LcX3N+kx0uoqwy6H6E1i
         O9b3rQBNo4ltSkYXmAXb4QoIV1R9oR88FcT8MsBzzAeOBflhtX4BVtt3OPrXEDOczoXr
         C7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790980727; x=1791585527;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FKzhc6JuX9pGuBJ5sRMzCjJd9/g4im8E9bMuOULVOQ=;
        b=mcsM/BGbTSit7SbZVzCDcm96m79B/XltjYqleN9GrQAv7pgG7qGuF654aYVmgM7EPV
         57DjXVvZsOdJnFWnRt2INpgzxryrEpIuWackHjl94DwUOtn1W0DMTsUx+EFUSbFpRo27
         odRc3s9tDLyevInXeA2b91yYh65RsLD3XvXU2ksm+FI+9QmfwnuJ/GGAKboqQnPpx9y+
         6gqMQ583ygmrIJd4JySqJE5808ZLis90mdNNJiC3/tYoEnWWAOdCwKCTyOYmylhbOKA6
         nHypcTSda5NbzJz9zM0cqzmQBJ5nPop7kAQU4YVlYxtJvVH38aMByVMQoRNTNEfeUOFD
         hx1w==
X-Forwarded-Encrypted: i=1; AKwUvByYG6wiKiXit9aSqLL8IpHLCi0l5O6LQ9autnjex8bqiUM0trAHWC6nR9RfSaaDIVPb9kWCm0Lci2fom+w=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nFpS++97q4XUSO3ThLULxoeIVOyCMhYCDmHERRY2R42FGCRBvU
	1CP+nIj47RtrBCYenMZ9e31O3llpXAsLDjYRyZJrnVSOVn4+wJuCAD97CM/rC2HNMMi1dtcXUbv
	asc482g==
X-Received: from pfbhu35.prod.google.com ([2002:a05:6a00:69a3:b0:883:f59:2478])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc1:b0:886:301:cb7d
 with SMTP id d2e1a72fcca58-88af54f7783mr3790819b3a.11.1790980726304; Fri, 02
 Oct 2026 15:38:46 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:38:45 -0700
In-Reply-To: <pkxwkffc.ritesh.list@gmail.com>
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
Message-ID: <asAydfQLscU6rXQL@google.com>
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

On Tue, Sep 29, 2026, Ritesh Harjani wrote:
> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
> 
> > Hi All,
> >
> > This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
> > radix MMU).
> >
> 
> Hello Sean,
> 
> Just wanted to check what's our plan on this one?

At this point, I'm not going to get a pull request to Paolo before the normal
merge window.  I was hoping/planning to get some early pull requests to Paolo
this cycle so y'all could build on kvm/next directly, but that didn't happen.

> Are we planning for both PPC pre-enablement series of yours and this one to
> be taken for v7.4 merge? Do you think this can go in too?

I'd like to get at least a subset of this series in for 7.4.  If I'm reading
things correctly, all of the hacky changes I don't like are for the
kvm_create_max_vcpus_test and hardware_disable_test.  And as called out in the
final patch, "fixes" for PPC really should be ordered so that they land *before*
the tests are enabled.

Actually, better idea.  Limit patch 1 to just TEST_GEN_PROGS_COMMON, then for
the addon tests, bundle the "fix" with the PPC enablement.  AFAICT, except for
the kvm_create_max_vcpus changes, they're all pretty small, i.e. bundling the
PPC support with the "fix" shouldn't be too painful, and then we don't have to
worry about ordering.

As for kvm_create_max_vcpus and hardware_disable_test, drop them from the initial
enablement so we can get the core support landed, and tackle them as separate
series post-7.4.

As for actually landing this, the easiest thing at this point would probably be
for me to grab the patches in a dedicated topic branch that's based off the
kvm-x86/selftests branch at an appropriate point in time.  Alternatively, I
could provide a stable tag and someone else could grab the patches, but other
than it being a little weird taking PPC changes through kvm-x86, that's by far
the easiest approach since I'll be sending Paolo pull requests anyways and can
explain the dependencies and whatnot.

TL;DR: what if you post a slightly trimmed-down v6 and I take it through kvm-x86?

