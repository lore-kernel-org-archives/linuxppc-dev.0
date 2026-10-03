Return-Path: <linuxppc-dev+bounces-28811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1EFCA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 06:00:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxZlC6B3Zz2y2B;
	Sat, 03 Oct 2026 16:00:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791007255;
	cv=none; b=M4gkQqT+y83Va4Fx0EO74TshvVJ2X/2bwLtSRCqBZ2IRZDyQ1fq+GN4XN+b7aYx45W6pjz+RYCdKPMCTz0fGM1ZaXyLOYJNXTAZGejbILfu7LF0cwlTxfmsewvaul5agKueRoEAb7OLY+h3eCZRLnYBHGM90JOJ0Ardec5TVC48czx7eDmshBFRDyPNMZkMEA9ppF7ckHSk4FHGqGqdy9uiBERrGO+hXJj9Gx6jMLLubcmvpS4wkwPl74TPZ2FUGQYDbTcLph1Fau0pcFsWHFVbV0c4c6q/4btabnuKpAPMtMiHaeAPqoNOa0e+aKhuBOOQbWx6kICZuvO1QyD0aCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791007255; c=relaxed/relaxed;
	bh=BHbeuwzJ3G6xnJ7FZ53NVkGVQtvmx37StvDtCuaGguo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ANdO24ANLujZZyinvU4FAH6Xt0DTyvg8vNfH5dxfPvvDoGI8odLoAkXCZu4uyL/XFsnhIRWGLJWBKOLSDzCSVzwqKz4EbhwiZr2pA71GLqsu4/DZSYn3KrJJ3ClcVkFmiukQGKZzemrW9hQ/ciwTZglWWD+3prsntBjyaEhjFwYCNXjX2jBRk+t8iEFq7lpB0s5xEbTZwXh3TNT5Vs2Zxy9WM431dFmgx5MBmpXuCjquNPQE8wu/1vFw8N0IKmWbLqnYhwq2JGb3JC4/MAn2tulNZIEq6Hk0N1/F40p06TMXsaGmYaYyYSVgIvXadWstV8kvsoDFQPMln+XtcvoPyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icDmBQPy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icDmBQPy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxZlB6jgYz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 16:00:54 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-35118a5991dso29990eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 23:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791007252; x=1791612052; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BHbeuwzJ3G6xnJ7FZ53NVkGVQtvmx37StvDtCuaGguo=;
        b=icDmBQPycrthcuBTBHFVK3KKrdhsGdXhAlxYUBLjU32onzTdAiKKnXl10wVoJ4NW9x
         bzBlofx5PDYb5mLFdCiOWkVgFsKLwj11mUARgn8m5mMbp4UdpAHNoNThic6KGaFavZhf
         Rv8dd7a6Vx4qKRsgeVEnhk9+8cNoIzhUb8LPxx3KpT+PugO9/oS6sl9TrjNf5DBhMHv8
         HA3JZuwdteyEDw0L1T3OKWnmDHWBJHyqQBLkNxgnm+YyzTEpNkzWsiw6Yq4UWn23OjZl
         Cww0ESFj+1Al5KHJeqQo4pP565rMFnZRN934Zlw1it5NQ25rgCAi2ifLtThyuo8mIB0f
         uReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791007252; x=1791612052;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BHbeuwzJ3G6xnJ7FZ53NVkGVQtvmx37StvDtCuaGguo=;
        b=x9lEKuw/xHfAvY9CR8bMDhgxx/rh9kW6Fk36xCVH21GrxSP8CRieS+bbLlLvx6xFwZ
         QNa4T+wFYl/Kl4nJmib3sSVQAZaUym8guU1/pHTxlbNlXGb2vYKuYa7bLl4j+rR5QtXI
         Obo7UI3QmC2PIRnarH67PjA8PFLMEcD1EERScqtjQyRrjBmvwrdU4RuS4yegpkFg6818
         XJdhGIjM1OPkmUkE6+EQNPsR4Ak0/CWN5fsqixmyoFviBZ/AZ/s6wLa09948UIZGlDP5
         Bx9ArlLJI2z9Ole78oCGT7oJO4LClykS3paBdNY13FbyQGtnRpjNc2DMBCLiPpTOgiz1
         PLfA==
X-Forwarded-Encrypted: i=1; AKwUvBzQiipBgxNUXQeoMMroyKp3aE9Qb3LrYU32uE69RooniePqRZfMLsbW+8Zsd/hR/vwA8EAaETGTjc+wGtM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ7WOrUtfc7hgSpis0JXWbdtiDiTioiT2x1crJmWVVVTlNyIeEy
	P/lLuigGb8SD65raU9qIDIODWkC/RjwnOgn3WI5OorF8Hwpw7i0ozZha
X-Gm-Gg: AYBFou1PeZPjCX3srGGxU9cf+bDLTw601RcAoWoFIdSyv9R4/KdLk8TXCP5aGKavCb7
	WD4kaQ8lXQE/wRrjJANw42SRVWsV+/+S42UMbApZyrmpuTFAaUPomFc27B8nCNxHchoAckh9LXk
	paxl7IyWHu8HTx03SvCI1NzbjdCQ9W1VFujCDmC/XTKDkPxBxltzgXj6sExIZLFzhP1PxypSEMj
	YqhXBtk/IaQtvnTM5QBzTwDkAK86mGOY6ufjq+1trqtUFVqnu1xy0l1scAX3sjUh38TSpQOVBl6
	tmCmDuZctEACEke82BhdBFEDBA2q/GbCdK+NtZI5NqW7eBDbw4CU2DeHJteGeqWmU+hSeIEp501
	EATRDFuP/BCGXeKK/m8/6bbCAs1ewIZi8TYhlnDUb5iZbR+YltBTKiOtpABz0inhePaAtGTNAy9
	YcPO1Ifts2k41+Oo1pyYZtHn5uhcyE8yHwPeF1GID+tutbpPpKT/DmRne1I+OsEAWeik5Lrns4y
	XWynazPPtg7rG2kxKJzDnLECqGdpJDXicR+e28WM/DvVrCIhJ0LjM8=
X-Received: by 2002:a05:7301:dd91:b0:34b:8ebd:e3b with SMTP id 5a478bee46e88-34f150d946bmr5245863eec.14.1791007251743;
        Fri, 02 Oct 2026 23:00:51 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f9f2afsm25349897eec.18.2026.10.02.23.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 23:00:50 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] KVM: selftests: Make kvm_create_max_vcpus tolerate ENOMEM
In-Reply-To: <asAtNhSQHDy_k0d_@google.com>
Date: Sat, 03 Oct 2026 11:15:20 +0530
Message-ID: <jynzjq1b.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <25cdef9c45a1270dcad7e9c4140e56b6953eb27b.1790101179.git.ritesh.list@gmail.com> <asAtNhSQHDy_k0d_@google.com>
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

> On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
>> diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
>> index 59ddc3757943..45a9d8b369b5 100644
>> --- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
>> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
>> @@ -20,16 +20,29 @@
>>  void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
>>  {
>>  	struct kvm_vm *vm;
>> -	int i;
>> +	struct kvm_vcpu *vcpu;
>> +	int i, created = 0;
>>  
>>  	pr_info("Testing creating %d vCPUs, with IDs %d...%d.\n",
>>  		num_vcpus, first_vcpu_id, first_vcpu_id + num_vcpus - 1);
>>  
>>  	vm = vm_create_barebones();
>>  
>> -	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
>> -		/* This asserts that the vCPU was created. */
>> -		__vm_vcpu_add(vm, i);
>> +	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++) {
>> +		vcpu = __vm_vcpu_try_add(vm, i);
>> +		if (vcpu) {
>> +			created++;
>> +			continue;
>> +		}
>
> Oof.  I dislike this, to put it very mildly.  Is this the KVM_CAP_PPC_SMT thing
> again, or something else?
>

No, this is not the SMT issue, where PowerPC encodes topology in the id,
so we cannot use the full MAX_VCPU_ID range without a valid SMT layout.
That problem we have fixed in Patch-2.

This is resource limitation on L0 Hypervisor for KVM-on-PowerVM
(nestedv2) case. On nestedv2, KVM_CREATE_VCPU is an hcall to the PowerVM
hypervisor (H_GUEST_CREATE_VCPU). Now MAX_VCPUS or the MAX_VCPU_ID are
the max vcpuid range limits, but that is not a promise. L0 can still run
out of guest management space, i.e. the hcall can fail with
H_Not_Enough_Resources error as per platform HCALL specification.
KVM maps this hcall's out of resource error to -ENOMEM.

> Assuming it's KVM_CAP_PPC_SMT, is there really no way userspace can pre-probe the
> "real" limit?  Or modify the test to enable KVM_CAP_PPC_SMT and do the proper
> striding?  Eating -ENOMEM is all kinds of gross, and I really don't want to add
> __vm_vcpu_try_add().

We already probed for max vcpu id range limit. I don't think userspace
can probe for anything else here. But let me think about this a bit and
get back. Maybe I can see if I can drop the helper.

-ritesh

