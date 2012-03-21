Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D948B6FDC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 09:15:22 +1100 (EST)
Received: by pbcwy12 with SMTP id wy12so1182184pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 15:15:20 -0700 (PDT)
Date: Wed, 21 Mar 2012 15:15:17 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Yoder <key@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/17] powerpc: crypto: nx driver code supporting nx
 encryption
Message-ID: <20120321221517.GB30748@kroah.com>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
 <1332366068.3858.50.camel@key-ThinkPad-W510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332366068.3858.50.camel@key-ThinkPad-W510>
Cc: rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2012 at 04:41:08PM -0500, Kent Yoder wrote:
> +static int nx_register_algs(void)
> +{
> +	int rc = -1;
> +
> +	if (nx_driver.of.flags != NX_OF_FLAG_MASK_READY)
> +		goto out;
> +
> +	memset(&nx_driver.stats, 0, sizeof(struct nx_stats));
> +
> +	rc = nx_sysfs_init(&nx_driver.viodriver.driver);

Ok, that's not bad, you are doing it from the probe() function of your
bus.  As long as the bus got things right on when uevents get sent to
userspace, does it?

> +static struct vio_device_id nx_crypto_driver_ids[] __devinitdata = {
> +	{ "ibm,sym-encryption-v1", "ibm,sym-encryption" },
> +	{ "", "" }
> +};
> +MODULE_DEVICE_TABLE(vio, nx_crypto_driver_ids);
> +
> +/* driver state structure */
> +struct nx_crypto_driver nx_driver = {
> +	.viodriver = {
> +		.id_table = nx_crypto_driver_ids,
> +		.probe = nx_probe,
> +		.remove = nx_remove,
> +		.driver = {
> +			.name  = "nx",
> +			.owner = THIS_MODULE,
> +		},

Really?  vio drivers are supposed to look like this with the .name and
.owner field manually being set in the static initialization of the
driver?  That's sad, and should be fixed, the vio core should do this
type of thing for you.

greg k-h
