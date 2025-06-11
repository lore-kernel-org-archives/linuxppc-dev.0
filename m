Return-Path: <linuxppc-dev+bounces-9290-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C139C677C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Jun 2025 13:56:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHRyT4nlgz2yMt;
	Wed, 11 Jun 2025 23:56:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749650161;
	cv=none; b=ZnjzMnaq0AbphSM7+lTqhAryNDAVpSXRmM/oXrVSE7JxUnM8yuEXW2+Hyovjokyg4asI7gmOll82pmj7izN+F+2WPF3seyJ42dhgHLGF43VTCp7BwhTJBV3QFEM34inWkDEpUfwHnBAsuPaNo2WVRR959mEDkx+vtcfpfdlAAaJS4nmr7t8iTtxjOr01adbf+DnmeoqOkb/+klS/yPXP2pNpalS51NWSbEurTrLgwGxwPcDXgFfQ3DeJ2DLx5qSjQqUn63/IqgMhQi+tYUaFwtR1o/aJ+PPnN6TIe/hhlnU7o4ThC2Y0MK6zLdQ+CL1wU8o5EvZH/kNfYcTJDHTEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749650161; c=relaxed/relaxed;
	bh=SkTsngJ6rWHC0YdfqFF9Vq1NCYY9a7C/v42aK3vSqTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/c8d2vWWU49JrS57fD4xeOutdskcpWT9VrFD8bwQlRngKrC00JjzoUo7kVNkgoWsiJCsdVb1miRTrSfT1KUDLOXuyv+y981LVUBeqFx0knzfn8vIR4/+sF5IJBFngLbFbS0l27toKiWDckCFOsaePZWut0pfYIDu6TrdU/wKzA3QEOR4iCtAmYmyO7ByANjamstNH1iGjFbk69i/o8md4cB7RRMFs2TcSk89xDG+XUo3Jfg+OrY/fwR3XJfYAyzrpZDLCiVi2DeIWIzASTl+L2VWcxnpjk+bGu+uRl6+fcfPKCCx+IFzYMwY2JA9mXWARtfpHY04okELaGy9qY/9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHRyS0dKNz2yDH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2025 23:55:58 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 55BDlZUP018154;
	Wed, 11 Jun 2025 08:47:35 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 55BDlWsZ018136;
	Wed, 11 Jun 2025 08:47:32 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 11 Jun 2025 08:47:30 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Thomas Huth <thuth@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>, Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH v2 2/2] powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Message-ID: <20250611134730.GI30295@gate.crashing.org>
References: <20250610160128.69033-1-thuth@redhat.com> <20250610160128.69033-3-thuth@redhat.com> <20250610202634.GG30295@gate.crashing.org> <53b46042-4ca3-4ba8-bf72-2dee9c54dc6d@redhat.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b46042-4ca3-4ba8-bf72-2dee9c54dc6d@redhat.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Jun 11, 2025 at 07:55:45AM +0200, Thomas Huth wrote:
> On 10/06/2025 22.26, Segher Boessenkool wrote:
> >On Tue, Jun 10, 2025 at 06:01:28PM +0200, Thomas Huth wrote:
> >>From: Thomas Huth <thuth@redhat.com>
> >>
> >>While the GCC and Clang compilers already define __ASSEMBLER__
> >>automatically when compiling assembly code, __ASSEMBLY__ is a
> >>macro that only gets defined by the Makefiles in the kernel.
> >
> >And it should not, the kernel is not allowed to define any symbol
> >starting with two underscores at all!  Including __ASSEMBLER__ yes.
> 
> Right, I can add that in the next version, too.
> 
> >>This can be very confusing when switching between userspace
> >>and kernelspace coding, or when dealing with uapi headers that
> >>rather should use __ASSEMBLER__ instead. So let's standardize on
> >>the __ASSEMBLER__ macro that is provided by the compilers now.
> >
> >"Now"?  This is true since at least 2003, and probably a lot longer
> >already.
> 
> Sorry, I've put the "now" into the wrong location ... it should rather be 
> in the first half of the sentence instead :-)

Ah :-)

So do you want to redefine this symbol (which is off-limits) at all?  Or
do you belief that the compiler will have already defined it (like has
been documented for forever-and-a-half already, and there never were
problems with it)?


Segher

