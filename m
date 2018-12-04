Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97647C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:47:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C50B12082D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50B12082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438H8T4390zDqZj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438H5r3T9yzDqXm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 20:45:04 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 834AEAD2C;
 Tue,  4 Dec 2018 09:44:58 +0000 (UTC)
Date: Tue, 4 Dec 2018 10:44:54 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 3/4] mm/memory_hotplug: Introduce and use more
 memory types
Message-ID: <20181204104454.522a3ba2@naga.suse.cz>
In-Reply-To: <20181130175922.10425-4-david@redhat.com>
References: <20181130175922.10425-1-david@redhat.com>
 <20181130175922.10425-4-david@redhat.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Rashmica Gupta <rashmica.g@gmail.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Ingo Molnar <mingo@kernel.org>,
 linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
 YueHaibing <yuehaibing@huawei.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Arun KS <arunks@codeaurora.org>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 Andrew Banman <andrew.banman@hpe.com>, Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 30 Nov 2018 18:59:21 +0100
David Hildenbrand <david@redhat.com> wrote:

> Let's introduce new types for different kinds of memory blocks and use
> them in existing code. As I don't see an easy way to split this up,
> do it in one hunk for now.
> 
> acpi:
>  Use DIMM or DIMM_UNREMOVABLE depending on hotremove support in the kernel.
>  Properly change the type when trying to add memory that was already
>  detected and used during boot (so this memory will correctly end up as
>  "acpi" in user space).
> 
> pseries:
>  Use DIMM or DIMM_UNREMOVABLE depending on hotremove support in the kernel.
>  As far as I see, handling like in the acpi case for existing blocks is
>  not required.
> 
> probed memory from user space:
>  Use DIMM_UNREMOVABLE as there is no interface to get rid of this code
>  again.
> 
> hv_balloon,xen/balloon:
>  Use BALLOON. As simple as that :)
> 
> s390x/sclp:
>  Use a dedicated type S390X_STANDBY as this type of memory and it's
>  semantics are very s390x specific.
> 
> powernv/memtrace:
>  Only allow to use BOOT memory for memtrace. I consider this code in
>  general dangerous, but we have to keep it working ... most probably just
>  a debug feature.

I don't think it should be arbitrarily restricted like that.

Thanks

Michal
