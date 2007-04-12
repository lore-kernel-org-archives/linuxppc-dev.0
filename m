Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17949.47307.827348.233684@cargo.ozlabs.ibm.com>
Date: Thu, 12 Apr 2007 14:42:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] bootwrapper: Add CONFIG_DEVICE_TREE
In-Reply-To: <20070326205226.GB2931@ld0162-tx32.am.freescale.net>
References: <20070326205145.GA2868@ld0162-tx32.am.freescale.net>
	<20070326205226.GB2931@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> This provides a way to tell the bootwrapper makefile which device tree to
> include by default.  The wrapper can still be invoked standalone to wrap
> with a different device tree without reconfiguring the kernel, if that is
> desired.
...
> +config DEVICE_TREE
> +	string "Static device tree source file"
> +	help
> +	  This specifies the device tree source (.dts) file to be
> +	  compiled and included when building the bootwrapper.
> +	  If a relative filename is given, then it will be relative
> +	  to arch/powerpc/boot/dts.
> +
> +	  This is required when building a cuImage target for an
> +	  older U-Boot, which cannot pass a device tree itself.
> +	  Such a kernel will not work with a newer U-Boot that
> +	  tries to pass a device tree (unless you tell it not to).
> +	  If your U-Boot does not mention a device tree in
> +	  "help bootm", then use the cuImage target and specify
> +	  a device tree here.  Otherwise, use the uImage target.

Hmmm, I'm not sure that I want to be asked about CONFIG_DEVICE_TREE on
*all* powerpc platforms...  Surely this option should depend on
something that says we're including support for a uBoot-able platform?

Paul.
