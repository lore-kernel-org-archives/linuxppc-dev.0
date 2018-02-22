Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znGnK3t60zDqH0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 01:24:05 +1100 (AEDT)
Subject: Re: [PATCH v4 2/5] powerpc/mm/slice: Enhance for supporting PPC32
To: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
 <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
 <20180211235944.14c2be39@roar.ozlabs.ibm.com>
 <ba493b6c-c61a-5097-e896-5ae3f0128b3a@linux.vnet.ibm.com>
 <20180212093435.20200712@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <c2d1fb88-ced1-2674-d320-8c66f6f5e5c5@c-s.fr>
Date: Thu, 22 Feb 2018 15:24:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180212093435.20200712@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/02/2018 à 00:34, Nicholas Piggin a écrit :
> On Sun, 11 Feb 2018 21:04:42 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
>> On 02/11/2018 07:29 PM, Nicholas Piggin wrote:
>>> On Sat, 10 Feb 2018 13:54:27 +0100 (CET)
>>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>    
>>>> In preparation for the following patch which will fix an issue on
>>>> the 8xx by re-using the 'slices', this patch enhances the
>>>> 'slices' implementation to support 32 bits CPUs.
>>>>
>>>> On PPC32, the address space is limited to 4Gbytes, hence only the low
>>>> slices will be used.
>>>>
>>>> This patch moves "slices" functions prototypes from page64.h to slice.h
>>>>
>>>> The high slices use bitmaps. As bitmap functions are not prepared to
>>>> handling bitmaps of size 0, the bitmap_xxx() calls are wrapped into
>>>> slice_bitmap_xxx() functions which will void on PPC32
>>>
>>> On this last point, I think it would be better to put these with the
>>> existing slice bitmap functions in slice.c and just have a few #ifdefs
>>> for SLICE_NUM_HIGH == 0.
>>>    
>>
>> We went back and forth with that. IMHO, we should avoid as much #ifdef
>> as possible across platforms. It helps to understand the platform
>> restrictions better as we have less and less access to these platforms.
>> The above change indicates that nohash 32 wants to use the slice code
>> and they have different restrictions. With that we now know that
>> book3s64 and nohash 32 are the two different configs using slice code.
> 
> I don't think it's the right place to put it. It's not platform dependent
> so much as it just depends on whether or not you have 0 high slices as
> a workaround for bitmap API not accepting 0 length.
> 
> Another platform that uses the slice code would just have to copy and
> paste either the nop or the bitmap implementation depending if it has
> high slices. So I don't think it's the right abstraction. And it
> implies a bitmap operation but it very specifically only works for
> struct slice_mask.high_slices bitmap, which is not clear. Better to
> just work with struct slice_mask.
> 
> Some ifdefs inside .c code for small helper functions like this IMO isn't
> really a big deal -- it's not worse than having it in headers. You just
> want to avoid ifdef mess when looking at non-trivial logic.
> 
> static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
> {
>      dst->low_slices |= src->low_slices;
> #if SLICE_NUM_HIGH > 0
>      bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
> #endif
> }
> 
> I think that's pretty fine. If you have a singular hatred for ifdef in .c,
> then if() works just as well.
> 

To be honest, I tend to agree with you. Therefore, after a few words
with Michael, v5 gets rid of those obscure wrappers to come back to the 
initial (v1) approach which was to use 'if (SLICE_NUM_HIGH)'.
Behind the fact that it in my mind looks cleared in the code than using 
slice_bitmap_xxx() wrappers, it also has the advantage of significantly 
reducing the size of the patch, which is a must to be able to get it 
applied on stable.

Christophe
