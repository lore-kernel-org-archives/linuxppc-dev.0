Return-Path: <linuxppc-dev+bounces-18615-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1168EC01BE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:14:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffTYZ2yc8z2ySc;
	Mon, 23 Mar 2026 21:14:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774260882;
	cv=none; b=XZ/LPkjFg7D0DcwmN+kGgsf67UsLcws1jcHkYDVQK70EP2/zW4Hcg4YbZ78IDJlGxYFKLnOGqvs6ikXt1Has+iUzioVh37eJA4gKvVGh99i+k41le6q+NXzQr4EGHI/M/FfO55pBn4frC3ZX8TI/qQncNDTDDHCWNPLxNLoQJNpffFUjAR0k+8pC6sNTcXCySOAkogn5FIgKjtL52zKcU29g7aSriXCP/uA6gJfQ7t70XY2fPgwTYKXXOsVrYEONWYJzRUAekGuclte3xaCP+oWKPQLXcMXYhHrayUoSxiWzSne2V1zWnJOu3z+QCY9rIprzNjA7rXaNwCXFAs4Jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774260882; c=relaxed/relaxed;
	bh=ZVYi/3cA8gqc1iqgD7SprnfmKsToiopM2hIVs96pebE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO/f+5pLLdpVRTsZwVZFdFCytbOH5EpwGQgEEdSnMaCARWloYZq7duPeScgaJRD9pbNB/DWVZ6Gzdrv40xwgkJntWTW9+NkfGlSCn9pFYjuePFSYDb+LNRs8wvsP26emqoSg6+U+VeGNCIi3n0uzDi18ZVSEqTwqujD8BJX6oKXWb3iHT9UkhxMCRFOgmgWDgSnxhJKfyGQ2nN4d/u4rzpcoeZ+i5VonObKiLZjCWM6/dURtQoOyyFo5fqL/uPBu1IX1HrSYgiw+ut9tj4cvgEpvjGocyx6GIZHaLnsxzEy2R2/GORSsm1W6ROLpNcDZMFRQRJ8uKoIk8TdedEMUuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OS3M+qbu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OS3M+qbu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffTYY0y8dz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 21:14:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E461660051;
	Mon, 23 Mar 2026 10:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2243C4CEF7;
	Mon, 23 Mar 2026 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774260877;
	bh=oerB1WWxL48/4S0FWQM8KbgtK24CS2HM+Renmll0YpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OS3M+qbuwk0+Km6yV4c+36VvjE2OK2eRv7NgCJAXK4W8vQq0yOBtXYGchfu7/WEfL
	 Zq7t5dic1U98tm3z4t0+c2ayBzYS5Jpc9kjttDS/9IEbYIzTPua/fz2xY7JY/VixPz
	 Z0S2cwUEDUpz2ZfGg3gBC+Wpb84GOBDcihUXtRrbllrj/h/Xg+VULFKvCbJc94xmeD
	 8srImhK1bsCRxfoJGcXF/advujhhMdrsBAsGRNbB/f5jlrS8GCExZlEWsuKqZcazQ7
	 WiOkTqOUjefMDP8Otku1Y6jN2EW7hKLSqI5ylFSJqSH+xJp7UnSbeXUyLTVr1barvT
	 0W8qRAM+p6i+g==
Message-ID: <e6db8617-6b12-4f90-967d-85c9f7805823@kernel.org>
Date: Mon, 23 Mar 2026 11:14:31 +0100
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
Subject: Re: [PATCH v2] char: nvram: Remove unused nvram_mutex to fix
 -Wunused-variable warning
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nathan@kernel.org, nsc@kernel.org,
 ojeda@kernel.org, masahiroy@kernel.org, linux@weissschuh.net,
 tamird@kernel.org, rostedt@goodmis.org, ihor.solodrai@linux.dev,
 ritesh.list@gmail.com, maddy@linux.ibm.com, peterz@infradead.org
References: <20260323073220.25798-1-venkat88@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260323073220.25798-1-venkat88@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/03/2026 à 08:32, Venkat Rao Bagalkote a écrit :
> v2:
>    - Added missing Suggested-by tag from Ritesh Harjani (IBM)
> 

Patch history must go _after_ the --- below, otherwise it will appear in 
the commit message when applied, which is pointless.

> drivers/char/nvram.c defines a static mutex 'nvram_mutex' which is never
> used. This results in a compiler warning on linux-next builds:

It is probably not only linux-next builds, I think the problem exists 
since 20e07af71f34 ("powerpc: Adopt nvram module for PPC64")

> 
>    warning: 'nvram_mutex' defined but not used [-Wunused-variable]
> 
> Remove the unused definition to avoid the warning.

It is not what you are doing.

You are just hiding the probleme by saying 'maybe it is used, maybe it 
is not used, I don't know I don't care". Please properly fix the problem 
instead.

I think the fix is probably to remove the #ifdef CONFIG_PPC32 around 
IOC_NVRAM_SYNC.
If you think it is important to return -ENOTTY on CONFIG_PPC64, just add:

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 9eff426a9286..2fd744bf9093 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -308,8 +308,10 @@ static long nvram_misc_ioctl(struct file *file, 
unsigned int cmd,
  		}
  #endif
  		break;
-#ifdef CONFIG_PPC32
  	case IOC_NVRAM_SYNC:
+		if (IS_ENABLED(CONFIG_PPC64))
+			break;
+
  		if (ppc_md.nvram_sync != NULL) {
  			mutex_lock(&nvram_mutex);
  			ppc_md.nvram_sync();
@@ -317,7 +319,6 @@ static long nvram_misc_ioctl(struct file *file, 
unsigned int cmd,
  		}
  		ret = 0;
  		break;
-#endif
  #elif defined(CONFIG_X86) || defined(CONFIG_M68K)
  	case NVRAM_INIT:
  		/* initialize NVRAM contents and checksum */

> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
>   drivers/char/nvram.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
> index 9eff426a9286..2ce3307663ed 100644
> --- a/drivers/char/nvram.c
> +++ b/drivers/char/nvram.c
> @@ -53,7 +53,7 @@
>   #include <asm/nvram.h>
>   #endif
>   
> -static DEFINE_MUTEX(nvram_mutex);
> +static __maybe_unused DEFINE_MUTEX(nvram_mutex);
>   static DEFINE_SPINLOCK(nvram_state_lock);
>   static int nvram_open_cnt;	/* #times opened */
>   static int nvram_open_mode;	/* special open modes */


