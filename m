Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 23 Jan 2012 15:08:14 -0700
Message-ID: <CACxGe6tTMSR1sRTg2qGLBD-a=M7ZHErOm_7F_kfir16ojsD=Sg@mail.gmail.com>
Subject: RFC v2 irq_domain rework posted to linux-kernel. (Was: [RFCv2 00/14])
To: Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Benoit Cousson <b-cousson@ti.com>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 23, 2012 at 2:53 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 01/23/2012 03:07 PM, Grant Likely wrote:
>>
>> Hey everyone,
>>
>> Here's the second RFC for the irq_domain patches. =A0I could use some
>> help testing now. =A0I still expect there will be a few bugs. =A0The
>> series is based on v3.3-rc1, and I've pushed it out to my git server:
>>
>> git://git.secretlab.ca/git/linux-2.6.git irqdomain/next
>
> Can you post to linux-arm-kernel too so people are aware of this work
> and stop posting dead-end irqdomain patches.

Oops, I had intended to do so.  Apparently I forgot to set the subject
line of the cover letter too.  :-(  I don't want to irritate folks
with an immediate repost of the whole series, but I'm cc'ing the
linux-arm-kernel list on this email.  I'll repost a v3 and include
linux-arm-kernel before I ask Stephen to pull this stuff into
linux-next.

For anyone who is doing irq_domain work, please be aware of these
patches that are probably going to be merged for v3.4.  You'll need to
coordinate with me before your patches hit linux-next, otherwise you
will have a build failure.  The patches can be found here:

http://thread.gmane.org/gmane.linux.kernel/1242692

g.

>
> I tested what you had as of this morning and it works fine for me. Looks
> like the only diff is the VExpress code. I'm working on rebasing my
> domain support for generic irqchip now.
>
> Rob
>
>> On Wed, Jan 11, 2012 at 1:22 PM, Grant Likely <grant.likely@secretlab.ca=
> wrote:
>>> Here are the patches that I've been working on to finish up the creatio=
n
>>> of the generic irq_domain infrastructure.
>>>
>>> I'm taking a different approach that I originally intended.
>>> Originally I intended to start with the basic design of irq_host from
>>> powerpc, but there were some things about the implementation that I
>>> didn't like, so I was going to reimplement those bits and then migrate
>>> powerpc over to use it. =A0That was a mistake and would have resulted i=
n
>>> a lot more work. =A0Instead, I should have started with the powerpc
>>> irq_host code, moved it to a common location, and then reworked it in
>>> place. =A0The powerpc code is working and well tested. =A0It is a lot l=
ess
>>> risky to use it as the starting point with a nicely bisectable series
>>> of changes to make it do what other architectures need.
>>
>> [RFCv2 01/14] irq_domain: add documentation and MAINTAINERS entry.
>> [RFCv2 02/14] dt: Make irqdomain less verbose
>> [RFCv2 03/14] irq_domain: Make irq_domain structure match powerpc's
>> [RFCv2 04/14] irq_domain: convert microblaze from irq_host to
>> [RFCv2 05/14] irq_domain/powerpc: Use common irq_domain structure
>> [RFCv2 06/14] irq_domain/powerpc: eliminate irq_map; use
>> [RFCv2 07/14] irq_domain/powerpc: Eliminate virq_is_host()
>> [RFCv2 08/14] irq_domain: Move irq_domain code from powerpc to
>> [RFCv2 09/14] irqdomain: remove NO_IRQ from irq domain code
>> [RFCv2 10/14] irq_domain: Remove references to old irq_host names
>> [RFCv2 11/14] irq_domain: Replace irq_alloc_host() with
>> [RFCv2 12/14] irq_domain: Add support for base irq and hwirq in
>> [RFCv2 13/14] irq_domain: Remove 'new' irq_domain in favour of the
>> [RFCv2 14/14] irq_domain: Remove irq_domain_add_simple()
>>
>> =A0Documentation/IRQ-domain.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0113 ++++
>> =A0MAINTAINERS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0| =A0 =A09 +
>> =A0arch/arm/common/gic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 97 ++--
>> =A0arch/arm/common/vic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 16 +-
>> =A0arch/arm/include/asm/hardware/gic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 +-
>> =A0arch/arm/include/asm/hardware/vic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 +
>> =A0arch/arm/mach-exynos/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
>> =A0arch/arm/mach-imx/mach-imx6q.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A03 +-
>> =A0arch/arm/mach-msm/board-msm8x60.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A08 +-
>> =A0arch/arm/mach-mx5/imx51-dt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A04 +-
>> =A0arch/arm/mach-mx5/imx53-dt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A04 +-
>> =A0arch/arm/mach-omap2/board-generic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 +-
>> =A0arch/arm/mach-prima2/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A02 +-
>> =A0arch/arm/mach-versatile/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A05 +-
>> =A0arch/microblaze/include/asm/irq.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A04 +-
>> =A0arch/microblaze/kernel/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A02 +-
>> =A0arch/microblaze/kernel/setup.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 -
>> =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A01 +
>> =A0arch/powerpc/include/asm/ehv_pic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +-
>> =A0arch/powerpc/include/asm/i8259.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
>> =A0arch/powerpc/include/asm/irq.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0247 +-------
>> =A0arch/powerpc/include/asm/mpic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
>> =A0arch/powerpc/include/asm/xics.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
>> =A0arch/powerpc/kernel/irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0617 +------------------
>> =A0arch/powerpc/platforms/512x/mpc5121_ads_cpld.c =A0 | =A0 12 +-
>> =A0arch/powerpc/platforms/52xx/media5200.c =A0 =A0 =A0 =A0 =A0| =A0 15 +=
-
>> =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c =A0 =A0 =A0 =A0| =A0 16 +-
>> =A0arch/powerpc/platforms/52xx/mpc52xx_pic.c =A0 =A0 =A0 =A0| =A0 12 +-
>> =A0arch/powerpc/platforms/82xx/pq2ads-pci-pic.c =A0 =A0 | =A0 14 +-
>> =A0arch/powerpc/platforms/85xx/socrates_fpga_pic.c =A0| =A0 15 +-
>> =A0arch/powerpc/platforms/86xx/gef_pic.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 15=
 +-
>> =A0arch/powerpc/platforms/cell/axon_msi.c =A0 =A0 =A0 =A0 =A0 | =A0 29 +=
-
>> =A0arch/powerpc/platforms/cell/beat_interrupt.c =A0 =A0 | =A0 16 +-
>> =A0arch/powerpc/platforms/cell/interrupt.c =A0 =A0 =A0 =A0 =A0| =A0 16 +=
-
>> =A0arch/powerpc/platforms/cell/spider-pic.c =A0 =A0 =A0 =A0 | =A0 14 +-
>> =A0arch/powerpc/platforms/embedded6xx/flipper-pic.c | =A0 30 +-
>> =A0arch/powerpc/platforms/embedded6xx/hlwd-pic.c =A0 =A0| =A0 35 +-
>> =A0arch/powerpc/platforms/iseries/irq.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11=
 +-
>> =A0arch/powerpc/platforms/powermac/pic.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 15=
 +-
>> =A0arch/powerpc/platforms/powermac/smp.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A09 +-
>> =A0arch/powerpc/platforms/ps3/interrupt.c =A0 =A0 =A0 =A0 =A0 | =A0 11 +=
-
>> =A0arch/powerpc/platforms/wsp/opb_pic.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 15=
 +-
>> =A0arch/powerpc/sysdev/cpm1.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A09 +-
>> =A0arch/powerpc/sysdev/cpm2_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 11 +-
>> =A0arch/powerpc/sysdev/ehv_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 14 +-
>> =A0arch/powerpc/sysdev/fsl_msi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 10 +-
>> =A0arch/powerpc/sysdev/fsl_msi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
>> =A0arch/powerpc/sysdev/i8259.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 15 +-
>> =A0arch/powerpc/sysdev/ipic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 15 +-
>> =A0arch/powerpc/sysdev/ipic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A02 +-
>> =A0arch/powerpc/sysdev/mpc8xx_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 11 +-
>> =A0arch/powerpc/sysdev/mpic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 17 +-
>> =A0arch/powerpc/sysdev/mpic_msi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +-
>> =A0arch/powerpc/sysdev/mv64x60_pic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 11 +-
>> =A0arch/powerpc/sysdev/qe_lib/qe_ic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
13 +-
>> =A0arch/powerpc/sysdev/qe_lib/qe_ic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +-
>> =A0arch/powerpc/sysdev/tsi108_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 13 +-
>> =A0arch/powerpc/sysdev/uic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 14 +-
>> =A0arch/powerpc/sysdev/xics/xics-common.c =A0 =A0 =A0 =A0 =A0 | =A0 25 +=
-
>> =A0arch/powerpc/sysdev/xilinx_intc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 19 +-
>> =A0drivers/gpio/gpio-mpc8xxx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 15 +-
>> =A0drivers/mfd/twl-core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 12 +-
>> =A0include/linux/irqdomain.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0180 ++++--
>> =A0kernel/irq/irqdomain.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0757 ++++++++++++++++++----
>> =A064 files changed, 1207 insertions(+), 1414 deletions(-)



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
