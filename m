Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC93C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 18:56:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D26218FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 18:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D26218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QtDd42BzzDqRk
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 05:56:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QtBp4VNDzDqLr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 05:55:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44QtBp1jX8z8wMX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 05:55:14 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44QtBp1Dcnz9sRd; Sat, 23 Mar 2019 05:55:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44QtBY0hVhz9sQp
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Mar 2019 05:54:59 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2MIUAHk029368;
 Fri, 22 Mar 2019 13:30:24 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x2MITmkv029327;
 Fri, 22 Mar 2019 13:29:48 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 22 Mar 2019 13:29:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/64: Fix memcmp reading past the end of src/dest
Message-ID: <20190322182943.GF3969@gate.crashing.org>
References: <20190322123724.28435-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322123724.28435-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev@ozlabs.org, chandan@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 22, 2019 at 11:37:24PM +1100, Michael Ellerman wrote:
>  .Lcmp_rest_lt8bytes:
> -	/* Here we have only less than 8 bytes to compare with. at least s1
> -	 * Address is aligned with 8 bytes.
> -	 * The next double words are load and shift right with appropriate
> -	 * bits.
> +	/*
> +	 * Here we have less than 8 bytes to compare. At least s1 is aligned to
> +	 * 8 bytes, but s2 may not be. We must make sure s2 + 8 doesn't cross a

"s2 + 7"?  The code is fine though (bgt, not bge).

> +	 * page boundary, otherwise we might read past the end of the buffer and
> +	 * trigger a page fault. We use 4K as the conservative minimum page
> +	 * size. If we detect that case we go to the byte-by-byte loop.
> +	 *
> +	 * Otherwise the next double word is loaded from s1 and s2, and shifted
> +	 * right to compare the appropriate bits.
>  	 */
> +	clrldi	r6,r4,(64-12)	// r6 = r4 & 0xfff

You can just write
  rlwinm r6,r4,0,0x0fff
if that is clearer?  Or do you still want a comment with that :-)

> +	cmpdi	r6,0xff8
> +	bgt	.Lshort

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
