Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by ozlabs.org (Postfix) with ESMTP id 60A05DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 03:49:09 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so387982rvf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Aug 2007 10:49:07 -0700 (PDT)
Message-ID: <fa686aa40708091049m46607037jafe4b479ae52db43@mail.gmail.com>
Date: Thu, 9 Aug 2007 11:49:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "=?ISO-8859-1?Q?Joachim_F=F6rster?=" <mls.JOFT@gmx.de>
Subject: Re: [PATCH 1/2] Xlinx ML403 AC97 Controller Reference device driver
In-Reply-To: <1186655810.7420.26.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1186655810.7420.26.camel@localhost>
Cc: alsa-devel <alsa-devel@alsa-project.org>,
	Lorenz Kolb <lorenz.kolb@lkmail.de>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/9/07, Joachim F=F6rster <mls.JOFT@gmx.de> wrote:
> From: Joachim Foerster <JOFT@gmx.de>
>
> Add ALSA support for the opb_ac97_controller_ref_v1_00_a ip core found
> in Xilinx' ML403 reference design.
>
> Known issue: Currently this driver hits a WARN_ON_ONCE(1) statement in
> kernel/irq/resend.c (line 70). According to Linus
> (http://lkml.org/lkml/2007/8/5/5) this may be ignored, right? I haven't
> had a look into this "problem" yet.
>
> (Patch for Linus' master branch, date 2007/08/08)
>
> This patchset _will_ be published on
> http://www.esic-solutions.com/support.html soon (like the first version
> of the driver (tar file), but this may take some days ...).

Comments below

> diff --git a/sound/ppc/Makefile b/sound/ppc/Makefile
> index eacee2d..827f2f5 100644
> --- a/sound/ppc/Makefile
> +++ b/sound/ppc/Makefile

Couldn't this end up on MicroBlaze too?  If so, sound/ppc is the wrong plac=
e.

> @@ -4,7 +4,9 @@
>  #
>
>  snd-powermac-objs :=3D powermac.o pmac.o awacs.o burgundy.o daca.o tumbl=
er.o keywest.o beep.o
> +snd-ml403_ac97cr-objs :=3D ml403_ac97cr.o

This line is only needed if you're compiling multiple .c files into one .ko

>
>  # Toplevel Module Dependency
>  obj-$(CONFIG_SND_POWERMAC)     +=3D snd-powermac.o
>  obj-$(CONFIG_SND_PS3)          +=3D snd_ps3.o
> +obj-$(CONFIG_SND_ML403_AC97CR) +=3D snd-ml403_ac97cr.o
> diff --git a/sound/ppc/ml403_ac97cr.c b/sound/ppc/ml403_ac97cr.c
> new file mode 100644
> index 0000000..99791d7
> --- /dev/null
> +++ b/sound/ppc/ml403_ac97cr.c
> @@ -0,0 +1,1274 @@
> +
> +/*  ALSA driver for Xilinx ML403 AC97 Controller Reference
> + *    IP: opb_ac97_controller_ref_v1_00_a (EDK 8.1i)
> + *    IP: opb_ac97_controller_ref_v1_00_a (EDK 9.1i)
> + *
> + *  Copyright (c) by 2007  Joachim Foerster <JOFT@gmx.de>
> + *
> + *   This program is free software; you can redistribute it and/or modif=
y
> + *   it under the terms of the GNU General Public License as published b=
y
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program; if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7 USA
> + *
> + */
> +
> +#include <sound/driver.h>
> +#include <linux/init.h>
> +#include <linux/moduleparam.h>
> +
> +#include <linux/platform_device.h>
> +
> +#include <linux/ioport.h>
> +#include <asm/io.h>
> +#include <linux/interrupt.h>
> +
> +/* HZ */
> +#include <linux/param.h>
> +/* jiffies, time_*() */
> +#include <linux/jiffies.h>
> +/* schedule_timeout*() */
> +#include <linux/sched.h>
> +/* spin_lock*() */
> +#include <linux/spinlock.h>
> +
> +/* snd_printk(), snd_printd() */
> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/ac97_codec.h>
> +
> +
> +#define SND_ML403_AC97CR_DRIVER "ml403_ac97cr"
> +
> +MODULE_AUTHOR("Joachim Foerster <JOFT@gmx.de>");
> +MODULE_DESCRIPTION("Xilinx ML403 AC97 Controller Reference");
> +MODULE_LICENSE("GPL");
> +MODULE_SUPPORTED_DEVICE("{{Xilinx,ML403 AC97 Controller Reference}}");
> +MODULE_VERSION("0.0.1-pre2");

This patch is targeted for mainline inclusion (which gives you the
kernel version number).  Do you really want to maintain a separate
version number that needs to be update manually?  I'd drop the
MODULE_VERSION line.

<snip>

I'm not an ALSA expert, so I didn't review the rest of the code in
detail (but I didn't see anything to comment on with a quick review).
I'll try adding your patches to my tree this afternoon.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
