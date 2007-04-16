Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3567FDDEA2
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 04:40:12 +1000 (EST)
In-Reply-To: <ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
	<ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <98DB6E05-1869-47E9-882E-17B4F574581F@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Mon, 16 Apr 2007 13:40:09 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 16, 2007, at 10:47, Segher Boessenkool wrote:

>
>> I believe the question is about where the information should truly
>> live.
>
> Yeah.

Agreed

>
>> It would seem to be more of a property of the phy than of the enet
>> controller.
>
> Yep.  The whole reason why any property is wanted here is
> to say what type the PHY is, as the enet controller can
> be attached to several kinds.  And what type the PHY is
> belongs in the PHY node, obviously.  In its "compatible"
> property to be exact.


It's not saying what type the PHY is, though.  It's describing the  
connection.  The PHY is just as flexible wrt connection type as the  
ethernet controller.  This is actually a property of the board.  In  
some cases its a fixed property of the board.  In some cases it's  
changeable through dip switches, or even through software.

Ethernet controllers need to know what the connection is so they can  
establish a data connection with the PHYs

PHYs need to know what the connection is so they can establish a data  
connection with the ethernet controllers.

There is equal flexibility on both sides, and I think the choice of  
where to put this information is fairly arbitrary.  The reason for  
choosing the ethernet controller in this case has to do with the flow  
of information.

1) The driver tells the PHY what interface to use
2) The ethernet controller is the endpoint of this connection which  
is accessible by everyone else.  IE data is not sent through PHYs by  
any means but through the ethernet controller, and data is not  
received from PHYs by any means but through the ethernet controller.
3) The UCC needs to be told the connection type, because it does not  
have logic to detect it on its own.

The truth is, this is a somewhat intractable problem because of the  
myriad possibilities for how board designers can hook up ethernet  
controllers to PHYs.  One can envision scenarios where controllers  
can hook up to multiple PHYs, each of one fixed type.  One can  
envision scenarios where multiple controllers are hooked up to one  
PHY, and each of the controllers can use different connections.  If  
we put the information in the PHY node, we allow for the first  
scenario, but not the second.  If we put it in the ethernet node, we  
reverse that situation.  In either case, we'd currently have to  
modify our dts to specify which PHY we want to use.

Andy
