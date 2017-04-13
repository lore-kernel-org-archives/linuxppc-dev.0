Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3WlQ1WS9zDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 16:55:46 +1000 (AEST)
Message-ID: <1492066545.4624.52.camel@neuling.org>
Subject: Re: [PATCH 2/3] powernv:idle: Decouple TB restore & Per-core SPRs
 restore
From: Michael Neuling <mikey@neuling.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>,  Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>,  Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Apr 2017 16:55:45 +1000
In-Reply-To: <27511c1235ee58c66eabdea65b39f5dd35d91426.1491996797.git.ego@linux.vnet.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
 <27511c1235ee58c66eabdea65b39f5dd35d91426.1491996797.git.ego@linux.vnet.ibm.com>
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

On Wed, 2017-04-12 at 17:16 +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>=20
> The idle-exit code assumes that if Timebase is not lost, then neither
> are the per-core hypervisor resources lost.=20

Double negative!  How about:

The idle-exit code assumes that if the timebase is restored, then the
per-core hypervisor resources are also restored.

> This was true on POWER8
> where fast-sleep lost only TB but not per-core resources, and winkle
> lost both.
>=20
> This assumption is not true for POWER9 however, since there can be
> states which do not lose timebase but can lose per-core SPRs.
>=20
> Hence check if we need to restore the per-core hypervisor state even
> if timebase is not lost.

I think I understand what you're doing, just seems awkwardly worded.

Is this actually what the patch is doing?  It seem to be just changing one
branch.

Mikey

>=20
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> =C2=A0arch/powerpc/kernel/idle_book3s.S | 7 ++++---
> =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/idle_book3s.S
> b/arch/powerpc/kernel/idle_book3s.S
> index 9b747e9..6a9bd28 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -723,13 +723,14 @@ timebase_resync:
> =C2=A0	=C2=A0* Use cr3 which indicates that we are waking up with atleast=
 partial
> =C2=A0	=C2=A0* hypervisor state loss to determine if TIMEBASE RESYNC is n=
eeded.
> =C2=A0	=C2=A0*/
> -	ble	cr3,clear_lock
> +	ble	cr3,.Ltb_resynced
> =C2=A0	/* Time base re-sync */
> =C2=A0	bl	opal_resync_timebase;
> =C2=A0	/*
> -	=C2=A0* If waking up from sleep, per core state is not lost, skip to
> -	=C2=A0* clear_lock.
> +	=C2=A0* If waking up from sleep (POWER8), per core state
> +	=C2=A0* is not lost, skip to clear_lock.
> =C2=A0	=C2=A0*/
> +.Ltb_resynced:
> =C2=A0	blt	cr4,clear_lock
> =C2=A0
> =C2=A0	/*
