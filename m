Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA20C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:17:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD13220875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD13220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RLgG5LZPzF3L4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:17:30 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RLd20VHdzF3K9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 17:15:33 +1000 (AEST)
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so852418wmc.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 00:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rLF/fUrswzwTf1w0onr3v+ax23k7hk6LQODldba/KpQ=;
 b=kITe02S85Iu6Jx6KYmExEF7WxNZpDC8trDeeHYn2sUgq/Zh6IwghA3FeprwIQ6jEK7
 kjcJWyThzWV8bFD70x1Y/LABcqZatPRELowbjpKuj/ueffeLQyPlbriz6EVZtFmbYDqp
 eNd0wdByQGn33drqaUdFbP8mS0RymOYu1l5pHUVf4Uy70F8/5dwm422vPISOeMK3QpU3
 ChhxXZEVOlrSqcgCT60ev5aiA6pPDnQvSUq7G/EZZOdYZxEx3gE5NTLRQqnZ0MaM4Z+S
 VCoGzazC8JcMk/7AG1Kr/SF5t93l01Loj/K/fih+Gnc8MBaAJPlzJERCmOTA4JHAkyvK
 JGLA==
X-Gm-Message-State: ABuFfojtONLGhbQUDjFrMiyZqUGfnLSEACsAwSf33sF1lXMQckbNYE6w
 JsOCAwnwzVje7UTsnELskrI=
X-Google-Smtp-Source: ACcGV62xTS7MoAnvgjRB5eo6esfIUGlYCP2yq8jFJz1NJEE76Gthgl8cHLOAdd7f71xBAils/qV+ow==
X-Received: by 2002:a1c:2846:: with SMTP id
 o67-v6mr6740461wmo.60.1538723730904; 
 Fri, 05 Oct 2018 00:15:30 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
 by smtp.gmail.com with ESMTPSA id s24-v6sm809132wmc.7.2018.10.05.00.15.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 00:15:30 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
 id 95CFE125826; Fri,  5 Oct 2018 09:15:29 +0200 (CEST)
Date: Fri, 5 Oct 2018 09:15:29 +0200
From: Oscar Salvador <osalvador@techadventures.net>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 1/6] mm/memory_hotplug: make remove_memory() take the
 device_hotplug_lock
Message-ID: <20181005071529.GC27754@techadventures.net>
References: <20180927092554.13567-1-david@redhat.com>
 <20180927092554.13567-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927092554.13567-2-david@redhat.com>
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
 Rashmica Gupta <rashmica.g@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 John Allen <jallen@linux.vnet.ibm.com>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 27, 2018 at 11:25:49AM +0200, David Hildenbrand wrote:
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
 
Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
