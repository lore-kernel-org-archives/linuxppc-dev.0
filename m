Return-Path: <linuxppc-dev+bounces-9942-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CE9C8302F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Jun 2025 21:36:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bWKH55VJqz2yPd;
	Tue,  1 Jul 2025 07:36:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751319393;
	cv=none; b=DRoa+TcTgtvVi9sbC+H2XsICUFSy3h3l1dokiCYPwGQ+AbrqI4jQj8WN0ExvDQb/aWBHochbmKeSPDzxrQmNSQh5dwgstWvMb0oDIalHPxw0xQwNbF1kmsqin/nrSOjiIb3MYEQJ+WskF5xB1FHFGQsWNf5ItGztfH7ox3Tga22+CwyMALxHnXpmIuyREoZ9emgJDqqka/u5fEqZrNnQysnVTDBwbK7+AVVF1s4jcZh1D1mGeO5C3WqNBtGk6xuQChFwmN6C2wGiWNCdv9+cvWs1HgiKPvZIo10cpgUvawAyRCIPKVN6SDRagR312gVzaGm/aBwJcb4PcwR2vk9ZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751319393; c=relaxed/relaxed;
	bh=i1wyNUvZ7zqO4azzeexqOeE3N+2Xq/Orq3cPYtek9D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJc6cxFtlb5M0quK6I8FHzxyZkTuT6yXzyJfJY1RJZhWgN1HprhSO2mfd49ROsrxXSVa0nAip6zqSmpaJT+e8DRj0pQ/ufy2HR8FxcjHwVm2Tlio2yLOWJ3Y7ZssdJ2Q9grUq/+l7VC+yv9wBHV03ANTvVj2NdpsKBJ9ommxHHt8rUIqHLirWdUM3QzYfEvkezt2+VPq4soUMbVNHrwc8knd6dG5SveVzfgqN0RdWgYAE6YxI+OWeqVO3dGebaFEKG+RIYOziner//ta/Lz7JJZqygiOwNE7QxFdbkoQkHDaDR2TCiqFPWK0bYfIwcD+4g40VmY0V71lBEKIRVG8eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QHgGDUtx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QHgGDUtx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bWKH40GFLz2yFJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2025 07:36:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B801E433A0;
	Mon, 30 Jun 2025 21:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F937C4CEE3;
	Mon, 30 Jun 2025 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751319389;
	bh=mZ5FIEorJVzzShKFZlqCCCfYQI+bkZcqGcvsqQdrGBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHgGDUtxTDuTIVFyC97+axikseCSVj8INevAe7xYq/UXxZPS9A/9ueB06xNKjpqF7
	 CUUllHEgVSD+SHBdIQmm5uEAc2FS70xoKsrm787KN12c986QHD8n8QeRimL2X1VCpW
	 bs7CpvQkPKoufzhz7Zqh7ZyxN9tEYCT57XU30cauy5F7nDN/+9gyBX8M3S9vj5McCq
	 pCTkL7/e3OFwDPpjywWk1Oib+E4pCuY9h9H0IclDnzHdJinZIdMRfDCgWNRh3jmdp2
	 wCaW9JuUdWbArfxZRYiTAr7sKv5f+ocN7ikyVCwh4nbxyiL6hvAifU5d2l8OJJOMle
	 4CYnMJ72nsEFA==
Date: Mon, 30 Jun 2025 16:36:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Crystal Wood <oss@buserror.net>,
	linux-kernel@vger.kernel.org, Naveen N Rao <naveen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert
 fsl,mpic-msi to YAML
Message-ID: <175131938693.3399448.343722096560779428.robh@kernel.org>
References: <20250611-msipic-yaml-v2-1-f2e174c48802@posteo.net>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611-msipic-yaml-v2-1-f2e174c48802@posteo.net>


On Wed, 11 Jun 2025 11:42:09 +0200, J. Neuschäfer wrote:
> As part of a larger effort to bring various PowerPC-related bindings
> into the YAML world, this patch converts msi-pic.txt to YAML and moves
> it into the bindings/interrupt-controller/ directory. The conversion may
> necessarily be a bit hard to read because the binding is quite verbose.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> Changes in v2:
> - Rebase on v6.16-rc1
> - Address Conor Dooley's review comments:
>   - Add multiline marker (|) to preserve formatting
>   - Split 'reg' list in second example
>   - Rewrite version dependent information as an if/else schema
> 
> Link to v1: https://lore.kernel.org/r/20250403-msipic-yaml-v1-1-f4248475714f@posteo.net
> ---
> ---
>  .../interrupt-controller/fsl,mpic-msi.yaml         | 161 +++++++++++++++++++++
>  .../devicetree/bindings/powerpc/fsl/msi-pic.txt    | 111 --------------
>  2 files changed, 161 insertions(+), 111 deletions(-)
> 

Applied, thanks!


