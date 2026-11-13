Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523AA60A3813
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Y27pSlBF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR2zH67YTz2xM9;
	Sat, 14 Nov 2026 03:39:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.27.42.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794587979;
	cv=none; b=NXklqydwYmazMoGZq0njl2iKY4eBjcMhpbaZcaKojxFCuDVWrdnuZ9rXpS8CDuRFDqBDj38ermab2LoWIWzYKRjwCrdtYYVoVm13hXN2Uw+jv0N60uPDMF0G2jS4xTzSvRmf8yPJNjJASecz2eIdfJtahf0IPapwJMSBAqQkDmPq1Z7mgXSDpXlhP/JCePfO1Uvd3XJFwcSrvXeJaf8RAY13lSit2sHHQc2zoCudVHXkvgYk1fAJ23mGn3c4CSX0ltSXB5jmdXX1cohxUGrtMTSQnMGRDpvc5UcBCeQygcg6etvjMHeZ3oEm8PDsi/rqKiQWLlAsJUm/ykHoDecRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794587979; c=relaxed/relaxed;
	bh=ZIaozk2aBHaH1oFJEjjG6pq54xGfHGZXMiLG49FuxWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM4QV/KkmoCuJXZHKpgooO5aKd3Eg/Vi3lJyCd6bCtc2DAC+qKHTAj+PH/kQRUtBfGnfLyrir/kCB/krAWbcoVrf+GluSnHZDRrnNuzTnV6lh4KzdOduk3OGQa8L+XdLLiAzEAeb4wXxgZY1DnyJoizAAf3gZ+HfelsO6DMRWLUH2qjYK/l6B6QUx2A5tkv1WK0bPfSoEnZm1/unB4RYh6MctrlaGnvgXnZ5SyShrvpIJNhk9IvN05Bn9yRPCzQW0rJATNeB5yGns2IE/44ZlQUGjzyDVYKYABG/kh0vJwGqkHDO27jG82wgaIwoBEonexYkXa4Vfj5ZcP6bbMvPPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Y27pSlBF; dkim-atps=neutral; spf=pass (client-ip=212.27.42.3; helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Y27pSlBF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=212.27.42.3; helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR2zF1XsRz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 03:39:35 +1100 (AEDT)
Received: from L30177.local (unknown [158.255.110.170])
	(Authenticated sender: vjardin@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id ECC3913F8AE;
	Fri, 13 Nov 2026 17:39:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1794587970;
	bh=Nq5VMxuAxZkNVKKpbGt5VbkTDNOsTH++OiONsbi9n9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y27pSlBF6JC60hVZAj8IPVqa48C/9DgkKqOkQDESe2muCIMq1QiH0t2hpY74zGNor
	 OtZzOAz4r2ULrN4s+CBzg/XtDOlc9O89iXA+G0s6SUgY7mlQnzDErXQV+ELA5RNaVW
	 PK2PDB4K43IBDzZj9SO+65cyDlC491QsHI1NYeRwF/XtNGdaiyb8ChPIcKkIUVC2In
	 dvO1b1pdQocvaDngZ6qUQv0TZJtqExY4YIAmBF+5gHhlvome38PHRk5sKV9ag8cLbe
	 xkXCmw2A00qeLS/JkZrIUoxtz0CyY8rdsqNrklwxDAO/6T8FiPaISATPfhBBiQvTEd
	 tKScOcofIrrdA==
Date: Fri, 13 Nov 2026 17:39:05 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Christophe Leroy <chleroy@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 3/5] soc: fsl: guts: add the RCW override of any RCWSR
Message-ID: <avc9KbxQ4dxlibGQ@L30177.local>
References: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
 <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-3-5a0063f1da9e@free.fr>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-3-5a0063f1da9e@free.fr>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christophe, or Vladimir,

Le 08/11/26 11:06, Vincent Jardin via B4 Relay a écrit :
> From: Vincent Jardin <vjardin@free.fr>
> 
> fsl_guts_rcw_rmw() only serves the SerDes lane modes. Export it for
> other fields of the RCW:
>  - fsl_guts_rcw_read() reads a status register
>  - fsl_guts_rcw_override() changes fields of one under rcwcr_lock and
>    waits for the status register to follow
>  - fsl_guts_rcw_override_supported() tells whether the DCSR view of DCFG,
>    which holds the override registers, is mapped

May I ask for your advise on this topic ?

I am looking for the review of this serie, then I'll adapt it
for u-boot along with the integration of Linux.

thank you,
  Vincent

