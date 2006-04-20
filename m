Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 64886679F8
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 01:38:49 +1000 (EST)
Subject: Re: [PATCH] DTC - validation by device_type
From: Jon Loeliger <jdl@freescale.com>
To: Paul Nasrat <pnasrat@redhat.com>
In-Reply-To: <1143599612.2704.14.camel@enki.eridu>
References: <1143586160.2660.19.camel@enki.eridu>
	<66cc5bfb5a367a814fbace8105572658@penguinppc.org>
	<1143599612.2704.14.camel@enki.eridu>
Content-Type: text/plain
Message-Id: <1145547307.5314.118.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 20 Apr 2006 10:35:08 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-28 at 20:33, Paul Nasrat wrote:

> Signed-off-by: Paul Nasrat <pnasrat@redhat.com>

Paul,

Sorry about the hang-time here.  Couple questions.


> +static int check_network(struct node *net)
> +{
> +
> +	int ok = 1;
> +	struct property *prop;
> +
> +	CHECK_HAVE(net, "reg");
> +	CHECK_HAVE(net, "local-mac-address");
> +	CHECK_HAVE(net, "mac-address");
> +	CHECK_HAVE(net, "address-bits");
> +
> +	return ok;
> +}

This says that all network nodes have to have all four
of those properties.  It's not clear to me that they all
need to have both local-mac-address and mac-address.
Specifically, 1275 seems to indicate to me that the
mac-address property, being introduced by the open
operation, might be dynamically set at run time, rather
than passed as a config parameter from, say, U-Boot to
the kernel.  Thus, it might not be necessary here.

Should this check be more like "has at least one of
local-mac-address and mac-address" instead?


> +static struct {
> +	char *devtype;
> +	int (*check_fn)(struct node *node);
> +} devtype_checker_table[] = {
> +	{"network", check_network},
> +};
> +
> +static int check_devtypes(struct node *root)
> +{
> +
> +	struct node *child;
> +	struct property *prop;
> +	int ok = 1;
> +	int i;
> +
> +	for_each_child(root, child) {
> +		/* check this node */
> +		if ((prop = get_property((child), ("device_type"))))
> +			for (i = 0; i < ARRAY_SIZE(devtype_checker_table); i++) {
> +				if (streq(prop->val.val, devtype_checker_table[i].devtype))
> +					if (! devtype_checker_table[i].check_fn(child)) {
> +						ok = 0;
> +						break;
> +					}
> +			}
> +		ok = check_devtypes(child);
> +	}
> +
> +	return ok;
> +}
> +
>  static int check_root(struct node *root)
>  {
>  	struct property *prop;
> @@ -716,6 +761,7 @@ int check_device_tree(struct node *dt)
>  	ok = ok && check_cpus(dt);
>  	ok = ok && check_memory(dt);
>  	ok = ok && check_chosen(dt);
> +	ok = ok && check_devtypes(dt);
>  	if (! ok)
>  		return 0;

I buy the rest of this.

Thanks,
jdl
