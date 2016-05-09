Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3PHc5xZVzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 00:03:40 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 10 May 2016 00:03:38 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 629F62BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 00:03:36 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u49E3SDH50856176
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 00:03:36 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u49E33Wq018388
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 00:03:04 +1000
Message-ID: <1462802528.20290.104.camel@au1.ibm.com>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 linux-mips@linux-mips.org
Cc: Christian Lamparter <chunkeey@googlemail.com>, linux-usb@vger.kernel.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org, a.seppala@gmail.com,
 linux-kernel@vger.kernel.org
Date: Tue, 10 May 2016 00:02:08 +1000
In-Reply-To: <4162108.qmr2GZCaDN@wuerfel>
References: <4231696.iL6nGs74X8@debian64> <1908894.Nkk1LXQkFm@debian64>
 <1462753402.20290.95.camel@au1.ibm.com> <4162108.qmr2GZCaDN@wuerfel>
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

On Mon, 2016-05-09 at 12:36 +0200, Arnd Bergmann wrote:
> 
> I think we can simply make this set of accessors architecture-
> dependent
> (MIPS vs. the rest of the world) to revert ARM and PowerPC back to
> the working version.

Or use writel_be which mips seems to support...

Really, make it a BE vs. LE device test is a much better solution.

For now, since dwc2_readl() and writel don't take the device as an
argument, you can make it a function of a compile time #define, or
maybe a driver global, but the right way is really something like

	if (device_is_be())
		return readl_be(...)
	else
		return readl(...)

With the device_is_be() being temporarily set to true for MIPS for
example, and later, a second pass, add the device argument and make it
a device-flag initialized from the probe routine, possibly from the DT.

Cheers,
Ben.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 3c58d633ce80..1f8ed149a40f 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -64,12 +64,24 @@
>  	DWC2_TRACE_SCHEDULER_VB(pr_fmt("%s: SCH: " fmt),		
> \
>  				dev_name(hsotg->dev), ##__VA_ARGS__)
>  
> +
> +#ifdef CONFIG_MIPS
> +/*
> + * There are some MIPS machines that can run in either big-endian
> + * or little-endian mode and that use the dwc2 register without
> + * a byteswap in both ways.
> + * Unlike other architectures, MIPS does not require a barrier
> + * before the __raw_writel() to synchronize with DMA but does
> + * require the barrier after the writel() to serialize a series
> + * of writes. This set of operations was added specifically for
> + * MIPS and should only be used there.
> + */
>  static inline u32 dwc2_readl(const void __iomem *addr)
>  {
>  	u32 value = __raw_readl(addr);
>  
> -	/* In order to preserve endianness __raw_* operation is
> used. Therefore
> -	 * a barrier is needed to ensure IO access is not re-ordered 
> across
> +	/* in order to preserve endianness __raw_* operation is
> used. therefore
> +	 * a barrier is needed to ensure io access is not re-ordered 
> across
>  	 * reads or writes
>  	 */
>  	mb();
> @@ -81,15 +93,32 @@ static inline void dwc2_writel(u32 value, void
> __iomem *addr)
>  	__raw_writel(value, addr);
>  
>  	/*
> -	 * In order to preserve endianness __raw_* operation is
> used. Therefore
> -	 * a barrier is needed to ensure IO access is not re-ordered 
> across
> +	 * in order to preserve endianness __raw_* operation is
> used. therefore
> +	 * a barrier is needed to ensure io access is not re-ordered 
> across
>  	 * reads or writes
>  	 */
>  	mb();
> -#ifdef DWC2_LOG_WRITES
> -	pr_info("INFO:: wrote %08x to %p\n", value, addr);
> +#ifdef dwc2_log_writes
> +	pr_info("info:: wrote %08x to %p\n", value, addr);
>  #endif
>  }
> +#else
> +/* Normal architectures just use readl/write */
> +static inline u32 dwc2_readl(const void __iomem *addr)
> +{
> +	u32 value = readl(addr);
> +	return value;
> +}
> +
> +static inline void dwc2_writel(u32 value, void __iomem *addr)
> +{
> +	writel(value, addr);
> +
> +#ifdef dwc2_log_writes
> +	pr_info("info:: wrote %08x to %p\n", value, addr);
> +#endif
> +}
> +#endif
>  
>  /* Maximum number of Endpoints/HostChannels */
>  #define MAX_EPS_CHANNELS	16
