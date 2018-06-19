Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4198Wy1BmpzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 23:51:35 +1000 (AEST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JDiFgC017662
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 13:51:31 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by aserp2130.oracle.com with ESMTP id 2jmr2mgcks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 13:51:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5JDpUkk021572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 13:51:30 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5JDpTIS028783
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 13:51:29 GMT
Received: by mail-oi0-f54.google.com with SMTP id t133-v6so18197540oif.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 06:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz>
 <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
In-Reply-To: <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 19 Jun 2018 09:50:52 -0400
Message-ID: <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
To: jslaby@suse.cz
Cc: mhocko@kernel.org, Steven Sistare <steven.sistare@oracle.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, benh@kernel.crashing.org,
 paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>,
 kirill.shutemov@linux.intel.com, Reza Arbab <arbab@linux.vnet.ibm.com>,
 schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>,
 x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-s390@vger.kernel.org, mgorman@techsingularity.net
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 16, 2018 at 4:04 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 11/21/2017, 08:24 AM, Michal Hocko wrote:
> > On Thu 16-11-17 20:46:01, Pavel Tatashin wrote:
> >> There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
> >> as all the page initialization code is in common code.
> >>
> >> Also, there is no need to depend on MEMORY_HOTPLUG, as initialization code
> >> does not really use hotplug memory functionality. So, we can remove this
> >> requirement as well.
> >>
> >> This patch allows to use deferred struct page initialization on all
> >> platforms with memblock allocator.
> >>
> >> Tested on x86, arm64, and sparc. Also, verified that code compiles on
> >> PPC with CONFIG_MEMORY_HOTPLUG disabled.
> >
> > There is slight risk that we will encounter corner cases on some
> > architectures with weird memory layout/topology
>
> Which x86_32-pae seems to be. Many bad page state errors are emitted
> during boot when this patch is applied:

Hi Jiri,

Thank you for reporting this bug.

Because 32-bit systems are limited in the maximum amount of physical
memory, they don't need deferred struct pages. So, we can add depends
on 64BIT to DEFERRED_STRUCT_PAGE_INIT in mm/Kconfig.

However, before we do this, I want to try reproducing this problem and
root cause it, as it might expose a general problem that is not 32-bit
specific.

Thank you,
Pavel
