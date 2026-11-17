Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4E0606A33B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbPCRoQE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTfV44wYYz2xnh;
	Wed, 18 Nov 2026 09:26:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794954412;
	cv=none; b=WWLqOXZKG1FhJQTW38LXVqRJJwwIcdQ79TR7yjoMfT8HQrGnHf/4/iEiQnLe3lRUDIIyrJjAwdH26Rsfj2OrPG3XK9LMswV1ik5Fz0xNmBHVg38IevhxEKLxpB+jXZ5gYh9nvSSmczL/Js54hugXXAf65QsX7jygm2aw9miX/8u7/wOcTDnmyVHJBJjfzoIXxRv7lCvymIOhGsU3pahWrgcjQvB3vasdwW2u29DlMcruTAuGPsdest/NAbVRF5bnlcnZojSx2HHHItH7N58AX+Xdq/HfmB1uy2D9cFra80FvVI4j+fIccHZ03eagczPJ5cyOP6O320jELOcmv91QRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794954412; c=relaxed/relaxed;
	bh=4s3mRwUX6ILMJnNwIdnhxtjyTyFSrX3O/LnhuPICPo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VThDBcO6POpwsjt8w+Fd8onbwSg6v0peWvsk3iFKOwHqgIAD+MI7FmI/MagTTl9rTGIdcwdmYJZwo+S2aSAKkxe1+caIcZIMaBBy+qWi6q15onlUBtj8c15qr2gLC/L4tSWtmwkOaJLoaLnb8DuIGTNVhqs96UNX2IOfGHQ5jWHH3zSKBDLx3nudZTp+zvCvOi8w6f5Zbm42s0KWpbKbDDAVUaU8lpzWGRFZaQHS9ThruNkHSfVABJLaYon6BSCTbS57GaxWMhdUZTDIzTgFqsAjwgBZXulo/+VPwqNb3LUprqd9nzwe1VoEm0RmMO585sjP6/eaxVE2sbbBVrCtZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbPCRoQE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbPCRoQE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTfV35ZD0z2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 09:26:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7152640B91;
	Tue, 17 Nov 2026 22:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC151F000C4;
	Tue, 17 Nov 2026 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794954408;
	bh=4s3mRwUX6ILMJnNwIdnhxtjyTyFSrX3O/LnhuPICPo8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nbPCRoQE3o89KlLREqLTWYyUtsNPEovbGEBCvg9Bs5W+CQn+EDoSd4kW6CqQ6noPn
	 fij8XDQ78Aiz1EQNF/Hnm/KK6k1ivKx51Rs40LhTRyKdis/NA0QALWgxa1jEn7XRrO
	 WqI2TGo5r17KymhUe132c+/rkmGIwK7In96jrBpnei3XIdW2MCH3wwmhw63UR7WLv2
	 yVsOlDs+YPNQvWkY+UMnWYyMYjKrrDoAr11HslTU11tjeKxn6U3EieqogoqSJvWMXD
	 N84lCTVVRl/84g9ywTc6nzbFoO5ebOnayr+Ug7EKMg8ituJcg7A6tTW+g5Zi7FTqZK
	 GrJXO1eClwF3Q==
Message-ID: <44bb9bd5-42f5-46d2-8dca-dd220aa221cb@kernel.org>
Date: Tue, 17 Nov 2026 23:26:38 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] soc: fsl: guts: add the RCW override of the pad
 muxes
To: Vladimir Oltean <vladimir.oltean@nxp.com>, vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-3-5d7201970629@free.fr>
 <20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-3-5d7201970629@free.fr>
 <avzCrmvlOQh0RVjT@lxl00025.wbi.nxp.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <avzCrmvlOQh0RVjT@lxl00025.wbi.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 17/11/2026 à 22:10, Vladimir Oltean a écrit :
> On Tue, Nov 17, 2026 at 03:53:13PM +0100, Vincent Jardin via B4 Relay wrote:
>> From: Vincent Jardin <vjardin@free.fr>
>>
>> fsl_guts_rcw_rmw() only serves the SerDes lane modes. Export it for
>> the pad-mux fields of the RCW, and for them only:
>>   - fsl_guts_pmux_read() reads the pad-mux fields of a status register
>>   - fsl_guts_pmux_override() changes pad-mux fields of one under
>>     rcwcr_lock and waits for the status register to follow
>>   - fsl_guts_pmux_override_supported() tells whether the SoC has pad-mux
>>     fields and whether the DCSR view of DCFG, which holds the override
>>     registers, is mapped
>>
>> Each SoC lists in its fsl_soc_data the fields that can be overridden,
>> per RCWSR: a register or a field outside of this list is refused, so
>> the SerDes protocols stay with fsl_guts_lane_set_mode(). The LX2160A
>> lists the pad muxes of RCWSR12 to RCWSR14 and of RCWSR27.
>>
>> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Acked-by: Frank Li <Frank.li@nxp.com>
>> Signed-off-by: Vincent Jardin <vjardin@free.fr>
>> ---
> 
> Looks good, thanks.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



