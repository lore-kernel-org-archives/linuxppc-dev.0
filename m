Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0136.outbound.protection.outlook.com [207.46.100.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00DCE1A1BDE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 02:28:25 +1000 (AEST)
Message-ID: <1440520092.16577.9.camel@freescale.com>
Subject: Re: [PATCH v6 1/3] genalloc:support memory-allocation with
 bytes-alignment to genalloc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: Laura Abbott <labbott@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "lauraa@codeaurora.org"
 <lauraa@codeaurora.org>, Xie Xiaobo-R63061 <X.Xie@freescale.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Li Yang-Leo-R58472
 <LeoLi@freescale.com>, "paulus@samba.org" <paulus@samba.org>
Date: Tue, 25 Aug 2015 11:28:12 -0500
In-Reply-To: <SN1PR0301MB1550544FC379016F263EDCDD9B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
 <55DBA477.5020608@redhat.com>
 <SN1PR0301MB155021CDD677EFB6D1EAE79F9B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <55DBE896.9030702@redhat.com>
 <SN1PR0301MB1550544FC379016F263EDCDD9B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-25 at 03:09 -0500, Zhao Qiang-B45475 wrote:
> On 08/25/2015 12:01 PM, Laura Abbott wrote:
> 
> > -----Original Message-----
> > From: Laura Abbott [mailto:labbott@redhat.com]
> > Sent: Tuesday, August 25, 2015 12:01 PM
> > To: Zhao Qiang-B45475; Wood Scott-B07421
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH v6 1/3] genalloc:support memory-allocation with
> > bytes-alignment to genalloc
> > 
> > On 08/24/2015 07:40 PM, Zhao Qiang wrote:
> > > On 08/25/2015 07:11 AM, Laura Abbott wrote:
> > > > -----Original Message-----
> > > > From: Laura Abbott [mailto:labbott@redhat.com]
> > > > Sent: Tuesday, August 25, 2015 7:11 AM
> > > > To: Zhao Qiang-B45475; Wood Scott-B07421
> > > > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > > > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org;
> > > > Li Yang-Leo-R58472; paulus@samba.org
> > > > Subject: Re: [PATCH v6 1/3] genalloc:support memory-allocation with
> > > > bytes-alignment to genalloc
> > > > 
> > > > On 08/24/2015 02:31 AM, Zhao Qiang wrote:
> > > > > Bytes alignment is required to manage some special RAM, so add
> > > > > gen_pool_first_fit_align to genalloc, meanwhile add
> > > > > gen_pool_alloc_data to pass data to gen_pool_first_fit_align(modify
> > > > > gen_pool_alloc as a wrapper)
> > > > > 
> > > > > Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> > > > > ---
> > > > > Changes for v6:
> > > > >       - patches set v6 include a new patch because of using
> > > > >       - genalloc to manage QE MURAM, patch 0001 is the new
> > > > >       - patch, adding bytes alignment for allocation for use.
> > > > > 
> > > > >    include/linux/genalloc.h | 23 +++++++++++++++----
> > > > >    lib/genalloc.c           | 58
> > > > +++++++++++++++++++++++++++++++++++++++++++-----
> > > > >    2 files changed, 72 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
> > > > > index 1ccaab4..55da07e 100644
> > > > > --- a/include/linux/genalloc.h
> > > > > +++ b/include/linux/genalloc.h
> > > > > @@ -34,6 +34,7 @@
> > > > > 
> > > > >    struct device;
> > > > >    struct device_node;
> > > > > +struct gen_pool;
> > > > > 
> > > > >    /**
> > > > >     * Allocation callback function type definition @@ -47,7 +48,7 @@
> > > > > typedef unsigned long (*genpool_algo_t)(unsigned long *map,
> > > > >                       unsigned long size,
> > > > >                       unsigned long start,
> > > > >                       unsigned int nr,
> > > > > -                     void *data);
> > > > > +                     void *data, struct gen_pool *pool);
> > > > > 
> > > > >    /*
> > > > >     *  General purpose special memory pool descriptor.
> > > > > @@ -73,6 +74,13 @@ struct gen_pool_chunk {
> > > > >       unsigned long bits[0];          /* bitmap for allocating memory
> > chunk
> > > > */
> > > > >    };
> > > > > 
> > > > > +/*
> > > > > + *  gen_pool data descriptor for gen_pool_first_fit_align.
> > > > > + */
> > > > > +struct genpool_data_align {
> > > > > +     int align;              /* alignment by bytes for starting address */
> > > > > +};
> > > > > +
> > > > 
> > > > (sorry for chiming in late, I've been traveling)
> > > > 
> > > > Is there an advantage here to wrapping this in a structure instead of
> > > > just passing a pointer to an align integer?
> > > 
> > > 
> > > Please look at the commit message for
> > > ca279cf1065fb689abea1dc7d8c11787729bb185 which adds "data":
> > > 
> > > "As I can't predict all the possible requirements/needs for all
> > > allocation uses cases, I add a "free" field 'void *data' to pass any
> > > needed information to the allocation function.  For example 'data'
> > > could be used to handle a structure where you store the alignment, the
> > > expected memory bank, the requester device, or any information that
> > > could influence the allocation algorithm."
> > > 
> > 
> > Right, I understand what the purpose is but I'm not sure what you're
> > getting from the structure vs passing a pointer, e.g.
> > 
> > int align;
> > 
> > align = 4;
> > 
> > gen_pool_alloc_data(&pool, size, &align);
> > 
> > it just seems to obfuscate what's going on by wrapping a single integer
> > in a structure that's narrowly defined in a generic function right now. I
> > guess it could change later which would necessitate having the structure
> > but again it's so generic I'm not sure what else you would pass that
> > would be applicable to all clients.
> 
> Scott and me have discussed about this issue in my RFC patch.
> Please review: http://patchwork.ozlabs.org/patch/493297/

I don't see anything relevant in that discussion.  I tend to favor always 
using a struct for this type of opaque data, for consistency and 
extendability, but in this case it really doesn't matter much either way.

-Scott
