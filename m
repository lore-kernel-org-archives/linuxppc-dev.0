Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 88E362BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Oct 2004 03:20:06 +1000 (EST)
Date: Fri, 22 Oct 2004 10:20:03 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Mark Powell <medp@primagraphics.co.uk>
Message-ID: <20041022102003.C28106@home.com>
References: <41777D14.7090108@primagraphics.com>
	<35fb2e5904102106303edb204b@mail.gmail.com>
	<4177CB07.4000302@primagraphics.com>
	<4178D591.4080806@primagraphics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4178D591.4080806@primagraphics.co.uk>;
	from medp@primagraphics.co.uk on Fri, Oct 22, 2004 at 10:40:33AM
	+0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: gdb on a 440GP ELDK
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 22, 2004 at 10:40:33AM +0100, Mark Powell wrote:
> 
> Mark Powell wrote:
> 
> > Jon Masters wrote:
> >
> >> On Thu, 21 Oct 2004 10:10:44 +0100, Mark Powell 
> >> <medp@primagraphics.com> wrote:
> >>
> >>> The system seems to basically run fine apart from the fact that gdb
> >>> doesn't stop at any breakpoints.
> >>
> >> Even the most simple scenario doesn't work, e.g.:
> >
> I have been able to borrow an Ebony system to compare and gdb worked 
> fine on that system.
> The difference is that kernel debugging (with BDI2000 support) was 
> configured in my kernel but not in the Ebony kernel.
> I tried disabling the BDI2000 support in my kernel and gdb works again.
> 
> Seeing this in ebony_setup_arch():
> 
> #if !defined(CONFIG_BDI_SWITCH)
>     /*
>      * The Abatron BDI JTAG debugger does not tolerate others
>      * mucking with the debug registers.
>      */
>         mtspr(SPRN_DBCR0, (DBCR0_TDE | DBCR0_IDM));
> #endif
> 
> leads me to suspect that the BDI2000 support for kernel debugging stops 
> gdb working in userland.
> Does that sound likely? If so, I guess it is worth recording so that the 
> info is in the archives.

That's absolutely true. As the comment suggests, the BDI2000 insists
on full control of the DBCR0, so configuring for IDM mode will screw
it up.  Not configuring for IDM mode doesn't allow kgdb/gdb to work.
Since we are out of the early development phase, I'll update the
defconfigs to disable the BDI config option by default.

-Matt
