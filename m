Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAF0C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:19:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0282320875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0282320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RLjW0YSczF3Qq
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:19:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.128.65; helo=mail-wm1-f65.google.com;
 envelope-from=osalvador.vilardaga@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=techadventures.net
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RLf21cVBzF3RY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 17:16:26 +1000 (AEST)
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so825113wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 00:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aR/jC4H+BZ2o9lgfz0G0A5l8xgrll1yDCKPstbspgPM=;
 b=VKSdGCiEEq+tszj+cODloj9A0fh7Mm+QNGV6++ZHeWpHwY8F/9ImOSS+E4/FuXJt1H
 4OouWgn9A2WIqDLwHeKWBv1UyHqgd5zU1Y/mjzzwLGRlOcVawOh9v7wtpIHRoB92IwBK
 Drhea4a4MfRsT5twRNUaOyYAfhXMwI1GxE2UGZfSHrJzR52kDMGxqLcGgvjmMvvfeQdk
 O3OnctDT9hGo1s6Y6F2SBPyQdzEFpEf1LubUUM6gh4kIQ6uocZcWk6Vfo4pAacVhuv2F
 3tGr1dO/B7qIl6lJ3/FwqOelFMf255LYqE+jEkEaSbw7yC7lZ5WRV5HqNUj5ro6xNmk8
 mMdg==
X-Gm-Message-State: ABuFfoi5ul76JNLHXOqzQzZsQ423Y5YRPkZJoUmvfOIBmKjA+BwgnpVj
 cGps93dONvN4ijtzGyYcAB8=
X-Google-Smtp-Source: ACcGV62rkvQfaVax3+CKM4rI6dVZO/x+jQfOoQhQf86qnRsCE72Jcct7LW309FM0eBE/dW53ziii+Q==
X-Received: by 2002:a1c:e5cf:: with SMTP id
 c198-v6mr7001829wmh.113.1538723783664; 
 Fri, 05 Oct 2018 00:16:23 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
 by smtp.gmail.com with ESMTPSA id j203-v6sm940598wmd.46.2018.10.05.00.16.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 00:16:23 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
 id 7C2F7125828; Fri,  5 Oct 2018 09:16:22 +0200 (CEST)
Date: Fri, 5 Oct 2018 09:16:22 +0200
From: Oscar Salvador <osalvador@techadventures.net>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/6] mm/memory_hotplug: make add_memory() take the
 device_hotplug_lock
Message-ID: <20181005071622.GD27754@techadventures.net>
References: <20180927092554.13567-1-david@redhat.com>
 <20180927092554.13567-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927092554.13567-3-david@redhat.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 John Allen <jallen@linux.vnet.ibm.com>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 27, 2018 at 11:25:50AM +0200, David Hildenbrand wrote:
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
