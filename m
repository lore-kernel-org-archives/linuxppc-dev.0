Return-Path: <linuxppc-dev+bounces-24563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDF2C44515
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 00:19:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3yg63C2tz2ySg;
	Tue, 21 Jul 2026 10:19:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784593154;
	cv=none; b=Vr99TCF/vMK+ccrnERLB5y1eXw0iuGA7PdftDQU6/MYMImzlIKzirj/9ZtevYOJmO25MOaRapVp7ddEIWqwACO0K+KIO2Aztv0njm9nbJVcMgdhHVC4sqoiwkQlADZ63GUSGCIzHq5Ga0p7OpeopTN+8+PT3qpQl8JOhz9uZTbUdjy1+SV6v6kufffaROBnoKzgn24gORHKzQXsM12MBTYi8ePMohFRYaYDl+Vgo14YnI2RsUTzY9oXeWnJS6m5eUkMGVj1lTRhn8M68IttrQYEsjqdeD5/m1vmIa0yHaMWg0wbWokcKi7N26TaribpyrIoFH5PZVumvV1gKXsRLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784593154; c=relaxed/relaxed;
	bh=AFoF5hI+TyonHgFrZiKmtrN1ti4k0VjnSpnUvsJ8h/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxfKJvv4tATHzG8c62T/SMY6/hP/LMP4BRE0IcslhZ6Pc+wtgYqZBMen4o+22iPHXgOOpfsT8F/6PMguBLrSE7HTQi/mEzSpLUI6C4XDITKrZRY88TUiWVp0tFQWYT24xDxzPypA7F2u/xbrpvzafdj3NHAcWs6gkORt10NXF21RVC2ucri6XSb6oGv3iuQxEZpxOpHpwbTJnFIvKjPyx7fuQDUX4LWHHW5VcTye948XJkX5rDNUrE+hYm0xgKq0yD67LMtVuflb4kxv/6oHSKrGhaLTq1tosOAl2n6m8HAIEIV/Y0HuZlCow7YRoXpO+M1oEkxusj7rTOC9quDHwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+xaV714; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+xaV714;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3yg50Pybz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 10:19:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF72360A7A;
	Tue, 21 Jul 2026 00:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A856B1F000E9;
	Tue, 21 Jul 2026 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784593150;
	bh=AFoF5hI+TyonHgFrZiKmtrN1ti4k0VjnSpnUvsJ8h/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a+xaV714k0eHw8rUI7q1qTfijKgxRQ55rJXLUXJV5tiqYUp9mFNwYfDo5yCIs92XJ
	 9cKUZ6WSbtixHdiBNa3tfHIgCpRpSPgNxKtCYTYhCAZ3s57qRUwM2UhAqkub1zl3gv
	 v1Q2HorUH2vmYIh59cS2ON7m56FcZUVOTLlZaHAYeybX92bmOkiVYuSkRGkXHFZZHJ
	 +ONVwY2lra+naEsQ8nxIUIPF4pSuZ3oGXu3q1xXaH7r3eXxlO3VlqQOKT7BxbLTlE2
	 DLcnLtmOnvlC3uZvjq81uYtPH9ZFZDaTUFoi2v/sZtoxn983OV9rqUu7bE79n1EMrW
	 Od3dcqVbVo/+w==
Date: Tue, 21 Jul 2026 01:19:02 +0100
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
Subject: Re: [PATCH v18 13/13] Documentation: cxl: Document CXL protocol
 error handling
Message-ID: <20260721011902.0a93da2d@jic23-huawei>
In-Reply-To: <20260717222706.3540281-14-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-14-terry.bowman@amd.com>
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

On Fri, 17 Jul 2026 17:27:06 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> describing the end-to-end CXL protocol error path: AER ingress, the
> AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
> cases, severity policy, trace events, and a source code map.
> 
> This documents the architecture introduced by the preceding patches in
> this series.
> 
> Assisted-by: Claude:claude-opus-4.7
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
A couple of trivial things inline to tidy up. Actual text seems good
to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> ---
> Changes in v17->v18:
> - Simplify document for readability (Jonathan)
> - Drop historical context that goes stale (Jonathan)
> - Shorten ASCII flow diagram (Jonathan)
> - Drop manual backtick markup, use automarkup (Jonathan)
> - Clarify USP/DSP as single switch component (Dave)
> - Fix line wrapping to 80 chars (Jonathan)
> ---
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../cxl/linux/protocol-error-handling.rst     | 222 ++++++++++++++++++
>  2 files changed, 223 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 3dfae1d310ca5..6861b2e5726a3 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -42,6 +42,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>     linux/dax-driver
>     linux/memory-hotplug
>     linux/access-coordinates
> +   linux/protocol-error-handling
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/Documentation/driver-api/cxl/linux/protocol-error-handling.rst b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> new file mode 100644
> index 0000000000000..67f0492e56702
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> @@ -0,0 +1,222 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================
> +CXL Protocol Error Handling
> +==============================
> +
> +CXL devices report protocol-layer failures (CXL.cachemem RAS) as PCIe

Why short wrap?  Docs are 80 chars I think.

> +AER Internal Errors: PCI_ERR_COR_INTERNAL for correctable events and
> +PCI_ERR_UNC_INTN for uncorrectable events.  The actual fault
> +information lives in CXL RAS capability registers, not in the PCIe AER
> +status registers.

> +Error flow
> +==========
> +
> +.. code-block:: text
> +
> +   CXL device raises AER Internal Error
> +   (PCI_ERR_COR_INTERNAL or PCI_ERR_UNC_INTN)
> +                   |
> +                   v
> +   +--------------------------------------+
> +   | AER core (aer.c)                     |
> +   |  aer_irq() -> aer_isr()             |
> +   |  -> find_source_device()             |
> +   |  -> handle_error_source(dev, info)   |
> +   +--------------------------------------+
> +                   |
> +                   v
> +   +--------------------------------------+
> +   | handle_error_source() dispatch       |
> +   |                                      |
> +   |  1. cxl_rch_handle_error()           |
> +   |     [always; filters internally]     |
> +   |                                      |
> +   |  2. if is_cxl_error():              |

Smells like a missing space.

> +   |       cxl_forward_error()            |
> +   |       [enqueue to kfifo]             |
> +   |                                      |
> +   |  3. if cxl_pending && non-CE:        |
> +   |       cxl_proto_err_flush()          |
> +   |       [sync drain before recovery]   |
> +   |                                      |
> +   |  4. pci_aer_handle_error() [always]  |
> +   +--------------------------------------+
> +                   |
> +          (kfifo -> workqueue)
> +                   |
> +                   v
> +   +--------------------------------------+
> +   | __cxl_proto_err_work_fn() consumer   |
> +   |                                      |
> +   |  if is_cxl_restricted(pdev):         |
> +   |    cxl_handle_rdport_errors()        |
> +   |    [RCH dport RAS first]             |
> +   |                                      |
> +   |  port = find_cxl_port_by_dev(        |
> +   |           &pdev->dev, NULL)           |
> +   |  dport = cxl_find_dport_by_dev(      |
> +   |           port, &pdev->dev)           |
> +   |  [dport NULL for EP/USP; set RP/DSP] |

check the alignment here as well.  A couple of extra spaces in the
lines above I think.

> +   |                                      |
> +   |  cxl_handle_proto_error()            |
> +   +--------------------------------------+
> +            |                |
> +            v                v
> +   +-----------------+  +--------------------+
> +   | CE              |  | UCE                |
> +   | cxl_handle_     |  | cxl_do_recovery()  |
> +   |   cor_ras()     |  |  read RAS status   |
> +   | trace + clear   |  |  trace + panic     |
> +   +-----------------+  +--------------------+
> +
> +cxl_do_recovery() reads the CXL RAS uncorrectable status register.
> +If UE bits are set, it emits the trace event and panics.  If no bits
> +are set (e.g. RAS mapped but error already cleared), it logs a
> +diagnostic and defers to AER recovery.
> +
> +
> +Severity policy
> +===============
> +
> +**CE** - cxl_handle_cor_ras() reads the CXL RAS correctable status
> +register, clears set bits, and emits a cxl_aer_correctable_error
> +trace event.  No recovery action.
> +
> +**UCE (non-fatal, and fatal on Root Port/Downstream Port)** - cxl_do_recovery() reads the CXL RAS

Wrap needs an update here.

> +uncorrectable status register.  If UE bits are set, the kernel panics.
> +CXL.cachemem traffic cannot be safely recovered once an uncorrectable
> +error is signaled; continuing risks silent data corruption across
> +interleaved HDM regions.  This panic policy applies to the native AER
> +path.  On firmware-first (CPER/GHES) platforms the CPER handler emits
> +trace events only and does not call cxl_do_recovery().

