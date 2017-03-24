Return-Path: <srs0=h86y=3b=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqc5p4SsHzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 08:30:22 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vqc5p3szNz8vrk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 08:30:22 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vqc5p0BtDz9s3s
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2017 08:30:21 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2OLSZCY143173
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 17:30:18 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29d1cvkcgd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2017 17:30:17 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 24 Mar 2017 15:30:13 -0600
Date: Fri, 24 Mar 2017 14:30:09 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, stewart@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, apopple@au1.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v3 01/10] VAS: Define macros, register fields and
 structures
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490329340.28113.57.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1490329340.28113.57.camel@neuling.org>
Message-Id: <20170324213009.GD8330@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling [mikey@neuling.org] wrote:
> On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> > Define macros for the VAS hardware registers and bit-fields as well
> > as couple of data structures needed by the VAS driver.
> >=20
> > > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > ---
> > Changelog[v3]
> > 	- Rename winctx->pid to winctx->pidr to reflect that its a value
> > 	=A0=A0from the PID register (SPRN_PID), not the linux process id.
> > 	- Make it easier to split header into kernel/user parts
> > 	- To keep user interface simple, use macros rather than enum for
> > 	=A0=A0the threshold-control modes.
> > 	- Add a pid field to struct vas_window - needed for user space
> > 	=A0=A0send windows.
> >=20
> > Changelog[v2]
> > 	- Add an overview of VAS in vas-internal.h
> > 	- Get window context parameters from device tree and drop
> > 	=A0=A0unnecessary macros.
> > ---
> > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0|=A0=A0=A06 +
> > =A0arch/powerpc/include/asm/vas.h=A0=A0|=A0=A043 +++++
> > =A0drivers/misc/vas/vas-internal.h | 392 ++++++++++++++++++++++++++++++=
++++++++++
>=20
> This is going to have to go through gregkh/lkml if it's drivers/misc.  yo=
u'll at
> least need gregkh's ack/ok before mpe will take them (which is what we di=
d for
> CAPI).
>=20
> We might want to keep this in arch/powerpc but I'm not sure.
>=20

We will have device nodes accessible to user space so put it here and can
copy Gregkh next time. But let me know if we should move to arch/powerpc.

> > =A03 files changed, 441 insertions(+)
> > =A0create mode 100644 arch/powerpc/include/asm/vas.h
> > =A0create mode 100644 drivers/misc/vas/vas-internal.h
> >=20
> <snip>
> > +
> > +/*
> > + * Overview of Virtual Accelerator Switchboard (VAS).
> > + *
> > + * VAS is a hardware "switchboard" that allows senders and receivers to
> > + * exchange messages with _minimal_ kernel involvment. The receivers a=
re
> > + * typically NX coprocessor engines that perform compression or encryp=
tion
> > + * in hardware, but receivers can also be other software threads.
> > + *
> > + * Senders are user/kernel threads that submit compression/encryption =
or
> > + * other requests to the receivers. Senders must format their messages=
 as
> > + * Coprocessor Request Blocks (CRB)s and submit them using the instruc=
tions
> > + * "copy" and "paste" which were introduced in Power9.
> > + *
> > + * A Power node can have (upto?) 8 Power chips. There is one instance =
of
> > + * VAS in each Power9 chip. Each instance of VAS has 64K windows or po=
rts,
> > + * Senders and receivers must each connect to a separate window before=
 they
> > + * can exchange messages through the switchboard.
> > + *
> > + * Each window is described by two types of window contexts:
> > + *
> > > + *	Hypervisor Window Context (HVWC) of size VAS_HVWC_SIZE bytes
> > + *
> > > + *	OS/User Window Context (UWC) of size VAS_UWC_SIZE bytes.
> > + *
> > + * A window context can be viewed as a set of 64-bit registers. The se=
ttings
> > + * in these registers configure/control/determine the behavior of the =
VAS
> > + * hardware when messages are sent/received through the window. The re=
gisters
> > + * in the HVWC are configured by the kernel while the registers in the=
 UWC can
> > + * be configured by the kernel or by the user space application that i=
s using
> > + * the window.
> > + *
> > + * The HVWCs for all windows on a specific instance of VAS are in a co=
ntiguous
> > + * range of hardware addresses or Base address region (BAR) referred t=
o as the
> > + * HVWC BAR for the instance. Similarly the UWCs for all windows on an=
 instance
> > + * are referred to as the UWC BAR for the instance. The two BARs for e=
ach
> > + * instance are defined Power9 MMIO Ranges spreadsheet and available t=
o the
> > + * kernel the device tree as follows:
> > + *
> > > + *	/proc/device-tree/xscom@.../vas@.../hvwc-bar-start
> > > + *	/proc/device-tree/xscom@.../vas@.../hvwc-bar-size
> > > + *	/proc/device-tree/xscom@.../vas@.../uwc-bar-start
> > + *	/proc/device-tree/xscom@.../vas@.../uwc-bar-size
>=20
> should these just be reg properties?

I guess they could. Will try that
>=20
> > + *
> > + * The kernel maps these two hardware address regions into the kernel =
address
> > + * space (hvwc_map and uwc_map) and accesses the window contexts of a =
specific
> > + * window using:
> > + *
> > > + *	=A0hvwc =3D hvwc_map + winid * VAS_HVWC_SIZE.
> > > + *	=A0uwc =3D uwc_map + winid * VAS_UWC_SIZE.
> > + *
> > + * where winid is the window index (0..64K).
> > + *
> > + * Note that the window contexts are used to "configure" the windows. =
In
> > + * addition to this configuration address, each _send_ window also has=
 a
> > + * unique hardware address, referred to as the "paste-address" to whic=
h the
> > + * sender must "paste" the message (CRB) they wish to submit. This har=
dware
> > + * paste address for window can be computed from the following nodes i=
n the
> > + * device tree:
> > + *
> > > + *	/proc/device-tree/xscom@.../vas@.../window-base
> > + *	/proc/device-tree/xscom@.../vas@.../window-shift
>=20
> Same here with reg properties.

ok

>=20
> <snip>=20
> > +struct vas_winctx {
> <snip>
> > > +	int lpid;
> > +	int pidr;		/* value from SPRN_PID, not linux pid */
>=20
> I'm surprised we have a copy of these here.  They should be accessed from=
 the
> context we are attaching to, rather than copied here... but I've not look=
ed at
> the rest of the code yet...

struct vas_winctx is just a convenient container for the window context.
It gets initialized based on type/use of window (user/kernel send/receive).
The lpid/pid are set by callers of VAS kernel interfaces.

Sukadev
