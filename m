Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5209B6EEF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 09:11:29 +1100 (EST)
Received: by pbcwy12 with SMTP id wy12so1179904pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 15:11:25 -0700 (PDT)
Date: Wed, 21 Mar 2012 15:11:22 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Yoder <key@linux.vnet.ibm.com>
Subject: Re: [PATCH 15/17] powerpc: crypto: sysfs routines and docs for the
 nx device driver
Message-ID: <20120321221122.GA30748@kroah.com>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
 <1332366080.3858.52.camel@key-ThinkPad-W510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332366080.3858.52.camel@key-ThinkPad-W510>
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

On Wed, Mar 21, 2012 at 04:41:20PM -0500, Kent Yoder wrote:
> These routines add sysfs files supporting the Power7+ in-Nest encryption
> accelerator driver.
> 
> Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
> ---
>  Documentation/powerpc/pfo-nx-crypto.txt |   52 ++++++++

Please put sysfs file information in Documentation/ABI/ where it
belongs.

>  arch/powerpc/crypto/nx/nx_sysfs.c       |  194 +++++++++++++++++++++++++++++++
>  2 files changed, 246 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/powerpc/pfo-nx-crypto.txt
>  create mode 100644 arch/powerpc/crypto/nx/nx_sysfs.c
> 
> diff --git a/Documentation/powerpc/pfo-nx-crypto.txt b/Documentation/powerpc/pfo-nx-crypto.txt
> new file mode 100644
> index 0000000..63440d3
> --- /dev/null
> +++ b/Documentation/powerpc/pfo-nx-crypto.txt
> @@ -0,0 +1,52 @@
> +
> +Documentation for the sysfs interfaces provided by the nx-crypto driver, built
> +in arch/powerpc/crypto/nx.
> +
> +The driver provides 2 sets of sysfs files, 1 for confirming that the device is
> +actually being used and 1 for error detection.

Shouldn't the first just be debugfs files, as no "normal" user will ever
care about such a thing?

Actually, why are these sysfs files at all, how about all of this going
into debugfs?


> +Error Detection
> +===============

<snip>

What can anyone do with any of these files?  What use are they to users?

> +Device Use
> +==========

Again, what does a user care about these items for?

> +int
> +nx_sysfs_init(struct device_driver *drv)
> +{
> +	int rc;
> +
> +	rc = driver_create_file(drv, &driver_attr_aes_ops);
> +	if (rc)
> +		goto out;

<snip>

Oh, ${DIETY}, no.  Please don't create files one by one, we do have
functions that do all of this for you automatically, why aren't you
using them?

> +void
> +nx_sysfs_fini(struct device_driver *drv)
> +{
> +	driver_remove_file(drv, &driver_attr_sync_ops);
> +	driver_remove_file(drv, &driver_attr_aes_bytes);
> +	driver_remove_file(drv, &driver_attr_aes_ops);
> +	driver_remove_file(drv, &driver_attr_sha256_bytes);
> +	driver_remove_file(drv, &driver_attr_sha256_ops);
> +	driver_remove_file(drv, &driver_attr_sha512_bytes);
> +	driver_remove_file(drv, &driver_attr_sha512_ops);

Same here, don't do this, do it all at once.

> +}

Who is calling these functions?  Where in the device lifecycle are the
files being created?  Did you just race userspace with how they are
created, or are you doing it "properly"?  (hint, odds are, as you are
trying to manually create and remove these by hand, you aren't doing it
properly...)

thanks,

greg k-h
