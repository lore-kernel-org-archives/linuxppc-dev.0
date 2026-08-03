Return-Path: <linuxppc-dev+bounces-25252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60FAC55184
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 09:14:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD9wp0TFSz308X;
	Mon, 03 Aug 2026 19:14:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785748474;
	cv=none; b=bHDP51/VOBOlQ9yniMOtxpeXRTchM7CYKV0KCr63ZVFSEjrc/AIkcgfkQLzmgOzwikVz3L17rW6YYZ6nHbXKslcGIyMU5M3BdAoivJ7BtH76l9dvjR6rtG6GeIY0El/how1Th+51Pf0fvLIJfRj8/RNY1dA/U1FWLKEzR67aLk1FkhYoxGsttVqMscMdqGpKkKCUdtrZjfq0wSH7B80lInVSt1Mjk5MDMyDy5ZC/TjdAZWEchRszipYrhkhsmrJxwv1DhM1hZMZhIerr3ZLcIsFEamhQvRxV5vgRi9hmQn7gTZMSHxjyjAIs9DQBe1yke00c8JIigbkosdlPOvYiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785748474; c=relaxed/relaxed;
	bh=42FwwZaKUOqMneYEcznplotbPPKi+7qnPfiGOsEJRTU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LFbup2kT/pKFuSi9513uh19iOIp/B9zrY1TomnsbjEpi8Ly5vT4Nw5LDBPTPwn1PTEUtdXMbD3FlJ5NKRLV8U7wsLfsJ8nL0+LuMAenJip/BXNZfJZd5KgpeW87Zjn8ityFUEDd2gTNOSOZLeWPbKMyHhACIfvY9hxAa9iAeC1iRS/ghjM4Pk8Tj+JRaoLCMrxd6Bq6z+Utj5pgBSGqyWoca9Ns3qePw4biZVGoliB5k1Goh4o/oPo6G/HVS9c1YYGnX5wkEfqeXbG+//ne4w+68sCFeRdkAbwW6ifZec26CPTSKfa21PQ2sPVUj7c16LZ3h4vYe6ixzvYwUj0Ptug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=YH0qk0HT; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wbt7D3Td; dkim-atps=neutral; spf=pass (client-ip=103.168.172.157; helo=fhigh-a6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=YH0qk0HT;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wbt7D3Td;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.157; helo=fhigh-a6-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD9wm5JSBz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 19:14:32 +1000 (AEST)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD39214000EE;
	Mon,  3 Aug 2026 05:14:29 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 03 Aug 2026 05:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785748469;
	 x=1785834869; bh=42FwwZaKUOqMneYEcznplotbPPKi+7qnPfiGOsEJRTU=; b=
	YH0qk0HTR0cy4SGIn/8fZV0xCuyX+ptl6M4RiLy5N6DlB3+i5/X6UFGBwUN7vfHx
	lEREA6cE/Qow48BLCUk17Hbe+vb0XhnJqirLV34fQGoZC7Y1JAA085yX4P3Gt3l3
	VPuxGEnBPRCWWGaA5vCkgOlgWgdv6fLm/PDidXy2sKeGAsA5qoeYMktCoWocih2E
	FzQTDIfOfw8FNxFzS91oBliZlHnj7JqLGL4VZ0IC6YlY26I868QoZU3yOVGu19X6
	R0gBRN57fIps1X34gO8lHiyOpZ4HLJsJO1dnLTpDhJ1rUZ1j/lfgkFWNntAO+MFB
	V439V4VPunHrpZmH7RaDOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785748469; x=
	1785834869; bh=42FwwZaKUOqMneYEcznplotbPPKi+7qnPfiGOsEJRTU=; b=W
	bt7D3TdTgSI9gYayanuSa0inaCdLLbrdstOHdeeXU1I3JUem6HO7kMHNlqFHTCtB
	P204oFDaHuqrO86sap9ejvDkcfhMzIYD7bP9oIIsJDhbu0/E58H7qMaUDyNw29uR
	tCWxOc9DfiKS2bv1we7OUSRKDCLM5VYsD0c8/6NbxDF8YUaRpOyx+UT9lj4HHLQ4
	REtoRqn0fqvivpeLPUEiDGQ+jx+oIpSO/QSyCHhWl4eE3jUvIBvrbVhMD8vMiaHT
	8AGXBMwoXWPd9SsFTkjI0pyXDjEMbvpom9H6oe1Li7EuvnW50MB9CHAd5HfeYHUu
	WotA4++cTp87OJfu3ydLA==
X-ME-Sender: <xms:71twaiGw56yHzu3jlfSbzVgQXXrmvwrMrUeQjJjJfqFJQGQMmJ6_UA>
    <xme:71twauJ33p5ruFDrJ2BMTDTMEj3B3EgUfj06EPlp5L0hPHcmJe5WT6TTpM1yhbK1i
    ymawOLqCkw4j_b5Nh7pm93jDd0--exCyYYpMDmoNl_mVG45oXQaKX0>
X-ME-Proxy-Cause: dmFkZTEXEEIJmt0IWo/xvzE6j162pjnbLuyCS/iwXM1for27p0OU202vUASDxfJRL0oal0
    WXlIxEgQonfee0FZTqNys/zz5hrUWqTu/Hx11tdS9S0uhDy8KXXpnQaCdYl7G0rNmDpCJS
    A/ShhWHKmoRVRBzgHLEhAtNvrrjzf7DTmoNc/FQJZ4tklttrCKPDOQoGT6JUO++W3jOk3T
    HnIDsGPWE6XDt1yLEAPS92JKgLMUH2VqdSsv23/yQ0kv2uIYWN6rOdzaL+OD/I2iXlgFD1
    knef6lFRkuDd5KnDZWJdZ6gmromHlGO+o21PRTKqOdA0O3vwAEBHLxmd3169TIQhmT5LbD
    e4hJ28CiB0t6mposBBz7SYxkYwl/S9lGd1Sgh8C56aMMf+BTWctQ4sXpCU9QNwW/JY0qe/
    g84PEa7/5CtViho11jHY7TbYXLU1hXiakAAqno/seOTzufzeKRkMmiywBs75Yr1i5ILkmH
    ntmdIvVSPoGqJYlazDIdXGUeCIVCapvxK+HLQvu1OCdKK96tRx8yq001WiC+96DsCh92/i
    ZEzBRRmH+p4q6GB7xKKcRa2OF5sjEqUAMqXN2o1eQSq8cnfbSwmSDizAtsDUf9smnvGoDn
    nmmjvcyqrQ99U63C8VpccItiDuTKx0R4RLvSpB/sWKe/4yS+Nx1pSA/NMXpg
X-ME-Proxy: <xmx:8ltwap3t4qfi_rwKfFWM9BDq92PzDuf5stKbaUc8U6qeYwiE2LLnKQ>
    <xmx:8ltwamnZQ_VzslSf38jVND1UjgsLIFiPzrUnZN9GsTmT48Nlc5zq8Q>
    <xmx:8ltwan7y7XZexcormtDJRUGybuj6jKvEIPauLgy7NbGmn0eO065TTQ>
    <xmx:8ltwapm__0jtE4QFdqR03wp1lKVNN5hqRdqZwfGj_IAA4mUlnInW_w>
    <xmx:9VtwahgJAt4UkKZF-GaAB3w3W9VhQuBVs6ojmUgHTmCR3RMalCNRYYrL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5530D32A0060; Mon,  3 Aug 2026 05:14:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: AECrrmVH7FkB
Date: Mon, 03 Aug 2026 11:14:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: moonafterrain@outlook.com, "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Mackerras" <paulus@ozlabs.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Yuhao Jiang" <danisjiang@gmail.com>, stable@vger.kernel.org
Message-Id: <073a9c41-4545-4bf6-aeb2-1dadf3c222df@app.fastmail.com>
In-Reply-To: <20260802-fixes-v1-3-7368423440f4@outlook.com>
References: <20260802-fixes-v1-0-7368423440f4@outlook.com>
 <20260802-fixes-v1-3-7368423440f4@outlook.com>
Subject: Re: [PATCH 3/6] powerpc/spufs: bound NPC against local store size
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Aug 2, 2026, at 17:51, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
>
> spu_process_callback() masks the low bits of the NPC register and uses
> the result as an offset into the SPU local store: `ls_pointer = in_be32(ls
> + npc)`. The following guard validates ls_pointer against LS_SIZE, but npc
> itself is never bounds-checked.
>
> Fix by rejecting npc greater than LS_SIZE - sizeof(ls_pointer) before the
> read, mirroring the adjacent ls_pointer guard and returning the same
> -EFAULT.

This one seems wrong: npc is a hardware register value that can't
go out of range, unlike the ls_pointer value. I don't think there
is any use for the check.

     Arnd

