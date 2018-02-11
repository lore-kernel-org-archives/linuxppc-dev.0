Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zflX13pyMzDqYv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 10:34:57 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id t4so5270136pgp.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 15:34:57 -0800 (PST)
Date: Mon, 12 Feb 2018 09:34:35 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/5] powerpc/mm/slice: Enhance for supporting PPC32
Message-ID: <20180212093435.20200712@roar.ozlabs.ibm.com>
In-Reply-To: <ba493b6c-c61a-5097-e896-5ae3f0128b3a@linux.vnet.ibm.com>
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
 <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
 <20180211235944.14c2be39@roar.ozlabs.ibm.com>
 <ba493b6c-c61a-5097-e896-5ae3f0128b3a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 11 Feb 2018 21:04:42 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> On 02/11/2018 07:29 PM, Nicholas Piggin wrote:
> > On Sat, 10 Feb 2018 13:54:27 +0100 (CET)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >   
> >> In preparation for the following patch which will fix an issue on
> >> the 8xx by re-using the 'slices', this patch enhances the
> >> 'slices' implementation to support 32 bits CPUs.
> >>
> >> On PPC32, the address space is limited to 4Gbytes, hence only the low
> >> slices will be used.
> >>
> >> This patch moves "slices" functions prototypes from page64.h to slice.h
> >>
> >> The high slices use bitmaps. As bitmap functions are not prepared to
> >> handling bitmaps of size 0, the bitmap_xxx() calls are wrapped into
> >> slice_bitmap_xxx() functions which will void on PPC32  
> > 
> > On this last point, I think it would be better to put these with the
> > existing slice bitmap functions in slice.c and just have a few #ifdefs
> > for SLICE_NUM_HIGH == 0.
> >   
> 
> We went back and forth with that. IMHO, we should avoid as much #ifdef 
> as possible across platforms. It helps to understand the platform 
> restrictions better as we have less and less access to these platforms. 
> The above change indicates that nohash 32 wants to use the slice code 
> and they have different restrictions. With that we now know that 
> book3s64 and nohash 32 are the two different configs using slice code.

I don't think it's the right place to put it. It's not platform dependent
so much as it just depends on whether or not you have 0 high slices as
a workaround for bitmap API not accepting 0 length.

Another platform that uses the slice code would just have to copy and
paste either the nop or the bitmap implementation depending if it has
high slices. So I don't think it's the right abstraction. And it
implies a bitmap operation but it very specifically only works for
struct slice_mask.high_slices bitmap, which is not clear. Better to
just work with struct slice_mask.

Some ifdefs inside .c code for small helper functions like this IMO isn't
really a big deal -- it's not worse than having it in headers. You just
want to avoid ifdef mess when looking at non-trivial logic.

static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
{
    dst->low_slices |= src->low_slices;
#if SLICE_NUM_HIGH > 0
    bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
#endif
}

I think that's pretty fine. If you have a singular hatred for ifdef in .c,
then if() works just as well.

Thanks,
Nick
