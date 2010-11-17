Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 03463B7168
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Nov 2010 04:15:19 +1100 (EST)
Subject: Re: [PATCH] powerpc: Per process DSCR
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20101117113130.3702897c@kryten>
Date: Wed, 17 Nov 2010 11:15:07 -0600
Message-Id: <9BF17613-A893-4FE8-97BB-3BDCDF740591@kernel.crashing.org>
References: <20101117113130.3702897c@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2010, at 6:31 PM, Anton Blanchard wrote:

> In order to add per process control of the DSCR, the following patch =
emulates
> read/write of the DSCR from userspace and saves and restores it on =
context
> switch. We add emulated stats to track how many times we do this.
>=20
> While writing this patch a few things were apparent:
>=20
> - How will this work with the global DSCR setting in
>  /sys/devices/system/cpu/cpu*/dscr? Do we deprecate it? One thought is
>  to add a new sysfs entry (eg dscr_enabled), which tells us to
>  override any per process settings. Another way would be to overload
>  the dscr sysfs entry and make -1 mean the system wide dscr setting is
>  disabled.
>=20
> - Do we need an out of band method of changing the DSCR so another
>  process or could modify it? We may want to modify the DSCR of a long
>  running process, eg a HPC job.
>=20
> - To improve context switch speed we should probably check the old and
>  new DSCR values are identical and avoid the SPR write.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>

We don't have no stinking DSCR ;).  Would like this to be #ifdef =
CONFIG_PPC_BOOK3S_64.

- k=
