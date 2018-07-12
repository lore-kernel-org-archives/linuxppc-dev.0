Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RK9l6cF4zDr10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 01:10:03 +1000 (AEST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CEwb34134241
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 15:10:00 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
 by aserp2120.oracle.com with ESMTP id 2k2p7e443p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 15:10:00 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6CF9vAu031132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 15:09:57 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6CF9vhZ015727
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 15:09:57 GMT
Received: by mail-oi0-f43.google.com with SMTP id b15-v6so56357274oib.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 08:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
 <87lgai9bt5.fsf@concordia.ellerman.id.au>
 <20180711133737.GA29573@techadventures.net>
 <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
 <CAOXBz7ixEK85S-029XrM4+g4fxtSY6_tke0gcQ-hOXFCb7wcZg@mail.gmail.com>
 <87efg981rd.fsf@concordia.ellerman.id.au>
 <20180712095002.GA5342@techadventures.net>
In-Reply-To: <20180712095002.GA5342@techadventures.net>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 12 Jul 2018 11:09:20 -0400
Message-ID: <CAGM2reb=KeLH7KKUP+7-u27nJxvTcBskhtS2cDH8SwiiEZ1jNQ@mail.gmail.com>
Subject: Re: Boot failures with "mm/sparse: Remove
 CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER"
 on powerpc (was Re: mmotm 2018-07-10-16-50 uploaded)
To: osalvador@techadventures.net
Cc: mpe@ellerman.id.au, osalvador.vilardaga@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
 mhocko@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
 aneesh.kumar@linux.ibm.com, khandual@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 12, 2018 at 5:50 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> > > I just roughly check, but if I checked the right place,
> > > vmemmap_populated() checks for the section to contain the flags we are
> > > setting in sparse_init_one_section().
> >
> > Yes.
> >
> > > But with this patch, we populate first everything, and then we call
> > > sparse_init_one_section() in sparse_init().
> > > As I said I could be mistaken because I just checked the surface.

Yes, this is right, sparse_init_one_section() is needed after every
populate call on ppc64. I am adding this to my sparse_init re-write,
and it actually simplifies code, as it avoids one extra loop, and
makes ppc64 to work.

Pavel
