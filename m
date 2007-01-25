Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17849.11246.51329.645604@cargo.ozlabs.ibm.com>
Date: Fri, 26 Jan 2007 09:15:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 01/18] Include autoconf.h from the bootwrapper.
In-Reply-To: <20070125173915.GA18889@ld0162-tx32.am.freescale.net>
References: <20070124210654.GA10527@ld0162-tx32.am.freescale.net>
	<20070124235150.GA26212@localhost.localdomain>
	<56B86A8F-4E40-4C58-A774-0DE3C7AA8CE2@kernel.crashing.org>
	<17848.6331.164992.951431@cargo.ozlabs.ibm.com>
	<20070125173915.GA18889@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> So basically, there'd be several lines in the arch/powerpc/boot/Makefile
> like this?
> 
> cflags-$(CONFIG_6xx) += -DCONFIG_6xx
> cflags-$(CONFIG_8xx) += -DCONFIG_8xx
> cflags-$(CONFIG_E500) += -DCONFIG_E500
> BOOTCFLAGS += $(cflags-y)

No no no.  I said the Makefile could pass different flags to wrapper
depending on the config, that is, to the *invocation* of wrapper, not
the building of wrapper.  As it does already - if you have
CONFIG_PPC_PMAC, it runs wrapper with "-p pmac"; if you have
CONFIG_PPC_PSERIES, it runs wrapper with "-p pseries".  In your case
you would be using "-p myboard_uboot_bd_t_variant_59" or something
(hopefully more concise than that, of course :).

> I don't really see the point (a simple grep will show you all the config
> dependencies in the bootwrapper, to verify that it's only platform stuff
> and not actual options), but I can do it that way if you really want. 
> One way or another, the information has to be there, and it has to be
> compile-time or else the bd_info struct layout will be wrong.

So you will end up with a bunch of .o files, one for each possible
bd_t variant.  They will all get built and the appropriate one will
get selected by wrapper based on the value you give with the -p
option.  The line in arch/powerpc/boot/Makefile that defines src-plat
will list all of them.

Paul.
