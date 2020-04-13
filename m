Return-Path: <SRS0=PHx5=55=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FC8C2BA2B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2020 21:35:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF0B206C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2020 21:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF0B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491MNr3jDxzDqNr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 07:35:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.40; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0040.hostedemail.com
 [216.40.44.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491MLm17SmzDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2020 07:33:50 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id D45AF18027F9D;
 Mon, 13 Apr 2020 21:33:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: badge84_5a5696689f027
X-Filterd-Recvd-Size: 3380
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Mon, 13 Apr 2020 21:33:40 +0000 (UTC)
Message-ID: <efd6ceb1f182aa7364e9706422768a1c1335aee4.camel@perches.com>
Subject: Re: [PATCH 2/2] crypto: Remove unnecessary memzero_explicit()
From: Joe Perches <joe@perches.com>
To: Waiman Long <longman@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>,  David Howells <dhowells@redhat.com>, Jarkko
 Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
 David Rientjes <rientjes@google.com>
Date: Mon, 13 Apr 2020 14:31:32 -0700
In-Reply-To: <20200413211550.8307-3-longman@redhat.com>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413211550.8307-3-longman@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: samba-technical@lists.samba.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devel@driverdev.osuosl.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
 kasan-dev@googlegroups.com, cocci@systeme.lip6.fr, linux-wpan@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-crypto@vger.kernel.org,
 linux-pm@vger.kernel.org, ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-cifs@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 wireguard@lists.zx2c4.com, linux-ppp@vger.kernel.org,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2020-04-13 at 17:15 -0400, Waiman Long wrote:
> Since kfree_sensitive() will do an implicit memzero_explicit(), there
> is no need to call memzero_explicit() before it. Eliminate those
> memzero_explicit() and simplify the call sites.

2 bits of trivia:

> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
[]
> @@ -391,10 +388,7 @@ int sun8i_ce_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  		dev_dbg(ce->dev, "ERROR: Invalid keylen %u\n", keylen);
>  		return -EINVAL;
>  	}
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	kfree_sensitive(op->key);
>  	op->keylen = keylen;
>  	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
>  	if (!op->key)

It might be a defect to set op->keylen before the kmemdup succeeds.

> @@ -416,10 +410,7 @@ int sun8i_ce_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  	if (err)
>  		return err;
>  
> -	if (op->key) {
> -		memzero_explicit(op->key, op->keylen);
> -		kfree(op->key);
> -	}
> +	free_sensitive(op->key, op->keylen);

Why not kfree_sensitive(op->key) ?


