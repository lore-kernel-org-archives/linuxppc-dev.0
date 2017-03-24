Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq9Hc0vVQzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 15:22:20 +1100 (AEDT)
Message-ID: <1490329340.28113.57.camel@neuling.org>
Subject: Re: [PATCH v3 01/10] VAS: Define macros, register fields and
 structures
From: Michael Neuling <mikey@neuling.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 apopple@au1.ibm.com,  oohall@gmail.com
Date: Fri, 24 Mar 2017 15:22:20 +1100
In-Reply-To: <1489721642-5657-2-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-2-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> Define macros for the VAS hardware registers and bit-fields as well
> as couple of data structures needed by the VAS driver.
>=20
> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Changelog[v3]
> 	- Rename winctx->pid to winctx->pidr to reflect that its a value
> 	=C2=A0=C2=A0from the PID register (SPRN_PID), not the linux process id.
> 	- Make it easier to split header into kernel/user parts
> 	- To keep user interface simple, use macros rather than enum for
> 	=C2=A0=C2=A0the threshold-control modes.
> 	- Add a pid field to struct vas_window - needed for user space
> 	=C2=A0=C2=A0send windows.
>=20
> Changelog[v2]
> 	- Add an overview of VAS in vas-internal.h
> 	- Get window context parameters from device tree and drop
> 	=C2=A0=C2=A0unnecessary macros.
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A0=C2=A06 +
> =C2=A0arch/powerpc/include/asm/vas.h=C2=A0=C2=A0|=C2=A0=C2=A043 +++++
> =C2=A0drivers/misc/vas/vas-internal.h | 392 +++++++++++++++++++++++++++++=
+++++++++++

This is going to have to go through gregkh/lkml if it's drivers/misc.  you'=
ll at
least need gregkh's ack/ok before mpe will take them (which is what we did =
for
CAPI).

We might want to keep this in arch/powerpc but I'm not sure.

> =C2=A03 files changed, 441 insertions(+)
> =C2=A0create mode 100644 arch/powerpc/include/asm/vas.h
> =C2=A0create mode 100644 drivers/misc/vas/vas-internal.h
>=20
<snip>
> +
> +/*
> + * Overview of Virtual Accelerator Switchboard (VAS).
> + *
> + * VAS is a hardware "switchboard" that allows senders and receivers to
> + * exchange messages with _minimal_ kernel involvment. The receivers are
> + * typically NX coprocessor engines that perform compression or encrypti=
on
> + * in hardware, but receivers can also be other software threads.
> + *
> + * Senders are user/kernel threads that submit compression/encryption or
> + * other requests to the receivers. Senders must format their messages a=
s
> + * Coprocessor Request Blocks (CRB)s and submit them using the instructi=
ons
> + * "copy" and "paste" which were introduced in Power9.
> + *
> + * A Power node can have (upto?) 8 Power chips. There is one instance of
> + * VAS in each Power9 chip. Each instance of VAS has 64K windows or port=
s,
> + * Senders and receivers must each connect to a separate window before t=
hey
> + * can exchange messages through the switchboard.
> + *
> + * Each window is described by two types of window contexts:
> + *
> > + *	Hypervisor Window Context (HVWC) of size VAS_HVWC_SIZE bytes
> + *
> > + *	OS/User Window Context (UWC) of size VAS_UWC_SIZE bytes.
> + *
> + * A window context can be viewed as a set of 64-bit registers. The sett=
ings
> + * in these registers configure/control/determine the behavior of the VA=
S
> + * hardware when messages are sent/received through the window. The regi=
sters
> + * in the HVWC are configured by the kernel while the registers in the U=
WC can
> + * be configured by the kernel or by the user space application that is =
using
> + * the window.
> + *
> + * The HVWCs for all windows on a specific instance of VAS are in a cont=
iguous
> + * range of hardware addresses or Base address region (BAR) referred to =
as the
> + * HVWC BAR for the instance. Similarly the UWCs for all windows on an i=
nstance
> + * are referred to as the UWC BAR for the instance. The two BARs for eac=
h
> + * instance are defined Power9 MMIO Ranges spreadsheet and available to =
the
> + * kernel the device tree as follows:
> + *
> > + *	/proc/device-tree/xscom@.../vas@.../hvwc-bar-start
> > + *	/proc/device-tree/xscom@.../vas@.../hvwc-bar-size
> > + *	/proc/device-tree/xscom@.../vas@.../uwc-bar-start
> + *	/proc/device-tree/xscom@.../vas@.../uwc-bar-size

should these just be reg properties?

> + *
> + * The kernel maps these two hardware address regions into the kernel ad=
dress
> + * space (hvwc_map and uwc_map) and accesses the window contexts of a sp=
ecific
> + * window using:
> + *
> > + *	=C2=A0hvwc =3D hvwc_map + winid * VAS_HVWC_SIZE.
> > + *	=C2=A0uwc =3D uwc_map + winid * VAS_UWC_SIZE.
> + *
> + * where winid is the window index (0..64K).
> + *
> + * Note that the window contexts are used to "configure" the windows. In
> + * addition to this configuration address, each _send_ window also has a
> + * unique hardware address, referred to as the "paste-address" to which =
the
> + * sender must "paste" the message (CRB) they wish to submit. This hardw=
are
> + * paste address for window can be computed from the following nodes in =
the
> + * device tree:
> + *
> > + *	/proc/device-tree/xscom@.../vas@.../window-base
> + *	/proc/device-tree/xscom@.../vas@.../window-shift

Same here with reg properties.

<snip>=20
> +struct vas_winctx {
<snip>
> > +	int lpid;
> +	int pidr;		/* value from SPRN_PID, not linux pid */

I'm surprised we have a copy of these here.  They should be accessed from t=
he
context we are attaching to, rather than copied here... but I've not looked=
 at
the rest of the code yet...
