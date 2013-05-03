Return-Path: <bhutchings@solarflare.com>
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "WEBMAIL.SOLARFLARE.COM",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 18EDB2C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 02:30:43 +1000 (EST)
Message-ID: <1367598632.2756.3.camel@bwh-desktop.uk.solarflarecom.com>
Subject: Re: net/eth/ibmveth: Fixup retrieval of MAC address
From: Ben Hutchings <bhutchings@solarflare.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 3 May 2013 17:30:32 +0100
In-Reply-To: <1367458520.4389.6.camel@pasglop>
References: <1367458520.4389.6.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-02 at 11:35 +1000, Benjamin Herrenschmidt wrote:
> Some ancient pHyp versions used to create a 8 bytes local-mac-address
> property in the device-tree instead of a 6 bytes one for veth.
> 
> The Linux driver code to deal with that is an insane hack which also
> happens to break with some choices of MAC addresses in qemu by testing
> for a bit in the address rather than just looking at the size of the
> property.
> 
> Sanitize this by doing the latter instead.
[...]
> @@ -1334,11 +1334,19 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  		dev->unit_address);
>  
>  	mac_addr_p = (unsigned char *)vio_get_attribute(dev, VETH_MAC_ADDR,
> -							NULL);
> +							&mac_len);
>  	if (!mac_addr_p) {
>  		dev_err(&dev->dev, "Can't find VETH_MAC_ADDR attribute\n");
>  		return -EINVAL;
>  	}
> +	/* Workaround for old/broken pHyp */
> +	if (mac_len == 8)
> +		mac_addr_p += 2;
> +	if (mac_len != 6) {

Missing 'else' before the second if?

> +		dev_err(&dev->dev, "VETH_MAC_ADDR attribute wrong len %d\n",
> +			mac_len);
> +		return -EINVAL;
> +	}
[...]

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
