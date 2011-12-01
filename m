Return-Path: <prashantsmailcenter@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D21DAB6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 15:22:01 +1100 (EST)
Received: by eaai13 with SMTP id i13so1653801eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 20:21:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322712006.3729.14.camel@pasglop>
References: <CAD6p20evHeESH1UwpB4rg8NTxndAtQW9C1S1bpJWFLmS-rOu5w@mail.gmail.com>
 <1322712006.3729.14.camel@pasglop>
Date: Thu, 1 Dec 2011 09:51:56 +0530
Message-ID: <CAD6p20eX5uq=w5JU19+-x=bAPJ9tBSDanH46n22S6SFuFXbP_Q@mail.gmail.com>
Subject: Re: lmb_alloc() and page memory overlap
From: Prashant Bhole <prashantsmailcenter@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 1, 2011 at 9:30 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2011-11-29 at 18:51 +0530, Prashant Bhole wrote:
>> Hi,
>> I am using custom 460ex board with kernel version 2.6.30.
>> I noticed that page_alloc() is returning a page whose memory
>> is already allocated by lmb_alloc() while unflattening the device
>> tree. As per my knowledge the memory allocated by lmb_alloc()
>> should be reserved till the end, right?
>
> This should have been fixed in memblock in recent kernel, at least I
> believe it is. It looks like this is caused by overlapping lmb_reserve()
> at boot (or lmb_reserve() overlapping an lmb_alloc'ated region which
> boils down to the same thing).
>
> Old lmb didn't deal with that well at all and that lead to corruption of
> the lmb list. We fixed that in
>
> 8f7a66051b7523108c5aefb08c6a637e54aedc47
>
> =A0 =A0mm/memblock: properly handle overlaps and fix error path
>
> Which got merged in 2.6.39.
>
> If you absolutely need to stick to 2.6.30, you can try backporting the
> fix to lmb.
>
> Cheers,
> Ben.
>

I need to stick to 2.6.30, will try backporting the fix. Is this the same t=
hing
which is causing the wrong page (already allocated memory) allocation?



>> Some more explanation of what I observed:
>>
>> unflatten_device_tree() allocates memory, which will be used
>> for "struct node" objects in the device tree. I obtained base
>> address of allocated memory in "unsigned long base_mem"
>>
>> Now I executed the following code after the kernel booted properly.
>>
>> ---------------------------------------------------------------
>> extern unsigned long mem; // lmb_alloc() memory
>> struct page *test_page =3D virt_to_page(mem);
>> struct page *new_page =3D NULL;
>>
>> while(1)
>> {
>> =A0 =A0 new_page =3D NULL;
>> =A0 =A0 new_page =3D alloc_page(GFP_KERNEL);
>> =A0 =A0 if(!new_page)
>> =A0 =A0 {
>> =A0 =A0 =A0 =A0 printk("Allocation failed\n");
>> =A0 =A0 =A0 =A0 while(1);
>> =A0 =A0 }
>> =A0 =A0 if(test_page =3D=3D new_page)
>> =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0printk("Memory already allocated by lmb_alloc\n");
>> =A0 =A0 =A0 =A0 =A0while(1);
>> =A0 =A0 }
>> }
>> ---------------------------------------------------------------
>>
>> After many page allocations, I always hit the condition (test_page =3D=
=3D new_page).
>> Am I doing anything wrong here?
>> Has anybody faced this kind of problem before?
>>
>>
>> I also noticed that lmb_dump_all() shows 2 regions overlapping (last two=
):
>>
>> LMB configuration:
>> =A0rmo_size =A0 =A0=3D 0x30000000
>> =A0memory.size =3D 0x30000000
>> =A0memory.cnt =A0=3D 0x1
>> =A0memory[0x0] =A0 =A00x0000000000000000 - 0x000000002fffffff, 0x3000000=
0 bytes
>> =A0reserved.cnt =A0=3D 0x6
>> =A0reserved[0x0] =A00x0000000000000000 - 0x00000000006bffff, 0x6c0000 by=
tes
>> =A0reserved[0x1] =A00x0000000000ffa000 - 0x0000000000ffcfff, 0x3000 byte=
s
>> =A0reserved[0x2] =A00x000000002fdd0000 - 0x000000002fddffff, 0x10000 byt=
es
>> =A0reserved[0x3] =A00x000000002fde4000 - 0x000000002fde9fff, 0x6000 byte=
s
>> =A0reserved[0x4] =A00x000000002fdeb060 - 0x000000002ffff768, 0x214709 by=
tes
>> =A0reserved[0x5] =A00x000000002fdee000 - 0x000000002ffff769, 0x21176a by=
tes
>>
>>
>> Thanks,
>> Prashant
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>

Thanks,
Prashant
