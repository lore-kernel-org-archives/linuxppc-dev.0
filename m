Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE006.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 46DF2DE310
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 02:48:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] powerpc: legacy_serial: reg-offset & shift aren't used
Date: Tue, 1 Jul 2008 09:48:06 -0700
In-Reply-To: <12149299143952-git-send-email-john.linn@xilinx.com>
References: <12149299143952-git-send-email-john.linn@xilinx.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "John Linn" <john.linn@xilinx.com>, <linuxppc-dev@ozlabs.org>,
	<grant.likely@secretlab.ca>, <paulus@samba.org>,
	<benh@kernel.crashing.org>, <dwg@au1.ibm.com>, <jwboyer@linux.vnet.ibm.com>
Message-ID: <20080701164807.98F1EFF0083@mail8-va3.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: John Linn [mailto:john.linn@xilinx.com]
> Sent: Tuesday, July 01, 2008 9:32 AM
> To: linuxppc-dev@ozlabs.org; grant.likely@secretlab.ca;
paulus@samba.org; benh@kernel.crashing.org;
> dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com; Stephen Neuendorffer
> Cc: John Linn
> Subject: [PATCH] powerpc: legacy_serial: reg-offset & shift aren't
used
> =

> The legacy serial driver does not work with an 8250
> type UART that uses reg-offset and reg-shift. This
> change updates the driver so it doesn't find the UART
> when those properties are present on the UART in the
> device tree for soc devices.
> =

> Signed-off-by: John Linn <john.linn@xilinx.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> =

>  arch/powerpc/kernel/legacy_serial.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =

> diff --git a/arch/powerpc/kernel/legacy_serial.c
b/arch/powerpc/kernel/legacy_serial.c
> index 61dd174..b43235f 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -136,6 +136,11 @@ static int __init add_legacy_soc_port(struct
device_node *np,
>  	if (of_get_property(np, "clock-frequency", NULL) =3D=3D NULL)
>  		return -1;
> =

> +	/* if reg-shift and offset, don't try to use it */
> +	if ((of_get_property(np, "reg-shift", NULL) !=3D NULL) &&
> +		(of_get_property(np, "reg-offset", NULL) !=3D NULL))
> +		return -1;

Um, shouldn't this be || ?

> +
>  	/* if rtas uses this device, don't try to use it as well */
>  	if (of_get_property(np, "used-by-rtas", NULL) !=3D NULL)
>  		return -1;
> --
> 1.5.2.1
> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
