Return-Path: <shin@sm.sony.co.jp>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 933CADDF87
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 12:31:42 +1000 (EST)
Received: from mail34.sony.co.jp (localhost [127.0.0.1])
	by mail34.sony.co.jp (R8/Sony) with ESMTP id l5E2VbKl005426
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 11:31:37 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mail34.sony.co.jp (R8/Sony) with SMTP id l5E2VbxP005418
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 11:31:37 +0900 (JST)
In-Reply-To: <466EE965.404@am.sony.com>
References: <20070612181825.730300780@am.sony.com>> <466EE965.404@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <b28db8e8f870934a46f25581c808d8b8@sm.sony.co.jp>
From: Takao Shinohara <shin@sm.sony.co.jp>
Subject: Re: [patch 05/30] PS3: Use ioremap_flags
Date: Thu, 14 Jun 2007 11:31:29 +0900
To: Geoff Levand <geoffrey.levand@am.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 2007/06/13, at 3:43, Geoff Levand wrote:
> -	spu->problem = ioremap(spu->problem_phys,
> -		sizeof(struct spu_problem));
> +	spu->problem = (__force void *)ioremap_flags(spu->problem_phys,
> +		sizeof(struct spu_problem), _PAGE_NO_CACHE);
> +
>  	if (!spu->problem) {
>  		pr_debug("%s:%d: ioremap problem failed\n", __func__, __LINE__);
>  		goto fail_ioremap;
>  	}
>
> -	spu->priv2 = ioremap(spu_pdata(spu)->priv2_addr,
> -		sizeof(struct spu_priv2));
> +	spu->priv2 = (__force void 
> *)ioremap_flags(spu_pdata(spu)->priv2_addr,
> +		sizeof(struct spu_priv2), _PAGE_NO_CACHE);
> +
>  	if (!spu->priv2) {
>  		pr_debug("%s:%d: ioremap priv2 failed\n", __func__, __LINE__);
>  		goto fail_ioremap;

spu->problem and spu->priv2 needs _PAGE_GUARDED, because they are
MMIO register region.

-- Takao Shinohara
