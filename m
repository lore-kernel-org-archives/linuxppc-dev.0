Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF25606A32C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1IueEKF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVTVp67czz2xN4;
	Thu, 19 Nov 2026 17:45:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795046853;
	cv=none; b=RN5dv8n680rQ9CaRFN+CdgFcdi3x/T5lLjfDftixoN7KJJpG5AzMUpeUxe/MhIeyYNFPmDvRUVdgT7r6sXqoXPGYPexSEd0ifClAtj84F8f9cx2v8borltpXajYVa/B5DENan6N56MPJL/5HzhRXG7i7B7KAGpvhm64LEvOOAHIDTMdnIKHBsdAs/2bno5sY+ePdHiXjlGRvTTevQ9iMhJpcVX+GXG/Z8Sv3fXd5/9UnpapZtAf8JTwad3u+c4Bff33EO8dyv4CnuACOvi3ReTe1q1/6pdcwivaDL8PCas/epKFoxhaGhTuby2H+ayR37QHQEsdNl1kiJf/psjRibA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795046853; c=relaxed/relaxed;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cc+7xvKVPnrlQV6pNxy4+w0I7Vc4yc82ziEQe08ta5BQkWDo6Huj6DCu8uMlZSEd3cLRVrfC2ROtB1jOEtTs+mxMJbUaF6uQqMHIDHmDPq8F29kmUDEoiDPR3sF3Zju6boGAPfQ9kQqgTkyxy+1Apa40ZLnmrY/6zr6ChWRv4dEKJTQbm1JqAFhqvTEO1kuk06mhJZV/gO/EMpXDxH5awt4ptKZ1JxXh5ToHAZZiJw3gCbln5Zjxvb+cCacdck4mrEPQuflfBGwQJJXzajRZftjXTb9JgTLg7HK1HWr43foHWBas4b+jS6V4cgmzxHE/TqGA91FFnRg1WVR7sPzqYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1IueEKF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1IueEKF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=netdev-bot+sinfo@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVJgm1zvmz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:07:32 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 313E16436D;
	Thu, 19 Nov 2026 00:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA71F1F000C4;
	Thu, 19 Nov 2026 00:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046848;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1IueEKFqS5WVceOSa9LS6rT/LJCmRIUnPsdvO/DpUn7u4JQwVYAW3Orq9oTyfX6S
	 zNhd4S/9p+bJfYuW9VBnHrLm0gqJbXfHeimg94SR3cYxLhaNoUCgUTKhemwCbSqn/D
	 DqZhurt+D3naMSZ8Snb8eAlhcneH8nBHXsu4l9xGhGow+f5zVV2IyRdb7c2GhZknBv
	 6IScvzFPXYGzKbtHcosslOtsqIey+a2TDq8Vxaom8TZ8mkdeX5PjZ4tTKv8HotjyXX
	 V+da0tkKmuoFQwZhN38LPV/V4nMQPrOvWiD2zORc4gYwVo1dD8tdQshp1982Qhwthp
	 X8FBjdGHS6s2A==
From: netdev-bot+sinfo@kernel.org
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, horms@kernel.org, davemarq@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next 0/2] ibmveth: two TX and reset fixes
Date: Thu, 19 Nov 2026 00:07:27 +0000
Message-ID: <179504684743.3291.10300720489651147627@kernel.org>
In-Reply-To: <20261119000235.15622-1-mmc@linux.ibm.com>
References: <20261119000235.15622-1-mmc@linux.ibm.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.

