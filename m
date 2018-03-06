Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwt5V5LnhzF1Ng
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 10:19:26 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id w12-v6so221391plp.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 15:19:26 -0800 (PST)
Date: Wed, 7 Mar 2018 09:19:14 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/10] powerpc/mm/slice: Switch to 3-operand slice
 bitops helpers
Message-ID: <20180307091914.70557fb1@roar.ozlabs.ibm.com>
In-Reply-To: <49fb018e-50b2-a37c-e329-19b5d4f87942@c-s.fr>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-8-npiggin@gmail.com>
 <49fb018e-50b2-a37c-e329-19b5d4f87942@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Mar 2018 15:44:46 +0100
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 06/03/2018 à 14:25, Nicholas Piggin a écrit :
> > This converts the slice_mask bit operation helpers to be the usual
> > 3-operand kind, which is clearer to work with.  
> 
> What's the real benefit of doing that ?

One or two places where we want to combine 2 const input bitmaps
and can avoid the extra copy in the next patch.

E.g., slice_or_mask(&good_mask, maskp, compat_maskp);

> 
> It is helps for a subsequent patch, say it.

Fair point, I'll add to the changelog.

> > @@ -433,25 +433,33 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
> >   		return slice_find_area_bottomup(mm, len, mask, psize, high_limit);
> >   }
> >   
> > -static inline void slice_or_mask(struct slice_mask *dst,
> > +static inline void slice_copy_mask(struct slice_mask *dst,
> >   					const struct slice_mask *src)  
> 
> This new function is not used, the compiler while probably not be happy.

I think it doesn't get so grumpy with inlines (otherwise we'd have a lot
of problems of headers). Usually I think the new function should go into
the patch where it's first used, but this being a self contained helper,
I thought it fit better to add here. Maybe I'm wrong, I can move it.
