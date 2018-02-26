Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqxFr3ybfzF1Fp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 09:24:32 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id j143so5658802ywb.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 14:24:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180226140826.11641-3-aneesh.kumar@linux.vnet.ibm.com>
References: <20180226140826.11641-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180226140826.11641-3-aneesh.kumar@linux.vnet.ibm.com>
From: Nicholas Piggin <nicholas.piggin@gmail.com>
Date: Tue, 27 Feb 2018 08:24:29 +1000
Message-ID: <CANashXPZ=KZdixoqCoO7hTy4z7kJLqAst6C-77fg7OdAdfe8EA@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] powerpc/mm/slice: Reduce the stack usage in
 slice_get_unmapped_area
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="001a1143270e3d34a1056624f90b"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1143270e3d34a1056624f90b
Content-Type: text/plain; charset="UTF-8"

I had a series which goes significantly further with stack reduction. What
do you think about just going with that?

I wonder if we should switch to dynamically allocating the slice stuff on
ppc64

On 27 Feb. 2018 00:28, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
wrote:

> This patch kill potential_mask and compat_mask variable and instead use
> tmp_mask
> so that we can reduce the stack usage. This is required so that we can
> increase
> the high_slices bitmap to a larger value.
>
> The patch does result in extra computation in final stage, where it ends up
> recomputing the compat mask again.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/slice.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 259bbda9a222..832c681c341a 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -413,8 +413,7 @@ unsigned long slice_get_unmapped_area(unsigned long
> addr, unsigned long len,
>  {
>         struct slice_mask mask;
>         struct slice_mask good_mask;
> -       struct slice_mask potential_mask;
> -       struct slice_mask compat_mask;
> +       struct slice_mask tmp_mask;
>         int fixed = (flags & MAP_FIXED);
>         int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
>         unsigned long page_size = 1UL << pshift;
> @@ -449,11 +448,8 @@ unsigned long slice_get_unmapped_area(unsigned long
> addr, unsigned long len,
>         bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
>
>         /* silence stupid warning */;
> -       potential_mask.low_slices = 0;
> -       bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
> -
> -       compat_mask.low_slices = 0;
> -       bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
> +       tmp_mask.low_slices = 0;
> +       bitmap_zero(tmp_mask.high_slices, SLICE_NUM_HIGH);
>
>         /* Sanity checks */
>         BUG_ON(mm->task_size == 0);
> @@ -502,9 +498,11 @@ unsigned long slice_get_unmapped_area(unsigned long
> addr, unsigned long len,
>  #ifdef CONFIG_PPC_64K_PAGES
>         /* If we support combo pages, we can allow 64k pages in 4k slices
> */
>         if (psize == MMU_PAGE_64K) {
> -               slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask,
> high_limit);
> +               slice_mask_for_size(mm, MMU_PAGE_4K, &tmp_mask,
> high_limit);
>                 if (fixed)
> -                       slice_or_mask(&good_mask, &compat_mask);
> +                       slice_or_mask(&good_mask, &tmp_mask);
> +
> +               slice_print_mask("Mask for compat page size", tmp_mask);
>         }
>  #endif
>         /* First check hint if it's valid or if we have MAP_FIXED */
> @@ -541,11 +539,11 @@ unsigned long slice_get_unmapped_area(unsigned long
> addr, unsigned long len,
>          * We don't fit in the good mask, check what other slices are
>          * empty and thus can be converted
>          */
> -       slice_mask_for_free(mm, &potential_mask, high_limit);
> -       slice_or_mask(&potential_mask, &good_mask);
> -       slice_print_mask(" potential", potential_mask);
> +       slice_mask_for_free(mm, &tmp_mask, high_limit);
> +       slice_or_mask(&tmp_mask, &good_mask);
> +       slice_print_mask("Free area/potential ", tmp_mask);
>
> -       if ((addr != 0 || fixed) && slice_check_fit(mm, mask,
> potential_mask)) {
> +       if ((addr != 0 || fixed) && slice_check_fit(mm, mask, tmp_mask)) {
>                 slice_dbg(" fits potential !\n");
>                 goto convert;
>         }
> @@ -571,7 +569,7 @@ unsigned long slice_get_unmapped_area(unsigned long
> addr, unsigned long len,
>         /* Now let's see if we can find something in the existing slices
>          * for that size plus free slices
>          */
> -       addr = slice_find_area(mm, len, potential_mask,
> +       addr = slice_find_area(mm, len, tmp_mask,
>                                psize, topdown, high_limit);
>
>  #ifdef CONFIG_PPC_64K_PAGES
> @@ -585,9 +583,10 @@ unsigned long slice_get_unmapped_area(unsigned long
> addr, unsigned long len,
>                  * mask variable is free here. Use that for compat
>                  * size mask.
>                  */
> +               slice_mask_for_size(mm, MMU_PAGE_4K, &mask, high_limit);
>                 /* retry the search with 4k-page slices included */
> -               slice_or_mask(&potential_mask, &compat_mask);
> -               addr = slice_find_area(mm, len, potential_mask,
> +               slice_or_mask(&tmp_mask, &mask);
> +               addr = slice_find_area(mm, len, tmp_mask,
>                                        psize, topdown, high_limit);
>         }
>  #endif
> @@ -600,8 +599,9 @@ unsigned long slice_get_unmapped_area(unsigned long
> addr, unsigned long len,
>         slice_print_mask(" mask", mask);
>
>   convert:
> +       slice_mask_for_size(mm, MMU_PAGE_4K, &tmp_mask, high_limit);
>         slice_andnot_mask(&mask, &good_mask);
> -       slice_andnot_mask(&mask, &compat_mask);
> +       slice_andnot_mask(&mask, &tmp_mask);
>         if (mask.low_slices || !bitmap_empty(mask.high_slices,
> SLICE_NUM_HIGH)) {
>                 slice_convert(mm, mask, psize);
>                 if (psize > MMU_PAGE_BASE)
> --
> 2.14.3
>
>

--001a1143270e3d34a1056624f90b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I had a series which goes significantly further with stac=
k reduction. What do you think about just going with that?<div dir=3D"auto"=
><br></div><div dir=3D"auto">I wonder if we should switch to dynamically al=
locating the slice stuff on ppc64</div></div><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">On 27 Feb. 2018 00:28, &quot;Aneesh Kumar K.V&q=
uot; &lt;<a href=3D"mailto:aneesh.kumar@linux.vnet.ibm.com">aneesh.kumar@li=
nux.vnet.ibm.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">This patch kill potential_mask and compat_mask variable and i=
nstead use tmp_mask<br>
so that we can reduce the stack usage. This is required so that we can incr=
ease<br>
the high_slices bitmap to a larger value.<br>
<br>
The patch does result in extra computation in final stage, where it ends up=
<br>
recomputing the compat mask again.<br>
<br>
Signed-off-by: Aneesh Kumar K.V &lt;<a href=3D"mailto:aneesh.kumar@linux.vn=
et.ibm.com">aneesh.kumar@linux.vnet.ibm.<wbr>com</a>&gt;<br>
---<br>
=C2=A0arch/powerpc/mm/slice.c | 34 +++++++++++++++++-------------<wbr>----<=
br>
=C2=A01 file changed, 17 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c<br>
index 259bbda9a222..832c681c341a 100644<br>
--- a/arch/powerpc/mm/slice.c<br>
+++ b/arch/powerpc/mm/slice.c<br>
@@ -413,8 +413,7 @@ unsigned long slice_get_unmapped_area(<wbr>unsigned lon=
g addr, unsigned long len,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct slice_mask mask;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct slice_mask good_mask;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct slice_mask potential_mask;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct slice_mask compat_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct slice_mask tmp_mask;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int fixed =3D (flags &amp; MAP_FIXED);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int pshift =3D max_t(int, mmu_psize_defs[psize]=
.shift, PAGE_SHIFT);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long page_size =3D 1UL &lt;&lt; pshift=
;<br>
@@ -449,11 +448,8 @@ unsigned long slice_get_unmapped_area(<wbr>unsigned lo=
ng addr, unsigned long len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* silence stupid warning */;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0potential_mask.low_slices =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bitmap_zero(potential_mask.<wbr>high_slices, SL=
ICE_NUM_HIGH);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0compat_mask.low_slices =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bitmap_zero(compat_mask.high_<wbr>slices, SLICE=
_NUM_HIGH);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp_mask.low_slices =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bitmap_zero(tmp_mask.high_<wbr>slices, SLICE_NU=
M_HIGH);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Sanity checks */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG_ON(mm-&gt;task_size =3D=3D 0);<br>
@@ -502,9 +498,11 @@ unsigned long slice_get_unmapped_area(<wbr>unsigned lo=
ng addr, unsigned long len,<br>
=C2=A0#ifdef CONFIG_PPC_64K_PAGES<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If we support combo pages, we can allow 64k =
pages in 4k slices */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (psize =3D=3D MMU_PAGE_64K) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slice_mask_for_size=
(mm, MMU_PAGE_4K, &amp;compat_mask, high_limit);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slice_mask_for_size=
(mm, MMU_PAGE_4K, &amp;tmp_mask, high_limit);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fixed)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0slice_or_mask(&amp;good_mask, &amp;compat_mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0slice_or_mask(&amp;good_mask, &amp;tmp_mask);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slice_print_mask(&q=
uot;Mask for compat page size&quot;, tmp_mask);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* First check hint if it&#39;s valid or if we =
have MAP_FIXED */<br>
@@ -541,11 +539,11 @@ unsigned long slice_get_unmapped_area(<wbr>unsigned l=
ong addr, unsigned long len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We don&#39;t fit in the good mask, chec=
k what other slices are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* empty and thus can be converted<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0slice_mask_for_free(mm, &amp;potential_mask, hi=
gh_limit);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0slice_or_mask(&amp;potential_mask, &amp;good_ma=
sk);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0slice_print_mask(&quot; potential&quot;, potent=
ial_mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0slice_mask_for_free(mm, &amp;tmp_mask, high_lim=
it);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0slice_or_mask(&amp;tmp_mask, &amp;good_mask);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0slice_print_mask(&quot;Free area/potential &quo=
t;, tmp_mask);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((addr !=3D 0 || fixed) &amp;&amp; slice_che=
ck_fit(mm, mask, potential_mask)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((addr !=3D 0 || fixed) &amp;&amp; slice_che=
ck_fit(mm, mask, tmp_mask)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slice_dbg(&quot; fi=
ts potential !\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto convert;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -571,7 +569,7 @@ unsigned long slice_get_unmapped_area(<wbr>unsigned lon=
g addr, unsigned long len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Now let&#39;s see if we can find something i=
n the existing slices<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* for that size plus free slices<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D slice_find_area(mm, len, potential_mas=
k,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D slice_find_area(mm, len, tmp_mask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0psize, topdown, high_limit);<br>
<br>
=C2=A0#ifdef CONFIG_PPC_64K_PAGES<br>
@@ -585,9 +583,10 @@ unsigned long slice_get_unmapped_area(<wbr>unsigned lo=
ng addr, unsigned long len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* mask variab=
le is free here. Use that for compat<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* size mask.<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slice_mask_for_size=
(mm, MMU_PAGE_4K, &amp;mask, high_limit);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* retry the search=
 with 4k-page slices included */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slice_or_mask(&amp;=
potential_mask, &amp;compat_mask);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D slice_find=
_area(mm, len, potential_mask,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slice_or_mask(&amp;=
tmp_mask, &amp;mask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D slice_find=
_area(mm, len, tmp_mask,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0psize, to=
pdown, high_limit);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
@@ -600,8 +599,9 @@ unsigned long slice_get_unmapped_area(<wbr>unsigned lon=
g addr, unsigned long len,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 slice_print_mask(&quot; mask&quot;, mask);<br>
<br>
=C2=A0 convert:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0slice_mask_for_size(mm, MMU_PAGE_4K, &amp;tmp_m=
ask, high_limit);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 slice_andnot_mask(&amp;mask, &amp;good_mask);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0slice_andnot_mask(&amp;mask, &amp;compat_mask);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0slice_andnot_mask(&amp;mask, &amp;tmp_mask);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mask.low_slices || !bitmap_empty(mask.high_=
<wbr>slices, SLICE_NUM_HIGH)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slice_convert(mm, m=
ask, psize);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (psize &gt; MMU_=
PAGE_BASE)<br>
--<br>
2.14.3<br>
<br>
</blockquote></div></div>

--001a1143270e3d34a1056624f90b--
