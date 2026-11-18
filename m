Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77860A263A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HO+kR9le
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVChl4YHrz2xnQ;
	Thu, 19 Nov 2026 07:23:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795033383;
	cv=none; b=Lf1F05PfrxXaz3IspEeEiaow0OdFr7WoedwvJfKQaiW/5P5z/tNk7LcfHzBMLh7xlO2zzQUpoxd8IwMJal5L/GThooJv2r9F99SklqdPrJJwzpxYD4NhrHCJ+7MiTKk3xyGOFDc91xDoT+fBqjA4bB128rf7PPxWWXibU+mIi3fyJ4gdT9tsy3O6mkKqKQcgKH1E5VWQWzJSQi2rC20N4T6+nBI91yi3KlPdFH4Hzhg5zAKGQoWl24PxLi3zcEZE6sz2wfHvhiRbjMcC4Wk6DGRGRnP3Eqh54R1FAMWCicA7Og4EK5KqgWrL7WM5JNrDPGDAl7hFrlZ2ftTjSi1H7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795033383; c=relaxed/relaxed;
	bh=FkNN5wo0Am75uimk9STIjbiPLRC6EWagOnVoqK+PmwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePZ40RsiHCCEHL6Qva9IdbbpIJE9oGT3y5G4FSdiRBYi3CjkBTyCez311ROjTYniZ1znjAMxxtnx4z4ZJN7tY+VF1t+mbyvYzDV4LpHxC/ijRHAjWdpO1G80UPT1y1YSq3hQKLiaWkE38gldhBzMxxueDwdtIPf1zNK8o9eodJ18pO4LMMIZGXJCr/fAxwejgsyaupV6jIKx1FNWxcyvpcJ2DTQUx/bmFrQKgpcPnc7kiPQYhJIy3kl7TugEfDqLaBP44z8afzhYqQ9Uoj6lcxCaY+zxfQYLBCmStvDAJtMp7BV/USHhFMH+dyyKz3jeCtnwrYVaOp/S7ziTxfeLhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HO+kR9le; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HO+kR9le;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVChk4vcNz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 07:23:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5314863B0B;
	Wed, 18 Nov 2026 20:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDA61F000C4;
	Wed, 18 Nov 2026 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033380;
	bh=FkNN5wo0Am75uimk9STIjbiPLRC6EWagOnVoqK+PmwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HO+kR9le6tB0FawCiLsaWoSXs/8ddm9MKA7CskHLF837GeTsPeoB5lgFe3cWD67uV
	 XsNRJE0ReBHK5Fd8No0uWvclkVoAFlM9KNkmbPkpOuQrR24u7zhn228ysy11LIU3i/
	 6BHjzy+TbbZio27gMtSikd14LBTXHv/pdmbIoRZY98jSWsJ536966HH/Fiwblqi+3U
	 8BT3a+HT4mOMLRFdS02BtqfnIX3gxvkBdJfEpUBfv0dmVPFGsBtAoNIBqJNCbK/VID
	 q0EtuArQSHGboVZmAa9JYRLubflyz0MG3h+ou0Ri5wmaaRHWTxiYLv0MVqq+HI1I/5
	 U+eOtWYOc3vIg==
Date: Wed, 18 Nov 2026 20:22:49 +0000
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
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Radu
 Rendec <radu@rendec.net>, Avadhut Naik <avadhut.naik@amd.com>, Dave Jiang
 <dave.jiang@intel.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Breno Leitao <leitao@debian.org>, Dan Williams
 <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 17/19] ACPI: APEI: Share the extlog PCIe handler with
 GHES
Message-ID: <20261118202249.76b98c39@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-18-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-18-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:27 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Remove ghes_handle_aer() and re-use the existing extlog_print_pcie()
> to have a common PCIe logging handler. Update the function
> documentation.
> 
> Except for the warning ("PCIe error section too small"),
> no functional change intended.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Fine if the earlier patch to add error handling flow
to extlog is fine.  I'll wait for more input from others on that.

