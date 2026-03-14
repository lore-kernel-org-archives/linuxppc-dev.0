Return-Path: <linuxppc-dev+bounces-18187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64285107BCFE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Mar 2026 07:46:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXthy20mpz2xgv;
	Sat, 14 Mar 2026 18:46:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773474402;
	cv=none; b=e5anlkG1vcJBDaicJRxwcK4MUqdf8ta9x6wFLhsROvBCWMTVrPYz3NPSf9lXc/Edci/i6eOmDX3RxrbFDUkWc6/cT9kIoSwD6Wfj3a0xByzE8GV/8+QdwrGLRParkw0QHrxa0I8WXew1tZik8bRvqcd2vaLDup8OOHyEpfkSzqxxVelbZ17rgoq8xiM81qtFbElkr4LsLgyxUp0tNu89Jalo3UVrlJEYkhLF1xMPHzcdU4yxnQCMcbHRtXWIUTB6UjYEXTQ+N8Jx3i6fV2ntcqqYPDtFtXM+T+k4dhtCjGHGRdXrKC6yEsK4cieKhHOFzWDmzv2BXp7jB7nKQqkOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773474402; c=relaxed/relaxed;
	bh=bqs72lIeJ93Co8annkkLCJzb1UYqUT148EQmsY1AIe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lO9Z7pnar1XxY153qK70iFOnc7ZSYUA3amcANK3BumUTFdjOps538bA0KPNKWWKthpALLvzQPuC0z2mWldQnG0SVMDxEEFDXFXGKRtChto4QCRVRwImsEAjH6r/hnxmR7s0gg1gl795pPf5UxCizBLqIA0V4/x23crUI/YGy3qnvPYk68axMXvA6Uj/CPfqG85RH8asJlIFXI0APcOpVe8NfaAomCidfSw/HGboMGLir6xFDViASwVw2vFJioUVnUA2Y9QHjyst1s+euXCommmbwqh3FtqKYAVDGuKoZX5z0j9yidclnUtukY2jhTXEG0HqHZiRtu+8eLn4OyRe+KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ILB767sQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ILB767sQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXthw1Vq2z2xdV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 18:46:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C2C4760008;
	Sat, 14 Mar 2026 07:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BD6C116C6;
	Sat, 14 Mar 2026 07:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773474396;
	bh=MHGzmKFozUpafxnV8AnZXEkdvC5yVTHrFIee/jJtQKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ILB767sQQa0rzjADbPtKPLWo8s56cXtC0NQySmWuaZ24sgrGkSVZ396RUFYd4iDQX
	 Ekv26R/dC1g6RM5htRa/JEhHrewo2dDRT611oC1MKn4dETHDcAZcTXy6jZZaKUubbm
	 vZSl6rzuCITgxGD/h4Jo00+YngC6lS/ezLnR0Eul5l1/rjqvONLUkkcupIKfScUzF/
	 IoWuZAQ4aobO4JpiDtcSD38b/cFe0rgKDBMMZE5OyrPD7jcH2+3qd7PGVaGr1ocg8n
	 lnQOw5ruX5c1dHAl51hQqdy+l6v3h9Anab4OlT+BxsowGKdwof63Twr5wEIctiM7F6
	 jpgAZFUCElh6g==
Message-ID: <95fdd9f7-f7b7-4ab4-9506-f952b9af3a33@kernel.org>
Date: Sat, 14 Mar 2026 08:46:27 +0100
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
Subject: Re: [PATCH] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
To: Bart Van Assche <bvanassche@acm.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Kees Cook <kees@kernel.org>
References: <20260313194430.2396286-1-bvanassche@acm.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260313194430.2396286-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/03/2026 à 20:44, Bart Van Assche a écrit :
> I haven't been able to find any callers of the functions mentioned in
> the subject in the kernel tree nor in the history of the kernel tree.
> Hence, remove these two functions.

As far as I can see it was used by i2c-keywest driver until commit 
a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")

a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
     if (pmac_low_i2c_lock(iface->node))
a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
     if (pmac_low_i2c_lock(iface->node))
a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
     if (pmac_low_i2c_lock(np))
a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
     if (pmac_low_i2c_lock(iface->node))

a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
     pmac_low_i2c_unlock(iface->node);
a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
     pmac_low_i2c_unlock(iface->node);
a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
             pmac_low_i2c_unlock(np);
a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
             pmac_low_i2c_unlock(np);
a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
             pmac_low_i2c_unlock(np);
a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
     pmac_low_i2c_unlock(np);
a28d3af2a26c89aaa6470ca36edb212e05143d67~:drivers/i2c/busses/i2c-keywest.c: 
     pmac_low_i2c_unlock(iface->node);


> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/pmac_low_i2c.h   |  4 ---
>   arch/powerpc/platforms/powermac/low_i2c.c | 34 -----------------------
>   2 files changed, 38 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pmac_low_i2c.h b/arch/powerpc/include/asm/pmac_low_i2c.h
> index 21bd7297c87f..fead8fae08ab 100644
> --- a/arch/powerpc/include/asm/pmac_low_i2c.h
> +++ b/arch/powerpc/include/asm/pmac_low_i2c.h
> @@ -79,10 +79,6 @@ extern int pmac_i2c_match_adapter(struct device_node *dev,
>   				  struct i2c_adapter *adapter);
>   
>   
> -/* (legacy) Locking functions exposed to i2c-keywest */
> -extern int pmac_low_i2c_lock(struct device_node *np);
> -extern int pmac_low_i2c_unlock(struct device_node *np);
> -
>   /* Access functions for platform code */
>   extern int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled);
>   extern void pmac_i2c_close(struct pmac_i2c_bus *bus);
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
> index 73b7f4e8c047..da72a30ab865 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -1058,40 +1058,6 @@ int pmac_i2c_match_adapter(struct device_node *dev, struct i2c_adapter *adapter)
>   }
>   EXPORT_SYMBOL_GPL(pmac_i2c_match_adapter);
>   
> -int pmac_low_i2c_lock(struct device_node *np)
> -{
> -	struct pmac_i2c_bus *bus, *found = NULL;
> -
> -	list_for_each_entry(bus, &pmac_i2c_busses, link) {
> -		if (np == bus->controller) {
> -			found = bus;
> -			break;
> -		}
> -	}
> -	if (!found)
> -		return -ENODEV;
> -	return pmac_i2c_open(bus, 0);
> -}
> -EXPORT_SYMBOL_GPL(pmac_low_i2c_lock);
> -
> -int pmac_low_i2c_unlock(struct device_node *np)
> -{
> -	struct pmac_i2c_bus *bus, *found = NULL;
> -
> -	list_for_each_entry(bus, &pmac_i2c_busses, link) {
> -		if (np == bus->controller) {
> -			found = bus;
> -			break;
> -		}
> -	}
> -	if (!found)
> -		return -ENODEV;
> -	pmac_i2c_close(bus);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pmac_low_i2c_unlock);
> -
> -
>   int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled)
>   {
>   	int rc;


