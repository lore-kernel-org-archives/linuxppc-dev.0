Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423Zjm3xsRzF38n
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 13:11:07 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8338tUr027536
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Sep 2018 23:11:05 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m8twk3a0b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Sep 2018 23:11:05 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 3 Sep 2018 04:11:03 +0100
Subject: Re: [PATCH] powerpc/powernv: Make possible for user to force a full
 ipl cec reboot
To: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20180901081745.2165-1-vaibhav@linux.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 3 Sep 2018 13:10:55 +1000
In-Reply-To: <20180901081745.2165-1-vaibhav@linux.ibm.com>
Message-Id: <0fd029d2-e8ac-4392-6961-62e588ee5182@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/18 18:17, Vaibhav Jain wrote:
> Ever since fast reboot is enabled by default in opal,
> opal_cec_reboot() will use fast-reset instead of full IPL to perform
> system reboot. This leaves the user with no direct way to force a full
> IPL reboot except changing an nvram setting that persistently disables
> fast-reset for all subsequent reboots.
>=20
> This patch provides a more direct way for the user to force a one-shot
> full IPL reboot by passing the command line argument 'full' to the
> reboot command. So the user will be able to tweak the reboot behavior
> via:
>=20
>    $ sudo reboot full	# Force a full ipl reboot skipping fast-reset
>=20
>    or
>    $ sudo reboot  	# default reboot path (usually fast-reset)
>=20
> The reboot command passes the un-parsed command argument to the kernel
> via the 'Reboot' syscall which is then passed on to the arch function
> pnv_restart(). The patch updates pnv_restart() to handle this cmd-arg
> and issues opal_cec_reboot2 with OPAL_REBOOT_FULL_IPL to force a full
> IPL reset.
>=20
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Oh good, someone else has finally picked this up and sent a kernel=20
patch, I did the skiboot half and then neglected to make it useful (I=20
sent an RFC at https://patchwork.ozlabs.org/patch/697604/ but never=20
followed up on it... this approach seems more usable, I think).

When you say "the reboot command" - is this behaviour of passing the=20
argument common to all the important init systems/reboot utils?  What's=20
the correct systemd way to do it?

>   	while (rc =3D=3D OPAL_BUSY || rc =3D=3D OPAL_BUSY_EVENT) {
> -		rc =3D opal_cec_reboot();
> +
> +		/* See if we need to do a full IPL reboot */
> +		if (cmd && strcmp(cmd, "full") =3D=3D 0)
> +			rc =3D opal_cec_reboot2(OPAL_REBOOT_FULL_IPL, NULL);

You might want to check for OPAL_UNSUPPORTED here just in case we're=20
running on ancient firmware.

> +		else
> +			rc =3D opal_cec_reboot();
> +
>   		if (rc =3D=3D OPAL_BUSY_EVENT)
>   			opal_poll_events(NULL);
>   		else
>=20

--=20
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
