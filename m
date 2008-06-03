Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from WA4EHSOBE004.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id AF50EDE183
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 07:42:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
Date: Tue, 3 Jun 2008 14:41:59 -0700
In-Reply-To: <1210271125-11559-1-git-send-email-stephen.neuendorffer@xilinx.com>
References: <20080508161529.65566FB805F@mail185-va3.bigfish.com>
	<1210271125-11559-1-git-send-email-stephen.neuendorffer@xilinx.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	<dwg@au1.ibm.com>, <jwboyer@linux.vnet.ibm.com>,
	<grant.likely@secretlab.ca>, <linuxppc-dev@ozlabs.org>
Message-ID: <20080603214232.E0A8D1488061@mail55-wa4.bigfish.com>
Cc: git <git@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It appears that this turns out to interact badly with the probing of
PPC_UDBG_16550, which is always enabled on PPC405 (and apparently
found!) even though Virtex devices don't have them.

Steve

> -----Original Message-----
> From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com]
> Sent: Thursday, May 08, 2008 11:25 AM
> To: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com;
grant.likely@secretlab.ca; linuxppc-dev@ozlabs.org
> Cc: Stephen Neuendorffer
> Subject: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
> =

> ePAPR drafts propose 'simple-bus' as a generic compatibility type for
> busses which cannot be probed for devices.  In addition, the Xilinx
> versions of these IPs seem to be proliferating.  Hence, in the future
> let's prefer to use the standard names.  I've left the old names in
> for short term backward compatibility for existing device trees.
> =

> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> ---
>  arch/powerpc/platforms/40x/virtex.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/arch/powerpc/platforms/40x/virtex.c
b/arch/powerpc/platforms/40x/virtex.c
> index 6c72994..b1ab7b8 100644
> --- a/arch/powerpc/platforms/40x/virtex.c
> +++ b/arch/powerpc/platforms/40x/virtex.c
> @@ -16,6 +16,7 @@
>  #include <asm/xilinx_intc.h>
> =

>  static struct of_device_id xilinx_of_bus_ids[] __initdata =3D {
> +	{ .compatible =3D "simple-bus", },
>  	{ .compatible =3D "xlnx,plb-v46-1.00.a", },
>  	{ .compatible =3D "xlnx,plb-v46-1.02.a", },
>  	{ .compatible =3D "xlnx,plb-v34-1.01.a", },
> --
> 1.5.3.4
> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
