Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 72F94B6F5D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 20:15:21 +1000 (EST)
Date: Mon, 27 Jun 2011 05:14:14 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
Message-ID: <20110627101414.GA9369@crust.elkhashab.com>
References: <178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
	<1304109476.2513.243.camel@pasglop>
	<1304487166.2513.351.camel@pasglop>
	<BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
	<20110509160935.GA14965@crust.elkhashab.com>
	<6a09a426f126fb315b773fc207d68eb9@mail.gmail.com>
	<1306208412.7481.214.camel@pasglop>
	<20110527165108.GA1752@crust.elkhashab.com>
	<fa765cbed63d89c50a79b34f25dc9f5c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa765cbed63d89c50a79b34f25dc9f5c@mail.gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 31, 2011 at 02:27:19PM -0700, Tirumala Marri wrote:
> Not sure how I would know --  But with my eiger kit, I got a
> cd from amcc that had a patched 2.6.30 or something kernel
> in it to support the 460SX.  The pci code was basically
> subverted by adding a "port->link=1" at the very end of the
> link check to always force it to succeed.  However this code
> never appeared in the public git repositories, so I am not
> sure how the 460SX functioned (if it ever did) since the
> link check that is in there now can't work on that SOC.
> 
> 
> [marri]I don't know what PCI-E devices you use. We use E1000
> As a device for testing. Link-up was working before the submission.
> There were some changes happened afterwards to the common code
> Which seems to affected all 4xx devices. I will try latest code
> On our other SoCs.

Well, briefly we build a custom processor board that has
a couple powerpcs on it and some pcie switches.  We end up
plugging our devices into the switches which is unlike what
most people try.  In any case, we use several different
drive controllers for SAS, SCSI, and SSDs.  For testing
purposes (i.e. when things don't go the way they should) we
have an adapter to make "regular" pcie slots that we plug in
whatever.  But our switches are on the board with the CPUs
so as far as the CPU goes, it will always see a gen-2 link
8 lane link, irrespective of what the endpoint actually is.
We let the switches handle the speed changes and the port
bifurcation.  

> I took care of that in my patch.  Basically it let the
> system go to gen-2 speeds and negotiate down.
> [marri] Great thx.

Ok, so I am back from doing whatever it is that I do.  Shall
I go ahead and take a stab at making a new functor to handle
the "link check"? -- which IIRC was the thought from last
month about how best to handle the 460SX and whatever some
people were using internally.

Ayman
