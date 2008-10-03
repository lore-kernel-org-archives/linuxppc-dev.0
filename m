Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-156.bluehost.com (outbound-mail-156.bluehost.com
	[67.222.39.36]) by ozlabs.org (Postfix) with SMTP id AEBD6DE14B
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:05:56 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/2] powerpc: Add legacy PCI access via sysfs
Date: Fri, 3 Oct 2008 08:59:12 -0700
References: <20081003094953.A7F4EDE184@ozlabs.org>
In-Reply-To: <20081003094953.A7F4EDE184@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810030859.12335.jbarnes@virtuousgeek.org>
Cc: linuxppc-dev@ozlabs.org, tony.luck@intel.com, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday, October 3, 2008 2:49 am Benjamin Herrenschmidt wrote:
> +	/* WARNING: The generic code is idiotic. It gets passed a pointer
> +	 * to what can be a 1, 2 or 4 byte quantity and always reads that
> +	 * as a u32, which means that we have to correct the location of
> +	 * the data read within those 32 bits for size 1 and 2
> +	 */
> +	switch(size) {
> +	case 1:
> +		out_8(addr, val >> 24);
> +		return 1;
> +	case 2:
> +		if (port & 1)
> +			return -EINVAL;
> +		out_le16(addr, val >> 16);
> +		return 2;
> +	case 4:
> +		if (port & 3)
> +			return -EINVAL;
> +		out_le32(addr, val);
> +		return 4;
> +	}
> +	return -EINVAL;

Feel free to change the generic code if it makes things easier for you, the 
only limitation is that we have to live within the generic sysfs read/write 
functions.  Obviously I didn't worry about it when doing this code on ia64...

Jesse
