Return-Path: <chuckmeade@mindspring.com>
Received: from txslsmtp1.vzwmail.net (unknown [66.174.85.155])
	by ozlabs.org (Postfix) with ESMTP id 1992967A41
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 00:03:29 +1000 (EST)
From: "Chuck Meade" <chuckmeade@mindspring.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	"Alex Zeffertt" <ajz@cambridgebroadband.com>,
	"Kumar Gala" <galak@kernel.crashing.org>,
	"Chuck Meade \(mindspring\)" <chuckmeade@mindspring.com>
Subject: RE: No ttyS device at I/O port 0xfe004500 for console
Date: Wed, 14 Jun 2006 10:04:18 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGAEHHLDAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D9397E9DAC@tmnt04.transmode.se>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I think you should loose the "console=uart,io,0xfe004500", don't think
> it is needed
> sine the "console=ttyS0" will override it.

I agree.  I use "console=ttyS0,115200".

> > >> +        .device_list    = (enum ppc_sys_devices[])
> > >> +        {
> > >> +            MPC83xx_IIC1, MPC83xx_DUART,
> > >> +#ifdef CONFIG_QE
> > >> +            MPC83xx_QE_UCC3, MPC83xx_QE_UCC4,
> > >> +#endif
> > >> +        },
> > >> +    },
> > >>      {    /* default match */
> > >>          .ppc_sys_name    = "",
> > >>          .mask         = 0x00000000,
> 
> This device list appears to be common to all 8323E CPUs and to me this
> looks
> like a board unique list. Seems to that this list is better off in the 
> mpc832xe_mds.c board file. That would make it easier for custom boards I
> think.
> 
>  Jocke

Whatever is decided here is fine by me -- I followed the style of the 
existing code when adding this code block.  The current 2.6.17 kernel has
the device lists in this same file, for the CPU variants that are supported
in the "public tree".

But you are right, the CPU itself has more UCCs, and other peripherals, than
shown here.  These are just the ones that are used by the existing platform
device drivers I am aware of.  If you know of any additions to make to this
list for the 8323E let us know.

Chuck
