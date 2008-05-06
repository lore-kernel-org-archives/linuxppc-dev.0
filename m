Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound1-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2044ADE057
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 04:26:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Xilinx: hwicap: cleanup polling timeout.
Date: Tue, 6 May 2008 11:26:36 -0700
In-reply-to: <fa686aa40805051301u1542c51evbd2126fc1df5db22@mail.gmail.com>
References: <20080505182150.E9878B8004D@mail95-dub.bigfish.com>
	<fa686aa40805051301u1542c51evbd2126fc1df5db22@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080506182637.BF5361A18055@mail220-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Not really... In this case 'faster' means 'faster ICAP core' not 'faster
processor':
This is really something that is bounded by the number of cycles.

Steve

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
> Sent: Monday, May 05, 2008 1:01 PM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Xilinx: hwicap: cleanup polling timeout.
>=20
> On Mon, May 5, 2008 at 12:20 PM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> > In order to avoid polling forever if an error occurs, this driver
> >  includes a timeout counter.  However, in fast systems, this counter
> >  wasn't high enough.  This patch fixes the bug and also makes the
> >  buffer-based and fifo-based drivers return the same error condition
on
> >  a timeout (-EIO).
>=20
> Would it be better to base the timeout on real time instead of a hard
> iteration count?
>=20
> Cheers,
> g.
>=20
> >
> >  Signed-off-by: Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com>
> >  ---
> >   drivers/char/xilinx_hwicap/buffer_icap.c   |   10 ++++++++--
> >   drivers/char/xilinx_hwicap/fifo_icap.c     |    9 +++++++++
> >   drivers/char/xilinx_hwicap/xilinx_hwicap.h |    3 ---
> >   3 files changed, 17 insertions(+), 5 deletions(-)
> >
> >  diff --git a/drivers/char/xilinx_hwicap/buffer_icap.c
b/drivers/char/xilinx_hwicap/buffer_icap.c
> >  index aa7f796..0993883 100644
> >  --- a/drivers/char/xilinx_hwicap/buffer_icap.c
> >  +++ b/drivers/char/xilinx_hwicap/buffer_icap.c
> >  @@ -35,6 +35,12 @@
> >
> >   #include "buffer_icap.h"
> >
> >  +/* Number of times to poll the done register.  This has to be
large
> >  +   enough to allow an entire configuration to complete. If an
entire
> >  +   page (4kb) is configured at once, that could take up to 4k
cycles
> >  +   with a byte-wide icap interface. */
> >  +#define XHI_MAX_RETRIES     5000
> >  +
> >   /* Indicates how many bytes will fit in a buffer. (1 BRAM) */
> >   #define XHI_MAX_BUFFER_BYTES        2048
> >   #define XHI_MAX_BUFFER_INTS         (XHI_MAX_BUFFER_BYTES >> 2)
> >  @@ -208,7 +214,7 @@ static int buffer_icap_device_read(struct
hwicap_drvdata *drvdata,
> >         while (buffer_icap_busy(base_address)) {
> >                 retries++;
> >                 if (retries > XHI_MAX_RETRIES)
> >  -                       return -EBUSY;
> >  +                       return -EIO;
> >         }
> >         return 0;
> >
> >  @@ -242,7 +248,7 @@ static int buffer_icap_device_write(struct
hwicap_drvdata *drvdata,
> >         while (buffer_icap_busy(base_address)) {
> >                 retries++;
> >                 if (retries > XHI_MAX_RETRIES)
> >  -                       return -EBUSY;
> >  +                       return -EIO;
> >         }
> >         return 0;
> >
> >  diff --git a/drivers/char/xilinx_hwicap/fifo_icap.c
b/drivers/char/xilinx_hwicap/fifo_icap.c
> >  index 776b505..d1cd928 100644
> >  --- a/drivers/char/xilinx_hwicap/fifo_icap.c
> >  +++ b/drivers/char/xilinx_hwicap/fifo_icap.c
> >  @@ -35,6 +35,15 @@
> >
> >   #include "fifo_icap.h"
> >
> >  +/* Number of times to poll the done register.  This has to be
large
> >  + * enough to allow an entire configuration to complete.  If an
entire
> >  + * page (4kb) is configured at once, that could take up to 4k
cycles
> >  + * with a byte-wide icap interface.  In most cases, this driver is
> >  + * used with a much smaller fifo, but this should be sufficient in
the
> >  + * worst case.
> >  + */
> >  +#define XHI_MAX_RETRIES     5000
> >  +
> >   /* Register offsets for the XHwIcap device. */
> >   #define XHI_GIER_OFFSET        0x1C  /* Device Global Interrupt
Enable Reg */
> >   #define XHI_IPISR_OFFSET 0x20  /* Interrupt Status Register */
> >  diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.h
> b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
> >  index 1f9c8b0..fd4be31 100644
> >  --- a/drivers/char/xilinx_hwicap/xilinx_hwicap.h
> >  +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
> >  @@ -89,9 +89,6 @@ struct hwicap_driver_config {
> >         void (*reset)(struct hwicap_drvdata *drvdata);
> >   };
> >
> >  -/* Number of times to poll the done regsiter */
> >  -#define XHI_MAX_RETRIES     10
> >  -
> >   /************ Constant Definitions *************/
> >
> >   #define XHI_PAD_FRAMES              0x1
> >  --
> >  1.5.3.4-dirty
> >
> >
> >
> >
>=20
>=20
>=20
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
