Return-Path: <saikia.partha@gmail.com>
Received: from mail-we0-x230.google.com (mail-we0-x230.google.com
 [IPv6:2a00:1450:400c:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 999F02C02A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 22:58:33 +1000 (EST)
Received: by mail-we0-f176.google.com with SMTP id t56so4324495wes.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 05:58:27 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 19 Jun 2013 18:28:27 +0530
Message-ID: <CABeCxOL4n+zyF4y__vqbOw0rzhsCi5E8D=pobAcjjuufaxpGKg@mail.gmail.com>
Subject: DEBUG_PAGEALLOC on PPC not working (kernels 2.6-25, 3.0-34)
From: "saikia.partha" <saikia.partha@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=089e013d1022be29a904df816215
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e013d1022be29a904df816215
Content-Type: text/plain; charset=UTF-8

Hi,

We have two Freescale PowerPC boards on which we're trying to enable
DEBUG_PAGEALLOC with the hope that we'll see an exception whenever some
code tries to modify a page that's been already freed. To test it, we wrote
this sample code -

===
#define BUF_SIZE    4096
void
pagealloc_test(void)
{
    char *buf = kmalloc(BUF_SIZE, GFP_KERNEL);

    if (!buf) {
        printk("%s[%d] - alloc failed!\n", __func__, __LINE__);
        return;
    }
    printk("%s[%d] - alloc'd\n", __func__, __LINE__);
    memset(&buf[0], 0, BUF_SIZE);
    printk("%s[%d] - memset'd\n", __func__, __LINE__);
    kfree(buf);
    printk("%s[%d] - free'd\n", __func__, __LINE__);
    memset(&buf[0], 1, BUF_SIZE);
    printk("%s[%d] - memset'd after free!\n", __func__, __LINE__);
}
===

Here, the last memset() should generate an exception if PAGEALLOC code
correctly unmapped the page during kfree(). However, kernel is happily
running after the memset post-free. Any clue?
Also, the 2nd board has Book-E which has a different MMU architecture.
Here, I saw that the function __change_page_attr() always returns as the
condition v_mapped_by_tlbcam() is true. How do we remove the pte entry from
the TLB in this case?  Has anyone tried DEBUG_PAGEALLOC on Book-E?

Please find the board details below -
Board 1: CPU - e300c4, kernel 2.6-25
====================================
CONFIG_6xx=y
CONFIG_PPC_FPU=y
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_STD_MMU_32=y
CONFIG_PPC32=y
CONFIG_WORD_SIZE=32
CONFIG_PPC_MERGE=y
CONFIG_MMU=y
CONFIG_IRQ_PER_CPU=y
CONFIG_PPC=y

Board 2: CPU - e500v2, kernel 3.0-34
====================================
# CONFIG_PPC_BOOK3S_32 is not set
CONFIG_PPC_85xx=y
CONFIG_E500=y
# CONFIG_PPC_E500MC is not set
CONFIG_FSL_EMB_PERFMON=y
CONFIG_BOOKE=y
CONFIG_FSL_BOOKE=y
CONFIG_PPC_FSL_BOOK3E=y
# CONFIG_PHYS_64BIT is not set
CONFIG_SPE=y
CONFIG_PPC_MMU_NOHASH=y
CONFIG_PPC_MMU_NOHASH_32=y
CONFIG_PPC_BOOK3E_MMU=y
# CONFIG_PPC_MM_SLICES is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_PPC32=y
CONFIG_32BIT=y
CONFIG_WORD_SIZE=32
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
CONFIG_MMU=y
CONFIG_NR_IRQS=512
CONFIG_PPC=y

Regards,
Partha

--089e013d1022be29a904df816215
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>We have two Freescale PowerPC boards on which w=
e&#39;re trying to enable DEBUG_PAGEALLOC with the hope that we&#39;ll see =
an exception whenever some code tries to modify a page that&#39;s been alre=
ady freed. To test it, we wrote this sample code -<br>
<br>=3D=3D=3D<br>#define BUF_SIZE=C2=A0=C2=A0=C2=A0 4096<br>void<br>pageall=
oc_test(void)<br>{<br>=C2=A0=C2=A0=C2=A0 char *buf =3D kmalloc(BUF_SIZE, GF=
P_KERNEL);<br><br>=C2=A0=C2=A0=C2=A0 if (!buf) {<br>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 printk(&quot;%s[%d] - alloc failed!\n&quot;, __func__=
, __LINE__);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>=C2=A0=C2=A0=C2=A0 }<=
br>=C2=A0=C2=A0=C2=A0 printk(&quot;%s[%d] - alloc&#39;d\n&quot;, __func__, =
__LINE__);<br>=C2=A0=C2=A0=C2=A0 memset(&amp;buf[0], 0, BUF_SIZE);<br>=C2=
=A0=C2=A0=C2=A0 printk(&quot;%s[%d] - memset&#39;d\n&quot;, __func__, __LIN=
E__);<br>=C2=A0=C2=A0=C2=A0 kfree(buf);<br>
=C2=A0=C2=A0=C2=A0 printk(&quot;%s[%d] - free&#39;d\n&quot;, __func__, __LI=
NE__);<br>=C2=A0=C2=A0=C2=A0 memset(&amp;buf[0], 1, BUF_SIZE);<br>=C2=A0=C2=
=A0=C2=A0 printk(&quot;%s[%d] - memset&#39;d after free!\n&quot;, __func__,=
 __LINE__);<br>}<br>=3D=3D=3D<br><br>Here, the last memset() should generat=
e an exception if PAGEALLOC code correctly unmapped the page during kfree()=
. However, kernel is happily running after the memset post-free. Any clue? =
<br>
Also, the 2nd board has Book-E which has a different MMU architecture. Here=
, I saw that the function __change_page_attr() always returns as the condit=
ion v_mapped_by_tlbcam() is true. How do we remove the pte entry from the T=
LB in this case?=C2=A0 Has anyone tried DEBUG_PAGEALLOC on Book-E?<br>
<br>Please find the board details below - <br>Board 1: CPU - e300c4, kernel=
 2.6-25<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CONFIG_6xx=3Dy<br>CONFIG_P=
PC_FPU=3Dy<br>CONFIG_PPC_STD_MMU=3Dy<br>CONFIG_PPC_STD_MMU_32=3Dy<br>CONFIG=
_PPC32=3Dy<br>
CONFIG_WORD_SIZE=3D32<br>CONFIG_PPC_MERGE=3Dy<br>CONFIG_MMU=3Dy<br>CONFIG_I=
RQ_PER_CPU=3Dy<br>CONFIG_PPC=3Dy<br><br>Board 2: CPU - e500v2, kernel 3.0-3=
4<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br># CONFIG_PPC_BOOK3S_32 is not se=
t<br>
CONFIG_PPC_85xx=3Dy<br>CONFIG_E500=3Dy<br># CONFIG_PPC_E500MC is not set<br=
>CONFIG_FSL_EMB_PERFMON=3Dy<br>CONFIG_BOOKE=3Dy<br>CONFIG_FSL_BOOKE=3Dy<br>=
CONFIG_PPC_FSL_BOOK3E=3Dy<br># CONFIG_PHYS_64BIT is not set<br>CONFIG_SPE=
=3Dy<br>CONFIG_PPC_MMU_NOHASH=3Dy<br>
CONFIG_PPC_MMU_NOHASH_32=3Dy<br>CONFIG_PPC_BOOK3E_MMU=3Dy<br># CONFIG_PPC_M=
M_SLICES is not set<br>CONFIG_SMP=3Dy<br>CONFIG_NR_CPUS=3D2<br>CONFIG_PPC32=
=3Dy<br>CONFIG_32BIT=3Dy<br>CONFIG_WORD_SIZE=3D32<br># CONFIG_ARCH_PHYS_ADD=
R_T_64BIT is not set<br>
# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set<br>CONFIG_MMU=3Dy<br>CONFIG_NR_IR=
QS=3D512<br>CONFIG_PPC=3Dy<br><br>Regards,<br>Partha<br></div>

--089e013d1022be29a904df816215--
