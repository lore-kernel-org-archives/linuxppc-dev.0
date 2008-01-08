Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 6E995DDF4F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 11:51:10 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/8] pseries: phyp dump: debugging print routines.
Date: Tue, 8 Jan 2008 01:49:49 +0100
References: <4782B985.2090508@austin.ibm.com> <4782C53D.4060506@austin.ibm.com>
In-Reply-To: <4782C53D.4060506@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801080149.50375.arnd@arndb.de>
Cc: mahuja@us.ibm.com, lkessler@us.ibm.com, linasvepstas@gmail.com,
	strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 January 2008, Manish Ahuja wrote:
> +#ifdef DEBUG
> +static void print_dump_header(const struct phyp_dump_header *ph)
> +{
> +=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "dump header:\n");
> ...
> +=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "SRSD length_copied =3D%lx\n",ph->=
kernel_data.length_copied);
> +}
> +#endif
> +

If you move the #if to inside of the function,

> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk (KERN_ERR "phyp-du=
mp: unexpected error (%d) on register\n", rc);
> +#ifdef DEBUG
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0print_dump_header (ph);
> +#endif
> =A0=A0=A0=A0=A0=A0=A0=A0}

> =A0=A0=A0=A0=A0=A0=A0=A0}
> +#ifdef DEBUG
> +=A0=A0=A0=A0=A0=A0=A0print_dump_header (dump_header);
> +#endif


you don't need the #ifdefs here.

	Arnd <><
