Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-127.roch.qwest.net [67.41.71.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B62F167A5E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 13:36:26 +1000 (EST)
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060920012042.GA28489@mag.az.mvista.com>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 22:10:28 -0500
Message-Id: <1158721828.3043.13.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-19 at 18:20 -0700, Mark A. Greer wrote:
> Paul,
> 
> Regarding our earlier conversation about ft_translate_addr and
> ft_parentize.  I just realized that on IRC today Matt Porter pointed
> out that using the "reg" property in ns16550.c is wrong.  We--several
> of us on #mklinux--decided that the "address" property is the correct
> thing to use because we should really be using a virtual address from
> the fw (bootwrapper has no ioremap).  So, unless someone objects,
> we'll all add the "address" property to our uart device nodes in our
> fdt's (if they can be used as the console).

An example of where this is needed is 4xx.  Lots of boards rely on the
openbios mapping created for the UART in the zImage wrapper.  However,
the kernel doesn't rely on that, and the "reg" property of the .dts
should contain the physical address.

It was pointed out on IRC that the "address" property is defined in the
OF spec for specifying virtual address mappings.  This is exactly what
we need in that it allows the zImage wrapper to use the fw defined UART
mapping, but the kernel still gets the real physical address later on.
And other things that don't use zImage wrappers, like u-boot, can simply
ignore the "address" property defined within the UART node.

The options that were discussed were this, hardcoding, or implementing
ioremap in the bootwraper.  This seemed to be the most elegant way of
doing things.

josh
