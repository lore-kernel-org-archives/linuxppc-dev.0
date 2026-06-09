Return-Path: <linuxppc-dev+bounces-22350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5B3CD8CAA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:27:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZWTb0vhZz2ySf;
	Wed, 10 Jun 2026 00:27:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781015267;
	cv=none; b=Ia1KbzvZRJ/EpzM3JxDEUwvRU/5ZveClAlhdQhC2rBf3jdX/O004SuOmuChv16ZysaOXCHou8eMlZAKeQBqfnzvjcdwjIiH69qULdqkDJdBoDYVOOqnWkP4bZKT+vjv3aHW3QVVPdVo2TbD2MLWT3/1yq8Ox4rWPryuGL4I8gUW3bixfi4RXa7oOqD2ddL+zJ+vzTol4pah19erj5EcrCmaV2eHON1WFq7GF7gUHTFawkmIfbxiVRp5o5jhaGEAD8W2UlJ672EAG8wBxsjBVnJ5LRvBbRTL8LJabpBkIiO4+IoLsfLAFQwphGDWZKbJaW9xG85ta5zhvyw0jSrOFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781015267; c=relaxed/relaxed;
	bh=3iOytUVHx2Kw4SLTlA89uYZ+AZBEeiIBOi5iO0ryPr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHMv8A6gq0NQ2wuLf1bk54+1bXSazP2bjJ47snIUEv+cfkPXKc3k6zDY2W/LJc8rWtDj+TR87l22nmzW5qPg8ITvktFYMqbMsXOs2IDwjZoJ/na4mLG3IagGKO2jJHn6tExDyhaKb+Gwy4p7An2U1snHPKsGXoVkwvitAmXBhBKrNRTI4rtJeVoYnUfay8q3eZ5TOdJaRf0UwlTmIW7PXvwEfFbg/oN/JuaaI8oRQx6IMMkMHzpZNtX45/QDj5dP+G9lRBjRSber03Ztkf0uaGAJfNV/4I1eL7SM0yH/3ZBdudjD4dWlkA8asSE/zjRpsqD/DI3+hgaay4Jykwzp/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZWTZ1FGHz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 00:27:45 +1000 (AEST)
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 86023222F08;
	Tue,  9 Jun 2026 16:27:41 +0200 (CEST)
Date: Tue, 9 Jun 2026 16:27:40 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, ashish.kalra@amd.com, 
	michael.roth@amd.com, nsaenz@amazon.com, anelkz@amazon.de, 
	Melody Wang <huibo.wang@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, x86@kernel.org, 
	coconut-svsm@lists.linux.dev, joerg.roedel@amd.com
Subject: Re: [PATCH 35/60] kvm: Add VCPU plane-scheduling state and helpers
Message-ID: <aigifVmRZA0TXIrK@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
 <20260608144252.351443-36-joro@8bytes.org>
 <e7eb0dba-790a-4644-9895-5c9a7420d7fe@redhat.com>
 <aib8n5lO6HKbLC4Y@8bytes.org>
 <CABgObfbUsDeStnZF-7oyR-W-Bvd4qTMoeUwGizgn10UTdKtZ2A@mail.gmail.com>
 <aigE2EvJyZlYDz0V@8bytes.org>
 <51421426e0d4b154281e80d9f1c6c9a628d21c94.camel@HansenPartnership.com>
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
In-Reply-To: <51421426e0d4b154281e80d9f1c6c9a628d21c94.camel@HansenPartnership.com>

Hi James,

On Tue, Jun 09, 2026 at 08:59:02AM -0400, James Bottomley wrote:
> Are the details of this anywhere?  The last PUCK information I saw on
> the kvm list was the cancellation of the March and April calls.

Here is the calendar link I use, which has the appointments GMeet links:

https://calendar.google.com/calendar/embed?src=c_61a5b1f644739bf5bed7e5ea5fc3669ce32a2544c5db1c7c891702ca5090c7d5%40group.calendar.google.com


-Joerg

