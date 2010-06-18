Return-Path: <frank.rowand@am.sony.com>
Received: from VA3EHSOBE010.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 48A61B7D9E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jun 2010 08:27:43 +1000 (EST)
Message-ID: <4C1BEF33.7090400@am.sony.com>
Date: Fri, 18 Jun 2010 15:12:03 -0700
From: Frank Rowand <frank.rowand@am.sony.com>
MIME-Version: 1.0
To: "M. Warner Losh" <imp@bsdimp.com>
Subject: Re: Request review of device tree documentation
References: <4C186B7B.1060308@firmworks.com>
	<4C186C72.2020506@compulab.co.il>	<4C187013.5000400@firmworks.com>
	<20100616.005237.338122493954307067.imp@bsdimp.com>
In-Reply-To: <20100616.005237.338122493954307067.imp@bsdimp.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "nico@fluxnic.net" <nico@fluxnic.net>,
	"microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"jamie@shareable.org" <jamie@shareable.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"mike@compulab.co.il" <mike@compulab.co.il>,
	"wmb@firmworks.com" <wmb@firmworks.com>,
	"ppc6dev@digitaldans.com" <ppc6dev@digitaldans.com>,
	"jeremy.kerr@canonical.com" <jeremy.kerr@canonical.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Reply-To: frank.rowand@am.sony.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/15/10 23:52, M. Warner Losh wrote:
> In message: <4C187013.5000400@firmworks.com>
>             Mitch Bradley <wmb@firmworks.com> writes:
> : Mike Rapoport wrote:
> : > Mitch Bradley wrote:
> : >> Mike Rapoport wrote:
> : >>> Mitch Bradley wrote:
> : >>>
> : >>>> The second topic is the hypothetical use of OFW as a HAL. That will
> : >>>> not happen for several reasons.  The opposition to the idea is
> : >>>> widespread and deeply held, and there are good arguments to support
> : >>>> that opposition.  Furthermore, the economic conditions necessary for
> : >>>> the creation of such a HAL do not exist in the ARM world, nor indeed
> : >>>> in the Linux world in general.  (The necessary condition is the
> : >>>> ability for one company to impose a substantial change by fiat -
> : >>>> essentially a monopoly position.)
> : >>>>
> : >>>> Shall we agree, then, that any further discussion of the HAL issue is
> : >>>> "just for fun", and that nobody needs to feel threatened that it would
> : >>>> actually happen?
> : >>>
> : >>> I've recently worked with vendor versions of U-Boot for advanced ARM
> : >>> SoCs. There is already *huge* chunk of HAL code in those versions. And
> : >>> if there would be possibility to have callbacks into the firmware
> : >>> these chunks would only grow, IMHO.
> : >>
> : >> How can there be HAL code in U-Boot unless there is already the
> : >> possibility to have callbacks into the firmware?
> : >
> : > Currently it aims to abstract hardware from U-Boot and reuse the same
> : > HW access code across operating systems and bootloaders. If this code
> : > would have callbacks I afraid the things would became worse.
> : 
> : The only way I can understand what you said is if I assume that by
> : "callback", you mean the following sequence:
> : 
> : a) U-boot loads and executes the OS, providing to the OS the address
> : of some HW access routines that it can use
> : b) The OS calls one of those HW access routines
> : c) During the execution of that HW access routine, that routine calls
> : "back" into the OS, before returning.  So a call into the OS is nested
> : inside a call into U-boot resident code.
> : 
> : If that is what you are worried about, it is not what we were
> : discussing.  We were discussing - and many people were against - step
> : (b).
> : 
> : Are you saying that step (b) - the OS calling into routines provided
> : by U-Boot - is already the status quo?
> 
> I don't know about status quo, but it certainly is supported.  There's
> an option to allow for a secondary boot loader, such as FreeBSD's
> /boot/loader, to call back into uboot to read things from
> flash/disk/whatever, do network access, etc.  Not so much a HAL, but
> more of an echo of the functionality provided by PC BIOS functions.
> /boot/loader can be viewed as a mini OS that calls back into uboot to
> have it do things.  Once /boot/loader loads FreeBSD, btw, it and uboot
> disappear from the scene, so this isn't exactly a HAL situation...

Just for reference, there is a patch request on LKML to enable calling
openfirmware from the kernel on OLPC:

   http://lkml.org/lkml/2010/6/18/336

-Frank
