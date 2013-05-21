Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 35EA82C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 07:44:14 +1000 (EST)
Date: Tue, 21 May 2013 16:44:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: SATA hang on 8315E triggered by heavy flash write?
To: Anthony Foiani <tkil@scrye.com>
In-Reply-To: <gsj1oirve.fsf@dworkin.scrye.com> (from tkil@scrye.com on Wed
 May 15 03:12:21 2013)
Message-ID: <1369172643.1374.15@scott-Lenovo-G560>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, Shaohui.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/15/2013 03:12:21 AM, Anthony Foiani wrote:
> At this point, /dev/sda is pretty much unusable, and I have to do at
> least a reboot to recover.  (I don't recall if I had to do a power
> cycle at this point, though.)
>=20
> I suspect that it is related to errata eLBC-A001 (from MPC8315E Chip
> Errata, Rev. 3, 09/2011):
>=20
>   eLBC-A001:
>=20
>   Simultaneous FCM and GPCM or UPM operation may erroneously trigger
>   bus monitor timeout
>=20
>   Description: Devices: MPC8315E, MPC8314E
>   When the FCM is in the middle of a long transaction, such as NAND
>   erase or write, another transaction on the GPCM or UPM triggers the
>   bus monitor to start immediately for the GPCM or UPM, even though
>   the GPCM or UPM is still waiting for the FCM to finish and has not
>   yet started its transaction. If the bus monitor timeout value is not
>   programmed for a sufficiently large value, the local bus monitor may
>   time out. This timeout corrupts the current NAND Flash operation and
>   terminate the GPCM or UPM operation.
>=20
>   Impact: Local bus monitor may time out unexpectedly and corrupt the
>   NAND transaction.
>=20
>   Workaround: Set the local bus monitor timeout value to the maximum
>   by setting LBCR[BMT] =3D 0 and LBCR[BMTPS] =3D 0xF.
>=20
>   Fix plan: No plans to fix
>=20
> But it seems that erratum is already fixed:
>=20
>   http://patchwork.ozlabs.org/patch/96339/
>   (git patch d08e44570e)
>=20
> Am I reading that correctly?

Yes, that erratum has been worked around.

> (I'm already writing only one flash
> sector at a time, but it might be that even a single 0x10000-byte
> sector takes long enough to trigger the issue.)

I don't think this erratum is relevant.  Unlike NAND, NOR flash does =20
not involve holding the localbus for extended periods of time.  I also =20
don't see how it would interact with SATA, which is separate from the =20
localbus.  Are you seeing any errors on the localbus, or just on SATA?

> I also verified that
> I have the relevant property in my device tree:
>=20
>   localbus@e0005000 {
>     ...
>     compatible =3D "fsl,mpc8315-elbc", "fsl,elbc", "simple-bus";
>=20
> So, my questions are:
>=20
> 1. Is anyone else seeing something like this?
>=20
> 2. Is there an obvious way for our code to detect that we're in the
>    middle of error recovery, so we can not write to the disk until
>    recovery is complete?
>=20
> 3. Is there any chance that the 1.5Gbps limiting code might have
>    exacerbated the problems?
>=20
> 4. Should I open a support request with Freescale, or if someone from
>    Freescale is already reading this, could you look to see if anyone
>    else has reported it?

Hopefully Shaohui (our SATA person) can answer these.  If you don't get =20
an answer, go ahead and open an official support request.

-Scott=
