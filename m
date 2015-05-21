Return-Path: <mr.triggtrigg@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE0FF1A00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 13:36:50 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so92515526pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 20:36:48 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-BA454BD8-9228-4D7A-8BBF-5C1AE172D4CE
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] cxl: Export AFU error buffer via sysfs
From: trigg <mr.triggtrigg@gmail.com>
In-Reply-To: <1432165570.27130.5.camel@neuling.org>
Date: Thu, 21 May 2015 09:06:43 +0530
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ian Munsie <imunsie@au1.ibm.com>
Message-Id: <DFEFF502-9818-4AC2-ADDC-B5A16A047D71@gmail.com>
References: <1432142313-7741-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <1432165570.27130.5.camel@neuling.org>
To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-BA454BD8-9228-4D7A-8BBF-5C1AE172D4CE
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> On 21-May-2015, at 05:16, Michael Neuling <mikey@neuling.org> wrote:
>=20
> + */
>> +ssize_t cxl_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
>> +                loff_t off, size_t count)
>> +{
>> +    loff_t aligned_off;
>> +    size_t aligned_count;
>> +    const void __iomem *ebuf =3D afu->afu_desc_mmio + afu->eb_offset;
>> +
>> +    if (!afu->eb_len || count =3D=3D 0 || off < 0)
>=20
> if eb_len =3D=3D 0 we don't even create the sysfs file.  So is this check
> needed?
This function is non static so it can be potentially called from kernel.
Condition check of "if (count =3D=3D 0 || off < 0 || (size_t)off >=3D afu->e=
b_len) "
should work solving the problem below too.
>=20
>> +        return 0;
>> +
>> +    /* calculate aligned read window */
>> +    count =3D min((size_t)(afu->eb_len - off), count);
>=20
> What if count ends up being negative because off > afu->eb_len??
Agreed. Thanks for catching this. Size_t being unsigned would overflow
To a large positive value.

>=20
>> +    aligned_off =3D round_down(off, 8);
>> +    aligned_count =3D round_up(off + count, 8) - aligned_off;
>=20
> I kinda preferred the start end variables, and length was just end -
> start.
>=20
> I though it was more readable. IMHO
>=20
> How about:
>=20
>   aligned_start =3D round_down(off, 8);
>   aligned_end =3D round_up(off + count, 8);
>   aligned_length =3D aligned_end - aligned_start;
Agreed on aligned_start and aligned_end but would not
need aligned_end in rest of the code.
>=20
>> +
>> +    /* fast path */
>> +    if ((aligned_off =3D=3D off) && (aligned_count =3D=3D count)) {
>> +        /* no need to use the bounce buffer */
>> +        _memcpy_fromio(buf, ebuf + off, count);
>=20
> I would drop this, as the other code path should work fine.
> Premature optimisation.....
I am inclined to differ on this. Code below uses a bounce buffer
which needs more than double the amount of loads and stores.
If the caller wants to speed up things it can simply ask for aligned
read that won't have this overhead. This will be especially useful=20
In large reads.

>> +
>> +    } else {
>> +        /* use bounce buffer for copy */
>> +        void *tbuf =3D (void *)__get_free_page(GFP_TEMPORARY);
>> +
>> +        if (!tbuf)
>> +            return -ENOMEM;
>> +
>> +        /* max we can copy in one read is PAGE_SIZE */
>> +        aligned_count =3D min(aligned_count, PAGE_SIZE);
>> +        _memcpy_fromio(tbuf, ebuf + aligned_off, aligned_count);
>> +
>> +        count =3D min(count, aligned_count);
Thanks for catching this.

>=20
> This doesn't seem right.  count will equal PAGE_SIZE if it's too big but
> it has to be smaller by (off & 7) in this case.
>=20
> How about this?
>=20
>       #define MAX_COPY_SIZE PAGE_SIZE
>   ...
>=20
>   void *bbuf;
>=20
>   /* Bounds check count with err buf length */
>   count =3D min((size_t)(afu->eb_len - off), count);
>   if ((off < 0) || (count < 0))
>       return 0;
>=20
>   /* Create aligned bounce buffer to copy into */
>   aligned_start =3D round_down(off, 8);
>   aligned_end =3D round_up(off + count, 8);
>   aligned_length =3D aligned_end - aligned_start;
>=20
>   if (aligned_length > MAX_COPY_SIZE) {
>       aligned_length =3D MAX_COPY_SIZE;
>       count =3D MAX_COPY_SIZE - (off & 0x7);
>       }
>=20
>   bbuf =3D (void *)__get_free_page(GFP_TEMPORARY);
>   if (!bbuf)
>       return -ENOMEM;
>=20
>   /* Use _memcpy_fromio() so the reads are aligned */
>   _memcpy_fromio(bbuf, ebuf + aligned_start, aligned_length);
>   memcpy(buf, bbuf + (off & 0x7), count);
>=20
>   free_page(bbuf);
>=20
>=20
>> +        memcpy(buf, tbuf + (off & 0x7), count);
>> +
>> +        free_page((unsigned long)tbuf);
>> +    }
>> +
>> +    return count;
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--Apple-Mail-BA454BD8-9228-4D7A-8BBF-5C1AE172D4CE
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div><span></span></div><div><span></span><=
br><blockquote type=3D"cite"><span>On 21-May-2015, at 05:16, Michael Neuling=
 &lt;<a href=3D"mailto:mikey@neuling.org">mikey@neuling.org</a>&gt; wrote:</=
span><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquot=
e><blockquote type=3D"cite"><span>+ */</span><br></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>+ssize_t cxl_afu_read_err_buffer=
(struct cxl_afu *afu, char *buf,</span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;loff_t of=
f, size_t count)</span><br></blockquote></blockquote><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><span>+{</span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;=
loff_t aligned_off;</span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;size_t aligned_cou=
nt;</span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquot=
e type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;const void __iomem *ebuf =3D afu-&=
gt;afu_desc_mmio + afu-&gt;eb_offset;</span><br></blockquote></blockquote><b=
lockquote type=3D"cite"><blockquote type=3D"cite"><span>+</span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
+ &nbsp;&nbsp;&nbsp;</span><font color=3D"#000000"><span style=3D"background=
-color: rgba(255, 255, 255, 0);">if (!afu-&gt;eb_len || count =3D=3D 0 || of=
f &lt; 0)</span></font><br></blockquote></blockquote><blockquote type=3D"cit=
e"><span></span><br></blockquote><blockquote type=3D"cite"><span>if eb_len =3D=
=3D 0 we don't even create the sysfs file. &nbsp;So is this check</span><br>=
</blockquote><blockquote type=3D"cite"><span>needed?</span><br></blockquote>=
<span>This function is non static so it can be potentially called from kerne=
l.</span><br><span>Condition check of "</span><span style=3D"background-colo=
r: rgba(255, 255, 255, 0);">if (count =3D=3D 0 || off &lt; 0 || (size_t)off &=
gt;=3D&nbsp;afu-&gt;eb_len) "</span></div><div>should work solving the probl=
em below too.<br><blockquote type=3D"cite"><span></span><br></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><blockquote type=3D"cite"><span>+</span><br></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+ &nb=
sp;&nbsp;&nbsp;/* calculate aligned read window */</span><br></blockquote></=
blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp=
;&nbsp;&nbsp;count =3D min((size_t)(afu-&gt;eb_len - off), count);</span><br=
></blockquote></blockquote><blockquote type=3D"cite"><span></span><br></bloc=
kquote><blockquote type=3D"cite"><span>What if count ends up being negative b=
ecause off &gt; afu-&gt;eb_len??</span><br></blockquote><span>Agreed. Thanks=
 for catching this. Size_t being unsigned would overflow</span><br><span>To a=
 large positive value.</span><br><span></span><br><blockquote type=3D"cite">=
<span></span><br></blockquote><blockquote type=3D"cite"><blockquote type=3D"=
cite"><span>+ &nbsp;&nbsp;&nbsp;aligned_off =3D round_down(off, 8);</span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>+ &nbsp;&nbsp;&nbsp;aligned_count =3D round_up(off + count, 8) - a=
ligned_off;</span><br></blockquote></blockquote><blockquote type=3D"cite"><s=
pan></span><br></blockquote><blockquote type=3D"cite"><span>I kinda preferre=
d the start end variables, and length was just end -</span><br></blockquote>=
<blockquote type=3D"cite"><span>start.</span><br></blockquote><blockquote ty=
pe=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>I t=
hough it was more readable. IMHO</span><br></blockquote><blockquote type=3D"=
cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>How abou=
t:</span><br></blockquote><blockquote type=3D"cite"><span></span><br></block=
quote><blockquote type=3D"cite"><span> &nbsp;&nbsp;aligned_start =3D round_d=
own(off, 8);</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&=
nbsp;aligned_end =3D round_up(off + count, 8);</span><br></blockquote><block=
quote type=3D"cite"><span> &nbsp;&nbsp;aligned_length =3D aligned_end - alig=
ned_start;</span><br></blockquote><span>Agreed on aligned_start and aligned_=
end but would not</span><br><span>need aligned_end in rest of the code.</spa=
n><br><blockquote type=3D"cite"><span></span><br></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>+</span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbs=
p;&nbsp;/* fast path */</span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;if ((aligned_o=
ff =3D=3D off) &amp;&amp; (aligned_count =3D=3D count)) {</span><br></blockq=
uote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>=
+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* no need to use the bounce buf=
fer */</span><br></blockquote></blockquote><blockquote type=3D"cite"><blockq=
uote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_memcpy=
_fromio(buf, ebuf + off, count);</span><br></blockquote></blockquote><blockq=
uote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><=
span>I would drop this, as the other code path should work fine.</span><br><=
/blockquote><blockquote type=3D"cite"><span>Premature optimisation.....</spa=
n><br></blockquote><span>I am inclined to differ on this. Code below uses a b=
ounce buffer</span><br><span>which needs more than double the amount of load=
s and stores.</span><br><span>If the caller wants to speed up things it can s=
imply ask for aligned</span><br><span>read that won't have this overhead. Th=
is will be especially useful </span><br><span>In large reads.</span><br><spa=
n></span><br><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+</sp=
an><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D=
"cite"><span>+ &nbsp;&nbsp;&nbsp;} else {</span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;/* use bounce buffer for copy */</span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;void *tbuf =3D (void *)__get_=
free_page(GFP_TEMPORARY);</span><br></blockquote></blockquote><blockquote ty=
pe=3D"cite"><blockquote type=3D"cite"><span>+</span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!tbuf)</span><br></blockquote></blockquo=
te><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -ENOMEM;</span><=
br></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"c=
ite"><span>+</span><br></blockquote></blockquote><blockquote type=3D"cite"><=
blockquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/=
* max we can copy in one read is PAGE_SIZE */</span><br></blockquote></block=
quote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+ &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aligned_count =3D min(aligned_count, PAGE_SI=
ZE);</span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquo=
te type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_memcpy_f=
romio(tbuf, ebuf + aligned_off, aligned_count);</span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+</span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;count =3D min(count, a=
ligned_count);</span><br></blockquote></blockquote><span>Thanks for catching=
 this.</span><br><span></span><br><blockquote type=3D"cite"><span></span><br=
></blockquote><blockquote type=3D"cite"><span>This doesn't seem right. &nbsp=
;count will equal PAGE_SIZE if it's too big but</span><br></blockquote><bloc=
kquote type=3D"cite"><span>it has to be smaller by (off &amp; 7) in this cas=
e.</span><br></blockquote><blockquote type=3D"cite"><span></span><br></block=
quote><blockquote type=3D"cite"><span>How about this?</span><br></blockquote=
><blockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D=
"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#define MAX_COPY_SIZE PAGE=
_SIZE</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;..=
.</span><br></blockquote><blockquote type=3D"cite"><span></span><br></blockq=
uote><blockquote type=3D"cite"><span> &nbsp;&nbsp;void *bbuf;</span><br></bl=
ockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote=
 type=3D"cite"><span> &nbsp;&nbsp;/* Bounds check count with err buf length *=
/</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;count =3D=
 min((size_t)(afu-&gt;eb_len - off), count);</span><br></blockquote><blockqu=
ote type=3D"cite"><span> &nbsp;&nbsp;if ((off &lt; 0) || (count &lt; 0))</sp=
an><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;return 0;</span><br></blockquote><blockquote type=3D"cite"><spa=
n></span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;/* Cr=
eate aligned bounce buffer to copy into */</span><br></blockquote><blockquot=
e type=3D"cite"><span> &nbsp;&nbsp;aligned_start =3D round_down(off, 8);</sp=
an><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;aligned_end=
 =3D round_up(off + count, 8);</span><br></blockquote><blockquote type=3D"ci=
te"><span> &nbsp;&nbsp;aligned_length =3D aligned_end - aligned_start;</span=
><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><b=
lockquote type=3D"cite"><span> &nbsp;&nbsp;if (aligned_length &gt; MAX_COPY_=
SIZE) {</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;aligned_length =3D MAX_COPY_SIZE;</span><br></blockq=
uote><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;co=
unt =3D MAX_COPY_SIZE - (off &amp; 0x7);</span><br></blockquote><blockquote t=
ype=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</span><br></blockq=
uote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote typ=
e=3D"cite"><span> &nbsp;&nbsp;bbuf =3D (void *)__get_free_page(GFP_TEMPORARY=
);</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;if (!=
bbuf)</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;return -ENOMEM;</span><br></blockquote><blockquote typ=
e=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span> &n=
bsp;&nbsp;/* Use _memcpy_fromio() so the reads are aligned */</span><br></bl=
ockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;_memcpy_fromio(bbuf, e=
buf + aligned_start, aligned_length);</span><br></blockquote><blockquote typ=
e=3D"cite"><span> &nbsp;&nbsp;memcpy(buf, bbuf + (off &amp; 0x7), count);</s=
pan><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote=
><blockquote type=3D"cite"><span> &nbsp;&nbsp;free_page(bbuf);</span><br></b=
lockquote><blockquote type=3D"cite"><span></span><br></blockquote><blockquot=
e type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><blo=
ckquote type=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memc=
py(buf, tbuf + (off &amp; 0x7), count);</span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>+</span><br></bloc=
kquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><spa=
n>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;free_page((unsigned long)tbuf)=
;</span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>+ &nbsp;&nbsp;&nbsp;}</span><br></blockquote></blockquote=
><blockquote type=3D"cite"><blockquote type=3D"cite"><span>+</span><br></blo=
ckquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><sp=
an>+ &nbsp;&nbsp;&nbsp;return count;</span><br></blockquote></blockquote><bl=
ockquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cit=
e"><span>_______________________________________________</span><br></blockqu=
ote><blockquote type=3D"cite"><span>Linuxppc-dev mailing list</span><br></bl=
ockquote><blockquote type=3D"cite"><span><a href=3D"mailto:Linuxppc-dev@list=
s.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a></span><br></blockquote><bloc=
kquote type=3D"cite"><span><a href=3D"https://lists.ozlabs.org/listinfo/linu=
xppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></span><br></blo=
ckquote></div></body></html>=

--Apple-Mail-BA454BD8-9228-4D7A-8BBF-5C1AE172D4CE--
