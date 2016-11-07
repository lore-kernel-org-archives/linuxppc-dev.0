Return-Path: <kda@linux-powerpc.org>
Received: from mail-yb0-x242.google.com (mail-yb0-x242.google.com
 [IPv6:2607:f8b0:4002:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC6ml2vcpzDt1r
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 20:37:43 +1100 (AEDT)
Received: by mail-yb0-x242.google.com with SMTP id v78so2716873ybe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 01:37:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161107083824.23300-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161107083824.23300-1-aneesh.kumar@linux.vnet.ibm.com>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Mon, 7 Nov 2016 12:37:40 +0300
Message-ID: <CAOJe8K1pV2Yx+qCcLwbi1cLZbDYs1Ccux3q7OuUe_iyA38ELBg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: Add _PAGE_DEVMAP pte bit for ppc64.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=94eb2c14ed6c734ca70540b2c642
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c14ed6c734ca70540b2c642
Content-Type: text/plain; charset=UTF-8

On Monday, November 7, 2016, Aneesh Kumar K.V <
aneesh.kumar@linux.vnet.ibm.com> wrote:

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com
> <javascript:;>>


Hi Aneesh,

> ---
> NOTE: We need other patches to enable pmem on ppc64. I am waiting
> for dax pmd fault handling cleanup to hit upstream before I send
> the changes. Meanwhile reserve the pte bit.
>
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 24
> ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h
> b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 9eed9d66d24f..af9e1a150ae7 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -32,6 +32,8 @@
>  #define _PAGE_SOFT_DIRTY       0x00000
>  #endif
>  #define _PAGE_SPECIAL          _RPAGE_SW2 /* software: special page */
> +#define _PAGE_DEVMAP           _RPAGE_SW1
> +#define __HAVE_ARCH_PTE_DEVMAP
>
>
>  #define _PAGE_PTE              (1ul << 62)     /* distinguishes PTEs from
> pointers */
> @@ -485,6 +487,16 @@ static inline pte_t pte_mkhuge(pte_t pte)
>         return pte;
>  }
>
> +static inline pte_t pte_mkdevmap(pte_t pte)
> +{
> +       return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
> +}
> +
> +static inline int pte_devmap(pte_t pte)
> +{
> +       return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
> +}
>
> This could be bool, right?

 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
>         /* FIXME!! check whether this need to be a conditional */
> @@ -1030,6 +1042,18 @@ static inline bool arch_needs_pgtable_deposit(void)
>         return true;
>  }
>
> +static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> +{
> +       /*
> +        * No special ptes at pmd level.
> +        */
> +       return __pmd(pmd_val(pmd) | _PAGE_DEVMAP);
> +}
> +
> +static inline int pmd_devmap(pmd_t pmd)
> +{
> +       return pte_devmap(pmd_pte(pmd));
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif /* __ASSEMBLY__ */
>  #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
> --
> 2.10.2
>
>

--94eb2c14ed6c734ca70540b2c642
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 7, 2016, Aneesh Kumar K.V &lt;<a href=3D"mailto=
:aneesh.kumar@linux.vnet.ibm.com">aneesh.kumar@linux.vnet.ibm.com</a>&gt; w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Signed-off-by: Aneesh Kumar K.V &lt=
;<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;aneesh.=
kumar@linux.vnet.ibm.com&#39;)">aneesh.kumar@linux.vnet.ibm.com</a>&gt;</bl=
ockquote><div><br></div><div>Hi Aneesh,=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
---<br>
NOTE: We need other patches to enable pmem on ppc64. I am waiting<br>
for dax pmd fault handling cleanup to hit upstream before I send<br>
the changes. Meanwhile reserve the pte bit.<br>
<br>
=C2=A0arch/powerpc/include/asm/<wbr>book3s/64/pgtable.h | 24 ++++++++++++++=
++++++++++<br>
=C2=A01 file changed, 24 insertions(+)<br>
<br>
diff --git a/arch/powerpc/include/asm/<wbr>book3s/64/pgtable.h b/arch/power=
pc/include/asm/<wbr>book3s/64/pgtable.h<br>
index 9eed9d66d24f..af9e1a150ae7 100644<br>
--- a/arch/powerpc/include/asm/<wbr>book3s/64/pgtable.h<br>
+++ b/arch/powerpc/include/asm/<wbr>book3s/64/pgtable.h<br>
@@ -32,6 +32,8 @@<br>
=C2=A0#define _PAGE_SOFT_DIRTY=C2=A0 =C2=A0 =C2=A0 =C2=A00x00000<br>
=C2=A0#endif<br>
=C2=A0#define _PAGE_SPECIAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _RPAGE_SW2 /*=
 software: special page */<br>
+#define _PAGE_DEVMAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_RPAGE_SW1<br=
>
+#define __HAVE_ARCH_PTE_DEVMAP<br>
<br>
<br>
=C2=A0#define _PAGE_PTE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1u=
l &lt;&lt; 62)=C2=A0 =C2=A0 =C2=A0/* distinguishes PTEs from pointers */<br=
>
@@ -485,6 +487,16 @@ static inline pte_t pte_mkhuge(pte_t pte)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return pte;<br>
=C2=A0}<br>
<br>
+static inline pte_t pte_mkdevmap(pte_t pte)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE=
_DEVMAP);<br>
+}<br>
+<br>
+static inline int pte_devmap(pte_t pte)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return !!(pte_raw(pte) &amp; cpu_to_be64(_PAGE_=
DEVMAP));<br>
+}<br><br></blockquote><div>This could be bool, right?=C2=A0</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
=C2=A0static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME!! check whether this need to be a cond=
itional */<br>
@@ -1030,6 +1042,18 @@ static inline bool arch_needs_pgtable_deposit(<wbr>v=
oid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
+static inline pmd_t pmd_mkdevmap(pmd_t pmd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * No special ptes at pmd level.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return __pmd(pmd_val(pmd) | _PAGE_DEVMAP);<br>
+}<br>
+<br>
+static inline int pmd_devmap(pmd_t pmd)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return pte_devmap(pmd_pte(pmd));<br>
+}<br>
=C2=A0#endif /* CONFIG_TRANSPARENT_HUGEPAGE */<br>
=C2=A0#endif /* __ASSEMBLY__ */<br>
=C2=A0#endif /* _ASM_POWERPC_BOOK3S_64_<wbr>PGTABLE_H_ */<br>
--<br>
2.10.2<br>
<br>
</blockquote>

--94eb2c14ed6c734ca70540b2c642--
