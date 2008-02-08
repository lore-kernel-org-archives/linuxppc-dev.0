Return-Path: <jirislaby@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 7C654DDE26
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 20:10:11 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so2666243fgg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Feb 2008 01:10:08 -0800 (PST)
Message-ID: <47AC1C6E.1090101@gmail.com>
Date: Fri, 08 Feb 2008 10:10:06 +0100
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: hwicap driver
References: <47AB6552.7040503@gmail.com>
	<20080208021747.92253161805C@mail10-sin.bigfish.com>
In-Reply-To: <20080208021747.92253161805C@mail10-sin.bigfish.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 02/08/2008 03:17 AM, Stephen Neuendorffer wrote:
> This includes code for new fifo-based xps_hwicap in addition to the
> older opb_hwicap, which has a significantly different interface.  The
> common code between the two drivers is largely shared.
> 
> Significant differences exists between this driver and what is
> supported in the EDK drivers.  In particular, most of the
> architecture-specific code for reconfiguring individual FPGA resources
> has been removed.  This functionality is likely better provided in a
> user-space support library.  In addition, read and write access is
> supported.  In addition, although the xps_hwicap cores support
> interrupt-driver mode, this driver only supports polled operation, in
> order to make the code simpler, and since the interrupt processing
> overhead is likely to slow down the throughput under Linux.
> 
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> 
> Fixed to add mutexes, and a few style issues.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> The final update to xilinx_hwicap.h was missing.
> 
> fix some missing __user tags and incorrect section tags.
> convert semaphores to mutexes.
> make probed_devices re-entrancy and error condition safe.
> fix some backwards memcpys.
> some other minor cleanups.

Looks good to me.

> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> ---
[...]
> diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> new file mode 100644
> index 0000000..2caac31
> --- /dev/null
> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> @@ -0,0 +1,923 @@
[...]
> +module_param(xhwicap_major, int, S_IRUGO);
> +module_param(xhwicap_minor, int, S_IRUGO);
> +
> +/* An array, which is set to true when the device is registered. */
> +static bool probed_devices[HWICAP_DEVICES];
> +static struct mutex icap_sem;

Just a sideway note, static DEFINE_MUTEX(icap_sem); and you don't need to 
runtime init it then.
