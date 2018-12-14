Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2AC67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 06:53:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2202054F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 06:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsqdUVSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2202054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GLpk6FfYzDr7Z
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 17:53:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsqdUVSI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsqdUVSI"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GLgJ2L7fzDqwN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 17:46:36 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id u6so2263922plm.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 22:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5k5Xm7gA+YAbibREjZJes4UWSlK5iNrBIVPrVuEWcSM=;
 b=nsqdUVSIG5cVdCSXsJj0Fobi82G7Bzur0LaZw1IQV6jhdeL23zatVV43vuEMw5FQF0
 v6IJuxIiUL7+yD2NtOt+5OcFXJ6tOPC3XD26hHfml88wvOd/XM465Y63SVu2cDjbkbsG
 KXC/Qz0SvADPt+yJXCycaW7/8LSVmnNztnuF3vPUVO8VI+6zJUEB8Kf+QV9C6UDv/z8E
 InTBRmbEvwPcevta+eiI8UdgPypY+lR6Dl9qsfUH7w2EGRAGfDgrd8uTJuSX+Fn+j+W5
 MXG9tUAubfJA1vBREx2R8ORRuPknsWL8rShP3GupK0v50kX0DTn+DBpXbb4fqDAB3JpB
 hwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5k5Xm7gA+YAbibREjZJes4UWSlK5iNrBIVPrVuEWcSM=;
 b=q4GdMxOa0gKYtPuAwUJ/8pNpSPCt+XNLxYYkFtJ4agRAQDEqvI0889FV12AFb7gcGF
 L1NobHItZ61Hiyna9SEOnMJDx2VK67Lf3DYdiwlpOXiwXmSDCn9HjXzRIQTbt5BQH5FO
 HyR75toeHMxnF9qzJ18AF1dQ3pZGAZox88NfY1XPC3bVFI5KfWo+1U996Ks9P0ihzHsM
 7xA6TCYjH2fAGGGnIzFjERbTvjYLD9sX393ONIIgc918hl796d3F/hSI6sVGfrrqotqV
 bQ6AQ1HvNxi/IiET/u3/GQz7Mh8+LWFiQtEfzDEpDylvC7y4OK0zcR83zQlx7aGaUhYt
 rjGg==
X-Gm-Message-State: AA+aEWaW8etbHDrXbmCVzgtwQedojsu0Rk5qVOkqgozaGPQgSgqxURY2
 ZiIZEaCVzufvZU6IF0GkMSc=
X-Google-Smtp-Source: AFSGD/WG3tA/gpk1hm1D2RF0FwrUOLQ9yv3B1TFtJkjjIbo1n6GznsMDtgghTu8jGiNPpKGlO/YABg==
X-Received: by 2002:a17:902:2c03:: with SMTP id
 m3mr1851018plb.125.1544769994631; 
 Thu, 13 Dec 2018 22:46:34 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id c20sm4965074pfc.92.2018.12.13.22.46.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 22:46:34 -0800 (PST)
Subject: Re: [PATCH 0/2] of: phandle_cache, fix refcounts, remove stale entry
From: Frank Rowand <frowand.list@gmail.com>
To: robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
Message-ID: <84933c5e-04b1-df82-daec-cbae1017a830@gmail.com>
Date: Thu, 13 Dec 2018 22:46:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: devicetree@vger.kernel.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Juliet Kim <minkim@us.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael Bringmann,

On 12/13/18 10:42 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Non-overlay dynamic devicetree node removal may leave the node in
> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> will incorrectly find the stale entry.  This bug exposed the foloowing
> phandle cache refcount bug.
> 
> The refcount of phandle_cache entries is not incremented while in
> the cache, allowing use after free error after kfree() of the
> cached entry.
> 
> Frank Rowand (2):
>   of: of_node_get()/of_node_put() nodes held in phandle cache
>   of: __of_detach_node() - remove node from phandle cache
> 
>  drivers/of/base.c       | 99 ++++++++++++++++++++++++++++++++++++-------------
>  drivers/of/dynamic.c    |  3 ++
>  drivers/of/of_private.h |  4 ++
>  3 files changed, 81 insertions(+), 25 deletions(-)
> 

Can you please test that these patches fix the problem that you
reported in:

    [PATCH v03] powerpc/mobility: Fix node detach/rename problem

Thanks,

Frank
