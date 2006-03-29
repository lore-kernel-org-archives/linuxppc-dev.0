Return-Path: <hollis@penguinppc.org>
Received: from smtpauth07.mail.atl.earthlink.net
	(smtpauth07.mail.atl.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id EC841679F7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 13:03:39 +1100 (EST)
In-Reply-To: <1143586160.2660.19.camel@enki.eridu>
References: <1143586160.2660.19.camel@enki.eridu>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <66cc5bfb5a367a814fbace8105572658@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH] DTC - validation by device_type
Date: Tue, 28 Mar 2006 20:03:47 -0600
To: Paul Nasrat <pnasrat@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mar 28, 2006, at 4:49 PM, Paul Nasrat wrote:
>
> It'd be nice to be able to validate by device_type, to ensure that we
> don't reinvent the wheel (address vs. local-mac-address) and to give
> embedded designers an added level of sanity checking.
>
> Here is a proposed implementation with an implemented check for
> "network".
>
> Signed-off-by: Paul Nasrat <pnasrat@redhat.com>
>
> diff --git a/livetree.c b/livetree.c
> index ef54174..351773b 100644
> --- a/livetree.c
> +++ b/livetree.c
> @@ -441,6 +441,52 @@ static int check_structure(struct node *
>  				(propname), (node)->fullpath); \
>  	} while (0)
>
> +static int check_network(struct node *net)
> +{
> +
> +	int ok = 1;
> +	struct property *prop;
> +
> +	CHECK_HAVE_STREQ(net, "device_type", "network");

The only reason you got into this function was that device_type == 
"network"...

> +	CHECK_HAVE(net, "reg");
> +	CHECK_HAVE(net, "local-mac-address");
> +	CHECK_HAVE(net, "mac-address");
> +	CHECK_HAVE(net, "address-bits");
> +
> +	return ok;
> +}
> +
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
> +						}

Unless this is some weird style thing, that close brace seems 
misindented.

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
> @@ -716,6 +762,7 @@ int check_device_tree(struct node *dt)
>  	ok = ok && check_cpus(dt);
>  	ok = ok && check_memory(dt);
>  	ok = ok && check_chosen(dt);
> +	ok = ok && check_devtypes(dt);
>  	if (! ok)
>  		return 0;
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
