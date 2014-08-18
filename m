Return-Path: <bobby.prani@gmail.com>
Received: from mail-la0-x22a.google.com (mail-la0-x22a.google.com
 [IPv6:2a00:1450:4010:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE4581A003A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 06:52:45 +1000 (EST)
Received: by mail-la0-f42.google.com with SMTP id pv20so5104645lab.29
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 13:52:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXutLPeyDYHdRJ6Heb4vhtg=zMTpwOpKq1h4Yyk8exUSQ@mail.gmail.com>
References: <1408388465-26577-1-git-send-email-bobby.prani@gmail.com>
 <CAMuHMdXutLPeyDYHdRJ6Heb4vhtg=zMTpwOpKq1h4Yyk8exUSQ@mail.gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 18 Aug 2014 16:52:09 -0400
Message-ID: <CAJhHMCDE8e019oLvO7QEcAB-=yqkmgF4OS2VwRrJNV+vvXOe5Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix build failure for PPC_32
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: multipart/alternative; boundary=001a11c34d2e35ce9c0500ed8de1
Cc: Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Gerhard Sittig <gsi@denx.de>,
 open list <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c34d2e35ce9c0500ed8de1
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 18, 2014 at 3:28 PM, Geert Uytterhoeven <geert@linux-m68k.org>
wrote:

> Hi Pranith,
>
> On Mon, Aug 18, 2014 at 9:01 PM, Pranith Kumar <bobby.prani@gmail.com>
> wrote:
> > Fix ppc 32 build failure as reported here:
> >
> > http://kisskb.ellerman.id.au/kisskb/buildresult/11663513/
>
> | arch/powerpc/include/asm/floppy.h:142:20: error: 'isa_bridge_pcidev'
> undeclared (first use in this function)
> | make[3]: *** [drivers/block/floppy.o] Error 1
>
> The definition of isa_bridge_pcidev is only available if CONFIG_PCI=y...
>
> > The error is that pci_32.o was not being built for PPC_32. Fix error by
> adding
> > it in the Makefile. Tested using the ppc cross compiler.
>
> ... so how can adding this make the floppy.h error go away?
>

So the definition which you are talking about within CONFIG_PCI=y is an
extern definition

arch/powerpc/include/asm/ppc-pci.h:28:extern struct pci_dev
*isa_bridge_pcidev;

If you build pci_32.o unconditionally, there is an

EXPORT_SYMBOL(isa_bridge_pcidev);

which supplies the required symbol.

But yes, you are right in that we should not unconditionally compile
pci_32.o. Making floppy depend on PCI is the right thing to do. However,


>
> Note that arch/powerpc/kernel/Makefile does add
> pci_$(CONFIG_WORD_SIZE).o, but only if CONFIG_PCI=y.
>
> So, thanks for your patch, but I don't think your fix is the right
> solution.
>
> However, drivers/block/floppy.o is enabled by BLK_DEV_FD, which
> depends on ARCH_MAY_HAVE_PC_FDC.
>
> arch/powerpc/Kconfig has:
>
> config ARCH_MAY_HAVE_PC_FDC
>         bool
>         default !PPC_PSERIES || PCI
>
> PCI is not set, and PPC_PSERIES is also not set, so this
> defaults to y, which is obviously not correct, as floppy.h needs PCI.
>
> As this symbol doesn't enable floppy support in-se, probably it should just
> be:
>
> config ARCH_MAY_HAVE_PC_FDC
>         bool
>         depends on PCI
>

the right thing I guess here is to depend on !PPC_PSERIES && PCI since I
guess pSeries does not support floppy.h (hence the original condition
check?).

Note that there are other unrelated errors which do not let me complete the
PPC 32 build with the config there yet. I just verified this symbol error.


> This config line was last touched by
> commit bed59275810a55500e885cbdc5c2a0507f13c00e
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Sun Mar 4 17:04:44 2007 +1100
>
>     [POWERPC] Allow pSeries to build without CONFIG_PCI
>
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>     Signed-off-by: Paul Mackerras <paulus@samba.org>
>


-- 
Pranith

--001a11c34d2e35ce9c0500ed8de1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Aug 18, 2014 at 3:28 PM, Geert Uytterhoeven <span dir=3D"lt=
r">&lt;<a href=3D"mailto:geert@linux-m68k.org" target=3D"_blank">geert@linu=
x-m68k.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi Pranith,<br>
<div class=3D""><br>
On Mon, Aug 18, 2014 at 9:01 PM, Pranith Kumar &lt;<a href=3D"mailto:bobby.=
prani@gmail.com">bobby.prani@gmail.com</a>&gt; wrote:<br>
&gt; Fix ppc 32 build failure as reported here:<br>
&gt;<br>
&gt; <a href=3D"http://kisskb.ellerman.id.au/kisskb/buildresult/11663513/" =
target=3D"_blank">http://kisskb.ellerman.id.au/kisskb/buildresult/11663513/=
</a><br>
<br>
</div>| arch/powerpc/include/asm/floppy.h:142:20: error: &#39;isa_bridge_pc=
idev&#39;<br>
undeclared (first use in this function)<br>
| make[3]: *** [drivers/block/floppy.o] Error 1<br>
<br>
The definition of isa_bridge_pcidev is only available if CONFIG_PCI=3Dy...<=
br>
<div class=3D""><br>
&gt; The error is that pci_32.o was not being built for PPC_32. Fix error b=
y adding<br>
&gt; it in the Makefile. Tested using the ppc cross compiler.<br>
<br>
</div>... so how can adding this make the floppy.h error go away?<br></bloc=
kquote><div><br></div><div>So the definition which you are talking about wi=
thin CONFIG_PCI=3Dy is an extern definition<br><br>arch/powerpc/include/asm=
/ppc-pci.h:28:extern struct pci_dev *isa_bridge_pcidev;<br>

<br></div><div>If you build pci_32.o unconditionally, there is an<br><br>EX=
PORT_SYMBOL(isa_bridge_pcidev); <br><br>which supplies the required symbol.=
 <br><br></div><div>But yes, you are right in that we should not unconditio=
nally compile pci_32.o. Making floppy depend on PCI is the right thing to d=
o. However,<br>

</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Note that arch/powerpc/kernel/Makefile does add<br>
pci_$(CONFIG_WORD_SIZE).o, but only if CONFIG_PCI=3Dy.<br>
<br>
So, thanks for your patch, but I don&#39;t think your fix is the right solu=
tion.<br>
<br>
However, drivers/block/floppy.o is enabled by BLK_DEV_FD, which<br>
depends on ARCH_MAY_HAVE_PC_FDC.<br>
<br>
arch/powerpc/Kconfig has:<br>
<br>
config ARCH_MAY_HAVE_PC_FDC<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default !PPC_PSERIES || PCI<br>
<br>
PCI is not set, and PPC_PSERIES is also not set, so this<br>
defaults to y, which is obviously not correct, as floppy.h needs PCI.<br>
<br>
As this symbol doesn&#39;t enable floppy support in-se, probably it should =
just<br>
be:<br>
<br>
config ARCH_MAY_HAVE_PC_FDC<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on PCI<br></blockquote><div><br></div><=
div>the right thing I guess here is to depend on !PPC_PSERIES &amp;&amp; PC=
I since I guess pSeries does not support floppy.h (hence the original condi=
tion check?).<br>

</div><div>=C2=A0<br></div><div>Note that there are other unrelated errors =
which do not let me complete the PPC 32 build with the config there yet. I =
just verified this symbol error.<br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">


<br>
This config line was last touched by<br>
commit bed59275810a55500e885cbdc5c2a0507f13c00e<br>
Author: Stephen Rothwell &lt;<a href=3D"mailto:sfr@canb.auug.org.au">sfr@ca=
nb.auug.org.au</a>&gt;<br>
Date:=C2=A0 =C2=A0Sun Mar 4 17:04:44 2007 +1100<br>
<br>
=C2=A0 =C2=A0 [POWERPC] Allow pSeries to build without CONFIG_PCI<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Stephen Rothwell &lt;<a href=3D"mailto:sfr@can=
b.auug.org.au">sfr@canb.auug.org.au</a>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Paul Mackerras &lt;<a href=3D"mailto:paulus@sa=
mba.org">paulus@samba.org</a>&gt;<br></blockquote></div><br clear=3D"all"><=
br>-- <br>Pranith
</div></div>

--001a11c34d2e35ce9c0500ed8de1--
