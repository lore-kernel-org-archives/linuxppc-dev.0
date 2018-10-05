Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9013C65BA7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:10:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150D22084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150D22084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RLVf6fq5zF3Qm
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:10:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.52; helo=mail-wr1-f52.google.com;
 envelope-from=osalvador.vilardaga@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=techadventures.net
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RLSP0dxKzF3K9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 17:08:01 +1000 (AEST)
Received: by mail-wr1-f52.google.com with SMTP id w5-v6so12394778wrt.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 00:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oWo1xNzfo+k/gC3Zp/F75xR+3JKVfFbkGJq2SW9FQzo=;
 b=acG9Uo749sK1LiAsxb3sVqn2zESZSqxlQJAzIV04IQmaQAiOtn06ty/tvwL3H4qCKP
 87/614cGNnsQXQ0DWrjfUBH85Q8KOkzeDvOrdql0AQrcwEYm76oW7ybtZ7VWlkJSL3/t
 5NVlJFCOt9ZUFdZ9FHYI3pOmN8E7dqPJ/dATRQDepCZ35q7eeS2P93aeerYB3emIcSdx
 Qa/VIwVMNNUC4erwDks50Jr/X9yLuggosNm8Nq39zfUBPufNYOvj9V5/dogO5wB0bZC6
 BxR4VWo+hzHYFGckdWwRsN7ATqTskB0COmyZgboVteiqKGUgU261ypNfrPOYrM9UjNoR
 k0gA==
X-Gm-Message-State: ABuFfoi7PWXiLV2K6BTZF2GRxm0IotE1gr06jerGlTZWNxo6im/xo64e
 salh6yBAaIsOsQWozKjzixo=
X-Google-Smtp-Source: ACcGV60YB5PqaO8biF/WCLgxrXP1h5Gepxo+CeVyoVF3N/x1M2o3JuOPW7wOPYWHN6vxLsDVXN+r8A==
X-Received: by 2002:a5d:4101:: with SMTP id l1-v6mr7692851wrp.45.1538723278847; 
 Fri, 05 Oct 2018 00:07:58 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
 by smtp.gmail.com with ESMTPSA id e64-v6sm850655wmg.0.2018.10.05.00.07.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 00:07:57 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
 id 6D6B1125822; Fri,  5 Oct 2018 09:07:56 +0200 (CEST)
Date: Fri, 5 Oct 2018 09:07:56 +0200
From: Oscar Salvador <osalvador@techadventures.net>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 3/6] mm/memory_hotplug: fix online/offline_pages
 called w.o. mem_hotplug_lock
Message-ID: <20181005070756.GA27754@techadventures.net>
References: <20180927092554.13567-1-david@redhat.com>
 <20180927092554.13567-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927092554.13567-4-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Michal Hocko <mhocko@suse.com>,
 linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Rashmica Gupta <rashmica.g@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Michael Neuling <mikey@neuling.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 27, 2018 at 11:25:51AM +0200, David Hildenbrand wrote:
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>
-- 
Oscar Salvador
SUSE L3
