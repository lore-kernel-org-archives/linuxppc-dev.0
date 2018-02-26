Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-yw0-x232.google.com (mail-yw0-x232.google.com
 [IPv6:2607:f8b0:4002:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqx4Y4gg0zF1Tm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 09:16:26 +1100 (AEDT)
Received: by mail-yw0-x232.google.com with SMTP id q184so2060499ywh.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 14:16:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180226140950.12111-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180226140950.12111-1-aneesh.kumar@linux.vnet.ibm.com>
From: Nicholas Piggin <nicholas.piggin@gmail.com>
Date: Tue, 27 Feb 2018 08:16:22 +1000
Message-ID: <CANashXPc952+httE=Vhx=wGrkN3Ycva7j+a+WE6jXQaw38p=YQ@mail.gmail.com>
Subject: Re: [PATCH V2] powerpc: Don't do runtime futex_cmpxchg test
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="94eb2c0ba9f23a90c6056624dcf0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c0ba9f23a90c6056624dcf0
Content-Type: text/plain; charset="UTF-8"

On 27 Feb. 2018 00:34, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
wrote:

futex_detect_cmpxchg() does a cmpxchg_futex_value_locked on a NULL user
addr to
runtime detect whether architecture implements atomic cmpxchg for futex.
POWER
do implement the feature and hence we can enable the config instead of
depending
on runtime detection.

We could possible enable this on everything. For now limitted to book3s_64


I think everything implements it? Might as well do it all at once.

I wouldn't mind putting in an explicit null dereference test if we take
this out.

Thanks,
Nick



Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype
b/arch/powerpc/platforms/Kconfig.cputype
index a429d859f15d..31bc2bd5dfd1 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -75,6 +75,7 @@ config PPC_BOOK3S_64
        select ARCH_SUPPORTS_NUMA_BALANCING
        select IRQ_WORK
        select HAVE_KERNEL_XZ
+       select HAVE_FUTEX_CMPXCHG if FUTEX

 config PPC_BOOK3E_64
        bool "Embedded processors"
--
2.14.3

--94eb2c0ba9f23a90c6056624dcf0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
">On 27 Feb. 2018 00:34, &quot;Aneesh Kumar K.V&quot; &lt;<a href=3D"mailto=
:aneesh.kumar@linux.vnet.ibm.com">aneesh.kumar@linux.vnet.ibm.com</a>&gt; w=
rote:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">futex_detect_cmpxchg=
() does a cmpxchg_futex_value_locked on a NULL user addr to<br>
runtime detect whether architecture implements atomic cmpxchg for futex. PO=
WER<br>
do implement the feature and hence we can enable the config instead of depe=
nding<br>
on runtime detection.<br>
<br>
We could possible enable this on everything. For now limitted to book3s_64<=
br></blockquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I think everything implements it? Might as well do it all at once.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">I wouldn&#39;t mind putting=
 in an explicit null dereference test if we take this out.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Nick</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
Signed-off-by: Aneesh Kumar K.V &lt;<a href=3D"mailto:aneesh.kumar@linux.vn=
et.ibm.com">aneesh.kumar@linux.vnet.ibm.<wbr>com</a>&gt;<br>
---<br>
=C2=A0arch/powerpc/platforms/<wbr>Kconfig.cputype | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/arch/powerpc/platforms/<wbr>Kconfig.cputype b/arch/powerpc/pla=
tforms/<wbr>Kconfig.cputype<br>
index a429d859f15d..31bc2bd5dfd1 100644<br>
--- a/arch/powerpc/platforms/<wbr>Kconfig.cputype<br>
+++ b/arch/powerpc/platforms/<wbr>Kconfig.cputype<br>
@@ -75,6 +75,7 @@ config PPC_BOOK3S_64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select ARCH_SUPPORTS_NUMA_BALANCING<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select IRQ_WORK<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 select HAVE_KERNEL_XZ<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0select HAVE_FUTEX_CMPXCHG if FUTEX<br>
<br>
=C2=A0config PPC_BOOK3E_64<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Embedded processors&quot;<br>
<font color=3D"#888888">--<br>
2.14.3<br>
<br>
</font></blockquote></div><br></div></div></div>

--94eb2c0ba9f23a90c6056624dcf0--
