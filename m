Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4F2440A2.5080601@gmail.com>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <4F2440A2.5080601@gmail.com>
Date: Sat, 28 Jan 2012 12:10:04 -0700
Message-ID: <CACxGe6swuk51XRzZGU9XPJpzGRtNsw2v3MfVvgtQp3hAUU=1gg@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] irq_domain generalization and refinement
From: Grant Likely <grant.likely@secretlab.ca>
To: Rob Herring <robherring2@gmail.com>
Content-Type: multipart/alternative; boundary=047d7b10d16f5c2e3a04b79b5cf4
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Milton Miller <miltonm@bga.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b10d16f5c2e3a04b79b5cf4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Jan 28, 2012 11:38 AM, "Rob Herring" <robherring2@gmail.com> wrote:
>
> On 01/27/2012 03:35 PM, Grant Likely wrote:
> > Hey everyone,
> >
> > This patch series is ready for much wider consumption now.  I'd like
> > to get it into linux-next ASAP because there will be ARM board support
> > depending on it.  I'll wait a few days before I ask Stephen to pull
> > this in.
> >
> > Stephen/Milton/Ben, any testing you can help with here would be
> > appreciated since you've got access to a wider variety of Power
> > machines than I do.
> >
> > Thomas, I think it makes sense to maintain this in a separate branch
> > from other irq changes until the next merge window.  If you prefer,
> > I'm happy to maintain this branch until then.
> >
>
> I picked up your irqdomain/next branch and it doesn't compile:
>
>  CC      kernel/irq/irqdomain.o
> kernel/irq/irqdomain.c: In function =91irq_create_mapping=92:
> kernel/irq/irqdomain.c:403:47: error: =91irq=92 undeclared (first use in
> this function)
> kernel/irq/irqdomain.c:403:47: note: each undeclared identifier is
> reported only once for each function it app

Oops, I had fixed that but didn't refresh the patch. Change the references
in that function from irq to virq, or pop off the top patch to fix.

I'll push out a fixed tree when I get home.

g.

>
> Rob
>
> > Cheers,
> > g.
> >
> > The following changes since commit
dcd6c92267155e70a94b3927bce681ce74b80d1f:
> >
> >   Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)
> >
> > are available in the git repository at:
> >   git://git.secretlab.ca/git/linux-2.6 irqdomain/next
> >
> > Grant Likely (24):
> >       irq_domain: add documentation and MAINTAINERS entry.
> >       dt: Make irqdomain less verbose
> >       irq_domain: Make irq_domain structure match powerpc's irq_host
> >       irq_domain: convert microblaze from irq_host to irq_domain
> >       irq_domain/powerpc: Use common irq_domain structure instead of
irq_host
> >       irq_domain/powerpc: eliminate irq_map; use irq_alloc_desc()
instead
> >       irq_domain/powerpc: Eliminate virq_is_host()
> >       irq_domain: Move irq_domain code from powerpc to kernel/irq
> >       irqdomain: remove NO_IRQ from irq domain code
> >       irq_domain: Remove references to old irq_host names
> >       irq_domain: Replace irq_alloc_host() with revmap-specific
initializers
> >       irq_domain: Add support for base irq and hwirq in legacy mappings
> >       irq_domain: Remove 'new' irq_domain in favour of the ppc one
> >       irq_domain: Remove irq_domain_add_simple()
> >       irq_domain: Create common xlate functions that device drivers can
use
> >       irq_domain: constify irq_domain_ops
> >       irq_domain/c6x: constify irq_domain structures
> >       irq_domain/c6x: Use library of xlate functions
> >       irq_domain/powerpc: constify irq_domain_ops
> >       irqdomain/powerpc: Replace custom xlate functions with library
functions
> >       irq_domain/x86: Convert x86 (embedded) to use common irq_domain
> >       irq_domain: Include hwirq number in /proc/interrupts
> >       irq_domain: remove "hint" when allocating irq numbers
> >       irq_domain: mostly eliminate slow-path revmap lookups
> >
> > Mark Salter (1):
> >       irq_domain/c6x: Convert c6x to use generic irq_domain support.
> >
> >  Documentation/IRQ-domain.txt                     |  113 +++
> >  MAINTAINERS                                      |    9 +
> >  arch/arm/common/gic.c                            |   95 ++--
> >  arch/arm/common/vic.c                            |   16 +-
> >  arch/arm/include/asm/hardware/gic.h              |    4 +-
> >  arch/arm/include/asm/hardware/vic.h              |    2 +
> >  arch/arm/mach-exynos/common.c                    |    2 +-
> >  arch/arm/mach-imx/mach-imx6q.c                   |    3 +-
> >  arch/arm/mach-msm/board-msm8x60.c                |    8 +-
> >  arch/arm/mach-mx5/imx51-dt.c                     |    4 +-
> >  arch/arm/mach-mx5/imx53-dt.c                     |    4 +-
> >  arch/arm/mach-omap2/board-generic.c              |    2 +-
> >  arch/arm/mach-prima2/irq.c                       |    2 +-
> >  arch/arm/mach-versatile/core.c                   |    5 +-
> >  arch/c6x/Kconfig                                 |    1 +
> >  arch/c6x/include/asm/irq.h                       |  245 +-------
> >  arch/c6x/kernel/irq.c                            |  612
+----------------
> >  arch/c6x/platforms/megamod-pic.c                 |   25 +-
> >  arch/microblaze/include/asm/irq.h                |    4 +-
> >  arch/microblaze/kernel/irq.c                     |    2 +-
> >  arch/microblaze/kernel/setup.c                   |    2 -
> >  arch/powerpc/Kconfig                             |    1 +
> >  arch/powerpc/include/asm/ehv_pic.h               |    2 +-
> >  arch/powerpc/include/asm/i8259.h                 |    2 +-
> >  arch/powerpc/include/asm/irq.h                   |  247 +-------
> >  arch/powerpc/include/asm/mpic.h                  |    2 +-
> >  arch/powerpc/include/asm/xics.h                  |    2 +-
> >  arch/powerpc/kernel/irq.c                        |  617
+----------------
> >  arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |   12 +-
> >  arch/powerpc/platforms/52xx/media5200.c          |   15 +-
> >  arch/powerpc/platforms/52xx/mpc52xx_gpt.c        |   16 +-
> >  arch/powerpc/platforms/52xx/mpc52xx_pic.c        |   12 +-
> >  arch/powerpc/platforms/82xx/pq2ads-pci-pic.c     |   14 +-
> >  arch/powerpc/platforms/85xx/socrates_fpga_pic.c  |   15 +-
> >  arch/powerpc/platforms/86xx/gef_pic.c            |   15 +-
> >  arch/powerpc/platforms/cell/axon_msi.c           |   29 +-
> >  arch/powerpc/platforms/cell/beat_interrupt.c     |   16 +-
> >  arch/powerpc/platforms/cell/interrupt.c          |   16 +-
> >  arch/powerpc/platforms/cell/spider-pic.c         |   14 +-
> >  arch/powerpc/platforms/embedded6xx/flipper-pic.c |   30 +-
> >  arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |   35 +-
> >  arch/powerpc/platforms/iseries/irq.c             |   11 +-
> >  arch/powerpc/platforms/powermac/pic.c            |   26 +-
> >  arch/powerpc/platforms/powermac/smp.c            |    9 +-
> >  arch/powerpc/platforms/ps3/interrupt.c           |   11 +-
> >  arch/powerpc/platforms/wsp/opb_pic.c             |   26 +-
> >  arch/powerpc/sysdev/cpm1.c                       |    9 +-
> >  arch/powerpc/sysdev/cpm2_pic.c                   |   23 +-
> >  arch/powerpc/sysdev/ehv_pic.c                    |   14 +-
> >  arch/powerpc/sysdev/fsl_msi.c                    |   10 +-
> >  arch/powerpc/sysdev/fsl_msi.h                    |    2 +-
> >  arch/powerpc/sysdev/i8259.c                      |   15 +-
> >  arch/powerpc/sysdev/ipic.c                       |   31 +-
> >  arch/powerpc/sysdev/ipic.h                       |    2 +-
> >  arch/powerpc/sysdev/mpc8xx_pic.c                 |   11 +-
> >  arch/powerpc/sysdev/mpic.c                       |   17 +-
> >  arch/powerpc/sysdev/mpic_msi.c                   |    2 +-
> >  arch/powerpc/sysdev/mv64x60_pic.c                |   11 +-
> >  arch/powerpc/sysdev/qe_lib/qe_ic.c               |   26 +-
> >  arch/powerpc/sysdev/qe_lib/qe_ic.h               |    2 +-
> >  arch/powerpc/sysdev/tsi108_pci.c                 |   22 +-
> >  arch/powerpc/sysdev/uic.c                        |   26 +-
> >  arch/powerpc/sysdev/xics/xics-common.c           |   28 +-
> >  arch/powerpc/sysdev/xilinx_intc.c                |   19 +-
> >  arch/x86/Kconfig                                 |    2 +
> >  arch/x86/include/asm/irq_controller.h            |   12 -
> >  arch/x86/include/asm/prom.h                      |   10 -
> >  arch/x86/kernel/devicetree.c                     |  101 +--
> >  drivers/gpio/gpio-mpc8xxx.c                      |   30 +-
> >  drivers/mfd/twl-core.c                           |   12 +-
> >  drivers/net/phy/mdio-gpio.c                      |    4 +-
> >  include/linux/irqdomain.h                        |  190 ++++--
> >  kernel/irq/irqdomain.c                           |  816
+++++++++++++++++++---
> >  kernel/irq/proc.c                                |    3 +
> >  74 files changed, 1334 insertions(+), 2471 deletions(-)
> >  create mode 100644 Documentation/IRQ-domain.txt
> >  delete mode 100644 arch/x86/include/asm/irq_controller.h
> >
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
>

--047d7b10d16f5c2e3a04b79b5cf4
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<p><br>
On Jan 28, 2012 11:38 AM, &quot;Rob Herring&quot; &lt;<a href=3D"mailto:rob=
herring2@gmail.com">robherring2@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 01/27/2012 03:35 PM, Grant Likely wrote:<br>
&gt; &gt; Hey everyone,<br>
&gt; &gt;<br>
&gt; &gt; This patch series is ready for much wider consumption now. =A0I&#=
39;d like<br>
&gt; &gt; to get it into linux-next ASAP because there will be ARM board su=
pport<br>
&gt; &gt; depending on it. =A0I&#39;ll wait a few days before I ask Stephen=
 to pull<br>
&gt; &gt; this in.<br>
&gt; &gt;<br>
&gt; &gt; Stephen/Milton/Ben, any testing you can help with here would be<b=
r>
&gt; &gt; appreciated since you&#39;ve got access to a wider variety of Pow=
er<br>
&gt; &gt; machines than I do.<br>
&gt; &gt;<br>
&gt; &gt; Thomas, I think it makes sense to maintain this in a separate bra=
nch<br>
&gt; &gt; from other irq changes until the next merge window. =A0If you pre=
fer,<br>
&gt; &gt; I&#39;m happy to maintain this branch until then.<br>
&gt; &gt;<br>
&gt;<br>
&gt; I picked up your irqdomain/next branch and it doesn&#39;t compile:<br>
&gt;<br>
&gt; =A0CC =A0 =A0 =A0kernel/irq/irqdomain.o<br>
&gt; kernel/irq/irqdomain.c: In function =91irq_create_mapping=92:<br>
&gt; kernel/irq/irqdomain.c:403:47: error: =91irq=92 undeclared (first use =
in<br>
&gt; this function)<br>
&gt; kernel/irq/irqdomain.c:403:47: note: each undeclared identifier is<br>
&gt; reported only once for each function it app</p>
<p>Oops, I had fixed that but didn&#39;t refresh the patch. Change the refe=
rences in that function from irq to virq, or pop off the top patch to fix.<=
/p>
<p>I&#39;ll push out a fixed tree when I get home.</p>
<p>g.</p>
<p>&gt;<br>
&gt; Rob<br>
&gt;<br>
&gt; &gt; Cheers,<br>
&gt; &gt; g.<br>
&gt; &gt;<br>
&gt; &gt; The following changes since commit dcd6c92267155e70a94b3927bce681=
ce74b80d1f:<br>
&gt; &gt;<br>
&gt; &gt; =A0 Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)<br>
&gt; &gt;<br>
&gt; &gt; are available in the git repository at:<br>
&gt; &gt; =A0 git://<a href=3D"http://git.secretlab.ca/git/linux-2.6">git.s=
ecretlab.ca/git/linux-2.6</a> irqdomain/next<br>
&gt; &gt;<br>
&gt; &gt; Grant Likely (24):<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: add documentation and MAINTAINERS entry.<=
br>
&gt; &gt; =A0 =A0 =A0 dt: Make irqdomain less verbose<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: Make irq_domain structure match powerpc&#=
39;s irq_host<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: convert microblaze from irq_host to irq_d=
omain<br>
&gt; &gt; =A0 =A0 =A0 irq_domain/powerpc: Use common irq_domain structure i=
nstead of irq_host<br>
&gt; &gt; =A0 =A0 =A0 irq_domain/powerpc: eliminate irq_map; use irq_alloc_=
desc() instead<br>
&gt; &gt; =A0 =A0 =A0 irq_domain/powerpc: Eliminate virq_is_host()<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: Move irq_domain code from powerpc to kern=
el/irq<br>
&gt; &gt; =A0 =A0 =A0 irqdomain: remove NO_IRQ from irq domain code<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: Remove references to old irq_host names<b=
r>
&gt; &gt; =A0 =A0 =A0 irq_domain: Replace irq_alloc_host() with revmap-spec=
ific initializers<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: Add support for base irq and hwirq in leg=
acy mappings<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: Remove &#39;new&#39; irq_domain in favour=
 of the ppc one<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: Remove irq_domain_add_simple()<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: Create common xlate functions that device=
 drivers can use<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: constify irq_domain_ops<br>
&gt; &gt; =A0 =A0 =A0 irq_domain/c6x: constify irq_domain structures<br>
&gt; &gt; =A0 =A0 =A0 irq_domain/c6x: Use library of xlate functions<br>
&gt; &gt; =A0 =A0 =A0 irq_domain/powerpc: constify irq_domain_ops<br>
&gt; &gt; =A0 =A0 =A0 irqdomain/powerpc: Replace custom xlate functions wit=
h library functions<br>
&gt; &gt; =A0 =A0 =A0 irq_domain/x86: Convert x86 (embedded) to use common =
irq_domain<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: Include hwirq number in /proc/interrupts<=
br>
&gt; &gt; =A0 =A0 =A0 irq_domain: remove &quot;hint&quot; when allocating i=
rq numbers<br>
&gt; &gt; =A0 =A0 =A0 irq_domain: mostly eliminate slow-path revmap lookups=
<br>
&gt; &gt;<br>
&gt; &gt; Mark Salter (1):<br>
&gt; &gt; =A0 =A0 =A0 irq_domain/c6x: Convert c6x to use generic irq_domain=
 support.<br>
&gt; &gt;<br>
&gt; &gt; =A0Documentation/IRQ-domain.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0113 +++<br>
&gt; &gt; =A0MAINTAINERS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A09 +<br>
&gt; &gt; =A0arch/arm/common/gic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 95 ++--<br>
&gt; &gt; =A0arch/arm/common/vic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 16 +-<br>
&gt; &gt; =A0arch/arm/include/asm/hardware/gic.h =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A04 +-<br>
&gt; &gt; =A0arch/arm/include/asm/hardware/vic.h =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +<br>
&gt; &gt; =A0arch/arm/mach-exynos/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-<br>
&gt; &gt; =A0arch/arm/mach-imx/mach-imx6q.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A03 +-<br>
&gt; &gt; =A0arch/arm/mach-msm/board-msm8x60.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A08 +-<br>
&gt; &gt; =A0arch/arm/mach-mx5/imx51-dt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A04 +-<br>
&gt; &gt; =A0arch/arm/mach-mx5/imx53-dt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A04 +-<br>
&gt; &gt; =A0arch/arm/mach-omap2/board-generic.c =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +-<br>
&gt; &gt; =A0arch/arm/mach-prima2/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-<br>
&gt; &gt; =A0arch/arm/mach-versatile/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A05 +-<br>
&gt; &gt; =A0arch/c6x/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | =A0 =A01 +<br>
&gt; &gt; =A0arch/c6x/include/asm/irq.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0245 +-------<br>
&gt; &gt; =A0arch/c6x/kernel/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0612 +----------------<br>
&gt; &gt; =A0arch/c6x/platforms/megamod-pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 25 +-<br>
&gt; &gt; =A0arch/microblaze/include/asm/irq.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A04 +-<br>
&gt; &gt; =A0arch/microblaze/kernel/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-<br>
&gt; &gt; =A0arch/microblaze/kernel/setup.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 -<br>
&gt; &gt; =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 | =A0 =A01 +<br>
&gt; &gt; =A0arch/powerpc/include/asm/ehv_pic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +-<br>
&gt; &gt; =A0arch/powerpc/include/asm/i8259.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A02 +-<br>
&gt; &gt; =A0arch/powerpc/include/asm/irq.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0247 +-------<br>
&gt; &gt; =A0arch/powerpc/include/asm/mpic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-<br>
&gt; &gt; =A0arch/powerpc/include/asm/xics.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-<br>
&gt; &gt; =A0arch/powerpc/kernel/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0617 +----------------<br>
&gt; &gt; =A0arch/powerpc/platforms/512x/mpc5121_ads_cpld.c =A0 | =A0 12 +-=
<br>
&gt; &gt; =A0arch/powerpc/platforms/52xx/media5200.c =A0 =A0 =A0 =A0 =A0| =
=A0 15 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c =A0 =A0 =A0 =A0| =A0=
 16 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/52xx/mpc52xx_pic.c =A0 =A0 =A0 =A0| =A0=
 12 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/82xx/pq2ads-pci-pic.c =A0 =A0 | =A0 14 =
+-<br>
&gt; &gt; =A0arch/powerpc/platforms/85xx/socrates_fpga_pic.c =A0| =A0 15 +-=
<br>
&gt; &gt; =A0arch/powerpc/platforms/86xx/gef_pic.c =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 15 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/cell/axon_msi.c =A0 =A0 =A0 =A0 =A0 | =
=A0 29 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/cell/beat_interrupt.c =A0 =A0 | =A0 16 =
+-<br>
&gt; &gt; =A0arch/powerpc/platforms/cell/interrupt.c =A0 =A0 =A0 =A0 =A0| =
=A0 16 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/cell/spider-pic.c =A0 =A0 =A0 =A0 | =A0=
 14 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/embedded6xx/flipper-pic.c | =A0 30 +-<b=
r>
&gt; &gt; =A0arch/powerpc/platforms/embedded6xx/hlwd-pic.c =A0 =A0| =A0 35 =
+-<br>
&gt; &gt; =A0arch/powerpc/platforms/iseries/irq.c =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 11 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/powermac/pic.c =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 26 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/powermac/smp.c =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A09 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/ps3/interrupt.c =A0 =A0 =A0 =A0 =A0 | =
=A0 11 +-<br>
&gt; &gt; =A0arch/powerpc/platforms/wsp/opb_pic.c =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 26 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/cpm1.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A09 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/cpm2_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 23 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/ehv_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 14 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/fsl_msi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 10 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/fsl_msi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/i8259.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 15 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/ipic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 31 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/ipic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/mpc8xx_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 11 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/mpic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 17 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/mpic_msi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/mv64x60_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 11 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/qe_lib/qe_ic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 26 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/qe_lib/qe_ic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/tsi108_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 22 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/uic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 26 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/xics/xics-common.c =A0 =A0 =A0 =A0 =A0 | =
=A0 28 +-<br>
&gt; &gt; =A0arch/powerpc/sysdev/xilinx_intc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 19 +-<br>
&gt; &gt; =A0arch/x86/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 | =A0 =A02 +<br>
&gt; &gt; =A0arch/x86/include/asm/irq_controller.h =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 12 -<br>
&gt; &gt; =A0arch/x86/include/asm/prom.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 10 -<br>
&gt; &gt; =A0arch/x86/kernel/devicetree.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0101 +--<br>
&gt; &gt; =A0drivers/gpio/gpio-mpc8xxx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 30 +-<br>
&gt; &gt; =A0drivers/mfd/twl-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 12 +-<br>
&gt; &gt; =A0drivers/net/phy/mdio-gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A04 +-<br>
&gt; &gt; =A0include/linux/irqdomain.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0190 ++++--<br>
&gt; &gt; =A0kernel/irq/irqdomain.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0816 +++++++++++++++++++---<br>
&gt; &gt; =A0kernel/irq/proc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0| =A0 =A03 +<br>
&gt; &gt; =A074 files changed, 1334 insertions(+), 2471 deletions(-)<br>
&gt; &gt; =A0create mode 100644 Documentation/IRQ-domain.txt<br>
&gt; &gt; =A0delete mode 100644 arch/x86/include/asm/irq_controller.h<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; devicetree-discuss mailing list<br>
&gt; &gt; <a href=3D"mailto:devicetree-discuss@lists.ozlabs.org">devicetree=
-discuss@lists.ozlabs.org</a><br>
&gt; &gt; <a href=3D"https://lists.ozlabs.org/listinfo/devicetree-discuss">=
https://lists.ozlabs.org/listinfo/devicetree-discuss</a><br>
&gt;<br>
</p>

--047d7b10d16f5c2e3a04b79b5cf4--
