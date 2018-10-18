Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F58DC5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 17:11:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CD92064A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 17:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CD92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bbDV3GJrzF3Rn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:11:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bbBR0lT5zF33P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 04:09:34 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id v2so23365662otk.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 10:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HXcWGVzkOfaVHlss2GLVKMCrtIPoMyYNFPKDV+16whQ=;
 b=VaTO34DYrLAjYvzvjkA/eiN72Zii8dPD3aBBblGrRDJh/zs0DA9cpJnU9njADPF8LA
 KQWGydwPpFtC9TaA94e84jryCwDHiYHp+7o2VYZ9wPJttz734t/Jsdobqq9OhdCwSUKo
 ihRrGrtF26E7znJpLM4Sr+jHIeRqM02lFmMqALdhQ4+zd0Dt6Hxm7hzD0aioVX5ZwUhH
 GVSUSgH4gL43tdopM34fUUQpH2rE6kMKzt8ZLeibLQv27BUonYvXXMlKeAV/E21rF8pe
 k3y8SVESv/3vEYG/hCt4Ha97tdRYMML24RA2BCuuZ8SfjJzpIKCKavslFggGSsZ3DvFW
 OMMA==
X-Gm-Message-State: ABuFfoisevSOpa35pxrjNdaKvnJiFOU8F+fd4MR2vjVX5EtJnHnIszrv
 FbH0G/s3GPwsuhmOjRR4PA==
X-Google-Smtp-Source: ACcGV604rMfo3OfFb/7pa7GuBL6T7JBbycfNuE1EBytvF7LFox1KN+GieJOMROEZqKdpbXic1gms3w==
X-Received: by 2002:a9d:2014:: with SMTP id n20mr20468462ota.308.1539882572821; 
 Thu, 18 Oct 2018 10:09:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id u123-v6sm7422757oie.22.2018.10.18.10.09.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Oct 2018 10:09:31 -0700 (PDT)
Date: Thu, 18 Oct 2018 12:09:31 -0500
From: Rob Herring <robh@kernel.org>
To: frowand.list@gmail.com
Subject: Re: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Message-ID: <20181018170931.GC15557@bogus>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devicetree@vger.kernel.org, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 07:37:24PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
> added a missing of_node_get() to __of_attach_node_sysfs().  This
> results in a refcount imbalance for nodes attached with
> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
> to __of_attach_node_sysfs() is:
> 
>    dlpar_attach_node()
>       of_attach_node()
>          __of_attach_node_sysfs()

IIRC, there's a long standing item in the todo (Grant's) to convert the 
open coded dlpar code. Maybe you want to do that first?

> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> ***** UNTESTED.  I need people with the affected PowerPC systems
> *****            (systems that dynamically allocate and deallocate
> *****            devicetree nodes) to test this patch.

Can't we write a test case that does the same thing?

> 
>  arch/powerpc/platforms/pseries/dlpar.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index a0b20c03f078..e3010b14aea5 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
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
> 
