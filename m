Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VgNZ2L1kzF35s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 12:01:01 +1000 (AEST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I1wljZ189794
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 02:00:59 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2120.oracle.com with ESMTP id 2k7a3431r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 02:00:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I20vh2015556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 02:00:57 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6I20vnb005386
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 02:00:57 GMT
Received: by mail-oi0-f42.google.com with SMTP id y207-v6so5777482oie.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 19:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <1531416305.6480.24.camel@abdul.in.ibm.com>
 <CAGM2rebtisZda0kqhg0u92fTDxC+=zMNNgKFBLH38osphk0fdA@mail.gmail.com>
 <1531473191.6480.26.camel@abdul.in.ibm.com>
 <20180714105500.3694b93f@canb.auug.org.au>
 <1531824532.15016.30.camel@abdul.in.ibm.com>
In-Reply-To: <1531824532.15016.30.camel@abdul.in.ibm.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 17 Jul 2018 22:00:20 -0400
Message-ID: <CAGM2reav2giqHjUTWADWzqb-8m7AqUBJxerA1Oc+4YJhTLXrDA@mail.gmail.com>
Subject: Re: [next-20180711][Oops] linux-next kernel boot is broken on powerpc
To: abdhalee@linux.vnet.ibm.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, sachinp@linux.vnet.ibm.com,
 Michal Hocko <mhocko@suse.com>, sim@linux.vnet.ibm.com,
 venkatb3@in.ibm.com, LKML <linux-kernel@vger.kernel.org>,
 manvanth@linux.vnet.ibm.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-next@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2018 at 6:49 AM Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
>
> On Sat, 2018-07-14 at 10:55 +1000, Stephen Rothwell wrote:
> > Hi Abdul,
> >
> > On Fri, 13 Jul 2018 14:43:11 +0530 Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:
> > >
> > > On Thu, 2018-07-12 at 13:44 -0400, Pavel Tatashin wrote:
> > > > > Related commit could be one of below ? I see lots of patches related to mm and could not bisect
> > > > >
> > > > > 5479976fda7d3ab23ba0a4eb4d60b296eb88b866 mm: page_alloc: restore memblock_next_valid_pfn() on arm/arm64
> > > > > 41619b27b5696e7e5ef76d9c692dd7342c1ad7eb mm-drop-vm_bug_on-from-__get_free_pages-fix
> > > > > 531bbe6bd2721f4b66cdb0f5cf5ac14612fa1419 mm: drop VM_BUG_ON from __get_free_pages
> > > > > 479350dd1a35f8bfb2534697e5ca68ee8a6e8dea mm, page_alloc: actually ignore mempolicies for high priority allocations
> > > > > 088018f6fe571444caaeb16e84c9f24f22dfc8b0 mm: skip invalid pages block at a time in zero_resv_unresv()
> > > >
> > > > Looks like:
> > > > 0ba29a108979 mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> > > >
> > > > This patch is going to be reverted from linux-next. Abdul, please
> > > > verify that issue is gone once  you revert this patch.
> > >
> > > kernel booted fine when the above patch is reverted.
> >
> > And it has been removed from linux-next as of next-20180713.  (Friday
> > the 13th is not all bad :-))
>
> Hi Stephen,
>
> After reverting 0ba29a108979, our bare-metal machines boot fails with
> kernel panic, is this related ?
>
> I have attached the boot logs.

The panic happens much later in boot and looks unrelated to the
sparse_init changes.

Thank you,
Pavel
