Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C693DC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 13:42:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1F120684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 13:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1F120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QHJs0CjGzDr43
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 23:42:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=vkuznets@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QHCk56pfzDr8q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 23:38:23 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BBCD6300287B;
 Wed,  3 Oct 2018 13:38:19 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C648027BC4;
 Wed,  3 Oct 2018 13:38:06 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
In-Reply-To: <98fb8d65-b641-2225-f842-8804c6f79a06@redhat.com>
References: <20180928150357.12942-1-david@redhat.com>
 <20181001084038.GD18290@dhcp22.suse.cz>
 <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
 <20181002134734.GT18290@dhcp22.suse.cz>
 <98fb8d65-b641-2225-f842-8804c6f79a06@redhat.com>
Date: Wed, 03 Oct 2018 15:38:04 +0200
Message-ID: <8736tndubn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 03 Oct 2018 13:38:21 +0000 (UTC)
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Rashmica Gupta <rashmica.g@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Rob Herring <robh@kernel.org>, "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 =?utf-8?B?SsOpcsO0?= =?utf-8?B?bWU=?= Glisse <jglisse@redhat.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>,
 Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 devel@linuxdriverproject.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

David Hildenbrand <david@redhat.com> writes:

> On 02/10/2018 15:47, Michal Hocko wrote:
...
>> 
>> Why do you need a generic hotplug rule in the first place? Why don't you
>> simply provide different set of rules for different usecases? Let users
>> decide which usecase they prefer rather than try to be clever which
>> almost always hits weird corner cases.
>> 
>
> Memory hotplug has to work as reliable as we can out of the box. Letting
> the user make simple decisions like "oh, I am on hyper-V, I want to
> online memory to the normal zone" does not feel right. But yes, we
> should definitely allow to make modifications.

Last time I was thinking about the imperfectness of the auto-online
solution we have and any other solution we're able to suggest an idea
came to my mind - what if we add an eBPF attach point to the
auto-onlining mechanism effecively offloading decision-making to
userspace. We'll of couse need to provide all required data (e.g. how
memory blocks are aligned with physical DIMMs as it makes no sense to
online part of DIMM as normal and the rest as movable as it's going to
be impossible to unplug such DIMM anyways).

-- 
Vitaly
