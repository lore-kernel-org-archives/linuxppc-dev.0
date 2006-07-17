Return-Path: <hollis@penguinppc.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by ozlabs.org (Postfix) with ESMTP id 7EC3667BA0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 06:08:01 +1000 (EST)
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
From: Hollis Blanchard <hollis@penguinppc.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
References: <44B7857A.2060101@freescale.com>
	<B8AB8BA6-500C-43AC-B6E7-A76CA598A429@kernel.crashing.org>
	<a0bc9bf80607140921y5d11bf37r3f18e2dbdd03b017@mail.gmail.com>
	<A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 16:08:14 -0400
Message-Id: <1153166894.4459.4.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-07-17 at 14:16 -0500, Kumar Gala wrote:
> On Jul 14, 2006, at 11:21 AM, Li Yang wrote:
> 
> > On 7/14/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> >> Nack, my expectation is this is all setup by the boot loader.
> >
> > That's a good wish. ;)  However, USB is not required by bootloader. So
> > it is not likely to be initialized there.  And if we put it in
> > bootloader, it will be hard to change the mode(MPH/DR), which requires
> > a re-burn of bootloader.  It's better that we make sure it's correctly
> > configured here.
> 
> I disagree.  You are coming from this from a board that does  
> everything under the sun.  I'd like to avoid having this type of  
> initialization in the kernel.  There is a whole additional kitchen  
> sink that could move into the kernel as well.

Seems to me that it's far better to have init code in the kernel than
firmware. For one example, look at the x86 video card init problem
PowerPC Linux has. It's also far easier to fix/deploy Linux code than
firmware code, as Li observed, and on top of that it's less work for
non-UBoot firmwares in the future.

-Hollis
