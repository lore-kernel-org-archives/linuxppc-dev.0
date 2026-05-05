Return-Path: <linuxppc-dev+bounces-20445-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C89EFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 08:37:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8sMt0K8fz2xMV;
	Tue, 05 May 2026 18:37:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777970265;
	cv=none; b=dfg1mlmtakiK+0f769/rkSlINE0YB6Z0Deu9Y300UXj+E4jjN3so/4f8GPx05Bca8PGIJLhQKvWy1k9r5RHuOeSrbviUbHiDofRLnnXnmkmV2++sp6j2k5g4O5mDD6UPsp68YD7XsDpTKttchZMBTehPGh2QQn6wQCzMI9k8BE51ibWeJw12uquz9/pG40oDOs3kVq3W/AB6oRosgWx7ChK/yF0HAzrDBGXEoR44thohxnkrWzGwMrDbLvxwFl4H1aA8pmdLQ78E3UgNJ9B6aIETDzu2gk1Gm75SCC8dgDlHgnRX+7q3irWGsAS8Gz3ZkdUQz83D4PD5V3kskAwNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777970265; c=relaxed/relaxed;
	bh=U39QDvsdqpFUJ94r90OiDgn9uEHoRdXlihaDUDgf2Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDIaKg2e/4KLmmzvo0NR+XehsJRS0PjZc5zGOs908y/NLHOqmAYlG677YpuXjLRg28l7brKv6sey6JBfJTaj/TT3ouxTKqexLDVqJRkzYFVZbfY+4ObC5G0NMQR380wusW5vc+P8sNBsKpMdtdGsqH6+J04/wz8bPjIrPnIxYsrikhdKI0A468p8KMTzFi9AJJygM1Zp6Tbt5hUDPdbfqe3AUtHWiXqj8SnKVdpIySV/pf/W7q27y2Fk0b7TcHQiqgCj6Nv09aJqgVXj7VlOa1Kl/y74q5Xk2jZNFK3uDc6xcbdfKbz8tvyFyzOs32DGs4VpFhOt8tlv29fM4o+qMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iCV7vR2c; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iCV7vR2c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8sMs1rMsz2xGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 18:37:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4437D60125;
	Tue,  5 May 2026 08:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9BAC2BCB4;
	Tue,  5 May 2026 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777970262;
	bh=NS61ymXjH9xBfF5IZxd3ftaRRRX71RParCmS0BZYtXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iCV7vR2choTu6H41DcoJAYRkak3WtZ4NQBGEl4AM6Ig7NnHKeWryi3kDWOj9smV6O
	 +x03XfFmHOpQNxk83qO29pZ0NPGg6EuLs+ncT5GM6536aq/K2UNapGoM+0THYrtQvT
	 kbvoX79IYWghR6G8sUDJV/ZyYVZx5C15Jy5CdzQ5irZ+lUF/orE9SR5BvIY19w0cNf
	 ti2t1GFv4WM+8LfM3xD+t4csnEmCantpan4yXhBMAEdtWOkbaW9Ddw/vzhtDI/uL4T
	 oXv+VhuJwYYVbCJh8ZHWa/DEDj8CdXjxZuYJJRJFAZUtunerbAOMxXiam5ynV7z5UW
	 qQedMgdt03Odw==
Message-ID: <07fc37e5-7815-48ed-8632-62e896f8f6ad@kernel.org>
Date: Tue, 5 May 2026 10:37:30 +0200
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
Subject: Re: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
To: Holger Brunck <holger.brunck@hitachienergy.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "qiang.zhao@nxp.com" <qiang.zhao@nxp.com>,
 "horms@kernel.org" <horms@kernel.org>
References: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
 <d6957853-9d24-4f35-8ea7-ef4376de991e@kernel.org>
 <AM0PR06MB10396920527D0B69CC9D9BDFEF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <AM0PR06MB10396920527D0B69CC9D9BDFEF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/05/2026 à 10:14, Holger Brunck a écrit :
>>
>> Le 04/05/2026 à 17:56, Holger Brunck a écrit :
>>> If dma_rmb is used it has to be done after reading bd_status and
>>> checking if R_E_S is zero. Therefore we need to move it into the while loop.
>>
>> Can you give more details ? Why does dma_rmb() has to be done after reading
>> bd_status and checking if R_E_S is zero ?
>>
> 
> when R_E_S is zero in the status of the buffer descriptor it means the buffer is
> filled with data from the device.  Now the CPU owns the descriptor. Now we
> should execute the dma_rmb to be sure that we read the data correctly.
> And this we need to redo for each buffer descriptor which is filled with data,
> that’s why it must be done within the for loop and not before and after.

We enter hdlc_rx_done() after an interrupt which triggers scheduling of 
ucc_hdlc_poll(). I think dma_rmb() is needed _before_ reading the first 
status, otherwise it might read an erroneous status.

Once we are here the interrupt has been cleared so any new buffer will 
trigger a new interrupt and call again this function. Therefore I don't 
think it is worth the cost of a dma_rmb() inside the loop.

Christophe

