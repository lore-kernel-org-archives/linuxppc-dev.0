Return-Path: <linuxppc-dev+bounces-19117-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A4B10F92EC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 01:54:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flp1l3YNbz2yfl;
	Wed, 01 Apr 2026 12:54:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774923773;
	cv=none; b=NmFpen+tbY9O/0PDo4YP0alramyV6o6qQBTpDEsnZ/SSfPgBH5WfDRKcb6pN7m5UDz7ypEuUl/HQP2QTbGXULZf/DIa7yetHZowCPYcH37Lxu7nvVMy9nPHr50clp/SlMn6V7Ec8hU1F0c7JTGU9nBun2fLQ/NFjbmFo5gh2In7fcTyUI1ExFqW7i18B4yGXKhNF08aTC7F2aTYDSn3wqDwWte+76b2uOlD9ir6qzCIfq7bts2d0co9tNAMgNdLCl7aaGFNAb4NlaaCshvZt9q+dXJ+vscep6YM4DrA+Oxrybq66HrysgLzescsuIsEmMpQQ12CnyD1Lxv6s+rYv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774923773; c=relaxed/relaxed;
	bh=QabMiw3X15wVYXIy7i5TdznxyWv79L5LHLcvahuNhGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET+5PWJTfaXPku/+JhYwOc6ixqztAW70QzfI/q1Mfle+4h/h3sKidbE+Twh5gDO+W22wQOTOqsMdmu1IgNhiVbyKSGYWFJ5qVhU13Y1RMHFOJl8LJBKcAPSQxyP/x0/LhKswHv2Li91n8wTFTPbbbaGZ5d2QBkUgMAu6GN4pF3NLcyLxGDJEG3LUipmLmWoqsbkDh7MUFU0BtP501MfheWbNXte+oCdmUE0jHVMNwM9aRxCZ2UNHsj3bRZ2VN0MXIzMlm4W73VFyFUl8EJoIy/LecZkCLSpv9P/uQl+dcLHdEW2tPklGXZsEGPxQboj/4WlREpJsIlKcTfO0cgvu4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dKyITreC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dKyITreC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flBjS6FzYz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 13:22:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D95A6001A;
	Tue, 31 Mar 2026 02:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3C9C4CEF7;
	Tue, 31 Mar 2026 02:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774923769;
	bh=l7yJ68saVTwIij/720EHHZQ7SKACJi+dA14H4Iz/0NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKyITreCFvpgzleJDzSfojc1RUx0rh933wIM/DxrEJcU+2OMUZsSJeZEjJ5Zo7ccc
	 Jv9xUS9s0iBiOl801QOPyyG/eWFZhYPkYbZIRoqnG9Bb4x9JtmCE38Uq5hzk4d1by+
	 cPfDSMyTh2b8VZtaYu92AD4ejaU1OVCp9HoB7V9wOZJsbrsd/bu05xczdY4/8JVyCE
	 zLi89KFGZKVjXNAPN5d4jQ1a+ife3KXkJbyrEJSdiLm1I11ZLaHwY716c8Ffng+FWr
	 FNtFkKfbbOY6866B8SBRM+HuAYzBzP+rO607pNwTQIKnB/DKGGKG/LHN/odixoKzYh
	 7fc3cDep3FpAQ==
Date: Tue, 31 Mar 2026 02:22:47 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
Message-ID: <acsvbxIdtlQzUw4q@google.com>
References: <20260325092001.613025-1-peter.fang@intel.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325092001.613025-1-peter.fang@intel.com>

On Wed, Mar 25, 2026 at 02:15:11AM -0700, Peter Fang wrote:
> kvm_vcpu_map() and kvm_vcpu_map_readonly() should take a gfn instead of
> a gpa. This appears to be a result of the original kvm_vcpu_map() being
> declared with the wrong function prototype in kvm_host.h, even though
> it was correct in the actual implementation in kvm_main.c.
> 
> No actual harm has been done yet as all of the call sites are correctly
> passing in a gfn. Plus, both gfn_t and gpa_t are typedef'd to u64 so
> this change shouldn't have any functional impact.
> 
> Compile-tested on x86 and ppc, which are the current users of these
> interfaces.
> 
> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Peter Fang <peter.fang@intel.com>

Most callers are converting a GPA to a GFN, I wonder if we should make
the function take in a GPA instead? But then we'll need to the GPA not
being aligned to a page boundary (either do gpa_to_gfn() in
__kvm_vcpu_map() or fail if it's not aligned).

Not sure if that's a net improvement, mostly thinking out loud here.

