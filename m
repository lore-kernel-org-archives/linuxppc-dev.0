Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01DBC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 12:27:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338222081D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 12:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338222081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qlzZ6vCpzF3CC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 23:27:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qlv55DTWzF3HY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 23:23:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42qlv50QSPz9sCw;
 Wed,  7 Nov 2018 23:23:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v6 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
In-Reply-To: <1541431515-25197-5-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <1541431515-25197-5-git-send-email-frowand.list@gmail.com>
Date: Wed, 07 Nov 2018 23:23:27 +1100
Message-ID: <87muqlqdog.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

frowand.list@gmail.com writes:

> From: Frank Rowand <frank.rowand@sony.com>
>
> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"

It would be clearer if you said 'The previous commit "of: overlay ..."

> added a missing of_node_get() to __of_attach_node_sysfs().  This
> results in a refcount imbalance for nodes attached with
> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
> to __of_attach_node_sysfs() is:
>
>    dlpar_attach_node()
>       of_attach_node()
>          __of_attach_node_sysfs()
>
> Tested-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>
> ***** UNTESTED.  I need people with the affected PowerPC systems
> *****            (systems that dynamically allocate and deallocate
> *****            devicetree nodes) to test this patch.

This looks OK to me in light of the previous patch.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

It also means dlpar_detach_node() is again behaving as described in the
comment to of_detach_node().

It would be good to make mention of:

  Fixes: 68baf692c435 ("powerpc/pseries: Fix of_node_put() underflow during DLPAR remove")

Which removed an of_node_put() in the exact same place for different
reasons.

cheers

> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 7625546caefd..17958043e7f7 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -270,6 +270,8 @@ int dlpar_detach_node(struct device_node *dn)
>  	if (rc)
>  		return rc;
>  
> +	of_node_put(dn);
> +
>  	return 0;
>  }
>  
> -- 
> Frank Rowand <frank.rowand@sony.com>
