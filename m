Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id B8D8CDDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 15:18:48 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so4907400wag.13
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 20:18:47 -0800 (PST)
Message-ID: <9e4733910801222018m3b5b648ak90c4ee0a624a6d84@mail.gmail.com>
Date: Tue, 22 Jan 2008 23:18:46 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
In-Reply-To: <20080123141121.02c69526.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020914.31675.35659.stgit@terra.home>
	<20080123141121.02c69526.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/22/08, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Tue, 22 Jan 2008 21:09:14 -0500 Jon Smirl <jonsmirl@gmail.com> wrote:
> >
> > +static struct of_device_id mpc_i2c_of_match[] = {
>
> (sfr winds up his broken record :-))  const, please.

Fixed this

>
> > +#else
> > +
> >  static int fsl_i2c_probe(struct platform_device *pdev)
>
> While this code is still here, you should still explicitly include
> <linux/platform.h>

Fixed this

>
> > -      fail_add:
> > +fail_add:
>
> If you are going to move labels, many people leave a single space in
> front of them so that "diff -p" picks up the function name instead of the
> label name.

checkpatch told me to get rid of the spaces.

>
> > +void of_register_i2c_devices(struct i2c_adapter *adap, struct device_node *adap_node)
>
> > +             compatible = of_get_property(node, "compatible", &len);
>
> You can specify NULL instead of &len since you don't use the returned value.

fixed

>
> > +             if (!compatible) {
> > +                     printk(KERN_ERR "i2c-mpc.c: invalid entry, missing compatible attribute\n");
>
> Some of these printk lines are a bit long.

i got rid of "invalid entry,"

>
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
