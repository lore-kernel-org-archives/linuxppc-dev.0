Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035C606A31D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdZujaRj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDbVy0kMvz2ySk;
	Wed, 28 Oct 2026 03:27:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793118442;
	cv=none; b=AjF1zkN3z1hQHoezFipGpqHCt8BnLPS0CfBtNlLKKaDhKzUH3wEodcYhP4L8uwBI5C1jkCSH89u243PoEpzCPC1AS++/aHE3uqFGmMGPq62+SO9m/4RekkOmNOAQgY82i10MLunKWYOCfz3021tXIoVMS9GeLVWBTdeGabaJ56p7gfqZhhwnNhQimmwgIftK24lfAEtoHACxhkvnsUjOP0s52UL8bxlbNacYRwYHJPS2li1EpVV4VS/7w3NXdy77mZ//WgNm0hWqZuyOgoImiG6Bz6He3dMRYH7vBPwb3QqsWj9dxFmUCeBj5LW7EosiI2fPwtPb2b9vU9lx3x1xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793118442; c=relaxed/relaxed;
	bh=0neYk5YrzikJjtW8ZXq29ALRyYZ/j0M4VHLdoq0EH3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RVbOtOojV7U/QLa9pQTk2QdQ73rc2wsZZYyjmLJ92aVuCGp16WQSoANDKjt40vw2gHIJPEPMmI1MAKc1LrJBjlQKidwQjk0OnfEV3QqUMd5+owQ2lh0MYRyvtvwyJsNCboCFbwFYqsh52Co/fYcDTtV/KSUbc9eUZV8LE5Y/NXfStrfC/bGhDElbx49y7RRGD7S4RB20K+d3EAcPU5W7yWxUtLsCzpbcu5UZ50nY3ro7VDsje3BouyC2wAVol+wW85XofHTvHilSSTd10Uud1OhAL7WY1ZkNxGJqBM8BiHLDK6mnpsEa4zAOE7cZbWe0RE3O6x5SvvOGWbAxPHUKYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdZujaRj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=srs0=bo/y=ir=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdZujaRj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=srs0=bo/y=ir=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDbVx2KySz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 03:27:21 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1E3BF41572;
	Tue, 27 Oct 2026 16:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FC61F01825;
	Tue, 27 Oct 2026 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118439;
	bh=0neYk5YrzikJjtW8ZXq29ALRyYZ/j0M4VHLdoq0EH3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XdZujaRj4O5z8foVBYdwhtk7pEGZ0SMFB+QidK1Qx8Fx7eUnjLyrXUkfs3YwZdzaO
	 AIuoyY9s5ByV8uDtnz7pL0yt75d1psMuK1r3gvEjRULw00dcw5Bi0KxgG6CDv9CdBB
	 lAPO/auka0BC0Rxv+lDjicwtqAAgnrs4SON8K5RRReQDwjB0a9DOdMpkEr4XVnecrE
	 0FsGqAk6tC2ajtJtYA2AjZQusgzf4pIu6xYsZwefsCYs5Pb6NJ/DlFSFOL3wyzzocf
	 I8mFGtPZTDbQabMkM2maMGWem7yM7pHoVHn23lJyF3M51RQyoxq3O6xWInuyCtddK6
	 n4lnbOiCU4W1A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, Zhiqiang.Hou@nxp.com, 
 easwar.hariharan@linux.microsoft.com, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261008173641.199142-1-jeffbarnes@linux.microsoft.com>
References: <20261008173641.199142-1-jeffbarnes@linux.microsoft.com>
Subject: Re: [PATCH v3] Revert "PCI: layerscape: Change default error
 response behavior"
Message-Id: <179311842858.16692.9389173908526877581.b4-ty@b4>
Date: Tue, 27 Oct 2026 21:57:08 +0530
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=350;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=oSZljKFgqNZT5ufuzpZRuVDIEd35DWYMJ1TbziJ9xds=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq4NDgZ5zady26m9K6haj/wBnaklC2m6VON1Uth
 fthEm/97AmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauDQ4AAKCRBVnxHm/pHO
 9Rg0B/0Yp4irU5NLfav7GFd57ZBMTVchSr4AOx/QhQT/NYiTpWZbAXk3PqQ+jiDyz6ve1sACZcb
 FIik6/0SbB2ZHYg1vpCv+QvsGauCZJkRCpE/LgYO1EcILA5JuIH57hoNl7Fs+Mh3H7qMSGv1IsE
 FBhn5M4BFnz87Y882zs/nUXVmlLRc90xr08qKclMYfJzlv0m0l4hrtfdyY5v+Z6E/15HVuKxTNS
 YzwOzzj7rETJVPX04kItadmv6KoQGSfYCZOEF2o5gdlTF/YfQg3cuavMRHDMFxHSa0BWMHTbKtk
 ZlAgEgsj6CoZVQ8ZeG14PtPR9eX2G2DuV6jeEGI+vzN8aHQZ
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 08 Oct 2026 13:36:41 -0400, Jeff Barnes wrote:
> Revert "PCI: layerscape: Change default error response behavior"

Applied, thanks!

[1/1] Revert "PCI: layerscape: Change default error response behavior"
      commit: d981c566d283ca074df2e485078b369cff088349

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



