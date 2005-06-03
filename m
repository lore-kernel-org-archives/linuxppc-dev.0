Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 528BD67A3C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 17:02:18 +1000 (EST)
Date: Fri, 3 Jun 2005 00:11:33 -0700
From: Greg KH <greg@kroah.com>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20050603071133.GB30292@kroah.com>
References: <20050602140359.B24818@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050602140359.B24818@cox.net>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][1/5] RapidIO support: core
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2005 at 02:03:59PM -0700, Matt Porter wrote:
> +RIO_LOP_READ(8, u8, 1)
> +    RIO_LOP_READ(16, u16, 2)
> +    RIO_LOP_READ(32, u32, 4)
> +    RIO_LOP_WRITE(8, u8, 1)
> +    RIO_LOP_WRITE(16, u16, 2)
> +    RIO_LOP_WRITE(32, u32, 4)
> +
> +    EXPORT_SYMBOL(__rio_local_read_config_8);
> +EXPORT_SYMBOL(__rio_local_read_config_16);
> +EXPORT_SYMBOL(__rio_local_read_config_32);
> +EXPORT_SYMBOL(__rio_local_write_config_8);
> +EXPORT_SYMBOL(__rio_local_write_config_16);
> +EXPORT_SYMBOL(__rio_local_write_config_32);

Odd indenting here.

And why the __rio* stuff for public functions?  You should drop the "__"
part.

> +RIO_OP_READ(8, u8, 1)
> +    RIO_OP_READ(16, u16, 2)
> +    RIO_OP_READ(32, u32, 4)
> +    RIO_OP_WRITE(8, u8, 1)
> +    RIO_OP_WRITE(16, u16, 2)
> +    RIO_OP_WRITE(32, u32, 4)
> +
> +    EXPORT_SYMBOL(rio_mport_read_config_8);
> +EXPORT_SYMBOL(rio_mport_read_config_16);
> +EXPORT_SYMBOL(rio_mport_read_config_32);
> +EXPORT_SYMBOL(rio_mport_write_config_8);
> +EXPORT_SYMBOL(rio_mport_write_config_16);
> +EXPORT_SYMBOL(rio_mport_write_config_32);

Again the odd indenting.

> +EXPORT_SYMBOL(rio_mport_send_doorbell);

Just a question, should these be EXPORT_SYMBOL_GPL() as this is GPL
code?  Just to be explicit that is.

> +static ssize_t
> +rio_read_config(struct kobject *kobj, char *buf, loff_t off, size_t count)

<snip>

You might want to compare this to the recent changes in the 2.6.12-rc
kernels in the pci sysfs config code.  There were some 64 and endian
issues fixed up there that you might want to make sure are also done
properly here.

> +static struct bin_attribute rio_config_attr = {
> +	.attr = {
> +		 .name = "config",
> +		 .mode = S_IRUGO | S_IWUSR,
> +		 .owner = THIS_MODULE,
> +		 },
> +	.size = 0x200000,
> +	.read = rio_read_config,
> +	.write = rio_write_config,
> +};

Wow, that's a huge config space (just a comment, not an issue...)

thanks,

greg k-h
