Return-Path: <SRS0=+v6T=6S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBDDC3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 05:44:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1E120721
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 05:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1E120721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49FsJ13X38zDqlJ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 15:44:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49FsCs1SnJzDqT2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2020 15:41:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49FsCr5wmwz9sSw;
 Mon,  4 May 2020 15:41:12 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v7 04/28] powerpc/xmon: Use bitwise calculations
 in_breakpoint_table()
Date: Mon, 04 May 2020 15:41:12 +1000
Message-ID: <8567555.I5S1BN7I14@townsend>
In-Reply-To: <20200501034220.8982-5-jniethe5@gmail.com>
References: <20200501034220.8982-1-jniethe5@gmail.com>
 <20200501034220.8982-5-jniethe5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: npiggin@gmail.com, bala24@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I probably would have just folded this change into patch 2 but it looks fine to 
me.

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Friday, 1 May 2020 1:41:56 PM AEST Jordan Niethe wrote:
> A modulo operation is used for calculating the current offset from a
> breakpoint within the breakpoint table. As instruction lengths are
> always a power of 2, this can be replaced with a bitwise 'and'. The
> current check for word alignment can be replaced with checking that the
> lower 2 bits are not set.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
> v6: New to series
> ---
>  arch/powerpc/xmon/xmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index bbfea22f4a96..e122f0c8a044 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -857,8 +857,8 @@ static struct bpt *in_breakpoint_table(unsigned long
> nip, unsigned long *offp) off = nip - (unsigned long) bpt_table;
>  	if (off >= sizeof(bpt_table))
>  		return NULL;
> -	*offp = off % BPT_SIZE;
> -	if (*offp != 0 && *offp != 4)
> +	*offp = off & (BPT_SIZE - 1);
> +	if (off & 3)
>  		return NULL;
>  	return bpts + (off / BPT_SIZE);
>  }




