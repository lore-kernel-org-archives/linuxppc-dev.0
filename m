Return-Path: <SRS0=NP7W=3L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26786C2D0DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jan 2020 19:03:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FD321835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jan 2020 19:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FD321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 482vtf55GpzDqYj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jan 2020 06:03:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.221.66; helo=mail-wr1-f66.google.com;
 envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 482vrk3tJ8zDqP2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2020 06:01:25 +1100 (AEDT)
Received: by mail-wr1-f66.google.com with SMTP id z3so269148wru.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2020 11:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fT9C07XJeWXduryKww0OrfVFvwMrniAzDyvK44e5lz0=;
 b=V6aFx80GM7YrOi2qX6zaZotrrnlsp9bsNsiAthpMELNDTU8cqwz0O9j47DKyDP9hdq
 X7avj/P47hmS5qrxsl9m7AFznGJ7fFAlkeEUkAi/qUNds4DjIB7q6XXG8XcElA8NNPtS
 lKXuHXkTy4evD9/bLCvyQtReKVhjTrjFL1VneLssg8Hkgq2EFtSXQ1AnVwPnnM2jOPeQ
 LEuo4ov1TW12ikL/GiUuHgZFZjixFK53M3DLcUET4GZX13f/tR3rF/XqGWYoGoXD0las
 Rxlrq8KM4h2mO1hxGFGpGRY2C+BZYJW+UWTc9T6hT026EgBGvfttnjT6BBDh4MYVWRSH
 vlCw==
X-Gm-Message-State: APjAAAWdSoD877jGCGdM0qWueKQseK+/RKx75uPnsq0dYzdfxJpjhVvF
 h+w+31JKHZBGyslOG9xyc30=
X-Google-Smtp-Source: APXvYqxPdbYCg4L9bE7BRZEYEC1YrA7Upz5yoZhAO3MKUClY2b0pknHNAtukj+4rsWFGeDRl6v6VSg==
X-Received: by 2002:adf:f484:: with SMTP id l4mr13322597wro.207.1579719682852; 
 Wed, 22 Jan 2020 11:01:22 -0800 (PST)
Received: from localhost (ip-37-188-226-95.eurotel.cz. [37.188.226.95])
 by smtp.gmail.com with ESMTPSA id a132sm4927254wme.3.2020.01.22.11.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 11:01:21 -0800 (PST)
Date: Wed, 22 Jan 2020 20:01:20 +0100
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
Message-ID: <20200122190120.GC29276@dhcp22.suse.cz>
References: <CAPcyv4jvmYRbX9i+1_LvHoTDGABadHbYH3NVkqczKsQ4fsf74g@mail.gmail.com>
 <20200120074816.GG18451@dhcp22.suse.cz>
 <a5f0bd8d-de5e-9f27-5c94-7746a3d20a95@redhat.com>
 <20200121120714.GJ29276@dhcp22.suse.cz>
 <a29b49b9-28ad-44fa-6c0b-90cd43902f29@redhat.com>
 <20200122104230.GU29276@dhcp22.suse.cz>
 <98b6c208-b4dd-9052-43f6-543068c649cc@redhat.com>
 <816ddd66-c90b-76f1-f4a0-72fe41263edd@redhat.com>
 <20200122164618.GY29276@dhcp22.suse.cz>
 <626d344e-8243-c161-cd07-ed1276eba73d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626d344e-8243-c161-cd07-ed1276eba73d@redhat.com>
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Allison Randal <allison@lohutok.net>, lantianyu1986@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed 22-01-20 19:15:47, David Hildenbrand wrote:
[...]
> c) CC relevant people I identify (lsmem/chmem/powerpc-utils/etc.) on the
> patch to see if we are missing other use cases/users/implications.
> 
> Sounds like a plan?

I would start with this step. Thanks!
-- 
Michal Hocko
SUSE Labs
