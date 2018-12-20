Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456F7C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 14:09:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC09217D8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 14:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC09217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LDCR63C0zDr5b
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 01:09:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LBsQ1KFPzDqgd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 00:08:42 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1D2DCADF4;
 Thu, 20 Dec 2018 13:08:38 +0000 (UTC)
Date: Thu, 20 Dec 2018 14:08:32 +0100
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 0/4] mm/memory_hotplug: Introduce memory block types
Message-ID: <20181220130832.GH9104@dhcp22.suse.cz>
References: <20181130175922.10425-1-david@redhat.com>
 <1b4afb6a-5f91-407d-6e6e-6a89b8cf5d56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b4afb6a-5f91-407d-6e6e-6a89b8cf5d56@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Fri, 21 Dec 2018 01:05:18 +1100
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
Cc: Oscar Salvador <osalvador@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 Pavel Tatashin <pavel.tatashin@microsoft.com>, Arun KS <arunks@codeaurora.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Rashmica Gupta <rashmica.g@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Paul Mackerras <paulus@samba.org>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Logan Gunthorpe <logang@deltatee.com>, x86@kernel.org,
 YueHaibing <yuehaibing@huawei.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org,
 Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 Len Brown <lenb@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
 Juergen Gross <jgross@suse.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Rob Herring <robh@kernel.org>, "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Oscar Salvador <osalvador@suse.de>, Tony Luck <tony.luck@intel.com>,
 Andrew Banman <andrew.banman@hpe.com>, Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu 20-12-18 13:58:16, David Hildenbrand wrote:
> On 30.11.18 18:59, David Hildenbrand wrote:
> > This is the second approach, introducing more meaningful memory block
> > types and not changing online behavior in the kernel. It is based on
> > latest linux-next.
> > 
> > As we found out during dicussion, user space should always handle onlining
> > of memory, in any case. However in order to make smart decisions in user
> > space about if and how to online memory, we have to export more information
> > about memory blocks. This way, we can formulate rules in user space.
> > 
> > One such information is the type of memory block we are talking about.
> > This helps to answer some questions like:
> > - Does this memory block belong to a DIMM?
> > - Can this DIMM theoretically ever be unplugged again?
> > - Was this memory added by a balloon driver that will rely on balloon
> >   inflation to remove chunks of that memory again? Which zone is advised?
> > - Is this special standby memory on s390x that is usually not automatically
> >   onlined?
> > 
> > And in short it helps to answer to some extend (excluding zone imbalances)
> > - Should I online this memory block?
> > - To which zone should I online this memory block?
> > ... of course special use cases will result in different anwers. But that's
> > why user space has control of onlining memory.
> > 
> > More details can be found in Patch 1 and Patch 3.
> > Tested on x86 with hotplugged DIMMs. Cross-compiled for PPC and s390x.
> > 
> > 
> > Example:
> > $ udevadm info -q all -a /sys/devices/system/memory/memory0
> > 	KERNEL=="memory0"
> > 	SUBSYSTEM=="memory"
> > 	DRIVER==""
> > 	ATTR{online}=="1"
> > 	ATTR{phys_device}=="0"
> > 	ATTR{phys_index}=="00000000"
> > 	ATTR{removable}=="0"
> > 	ATTR{state}=="online"
> > 	ATTR{type}=="boot"
> > 	ATTR{valid_zones}=="none"
> > $ udevadm info -q all -a /sys/devices/system/memory/memory90
> > 	KERNEL=="memory90"
> > 	SUBSYSTEM=="memory"
> > 	DRIVER==""
> > 	ATTR{online}=="1"
> > 	ATTR{phys_device}=="0"
> > 	ATTR{phys_index}=="0000005a"
> > 	ATTR{removable}=="1"
> > 	ATTR{state}=="online"
> > 	ATTR{type}=="dimm"
> > 	ATTR{valid_zones}=="Normal"
> > 
> > 
> > RFC -> RFCv2:
> > - Now also taking care of PPC (somehow missed it :/ )
> > - Split the series up to some degree (some ideas on how to split up patch 3
> >   would be very welcome)
> > - Introduce more memory block types. Turns out abstracting too much was
> >   rather confusing and not helpful. Properly document them.
> > 
> > Notes:
> > - I wanted to convert the enum of types into a named enum but this
> >   provoked all kinds of different errors. For now, I am doing it just like
> >   the other types (e.g. online_type) we are using in that context.
> > - The "removable" property should never have been named like that. It
> >   should have been "offlinable". Can we still rename that? E.g. boot memory
> >   is sometimes marked as removable ...
> > 
> 
> 
> Any feedback regarding the suggested block types would be very much
> appreciated!

I still do not like this much to be honest. I just didn't get to think
through this properly. My fear is that this is conflating an actual API
with the current implementation and as such will cause problems in
future. But I haven't really looked into your patches closely so I might
be wrong. Anyway I won't be able to look into it by the end of year.
-- 
Michal Hocko
SUSE Labs
