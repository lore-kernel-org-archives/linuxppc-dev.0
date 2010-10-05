Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09925B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 19:11:13 +1100 (EST)
Subject: Re: use of BAT before taking over the MMU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <acahalan@gmail.com>
In-Reply-To: <AANLkTikt9e5s3UUn1+k=NY7UhqosM5qkgdih=UD+Hd+L@mail.gmail.com>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
	<63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
	<AANLkTikt9e5s3UUn1+k=NY7UhqosM5qkgdih=UD+Hd+L@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 19:11:03 +1100
Message-ID: <1286266263.2463.337.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-04 at 12:06 -0400, Albert Cahalan wrote:
> On Mon, Oct 4, 2010 at 12:25 AM, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> 
> > The PowerPC OF binding requires the firmware to save and restore
> > the BATs on entry to / exit from the firmware.
> 
> This sucks, because using the BAT is **much** easier for
> the firmware. In my case, it also means I don't need to worry
> about Linux stomping on anything -- I have nothing in RAM.

What FW are we talking about here anyways ? As I said, Linux isn't
supposed to take any fault from the moment it starts setting up BATs to
the moment it takes over exceptions and can handle faults all by itself.

> (this is an emulator, but I don't want to cheat too much
> because adding special cases affects performance)
> 
> Page tables would need to go in RAM. If Linux wants to
> use that memory...? It seems that Linux does tend to ask;
> will it panic if I refuse? Are there addresses Linux won't
> ever ask for?
> 
> It also looks like I could just start up Linux w/o the MMU on.
> I'm just making 1:1 mappings anyway.

Cheers,
Ben.
