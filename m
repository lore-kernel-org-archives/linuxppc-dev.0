Return-Path: <linuxppc-dev+bounces-19824-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3050F8E4B9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 07:53:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxnFG3w4cz2yh4;
	Fri, 17 Apr 2026 17:53:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776412418;
	cv=none; b=FkOOnVVf/Tm5v/KLqRUQoj27hP+L9m4kWMtQjCZf/T9jd9HMYlPilkUA/paeaO5C+d3rn0bMW4qU5HglmCEQpk77a5GPi2HjRmgmfjudeYiJyUGNllJvzyZi2FlCSHNYX/wNUC+QzmKrTkGopdT2itCkbBXi2gsnH6irBPIV3aOYKAIPgTDG9C75l/z1nCxvq0+D3hyx1vEjwsoeq3DemMO0eX5ctUBGBxeE7buKGrnooF08T/wiPip4w5LuwK4sVMwmbwZfk20f2RGmLgHUZo8XVfdwXKJt/HlbYDqTp4/0uqLbO9UpWyaIixROOYlAh4/3DhO8yK60DSEnYijxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776412418; c=relaxed/relaxed;
	bh=pz6FZPxuCuijA+qSzPYes+1WeFdLFYSCgrGfF1EVjrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfAuFhhRjoap4KL8SmEhH6r28GU4Lfqkvz68D8c2u4KV+Ya199WlJ5rVn6wWhjZPLgCf54EsKESCBeKDZMR17p28bWIXy25SFxtXCr4vpvnzrr6R2lNyqZblzU9qt4kYAwKJbOKrpQ5w0u+uy3+RdTJcSk2TsK/xjr3hRdD6QI8gwaG9MepqURBi+hD4DM4NYGjDCnMJXx9mDTTTRAgdxWbidSz/LkpXcgjNkAcacOMAscj1OAbLYOU8EiSYbxIhgFXrjrH17GWAz60AJcAgZ3kD4hHOQFZmk5cx5j6LFOCqipcvUKZ+ztLqwI9XHeZAP4x4KPaeAOLfyK1v7Eefxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jmd0TAEB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jmd0TAEB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxnFF61yPz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 17:53:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DAC6960128;
	Fri, 17 Apr 2026 07:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B01C2BCB4;
	Fri, 17 Apr 2026 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776412414;
	bh=WYFBone+RdKeGJANQB5WksvtqaVQPIIUpwB7FrTJxLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jmd0TAEBDIPG0Wdexll4igX5vJLTTiFEO2Vzr1ZATAQqRdKR7yCGN9dqo3BiyJ7yv
	 6F8Al4rVG+yKRdXCrVAYTdpRRnrt4ZOmkd6sOf4LRJc5nbBxTaGtAnExo0XW8fX/LI
	 lA93sJzFI4wCUpfbuUqJlxbSrBH6F0TVxM19wu2JvwQUwTAibpvB2mYK0CbcnoqcXO
	 CfPZtOkY9pc/4UorT96so1Y5/txDF9xe+dB9RT9A1d3mrtYGz3s/QtHCyN+TW4/WEu
	 RSRnz9qk7dZ6w7mfxbro0ILPDO9ysqWv3YajgzCd7qyU1iYBKzY2b7/5MD0d00HaxA
	 CYBiz5uqIqD5w==
Message-ID: <c9c667ef-40d4-47fa-a3b8-591d2d3a7a2c@kernel.org>
Date: Fri, 17 Apr 2026 09:53:28 +0200
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
Subject: Re: [PATCH] powerpc/fadump: reject empty bootargs_append writes
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/04/2026 à 09:39, Pengpeng Hou a écrit :
> bootargs_append_store() indexes params[count - 1] when stripping a
> trailing newline from the sysfs write buffer.
> 
> kernfs passes zero-length writes through to the store callback, so an
> empty write makes that newline check read before the start of params.
> 
> Reject empty writes before looking at the last input byte.
> 
> Fixes: 683eab94da75 ("powerpc/fadump: setup additional parameters for dump capture kernel")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   arch/powerpc/kernel/fadump.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 4ebc333dd786..03ab5565e420 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1479,6 +1479,9 @@ static ssize_t bootargs_append_store(struct kobject *kobj,
>   	if (!fw_dump.fadump_enabled || fw_dump.dump_active)
>   		return -EPERM;
>   
> +	if (!count)
> +		return -EINVAL;

Why return an error ? A 0 size write is a valid write, it should return 
0 I think.

> +
>   	if (count >= COMMAND_LINE_SIZE)
>   		return -EINVAL;
>   


