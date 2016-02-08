Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B7A31A0018
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 22:31:50 +1100 (AEDT)
In-Reply-To: <1453272618-1083-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/2] powerpc/powernv: new function to access OPAL msglog
Message-Id: <20160208113149.F33D1140B99@ozlabs.org>
Date: Mon,  8 Feb 2016 22:31:49 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-20-01 at 06:50:17 UTC, Andrew Donnellan wrote:
> Currently, the OPAL msglog/console buffer is exposed as a sysfs file, with
> the sysfs read handler responsible for retrieving the log from the OPAL
> buffer. We'd like to be able to use it in xmon as well.
> 
> Refactor the OPAL msglog code to create a new function, opal_msglog_copy(),
> that copies to an arbitrary buffer.

This is a good idea, but the implementation is not quite right, comments below.

> diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
> index 44ed78a..a06191c 100644
> --- a/arch/powerpc/platforms/powernv/opal-msglog.c
> +++ b/arch/powerpc/platforms/powernv/opal-msglog.c
> @@ -31,11 +31,11 @@ struct memcons {
>  	__be32 in_cons;
>  };
>  
> -static ssize_t opal_msglog_read(struct file *file, struct kobject *kobj,
> -				struct bin_attribute *bin_attr, char *to,
> -				loff_t pos, size_t count)
> +static struct bin_attribute opal_msglog_attr;
> +
> +ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
>  {
> -	struct memcons *mc = bin_attr->private;
> +	struct memcons *mc = opal_msglog_attr.private;

Pulling the memcons out of the bin_attr here is not all that nice. This routine
should really stand on its own without reference to the bin_attr. In theory I
might want to disable building sysfs but still have this routine available.

It's also a bit fishy if it's called before the bin_attr is initialised or when
the memcons initialisation fails. In both cases it should be OK, because the
structs in question are static and so the private pointer will be NULL, but
that's a bit fragile.

I think the solution is simply to create a:

  static struct memcons *opal_memcons;

And use that in opal_msglog_copy() and so on.

cheers
