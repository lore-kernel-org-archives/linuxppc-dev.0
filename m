Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3392A2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2012 03:59:44 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so5206695pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 10:59:42 -0700 (PDT)
Date: Fri, 27 Jul 2012 10:59:39 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: sandeep@freescale.com
Subject: Re: [2/3][PATCH][v2] TDM Framework
Message-ID: <20120727175939.GA23105@kroah.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
Cc: devel@driverdev.osuosl.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2012 at 07:35:38PM +0530, sandeep@freescale.com wrote:
> +/* Data structures required for sysfs */
> +static struct tdm_sysfs attr = {
> +	.attr.name = "use_latest_data",
> +	.attr.mode = 0664,
> +	.cmd_type = TDM_LATEST_DATA,
> +};

What is this for?

> +int tdm_sysfs_init(void)
> +{
> +	struct kobject *tdm_kobj;
> +	int err = 1;
> +	tdm_kobj = kzalloc(sizeof(*tdm_kobj), GFP_KERNEL);
> +	if (tdm_kobj) {
> +		kobject_init(tdm_kobj, &tdm_type);
> +		if (kobject_add(tdm_kobj, NULL, "%s", "tdm")) {
> +			pr_err("tdm: Sysfs creation failed\n");
> +			kobject_put(tdm_kobj);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +	} else {
> +		pr_err("tdm: Unable to allocate tdm_kobj\n");
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +out:
> +	return err;
> +}

You just leaked memory, what are you trying to do here?

And why are you using "raw" kobjects?  That's a sure sign that something
is really wrong.

Your code doesn't look like it is tied into the driver model at all, why
not?  What are you trying to do here?

Also, when creating new sysfs entries, like you are attempting to do
here (unsuccessfully I might add), you must create Documentation/ABI/
files as well.

And, to top it all off, you do realize you are asking us to do code
review in the middle of the merge window, when we are all busy doing
other things?

greg k-h
