Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 54122DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 02:11:59 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so325389ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 08:11:56 -0700 (PDT)
Message-ID: <528646bc0703150709v49af8085p959bd36e0adf1e4a@mail.gmail.com>
Date: Thu, 15 Mar 2007 08:09:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 5/5] lite5200b suspend: low-power mode
In-Reply-To: <20070315104447.GG22215@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104447.GG22215@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/15/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Low-power mode implementation for Lite5200b.
> Some I/O registers are also saved here.
>
> A patch to U-Boot that wakes up SDRAM, and transfers control
> to address saved at physical 0x0 is needed.

I don't see any structural problems with this code, but I have a few
comments below.  I'm also concerned about the blind register
save/restore by memcpy_to/fromio.  I haven't looked at the chip
documentation, but it looks scary.  Is it safe to restore those
registers in that manner?

Cheers,
g.

>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>
> ---
>  arch/powerpc/platforms/52xx/Makefile         |    3
>  arch/powerpc/platforms/52xx/lite5200_pm.c    |  125 ++++++++
>  arch/powerpc/platforms/52xx/lite5200_sleep.S |  419 +++++++++++++++++++++++++++
>  3 files changed, 547 insertions(+)
>
> Index: grant.git/arch/powerpc/platforms/52xx/lite5200_pm.c
> ===================================================================
> --- /dev/null
> +++ grant.git/arch/powerpc/platforms/52xx/lite5200_pm.c
> @@ -0,0 +1,125 @@
<snip>
> +static int lite5200_pm_prepare(suspend_state_t state)
> +{
> +       /* deep sleep? let mpc52xx code handle that */
> +       if (state == PM_SUSPEND_STANDBY)
> +               return mpc52xx_pm_prepare(state);
> +
> +       if (state != PM_SUSPEND_MEM)
> +               return -EINVAL;
> +
> +       /* map registers */
> +       mbar = ioremap_nocache(0xf0000000, 0x8000);

Magic numbers?  Really?  This should be retrieved from the device
tree.  There is always the possibility of mbar getting moved.

> +static void lite5200_save_regs(void)
> +{
> +       _memcpy_fromio(&sbes, bes, sizeof(*bes));
> +       _memcpy_fromio(&spic, pic, sizeof(*pic));
> +       _memcpy_fromio(&scdm, cdm, sizeof(*cdm));
> +       _memcpy_fromio(&sxlb, xlb, sizeof(*xlb));
> +       _memcpy_fromio(&sgps, gps, sizeof(*gps));
> +       _memcpy_fromio(&sgpw, gpw, sizeof(*gpw));

Hmmm.  I have not dug into this deeply, but blind save/restore to
blocks of registers scares me.

> +
> +       memcpy(saved_sram, sdma.sram, sdma.sram_size);
> +}
> +
> +static void lite5200_restore_regs(void)
> +{
> +       memcpy(sdma.sram, saved_sram, sdma.sram_size);
> +
> +       _memcpy_toio(gpw, &sgpw, sizeof(*gpw));
> +       _memcpy_toio(gps, &sgps, sizeof(*gps));
> +       _memcpy_toio(xlb, &sxlb, sizeof(*xlb));
> +       _memcpy_toio(cdm, &scdm, sizeof(*cdm));
> +       _memcpy_toio(pic, &spic, sizeof(*pic));
> +       _memcpy_toio(bes, &sbes, sizeof(*bes));
> +}
> +
> +static int lite5200_pm_enter(suspend_state_t state)
> +{
> +       /* deep sleep? let mpc52xx code handle that */
> +       if (state == PM_SUSPEND_STANDBY) {
> +               return mpc52xx_pm_enter(state);
> +       }
> +
> +       cdm = mbar + 0x200;
> +       pic = mbar + 0x500;
> +       gps = mbar + 0xb00;
> +       gpw = mbar + 0xc00;
> +       bes = mbar + 0x1200;
> +       xlb = mbar + 0x1f00;

Again, magic numbers


> Index: grant.git/arch/powerpc/platforms/52xx/lite5200_sleep.S
> ===================================================================
> --- /dev/null
> +++ grant.git/arch/powerpc/platforms/52xx/lite5200_sleep.S
> @@ -0,0 +1,419 @@
> +#include <asm/reg.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/processor.h>
> +#include <asm/cache.h>
> +
> +
> +#define SDRAM_MODE     0x100
> +#define SDRAM_CTRL     0x104
> +#define SC_MODE_EN     (1<<31)
> +#define SC_CKE         (1<<30)
> +#define SC_REF_EN      (1<<28)
> +#define SC_SOFT_PRE    (1<<1)
> +
> +#define GPIOW_GPIOE    0xc00
> +#define GPIOW_ODE      0xc04
> +#define GPIOW_DDR      0xc08
> +#define GPIOW_DVO      0xc0c
> +#define GPIOW_INTEN    0xc10
> +
> +#define CDM_CE         0x214
> +#define CDM_SDRAM      (1<<3)
> +
> +
> +// about 2000 cpu cycles for one sdram cycle here
> +// just increase, to be on the safe side?
> +#define TCK    5000

Please avoid c++ comments

> +
> +
> +#define DONT_DEBUG 1

Convention is to #define DEBUG to enable debugging (as opposed to
#defining something to disable it)

> +restore_regs:
> +       lis     r4, registers@h
> +       ori     r4, r4, registers@l
> +#ifdef DONT_DEBUG

should be #if !defined(DEBUG)

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
