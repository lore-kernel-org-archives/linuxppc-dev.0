Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from agrxsusmail.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 0376C67CFD
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 02:05:24 +1000 (EST)
Message-ID: <4523DBC1.30108@smiths-aerospace.com>
Date: Wed, 04 Oct 2006 12:05:21 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>	<20060927165556.04c8d5d7@vitb.ru.mvista.com>	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>	<1159941148.13323.6.camel@localhost.localdomain>
	<80EE3621-ED80-408E-BF04-BA3CB985C769@embeddedalley.com>
In-Reply-To: <80EE3621-ED80-408E-BF04-BA3CB985C769@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> On Oct 4, 2006, at 1:52 AM, Benjamin Herrenschmidt wrote:
> 
>> I don't see how a mecanism of feature call at the board support  
>> level is
>> in any way incompatible with the device-tree thing.
> 
> It isn't.
> 
>> ...  I'm happy mixing
>> both on powermac :)
> 
> I know.  This was just an opportunity to make people
> realize that a board port does require the writing of
> some board specific code.  Using the feature call is
> an excellent model of portability and flexibility.  My
> point was that any BCSR access is necessary to be
> hidden behind such a function, because it is truly
> board specific.  You can't require the drivers to
> have this kind of logic in them, they must call out
> to board support functions for assistance.
> 
> Just like the powermac ports, embedded drivers
> will need a feature call at some points during
> their processing (set up clock routing, IO pin
> configuration, board specific bus connections,
> power management, etc).  Some board ports
> may do nothing, others may do lots of work.
> 
> Therefore, I see no reason why a BSCR address
> and all of it's associated format can't simply
> be a #define in a board specific file.  There is no
> need for this in the device tree.
> 
> 
> 	-- Dan

The promise of OF for me is that it promises to keep configuration 
information in _one place_.  My experience to date is that my u-boot has 
a bunch of semi-hardcoded constants, my linux drivers have a bunch of 
semi-hardcoded constants that likely do not match 1:1 (name and 
definitely not location) with the equivalent u-boot constants, and some 
constants are passed from u-boot to linux using the BD structure, which 
is never defined the same (for me) in u-boot and linux.

The result is that, when I upgrade my u-boot and/or linux sources, I end 
up having to re-find all the places where the constants live (and find 
some new places), fix them, and then make the u-boot and linux BD 
structures match.  Granted, this isn't insurmountable, but it is a major 
hassle and should be unnecessary.

In a perfect world perhaps we would have one (set of) #include file(s) 
that had all the configuration information necessary to build u-boot and 
linux.  In the current world, u-boot and linux are in different 
repositories with different people with different machines (and agendas) 
doing different development on them, and the result is disjoint.

I look at OF to be the /lingua franca/ of PowerPC bootloaders and linux.

gvb
