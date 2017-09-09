Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xqS5l3gwRzDrhq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Sep 2017 07:30:19 +1000 (AEST)
Date: Sun, 10 Sep 2017 07:30:14 +1000
In-Reply-To: <20170908111547.0f30e1a5@kryten>
References: <20170907050551.4632-1-anton@ozlabs.org>
 <ab33351f-1d52-2e55-8aeb-32813ca52e94@linux.vnet.ibm.com>
 <20170907151741.41ee33a8@kryten>
 <20170907155902.kpzhgqqsxbwxwce5@arbab-laptop.localdomain>
 <20170908111547.0f30e1a5@kryten>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----MDY8HTV68M8EGKV60U40LYMJJYW6P7"
Subject: Re: [PATCH] powerpc/powernv: Increase memory block size to 1GB on
 radix
To: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@ozlabs.org>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
CC: mikey@neuling.org, npiggin@gmail.com, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 bharata@linux.vnet.ibm.com, cyrilbur@gmail.com
From: Michael Ellerman <michael@ellerman.id.au>
Message-ID: <943A12E3-39BC-403D-81B3-CCB37993DE9A@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------MDY8HTV68M8EGKV60U40LYMJJYW6P7
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

We should do the 1G block size as a fix, and backport it, and then make the=
 hot unplug code smarter=2E

cheers

On 8 September 2017 11:15:47 am AEST, Anton Blanchard <anton@ozlabs=2Eorg>=
 wrote:
>Hi Reza,
>
>> I may be misunderstanding this, but what if we did something like x86
>
>> does? When trying to unplug a region smaller than the mapping, they
>> fill that part of the pagetable with 0xFD instead of freeing the
>> whole thing=2E Once the whole thing is 0xFD, free it=2E
>>=20
>> See arch/x86/mm/init_64=2Ec:remove_{pte,pmd,pud}_table()
>>=20
>> ---%<---
>> 	memset((void *)addr, PAGE_INUSE, next - addr);
>>=20
>> 	page_addr =3D page_address(pte_page(*pte));
>> 	if (!memchr_inv(page_addr, PAGE_INUSE, PAGE_SIZE)) {
>> 		=2E=2E=2E
>> 		pte_clear(&init_mm, addr, pte);
>> 		=2E=2E=2E
>> 	}
>> ---%<---
>
>But you only have 1GB ptes at this point, you'd need to start
>instantiating a new level in the tree, and populate 2MB ptes=2E
>
>That is what Ben is suggesting=2E I'm happy to go any way (fix hotplug
>to handle this, or increase the memblock size on PowerNV to 1GB), I
>just
>need a solution=2E
>
>Anton

--=20
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E
------MDY8HTV68M8EGKV60U40LYMJJYW6P7
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>We should do the 1G block size as a fix, and backp=
ort it, and then make the hot unplug code smarter=2E<br>
<br>
cheers<br><br><div class=3D"gmail_quote">On 8 September 2017 11:15:47 am A=
EST, Anton Blanchard &lt;anton@ozlabs=2Eorg&gt; wrote:<blockquote class=3D"=
gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid r=
gb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail">Hi Reza,<br /><br /><blockquote class=3D"gmail_quote=
" style=3D"margin: 0pt 0pt 1ex 0=2E8ex; border-left: 1px solid #729fcf; pad=
ding-left: 1ex;"> I may be misunderstanding this, but what if we did someth=
ing like x86 <br /> does? When trying to unplug a region smaller than the m=
apping, they<br /> fill that part of the pagetable with 0xFD instead of fre=
eing the<br /> whole thing=2E Once the whole thing is 0xFD, free it=2E<br /=
> <br /> See arch/x86/mm/init_64=2Ec:remove_{pte,pmd,pud}_table()<br /> <br=
 /> ---%&lt;---<br />  memset((void *)addr, PAGE_INUSE, next - addr);<br />=
 <br />  page_addr =3D page_address(pte_page(*pte));<br />  if (!memchr_inv=
(page_addr, PAGE_INUSE, PAGE_SIZE)) {<br />   =2E=2E=2E<br />   pte_clear(&=
amp;init_mm, addr, pte);<br />   =2E=2E=2E<br />  }<br /> ---%&lt;---<br />=
</blockquote><br />But you only have 1GB ptes at this point, you'd need to =
start<br />instantiating a new level in the tree, and populate 2MB ptes=2E<=
br /><br />That is what Ben is suggesting=2E I'm happy to go any way (fix h=
otplug<br />to handle this, or increase the memblock size on PowerNV to 1GB=
), I just<br />need a solution=2E<br /><br />Anton<br /><br /></pre></block=
quote></div><br>
-- <br>
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E</b=
ody></html>
------MDY8HTV68M8EGKV60U40LYMJJYW6P7--
