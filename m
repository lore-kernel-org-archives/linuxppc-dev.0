Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E38C282C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 00:06:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2160218A6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 00:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnzBcq7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2160218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lznh3m5YzDqLw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 11:06:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=turtle.in.the.kernel@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TnzBcq7B"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lzlm4bDnzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 11:04:17 +1100 (AEDT)
Received: by mail-qk1-x741.google.com with SMTP id d15so4489395qkj.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 16:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=irrrj1aIRm1Xathl7FhqoMhu6j8f0JSUgmySPpo0TJk=;
 b=TnzBcq7B9dj4hDWYhAdrx715udUh48w0TME8rdoDnyJg7e/O66OZ/uqb+2A1+FYq+7
 AAxxvrbaNhm6p9N7PDL8sH+IQDZDjqCIrZzbR0JxSjMAtPqp1VnDGsp+BEMFstBcm553
 KuLyNdGijyGwGxTzRiibJk8FbJzllRZXNOltaoQFIb7wAPL91TjdZPlb4yrrJ+wR9e+o
 PVDjB1d7mKVlHY+zu38jUJlTX1uAT2uM3N5ySWTYv8FT7SrrGbti1MET9ytPZKR4sEDM
 c3DofTr+n2IJUQpDyBUYvF/I7Ach8Kb/S5FFaXJXxGWX1aRCfmNHjNQvorNFvPg32ByO
 soKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=irrrj1aIRm1Xathl7FhqoMhu6j8f0JSUgmySPpo0TJk=;
 b=STCEHX/zRZZY9fUUbpyQ0uEEjU2foGzQrYb7mT/eYAKA9sCL4HFcNJplr6Mc5+RyKk
 xRt1hmJsfxYjEVIWyGiNjbdOPD2Da0/OqOoU4CNKci4ioUFPauw8+p8KJ3zwUCS873Vc
 jMlfvceoSB88lYwhRsO3VFNF+8EA6lZC518pmsTmSR/kKc9bTF6G3LjYuFA/mXu6qp2C
 aiT/aAOLs/URvtBkEze2UWofFxoY9JQB22X7wzHeydAlAZ+H3BziUTsAPQ+kvYMBzueA
 Cy4zS3JVhgwfVhbFEm7DLiIGi5TQXbfdB1eaZQTwqL0RD1+S5uf+zBDk0c01He5wLswe
 1g8Q==
X-Gm-Message-State: AJcUukdVqb+osU7/xwYpTG2oZt8hk4QeTkGFy2TXw8mCubo0EHX0UT26
 78YE3tDbLgdqZBtCpOSEwMQ=
X-Google-Smtp-Source: ALg8bN7F1X0jZrlK49XHVFQiN5j5GBjQLRNlGbXa8EFtP6jrRoxRo77yWgZNrRz1pJlMMTLHd5suuw==
X-Received: by 2002:a05:620a:9:: with SMTP id j9mr7795813qki.144.1548374654125; 
 Thu, 24 Jan 2019 16:04:14 -0800 (PST)
Received: from oc6857751186.ibm.com (c-24-20-82-131.hsd1.or.comcast.net.
 [24.20.82.131])
 by smtp.gmail.com with ESMTPSA id g25sm51998796qki.29.2019.01.24.16.04.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 16:04:13 -0800 (PST)
Subject: Re: [RFC 1/6] powerpc:/drc Define interface to acquire arch-specific
 drc info
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
 <20181214204957.16435.29255.stgit@powerkvm6.aus.stglabs.ibm.com>
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <e7030879-59e4-88fd-3785-fdd98b7f0a3b@gmail.com>
Date: Thu, 24 Jan 2019 16:04:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181214204957.16435.29255.stgit@powerkvm6.aus.stglabs.ibm.com>
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
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/14/2018 12:50 PM, Michael Bringmann wrote:
> Define interface to acquire arch-specific drc info to match against
> hotpluggable devices.  The current implementation exposes several
> pseries-specific dynamic memory properties in generic kernel code.
> This patch set provides an interface to pull that code out of the
> generic kernel.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>  include/linux/topology.h |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index cb0775e..df97f5f 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -44,6 +44,15 @@

As far as I know pseries is the only platform that uses DR connectors, and I
highly doubt that any other powerpc platform or arch ever will. So, I'm not sure
that this is really generic enough to belong in topology.h. If anything I would
suggest putting this in an include in arch/powerpc/include/ named something like
drcinfo.h or pseries-drc.h. That will make it visible to modules like rpaphp
that want/need to use this functionality.

-Tyrel

>  
>  int arch_update_cpu_topology(void);
>  
> +int arch_find_drc_match(struct device_node *dn,
> +			bool (*usercb)(struct device_node *dn,
> +				u32 drc_index, char *drc_name,
> +				char *drc_type, u32 drc_power_domain,
> +				void *data),
> +			char *opt_drc_type, char *opt_drc_name,
> +			bool match_drc_index, bool ck_php_type,
> +			void *data);
> +
>  /* Conform to ACPI 2.0 SLIT distance definitions */
>  #define LOCAL_DISTANCE		10
>  #define REMOTE_DISTANCE		20
> 

