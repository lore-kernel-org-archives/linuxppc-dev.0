Return-Path: <linuxppc-dev+bounces-21169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0830CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 14:54:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKd4c2PV0z2yS0;
	Wed, 20 May 2026 00:54:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779202496;
	cv=none; b=hN75cixuDAfbZorWPmY5qt55gn5IovF0Ots3z8WfQyxnDgml0URDRz+dGt38NSVHi12Z7K6Sc9QYi8W99PU0ui1fMZkbRe1dZ9sAZBrqV8+BqwKmRnUep2JuQYNabIksV4r5DiYQ2sJrWvNDPSpggzhSidi6zKI0EsW3mP3xfvnS4FPXgcstTMdG9svEHlwzhBkrCPONQZ5YMbv9yCSBMm3gxvyGj9bP3ObYm4WHEMgjTuklbJYnMP7p7ujG/ONtQr6K8JhvJ3KqQTY+BlPl6odsKv+Kic1F90VO/8I88flsVry/ZKeKMOWN5pKaZkBb35HUaSOe5hm5nLacGn24bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779202496; c=relaxed/relaxed;
	bh=jXXCHnnXm6J+7IdVEF67li849mIRrrMUbIp+mCicGjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UifPT7HrmjrXa48bc/61FzXyPD7Qg2jJzy2PFJ7F4tv8J+cji7GSRuhjz5KNE0CV5DJKy7nlTHoggI596nasXzbnMoW9yMlhPCc2v+ftAvAZGaEFs/kB8Q+WOPoK89TOZXMrIT8MT7mYy4v+fQePYIgCuxH24bPqN/BI9/YZFpBqDmNvJGP++PatAkcGg6Q+3He1yGleX4hFuaAybrNJQIbwpb5mMtyijxYNvjucdCny1toMSkO7xuBonG6E2YtH9pzgH7bUA1gS7ox5mC2CRaeX8/zptfjR0gweKdQkEMnE4eaNYYpdPNxP5j950BCdDZAaM87K/1A7uiYBR5Yhvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eonNaHjg; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eonNaHjg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKd4Z1y76z2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 00:54:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 29A5860126;
	Tue, 19 May 2026 14:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA54C2BCB3;
	Tue, 19 May 2026 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779202491;
	bh=UC51TFFAdYAAEu3Hn1AG/aOnKPwgH/g/o3sh2GAq0HA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eonNaHjgLxe9B7jJYmeAsLPwIsWasueEug+6sELaPW6zhqCBLKCVV0eXFoe5YqR/1
	 S8bKD+SEITM0ZovBZW83+t7ypM3/0bjK1YzUjckPvv6g5Kdkmpcd6F2rAwUS7oEgNw
	 0kq4U3FeqHKd2W/uPZnkkMGekIuuSoakXy+iDUcby8YgheVKxHyrVDAzj2DEu552s9
	 NYwahujt0vth4USrNPOpkPip6bcEeKyVlm1Lo7eE96penUWhmF8uZW0o+BdWceb0sn
	 V9q+MgwaQynubQNmFwKwcPDI8qJpxB5heitif+1RJfxLJS2ZJ3mpkvmuu2wVKeWzqw
	 riPzTDUCCAeuw==
Message-ID: <eb236109-1284-43ad-bd0f-1a39765fa30f@kernel.org>
Date: Tue, 19 May 2026 16:54:31 +0200
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
Subject: Re: crypto/ahash.c:1073:1: warning: the frame size of 1040 bytes is
 larger than 1024 bytes
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 kernel test robot <lkp@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, wireguard@lists.zx2c4.com
References: <202605100125.l4JVHppO-lkp@intel.com>
 <CAMuHMdXPeUnjN__PvY+HQg+cSxKe-RLnyT-A5KGe=4cmjnUNbg@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAMuHMdXPeUnjN__PvY+HQg+cSxKe-RLnyT-A5KGe=4cmjnUNbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/05/2026 à 08:42, Geert Uytterhoeven a écrit :
> On Sat, 9 May 2026 at 19:07, kernel test robot <lkp@intel.com> wrote:
>> FYI, the error/warning still remains.
>>
>> tree:   https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cb57c2e1952ea48b306d508deaf28809f%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639140785686768547%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=MBIlFF0TKur9ZxxdvLflUjFXN8BiEIWx%2FW2eO2rQteM%3D&reserved=0 master
>> head:   ec89572766744e844df24c27d31c97b4c00f4e07
>> commit: 9d9b193ed73a65ec47cf1fd39925b09da8216461 crypto: hash - Increase HASH_MAX_DESCSIZE for hmac(sha3-224-s390)
>> date:   9 months ago
>> config: mips-eyeq5_defconfig (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20260510%2F202605100125.l4JVHppO-lkp%40intel.com%2Fconfig&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cb57c2e1952ea48b306d508deaf28809f%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639140785686802803%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=9mLXlRz5JrVhRQ0Ft4c3tQJGrDtlSSmYmd7vZ4pneYc%3D&reserved=0)
>> compiler: mips64-linux-gcc (GCC) 15.2.0
>> reproduce (this is a W=1 build): (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdownload.01.org%2F0day-ci%2Farchive%2F20260510%2F202605100125.l4JVHppO-lkp%40intel.com%2Freproduce&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cb57c2e1952ea48b306d508deaf28809f%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639140785686823501%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=NNAWk0DHq2gD1%2FToE%2FXk75Mz3sKpppwVkpkDG6amzD0%3D&reserved=0)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Fixes: 9d9b193ed73a ("crypto: hash - Increase HASH_MAX_DESCSIZE for hmac(sha3-224-s390)")
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202605100125.l4JVHppO-lkp%40intel.com%2F&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7Cb57c2e1952ea48b306d508deaf28809f%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639140785686842796%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=2M0BnhyxISt3rrzxPXkX4p%2Ba1bIVz%2FhjwSNokIVueuE%3D&reserved=0
>>
>> All warnings (new ones prefixed by >>):
>>
>>     crypto/ahash.c: In function 'crypto_hash_digest':
>>>> crypto/ahash.c:1073:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>      1073 | }
>>           | ^
> 
> This is one of the few defconfigs that still use CONFIG_FRAME_WARN=1024.
> The default value for 32-bit systems was lifted from 1024 to 1280 in
> commit 32115734c0ed8b46 ("Increase the default 32-bit build frame size
> warning limit to 1280 bytes") in v6.18, so perhaps the downgrade to
> 1024 should be dropped from the following defconfigs:
> 
> $ git grep CONFIG_FRAME_WARN=1024
> arch/mips/configs/eyeq5_defconfig:CONFIG_FRAME_WARN=1024
> arch/mips/configs/eyeq6_defconfig:CONFIG_FRAME_WARN=1024
> arch/mips/configs/eyeq6lplus_defconfig:CONFIG_FRAME_WARN=1024
> arch/mips/configs/lemote2f_defconfig:CONFIG_FRAME_WARN=1024
> arch/mips/configs/loongson2k_defconfig:CONFIG_FRAME_WARN=1024
> arch/powerpc/configs/fsl-emb-nonhw.config:CONFIG_FRAME_WARN=1024

I agree for that one, lets drop the downgrade, don't know why it was 
added at the first place as it was the default, most likely someone 
didn't use make savedefconfig

So feel from to drop that in a treewide cleanup with my Acked-by: 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> tools/testing/selftests/wireguard/qemu/arch/arm.config:CONFIG_FRAME_WARN=1024
> tools/testing/selftests/wireguard/qemu/arch/armeb.config:CONFIG_FRAME_WARN=1024
> tools/testing/selftests/wireguard/qemu/arch/i686.config:CONFIG_FRAME_WARN=1024
> tools/testing/selftests/wireguard/qemu/arch/m68k.config:CONFIG_FRAME_WARN=1024
> tools/testing/selftests/wireguard/qemu/arch/mips.config:CONFIG_FRAME_WARN=1024
> tools/testing/selftests/wireguard/qemu/arch/mipsel.config:CONFIG_FRAME_WARN=1024
> tools/testing/selftests/wireguard/qemu/arch/powerpc.config:CONFIG_FRAME_WARN=1024
> 
> I am not sure about the wireguard selftests: they might use the lower
> value deliberately for testing?
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


