Return-Path: <dgibson@ozlabs.org>
Date: Sat, 13 Jan 2007 10:00:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH/RFC] Add cmd_wrap_dts rules to arch/powerpc/boot/Makefile
Message-ID: <20070112230047.GC18201@localhost.localdomain>
References: <20061019002635.GA2356@mag.az.mvista.com>
	<E1GaYUQ-0001jb-20@jdl.com>
	<20061019195156.GB6586@mag.az.mvista.com>
	<20070111004048.GA27351@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070111004048.GA27351@mag.az.mvista.com>
Cc: jdl@jdl.com, linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 10, 2007 at 05:40:48PM -0700, Mark A. Greer wrote:
> On Thu, Oct 19, 2006 at 12:51:56PM -0700, Mark A. Greer wrote:
> > On Thu, Oct 19, 2006 at 09:03:18AM -0500, Jon Loeliger wrote:
> > > So, like, the other day "Mark A. Greer" mumbled:
> > > > 
> > > > This would be used by the sandpoint, say, by adding the following rules
> > > > to the Makefile in the appropriate places:
> > > > 
> > > > 	$(obj)/zImage.sandpoint: vmlinux $(wrapperbits)
> > > > 		$(call cmd,wrap_dts,sandpoint)
> > > > 
> > > > 	$(obj)/zImage.initrd.sandpoint: vmlinux $(wrapperbits)
> > > > 		$(call cmd,wrap_dts_initrd,sandpoint)
> > > > 
> > > > and:
> > > > 
> > > > 	image-$(CONFIG_SANDPOINT)               += zImage.sandpoint
> > > > 
> > > > Comments?
> > > 
> > > Isn't there a way to do this without hardcoding the
> > > platform name in the makefiles directly?  I fear for
> > > the one-per-platform effect that is yet to come with
> > > the conversion of many of the legacy boards.
> 
> Okay, its been a while so let's see if anyone remembers and/or cares
> anymore.  :)
> 
> How about something like the patch below?
> 
> Basically, if you want a dtb wrapped up in your zImage, set
> CONFIG_DEFAULT_DTB=y and also define CONFIG_DTS to point where your dts
> file is.
> 
> Does that meet everyones requirements?

Erm.. actually from what I could tell, the way the wrapper script
invokes dtc will make a mess if you're building with a different
object tree from the source tree.  I think the other suggested patches
which have a cmd_wrap_dtb and a spearate make rule to invoke dtc are a
better shot, and it might be a good idea to rip the dtc invocation out
of wrapper entirely.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
