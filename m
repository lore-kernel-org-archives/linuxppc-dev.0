Return-Path: <SRS0=/SLd=ZO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4ABC432C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 11:45:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFC120714
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 11:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFC120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47KF3V5Rj0zDqsX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Nov 2019 22:45:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47KDyS0NTZzDrCs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2019 22:40:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 47KDyP68N3z8tGN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2019 22:40:45 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 47KDyP4d8lz9sSJ; Fri, 22 Nov 2019 22:40:45 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=deadmen.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
X-Greylist: delayed 1738 seconds by postgrey-1.36 at bilbo;
 Fri, 22 Nov 2019 22:40:44 AEDT
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47KDyN6Bvwz9sS8
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2019 22:40:44 +1100 (AEDT)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1iY6qZ-0005XE-QA; Fri, 22 Nov 2019 19:11:31 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1iY6qY-0002m8-1L; Fri, 22 Nov 2019 19:11:30 +0800
Date: Fri, 22 Nov 2019 19:11:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] crypto: vmx - Avoid weird build failures
Message-ID: <20191122111129.nu5lr5nfxilsjsy5@gondor.apana.org.au>
References: <20191120112738.7031-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120112738.7031-1-mpe@ellerman.id.au>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org,
 yamada.masahiro@socionext.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 20, 2019 at 10:27:38PM +1100, Michael Ellerman wrote:
> In the vmx crypto Makefile we assign to a variable called TARGET and
> pass that to the aesp8-ppc.pl and ghashp8-ppc.pl scripts.
> 
> The variable is meant to describe what flavour of powerpc we're
> building for, eg. either 32 or 64-bit, and big or little endian.
> 
> Unfortunately TARGET is a fairly common name for a make variable, and
> if it happens that TARGET is specified as a command line parameter to
> make, the value specified on the command line will override our value.
> 
> In particular this can happen if the kernel Makefile is driven by an
> external Makefile that uses TARGET for something.
> 
> This leads to weird build failures, eg:
>   nonsense  at /build/linux/drivers/crypto/vmx/ghashp8-ppc.pl line 45.
>   /linux/drivers/crypto/vmx/Makefile:20: recipe for target 'drivers/crypto/vmx/ghashp8-ppc.S' failed
> 
> Which shows that we passed an empty value for $(TARGET) to the perl
> script, confirmed with make V=1:
> 
>   perl /linux/drivers/crypto/vmx/ghashp8-ppc.pl  > drivers/crypto/vmx/ghashp8-ppc.S
> 
> We can avoid this confusion by using override, to tell make that we
> don't want anything to override our variable, even a value specified
> on the command line. We can also use a less common name, given the
> script calls it "flavour", let's use that.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/crypto/vmx/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
