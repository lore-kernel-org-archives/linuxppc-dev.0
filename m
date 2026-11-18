Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF0606A339
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUzLfTeG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVBF511STz2xdX;
	Thu, 19 Nov 2026 06:17:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795029449;
	cv=none; b=E5fKiXH9vGnrmwPYdYprBuEC6E+4SBA/b1R8IQWz9hrlDVtYZcHTCt2z96FHT+dWIz+yove+LSKd7QkD3yWqL3jRyFURZtVQtBcxoFW+P/sKe4MBnVf8bmjKBGc2I6U5tT6AyZtxPs65lBj7gRvt5yVrtY2Sj01+xYqK53DfrwK1Dy9DcVwNMVFYwe7IFXyqM+CoYmdZAgkY9T5bl9gr4iwNNMGc7fzakFjJBQe6t11qmlM7FmMT6mQVGI43f6hTfgk9J+6vFPx1XH4QSowZWrdNnAHnu4Qoz2uPdfDXEOQSzQn93Vx/vrpKgOu+qD609yQNzhNSXRhhi9Cy8OI4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795029449; c=relaxed/relaxed;
	bh=7owH4WUkerW4zIC+CKgnsga+eX0VNj1y0MG+J3/f8XA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLVCjOeqKEA/08chOWvEBX/h/GL/6n/qTfiCJykb8SuD5zXXfhr0cw537iJq40PNYtnF4UMxptPigOwJE9tX18j29hsJD5tDL7uj3iOFs6t0Sa+KNNWs9w68cXreGZ/e+ewHCdjNoDpNDCvhqu80ezKsDQ1rLfI4fxH0mHCIzC0kO/jES6TRG1od74Ol0OFtmE84KNo16RsFGJA6MftqNnRV+coPoHEQ7vjcp49xtqpJxiANaAc78MrkbyBEkc6WYEQ1gN0DWYLNbEGvDugOegR0o8qvFiVM7hNHx64lDtYNq35YneZGUR35tv7c+wDPt40IMzxd1Jt0FNM1PeV8/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUzLfTeG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUzLfTeG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVBF443Xkz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:17:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 481EC638CD;
	Wed, 18 Nov 2026 19:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BEA1F000C4;
	Wed, 18 Nov 2026 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029446;
	bh=7owH4WUkerW4zIC+CKgnsga+eX0VNj1y0MG+J3/f8XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jUzLfTeGVe+PVJWQpQLUkHhUrlMClo9R3mL7zgVI4gmp8SxXYkr468lUOUNgoDpeU
	 kDwzn7RvYzUgRVvJS5xWYx5ms43Uidq8z+Ldn5RfAAcFsGFAlQItErJV5WESWbYvpi
	 axnSxFLq3DJAwvWpYtGSR3KM/MimOlY/hMEOFBiiHnY2W/nMYpRdMakLP+OhixN/nn
	 +MGHg2u7eZ++8s1o7Po6K7SjXQL396mLgmhBnPeraKdNZeo8VyIJ2DeZ1MglbFhTNO
	 y+KLn3+Oa8wBs2ooCbN+hQsZZ/HOvwLcCmyAFlJrsOFDBIrI9ofXmIrCIG8xNrj3if
	 8sq5P1AiMZXDA==
Date: Wed, 18 Nov 2026 19:17:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu
 Zhuo <qiuxu.zhuo@intel.com>, Avadhut Naik <avadhut.naik@amd.com>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Breno Leitao
 <leitao@debian.org>, Dan Williams <djbw@kernel.org>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman
 <terry.bowman@amd.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 07/19] ACPI: extlog: Provide HEST generic data to
 extlog_print_pcie()
Message-ID: <20261118191712.19a5ebf6@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-8-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-8-pierre.gondois@arm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 12:10:17 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Pass struct acpi_hest_generic_data to extlog_print_pcie() and derive
> the payload, severity and length from it instead of passing them
> individually. This reduces the number of arguments and makes the
> section flags available for subsequent changes.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Looks fine as a standalone improvement.  So even though I haven't
yet read on far enough to see the usage of the flags:

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

