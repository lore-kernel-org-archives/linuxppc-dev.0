Return-Path: <linuxppc-dev+bounces-20536-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AA9CD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 23:16:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9rqP0lLdz2xqJ;
	Thu, 07 May 2026 09:16:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778109393;
	cv=none; b=O/Ll1ySftj4O7hLg9KNgJEz6vkCzjCJ7Pl4j4mqNSfcdWp2ORLun8ITuZ5oNqusSxeWXh5hWDIV1ixDXz4eVS0kJUmt2IxVkzYJeUzcRWUczlBXvCZBCMRnU2SvdrH58iaJLXIcwBox6WNZ+hQaDDtD+P6HJmj/3bYokGJpkcW5z/pNssl+uRpSfnNnRiYSMLqzk68gbtCp/XmDMj/AcZnj65XMQtSMDy7x+ASAVspiEU+rLdNcm8ol/S7RnHFD+PQPh0EhELXWPzgUrlq82mqgwWKjWzokf7AkBAbZ24HXnhmtINAtj+GEnYF8d3BT6Rn81sNgExInEYosnlGkBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778109393; c=relaxed/relaxed;
	bh=ctmrICSVUtbQrmuJUyc8W5eGsdbCGEEcppWRe17i5Io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLLAdYRjoCsfm2gMuxmHozc7mxBxIwYEzyPK/0A5cWZsra2WFIPwOtagKvBUKuSkOObFfi+T6bzNvrkLRMAEqWjkZ4NmBXtJZ3IVy6yRBn8aRsehFDcsVl6qhVUCriskf+Twl8H7eA1f0rwjmQgw8x7RVytiCVqVkgmsnkne9ZFcne+nyERXYvOyfNSlYL5DC0tkxPogV27rMiJLU5WWWEAfg6zO/3Zho73ZaZON1jCHqZ2zmUuRLPZzMnmTOpdy99LzDu8psfOihqIoxINlu0cBoSebngMjowWUofW8JK1V8JB3VZ7vEIZnvGEKcw26xeTeC8hSRgivDD5rp2+2bA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hw/IU/A2; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hw/IU/A2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9rqN3DlJz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 09:16:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B8FB0409E9;
	Wed,  6 May 2026 23:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB54C2BCB0;
	Wed,  6 May 2026 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778109390;
	bh=ZeQsG/N9Ska5pWnZzaJsL52vXjyhYhU7cDQ4rObifgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hw/IU/A2r4V8y7O6kkV3ePUos8hJlaVcXoR/jiizehDw+u3YVqr9YI78M+6ZcRL5F
	 yA7+iqvXCGAExh1HR+D+I1zzA4cxhIGlYK7KThCpzjSJEw8x2kRcLCF2fUq6ozms5S
	 t8JWyAeoSf1b+um5lyS7G36tLangQZaApZV2havmHEwmbK8Aju/ZE/A4NSHb+Pj9A8
	 AtNGL38evyydlQh6hy+J7KJ94JqzY7+7YVv54Yg6ad593d42wWNpkAGsrjR4WF/fxQ
	 vKXKAmfKPFhkrVwvHyechOoK1IY4EzDaBFN8s16OmoM/5S1pWbB/kUDXtaa4a81i8q
	 PimvG9DWf+GCA==
Date: Wed, 6 May 2026 16:16:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com,
 horms@kernel.org
Subject: Re: [PATCH v2 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in
 uhdlc_memclean
Message-ID: <20260506161629.5488a643@kernel.org>
In-Reply-To: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
References: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 13:15:29 +0200 Holger Brunck wrote:
> When the device is removed all allocated resources should be freed.
> In uhdlc_memclean the netdev transmit queue was already stopped. But at
> this point we may have pending skb in the transmit queue which must be
> freed. Therefore iterate over the tx_skbuff pointers and free all
> pending skb. The issue was discovered by sashiko.

And you tested this how? 

Given the questionable v1 I'm highly hesitant to accept patches
from you if you can't test them.

