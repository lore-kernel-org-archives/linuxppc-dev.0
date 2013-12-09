Return-Path: <vhtnguyen@apm.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
 by ozlabs.org (Postfix) with SMTP id 59BB62C017F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 19:44:44 +1100 (EST)
Received: by mail-bk0-f47.google.com with SMTP id mx12so1239501bkb.34
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Dec 2013 00:44:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1386377017-909-1-git-send-email-imirkin@alum.mit.edu>
References: <1386377017-909-1-git-send-email-imirkin@alum.mit.edu>
Date: Mon, 9 Dec 2013 15:38:23 +0700
Message-ID: <CAM9eBokeHwgDnddrH5PVNK9bCT7b1_7GA98DsJaUwKPJfLCvgw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/44x: fix ocm_block allocation
From: Vinh Huu Tuong Nguyen <vhtnguyen@apm.com>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Content-Type: multipart/alternative; boundary=bcaec52c68ff35a2f704ed15ebc8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--bcaec52c68ff35a2f704ed15ebc8
Content-Type: text/plain; charset=ISO-8859-1

Hi Ilia Mirkin,
Thanks for your info. I did investigated why our test didn't detect it and
found out that the struct ocm_block is only used on ocm_debugfs_show
function when we want to know information about ocm and it's available when
we enable debugfs. But our test only tried to use the OCM block functions
and didn't care about the OCM information. So I think we should apply your
patch to solve this issue instead of removing ocm part.




On Sat, Dec 7, 2013 at 7:43 AM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:

> Allocate enough memory for the ocm_block structure, not just a pointer
> to it.
>
> Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
> ---
>
> I have neither the hardware to test nor the toolchain to even build-test
> this. However this seems like a fairly obvious fix (and I have to wonder
> how
> this ever worked at all). Found with spatch.
>
> Actually further investigation makes it seem like this function is never
> called, perhaps it should just be removed? If it is kept around though,
> would
> be nice to apply this patch so that tools don't trip over this wrong code.
>
>  arch/powerpc/sysdev/ppc4xx_ocm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/ppc4xx_ocm.c
> b/arch/powerpc/sysdev/ppc4xx_ocm.c
> index b7c4345..85d9e37 100644
> --- a/arch/powerpc/sysdev/ppc4xx_ocm.c
> +++ b/arch/powerpc/sysdev/ppc4xx_ocm.c
> @@ -339,7 +339,7 @@ void *ppc4xx_ocm_alloc(phys_addr_t *phys, int size,
> int align,
>                 if (IS_ERR_VALUE(offset))
>                         continue;
>
> -               ocm_blk = kzalloc(sizeof(struct ocm_block *), GFP_KERNEL);
> +               ocm_blk = kzalloc(sizeof(struct ocm_block), GFP_KERNEL);
>                 if (!ocm_blk) {
>                         printk(KERN_ERR "PPC4XX OCM: could not allocate
> ocm block");
>                         rh_free(ocm_reg->rh, offset);
> --
> 1.8.3.2
>
>


-- 

 *Vinh Nguyen Huu Tuong **|** Staff SW Engineer*

C: 090.335.7841 | O: 083.770.0640 ext: 3719

F: 083.770.0641 | vhtnguyen@apm.com

--bcaec52c68ff35a2f704ed15ebc8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=A0<span style=3D"font-family:arial,sans-serif;font-size=
:13px">Ilia Mirkin,</span><div><font face=3D"arial, sans-serif">Thanks for =
your info. I did investigated why our test didn&#39;t detect it and found o=
ut that the struct ocm_block is only used on=A0ocm_debugfs_show function wh=
en we want to know information about ocm and it&#39;s available when we ena=
ble debugfs. But our test only tried to use the OCM block functions and did=
n&#39;t care about the OCM information. So I think we should apply your pat=
ch to solve this issue instead of removing ocm part.</font></div>
<div><font face=3D"arial, sans-serif"><br></font></div><div><font face=3D"a=
rial, sans-serif"><br></font></div></div><div class=3D"gmail_extra"><br><br=
><div class=3D"gmail_quote">On Sat, Dec 7, 2013 at 7:43 AM, Ilia Mirkin <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:imirkin@alum.mit.edu" target=3D"_blank=
">imirkin@alum.mit.edu</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Allocate enough memory for the ocm_block str=
ucture, not just a pointer<br>
to it.<br>
<br>
Signed-off-by: Ilia Mirkin &lt;<a href=3D"mailto:imirkin@alum.mit.edu">imir=
kin@alum.mit.edu</a>&gt;<br>
---<br>
<br>
I have neither the hardware to test nor the toolchain to even build-test<br=
>
this. However this seems like a fairly obvious fix (and I have to wonder ho=
w<br>
this ever worked at all). Found with spatch.<br>
<br>
Actually further investigation makes it seem like this function is never<br=
>
called, perhaps it should just be removed? If it is kept around though, wou=
ld<br>
be nice to apply this patch so that tools don&#39;t trip over this wrong co=
de.<br>
<br>
=A0arch/powerpc/sysdev/ppc4xx_ocm.c | 2 +-<br>
=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/arch/powerpc/sysdev/ppc4xx_ocm.c b/arch/powerpc/sysdev/ppc4xx_=
ocm.c<br>
index b7c4345..85d9e37 100644<br>
--- a/arch/powerpc/sysdev/ppc4xx_ocm.c<br>
+++ b/arch/powerpc/sysdev/ppc4xx_ocm.c<br>
@@ -339,7 +339,7 @@ void *ppc4xx_ocm_alloc(phys_addr_t *phys, int size, int=
 align,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR_VALUE(offset))<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocm_blk =3D kzalloc(sizeof(struct ocm_block *=
), GFP_KERNEL);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocm_blk =3D kzalloc(sizeof(struct ocm_block),=
 GFP_KERNEL);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ocm_blk) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR &quot;PPC4X=
X OCM: could not allocate ocm block&quot;);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rh_free(ocm_reg-&gt;rh, off=
set);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.3.2<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><table style=3D"BORDER-COLLAPSE:collapse" border=3D"0" cellspacing=3D"0" =
cellpadding=3D"0" align=3D"left">
<tbody>
<tr>
<td style=3D"PADDING-BOTTOM:0.75pt;PADDING-LEFT:0.75pt;PADDING-RIGHT:0.75pt=
;PADDING-TOP:0.75pt">
<p style=3D"MARGIN:6pt"><span style=3D"COLOR:black;FONT-SIZE:7.5pt"><img sr=
c=3D"https://sites.google.com/a/apm.com/logosig/_/rsrc/1278012978742/home/a=
pm_sig_left_063010.jpg"></span></p></td>
<td style=3D"PADDING-BOTTOM:0.75pt;PADDING-LEFT:0.75pt;PADDING-RIGHT:0.75pt=
;PADDING-TOP:0.75pt">
<p style=3D"LINE-HEIGHT:12.2pt;MARGIN:0in 6pt 0pt"><b><span style=3D"COLOR:=
#7f7f7f;FONT-SIZE:9pt">Vinh Nguyen Huu Tuong=A0</span></b><b><span style=3D=
"COLOR:#8cc63f;FONT-SIZE:9pt">|</span></b><b><span style=3D"COLOR:#7f7f7f;F=
ONT-SIZE:9pt">=A0Staff SW Engineer</span></b></p>

<p style=3D"LINE-HEIGHT:12.2pt;MARGIN:0in 6pt 0pt"><span style=3D"COLOR:#7f=
7f7f;FONT-SIZE:9pt">C: 090.335.7841=A0</span><span style=3D"COLOR:#8cc63f;F=
ONT-SIZE:9pt">|</span><span style=3D"COLOR:#7f7f7f;FONT-SIZE:9pt">=A0O: 083=
.770.0640 ext: 3719</span><span style=3D"COLOR:black;FONT-SIZE:12pt"></span=
></p>

<p style=3D"LINE-HEIGHT:12.2pt;MARGIN:0in 6pt 0pt"><span style=3D"COLOR:#7f=
7f7f;FONT-SIZE:9pt">F: 083.770.0641</span><span style=3D"COLOR:#8cc63f;FONT=
-SIZE:9pt"> |</span><span style=3D"COLOR:#7f7f7f;FONT-SIZE:9pt">=A0<a href=
=3D"mailto:vhtnguyen@apm.com" target=3D"_blank"><span>vhtnguyen@apm.com</sp=
an></a></span><span style=3D"FONT-FAMILY:&#39;Times New Roman&#39;,&#39;ser=
if&#39;;COLOR:black;FONT-SIZE:12pt"></span></p>
</td></tr></tbody></table><br>
<div><br></div>
<div><br></div>
<div><br></div>
<div><br></div>
<div><br></div>
<div><br></div>
</div>

--bcaec52c68ff35a2f704ed15ebc8--
