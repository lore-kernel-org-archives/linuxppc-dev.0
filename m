Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B7C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 05:10:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF0A60F58
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 05:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AF0A60F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpfHk2lGRz3cSv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 15:10:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GpfH92Blxz2xlG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 15:10:09 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GpfH14H6pz9sVD;
 Tue, 17 Aug 2021 07:10:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5d27vxsQSPgp; Tue, 17 Aug 2021 07:10:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GpfH138Ctz9sV9;
 Tue, 17 Aug 2021 07:10:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C3CB8B76D;
 Tue, 17 Aug 2021 07:10:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id jx7-YI0pXYqz; Tue, 17 Aug 2021 07:10:05 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DBD28B765;
 Tue, 17 Aug 2021 07:10:05 +0200 (CEST)
Subject: Re: [PATCH v2 2/3] powerpc/config: Renable MTD_PHYSMAP_OF
To: Joel Stanley <joel@jms.id.au>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <20210817045407.2445664-1-joel@jms.id.au>
 <20210817045407.2445664-3-joel@jms.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b69b2757-278d-330d-86d6-c9b93855f8f1@csgroup.eu>
Date: Tue, 17 Aug 2021 07:10:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817045407.2445664-3-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 17/08/2021 à 06:54, Joel Stanley a écrit :
> CONFIG_MTD_PHYSMAP_OF is not longer enabled as it depends on
> MTD_PHYSMAP which is not enabled.
> 
> This is a regression from commit 642b1e8dbed7 ("mtd: maps: Merge
> physmap_of.c into physmap-core.c"), which added the extra dependency.
> Add CONFIG_MTD_PHYSMAP=y so this stays in the config, as Christophe said
> it is useful for build coverage.
> 
> Fixes: 642b1e8dbed7 ("mtd: maps: Merge physmap_of.c into physmap-core.c")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/configs/mpc885_ads_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
> index 5cd17adf903f..cd08f9ed2c8d 100644
> --- a/arch/powerpc/configs/mpc885_ads_defconfig
> +++ b/arch/powerpc/configs/mpc885_ads_defconfig
> @@ -33,6 +33,7 @@ CONFIG_MTD_CFI_GEOMETRY=y
>   # CONFIG_MTD_CFI_I2 is not set
>   CONFIG_MTD_CFI_I4=y
>   CONFIG_MTD_CFI_AMDSTD=y
> +CONFIG_MTD_PHYSMAP=y
>   CONFIG_MTD_PHYSMAP_OF=y
>   # CONFIG_BLK_DEV is not set
>   CONFIG_NETDEVICES=y
> 
