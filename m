Return-Path: <linuxppc-dev+bounces-29088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CD0CA6012
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 09:21:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1Lw36mx3z2y8r;
	Fri, 09 Oct 2026 20:21:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791537699;
	cv=none; b=bDphvb89Oa2d34mehcH1tlPpLAJAx5qR9zm14Gh0JkV2s6m8a/juFBBayZWPqVQXKsfDUooVx2yd2YUreH3pB3/FBvItVAgFocV/O1Hfr3Z/G8v8Q/YhDw19e8zdth5IkSkRatVbUNZXQJ2RYsJY0Izy3b4tgcBex1iSz/Q2G+tZKDmfMijiNNZnUOKc6XRd/L3vVnfVi8XKJH2hE+Eh7eQ7RKb8UC8TeQjSewBBZmZz+H9KfAePAqBUUjKp/w6n9cvsCR1rN87c2+5hQ1lTi2Np7ER62L7pAWdz9yBC93CZD4xqftbHhkM9aTZp4Wu+pmz6tOKI8dIcojFA+hBMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791537699; c=relaxed/relaxed;
	bh=Vws84NjI9YU3PfHgWhqUoHAjWKtOzUf6T7B9xfFXSa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0fnv5xWo0av09Fv8UoA+bwu3Vmvrhx/FhwUwjl7F6mqGgA/o1pdmTWziN9zC53lUUoCKv7XQMpYzxl+Xcg1F5q5VcHn1JEScQ12DtnNsk0PEe6dDyHh+gF/xkYQUHCUHGpukweCPnVwJjZjd3lZSNmHjQN52XQzymdit59G4KayctoQykGzGMYe7zibE2MGNayIkIrTdlgIxOznIcwXbRjNcksFeUNx88F28xsD2UDqEIUiCNnLx7pBQrSdmJ/lKUawVdSDJA37HpvopQ7/zGEoVUvRuuizmZdwQu8BEZ8ethIYeZ4nYE8TNrXPFPAydWZr/dIilgIT8nX8As2VWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmjjlH79; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmjjlH79;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1Lw31XPfz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 20:21:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 088BD43A55;
	Fri,  9 Oct 2026 09:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26D11F000FF;
	Fri,  9 Oct 2026 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791537695;
	bh=Vws84NjI9YU3PfHgWhqUoHAjWKtOzUf6T7B9xfFXSa0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VmjjlH79aGdW/QsxmVmMophRu8dXXy5qUwV/UWL4IhZDy0sFybByXQaexVjvCWhz3
	 4TkutIudGao6zk1wu6+qYg1d//QbKhzX4CgVqDDKR/S1K/uvNH46g8w8ucNnYqCW9A
	 wH71p7Wj4uzA7ZRbbjwUUs82FhkEdjwti3kmJ120JfhwGqYHN6zK6GkZKo+45q5XrU
	 3m35tmeTrof3Xg0VeNj3ebnvG0GEGU+4c/6nXToGK463X6e3nLuYvieNTtkt+zkO0b
	 OwHfHIXX8pwzT33pYLTF9nkAWykVLsTGtg4EloI+u0rFgakcQZ9Blfx90AB+aR/KcB
	 c4YBf0Wu/bZcg==
Message-ID: <c8e47d1d-1487-4f51-a858-cb66b5f8c808@kernel.org>
Date: Fri, 9 Oct 2026 11:21:29 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: cpm1: tsa: Fix clock leak in
 tsa_of_parse_tdms()
To: broonie@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: herve.codina@bootlin.com, leoyang.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, qiang.zhao@nxp.com, stable@vger.kernel.org
References: <20260917152719.2160395-1-vulab@iscas.ac.cn>
 <178972077003.546774.17878987805855996127.b4-ty@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <178972077003.546774.17878987805855996127.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/09/2026 à 10:39, Christophe Leroy (CS GROUP) a écrit :
> 
> On Thu, 17 Sep 2026 15:27:19 +0000, Wentao Liang wrote:
>> The error cleanup loop puts l1rsync_clk and l1rclk_clk a second time
>> and never puts l1tsync_clk or l1tclk_clk, because the branches that
>> guard the transmit clocks use the receive clock field names.
>>
>> Use the matching field in each branch so every clock acquired by
>> tsa_of_parse_tdms() is released exactly once.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] soc: fsl: cpm1: tsa: Fix clock leak in tsa_of_parse_tdms()
>        commit: 7b3b0598c00e67f2df85d0b4cd99eaa3be6c9bfd
> 
> Best regards,

For your information, I folded in this patch a similar fix to 
tsa_remove() function.

Christophe

