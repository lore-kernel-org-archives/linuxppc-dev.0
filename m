Return-Path: <John.Linn@xilinx.com>
Received: from outbound9-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CD1EEDE1F5
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 03:22:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/3] [POWERPC] Xilinx: boot support for Xilinx uart 16550.
Date: Thu, 20 Mar 2008 10:15:23 -0600
In-Reply-To: <fa686aa40803200754j6972deenad63cf37a836f236@mail.gmail.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<1206024232655-git-send-email-john.linn@xilinx.com>
	<20080320144402.695C1518064@mail63-sin.bigfish.com>
	<fa686aa40803200754j6972deenad63cf37a836f236@mail.gmail.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080320161834.A873BDE0072@mail96-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

You're right.  Rick and I were just talking about could we not check the
versions but just make sure the device is the right type independent of
the versions.

This issue will be true for all the Xilinx drivers.

I think FPGA IP is a little different in that the hardware can change
much more often than in hard devices.

-- John

-----Original Message-----
From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
Sent: Thursday, March 20, 2008 8:55 AM
To: John Linn
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] [POWERPC] Xilinx: boot support for Xilinx uart
16550.

On Thu, Mar 20, 2008 at 8:43 AM, John Linn <john.linn@xilinx.com> wrote:
> The Xilinx 16550 uart core is not a standard 16550, because it uses
>  word-based addressing rather than byte-based addressing.  As a
result,
>  it is not compatible with the open firmware 'ns16550' compatible
>  binding.
>
>  This code adds the Xilinx uart 16550 to the serial console
>  of the boot. A new initialization function for the Xilinx 16550 uart
>  is added to the ns16550 driver. It sets up the correct register base
>  and regshift properties specific to the Xilinx 16550.
>
>  Signed-off-by: John Linn <john.linn@xilinx.com>
>  --- a/arch/powerpc/boot/ops.h
>  +++ b/arch/powerpc/boot/ops.h
>  @@ -86,6 +86,7 @@ int mpsc_console_init(void *devp, struct
serial_console_data *scdp);
>   int cpm_console_init(void *devp, struct serial_console_data *scdp);
>   int mpc5200_psc_console_init(void *devp, struct serial_console_data
*scdp);
>   int uartlite_console_init(void *devp, struct serial_console_data
*scdp);
>  +int xilinx16550_console_init(void *devp, struct serial_console_data
*scdp);
>   void *simple_alloc_init(char *base, unsigned long heap_size,
>                         unsigned long granularity, unsigned long
max_allocs);
>   extern void flush_cache(void *, unsigned long);
>  diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
>  index 7fa5078..fb5c91e 100644
>  --- a/arch/powerpc/boot/serial.c
>  +++ b/arch/powerpc/boot/serial.c
>  @@ -131,6 +131,14 @@ int serial_console_init(void)
>         else if (dt_is_compatible(devp, "xlnx,opb-uartlite-1.00.b") ||
>                   dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
>                 rc =3D uartlite_console_init(devp, &serial_cd);
>  +       else if (dt_is_compatible(devp, "xlnx,opb-uart16550-1.00.c")
||
>  +                dt_is_compatible(devp, "xlnx,opb-uart16550-1.00.d")
||
>  +                dt_is_compatible(devp, "xlnx,opb-uart16550-1.00.e")
||
>  +                dt_is_compatible(devp, "xlnx,plb-uart16550-1.00.c")
||
>  +                dt_is_compatible(devp, "xlnx,xps-uart16550-1.00.a")
||
>  +                dt_is_compatible(devp, "xlnx,xps-uart16550-2.00.a")
||
>  +                dt_is_compatible(devp, "xlnx,xps-uart16550-2.00.b"))
>  +               rc =3D xilinx16550_console_init(devp, &serial_cd);

I'll review this whole patch set today, but I need to make this
comment now.  Adding to this ever increasing list of xilinx device
versions is not sustainable.  A common base compatible value needs to
be chosen instead.  Way back in the mists of time something line
"sparse16550" was suggested and I think it is a good one.  xilinx uart
nodes should claim compatibility with their specific version *and*
"sparse16550".  Then all this code should only match with
"sparse16550" and documentation should be added to
Documentation/powerpc/booting-without-of.txt to describe what
sparse16550 means.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
