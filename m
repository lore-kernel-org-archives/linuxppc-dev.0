Return-Path: <jwboyer@jdub.homelinux.org>
Subject: Re: [PATCH/RFC] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20061019002635.GA2356@mag.az.mvista.com>
References: <20061019002635.GA2356@mag.az.mvista.com>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 19:34:55 -0500
Message-Id: <1161218095.18463.31.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-18 at 17:26 -0700, Mark A. Greer wrote:
> Paul, et. al.,
> 
> Currently, platforms that don't have a dt-aware firmware need to
> manually run the wrapper script to wrap a dtb into the zImage that
> was just built.  This is a PITA and is guaranteed to mess up people
> who just want to build a zImage and have it work.
> 
> To address this, I added a couple new rules to arch/powerpc/boot/Makefile
> so that the dtb is automatically wrapped for "reference" platforms.
> "reference" meaning a platform that has its dts in
> arch/powerpc/boot/dts/<platform>.dts.  It won't work for non-reference
> platforms.
> 
> The patch is attached below with a header in case it is acceptable, as
> is.
> 
> This would be used by the sandpoint, say, by adding the following rules
> to the Makefile in the appropriate places:
> 
> 	$(obj)/zImage.sandpoint: vmlinux $(wrapperbits)
> 		$(call cmd,wrap_dts,sandpoint)
> 
> 	$(obj)/zImage.initrd.sandpoint: vmlinux $(wrapperbits)
> 		$(call cmd,wrap_dts_initrd,sandpoint)
> 
> and:
> 
> 	image-$(CONFIG_SANDPOINT)               += zImage.sandpoint
> 
> Comments?

I've been using a patch much like this while I work on getting my
platform up and running with the new bootwrapper patches.  It's very
useful.

josh
