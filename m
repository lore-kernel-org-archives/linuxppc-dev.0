Return-Path: <linuxppc-dev+bounces-24555-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE0EC44524
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 23:12:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3xBb0KXYz2yT0;
	Tue, 21 Jul 2026 09:12:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784589174;
	cv=none; b=F1y6XzVoMGEszdTIePtoeUbtTeye9SgaZpdKwF11qsvwzZx38T1UHIhsaU2vRu83HUdqhLiWf0VyamVBNbsSNssIRDhoc0RRlTriUcWTOy/CkgHlik/Y8yPuK4uCe4SwO8a1SQCbNTixVTUc4ajpdiJtv7GwUnyy/YL+xKhysfr10iD+Xof6T+g17BhvVX9NIh50AL7mBCLmbyanXCMW2KUB/tXQ9025kgoZE13nuFqsZgTjuk5ldIi4hYMVI6jssTc2wi0wRPcxDR+yUOj+pjpZieBOmmc8fTUAKuQw006G1dkiFczOmgOTCeAsYesDctRHVVFXdCWm42yotww0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784589174; c=relaxed/relaxed;
	bh=HJodb/MUa0/2fzgcr0wdUYzVVN1f52BWBDtc7+OJ2ls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f78lHdsj/TyOEb0tRm5WWI9pJt3K+5f0C5G/fcRQSQ0RPbB5sNkoMB0dZigXVaSsVvdz+CnGkV341ZjcfvO8SqfJ7e6Sj+rPsup8OjHV8V8HcvEgkoArIq0x44McF+xcFHkzu9TlQwVUkuLfO1hwEw6aXv93QynuEzJUVcp7wYenQEgH8Nj0UaJo0TeZtN9SPRLEpgc8QvXWW33RhMzsClBio0PTjjJUB1+8lp0/QCNOUDuVPhQ7HlSN/aXAhD+8JvmS4HKorhONSYSnG0yubb9ehzSq+CeeZSJwB4KegGimTYz2CFhtPOIy99B6SyN4hMP/LqoFmivuf3J+kA1k7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4YLLEPu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4YLLEPu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3xBZ1HQ0z2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 09:12:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5E9EC60A82;
	Mon, 20 Jul 2026 23:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A061F000E9;
	Mon, 20 Jul 2026 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784589171;
	bh=HJodb/MUa0/2fzgcr0wdUYzVVN1f52BWBDtc7+OJ2ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G4YLLEPuA0iYilz7rpjGkTucZ5H9/6mwEO66Ls21BCum485HBWiy+B9HpMh8k3cmE
	 nK2LLQiyPstIfR8X518Gi8gKrABRPwR4tmmI4c6XHEGvwJaWeUvismbjdjJQ5jQcuz
	 a7uCoteF4YZBCh0rI12DiGzRccpLWdu9ew601GrsXxsgytSCx6/PfaVubRdXl8NJDY
	 yP3Etmvu6lf183J7jeJdE1NRXhCF/ZnwU5msYJ87tlSa+uCevbodtk96bgReXkoCut
	 r5nKD4yyjtRT9l5s5BrgektFc0XfLo877tnb1BuLrYwpQBHp/ivSznO0jx2ZKbMmMS
	 icdvXXEdxLOKA==
Date: Tue, 21 Jul 2026 00:12:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
Message-ID: <20260721001243.54ad7716@jic23-huawei>
In-Reply-To: <20260717222706.3540281-8-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-8-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:27:00 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Restricted CXL Host (RCH) error handling is a separate path from the
> new CXL Port error handling flow. Fold RCH error handling into the
> Port flow so both share a common entry point.
> 
> Update cxl_rch_handle_error_iter() to forward RCH protocol errors
> through the AER-CXL kfifo. Change cxl_rch_handle_error() return type
> from void to bool so handle_error_source() can determine whether work
> was enqueued and call cxl_proto_err_flush() before AER recovery
> proceeds.
> 
> For RC_END devices, __cxl_proto_err_work_fn() calls

Can we refer to these as RCiEPs to match the spec? I have no idea
where RC_END naming came from but to me it isn't obviously that same
thing. Or talk about the narrow case of RCDs here as well.

> cxl_handle_rdport_errors() to process RCH Downstream Port errors,
> then falls through to the VH path for RC_END Endpoint handling.
> 
> An RCD uncorrectable CXL RAS error now panics via cxl_do_recovery().
> Before this patch the RCH Downstream Port UCE path called
> cxl_handle_ras() but ignored its return value - no panic. After this
> patch the same condition calls cxl_do_recovery() which panics on
> confirmed UCE. The Endpoint UCE path already panicked at the parent
> commit. This matches the panic policy added in the common CXL Port
> protocol error flow.
> 
> Remove cxl_cor_error_detected() and its .cor_error_detected
> registration in cxl_error_handlers. Correctable Endpoint errors are
> now routed through the AER-CXL kfifo like all other CXL protocol
> errors.
> 
> Drop the cxlds->rcd / cxl_handle_rdport_errors(cxlds) branches from
> cxl_error_detected(). RCH downstream port error handling is now
> performed by __cxl_proto_err_work_fn() via the kfifo path, which
> calls cxl_handle_rdport_errors(pdev) before the common dispatch.
> 
> Change cxl_handle_rdport_errors() to take a struct pci_dev * instead
> of a struct cxl_dev_state *, matching the new caller context. Re-fetch
> dport under guard() to close the TOCTOU window between
> cxl_pci_find_port()'s lockless xa_load() and the first dereference of
> the returned pointer.
> 
> Change find_cxl_port_by_dev() RC_END lookup from
> find_cxl_port_by_dport(dev->parent) to find_cxl_port_by_uport(dev),
> matching the Endpoint lookup path. RC_END Endpoint port resolution
> uses the uport (the RC_END device itself), while the separate RCH
> Downstream Port lookup is handled by cxl_handle_rdport_errors().
> 
> The RCH Downstream Port and the RCD Endpoint (RC_END) are separate
> devices with independent RAS register blocks. cxl_handle_rdport_errors()
> handles the RCH Downstream Port RAS. RCD Endpoint (RC_END) is handled in
> cxl_handle_proto_error().
> 
> Use to_ras_base() in cxl_handle_rdport_errors() instead of referencing
> dport->regs.ras directly. Make to_ras_base() non-static in ras.c and
> declare it in core.h so ras_rch.c can access it. Route all RAS base address lookups
> through a single helper to prepare for CXL RAS error injection testing
> that follows this series.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
Other than taking another look at the patch description and seeing
if it can be more concise, this one looks fine to me.

Jonathan

