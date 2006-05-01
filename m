Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 77E9C679FC
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 06:07:34 +1000 (EST)
Date: Mon, 1 May 2006 15:07:28 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: DTC/dts modifications
Message-Id: <20060501150728.04694488.kim.phillips@freescale.com>
In-Reply-To: <55FD11DB-54AF-4284-9E9A-C313F4232105@kernel.crashing.org>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
	<695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
	<1146512732.24239.34.camel@cashmere.sps.mot.com>
	<55FD11DB-54AF-4284-9E9A-C313F4232105@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 1 May 2006 14:52:23 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> [snip]
> 
> >> Try running a current .dts through cpp today.  You will get errors  
> >> like:
> >>
> >> oftree.dts:15:3: error: invalid preprocessing directive #address
> >
> >> Because of props like:
> >>
> >>        #cpus = <1>;
> >>        #address-cells = <1>;
> >>        #size-cells = <0>;
> >>
> >> If these used some other symbol instead of '#' cpp will be happy and
> >> we can use it to create macros for us.
> >
> > Yeah, we're not going to be able to change those; they
> > are "By The Book".
> 
> By what book?  It would seem to me that BNF for dtc is completely  
> under our control and if we want to change it we can.  I understand  
> that there is some correspondence to Open Firmware, but it seems that  
> if its people are ok with the dts format changing that's a lot easier  
> than implementing tons of support in dtc for features that cpp gives us.
> 
> [I'm also guessing no one's really got time to go and implement these  
> features in dtc]
> 
cpp -x assembler-with-cpp seems to not produce the above errors, and still honours preprocessing directives like #define.  Don't know what else is messes with, and whether you want to add CPPFLAGS.

Kim

> > Instead, we'll have to make the lexical analysis conscious
> > of something like a <newline> context sensitive token or so.
> > Or throw some flag to cpp to not emit location markers.
> 
> - kumar
