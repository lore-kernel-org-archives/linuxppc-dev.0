Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA03.westchester.pa.mail.comcast.net
	(qmta03.westchester.pa.mail.comcast.net [76.96.62.32])
	by ozlabs.org (Postfix) with ESMTP id 93396DDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 12:33:39 +1100 (EST)
Message-ID: <473BA278.2000402@gmail.com>
Date: Wed, 14 Nov 2007 20:35:52 -0500
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
References: <20071113214845.85820@gmx.net>	<fa686aa40711131357r6b072f4cgcd43c5cb8e73abdb@mail.gmail.com>	<fa686aa40711131359l43f289e7j48b0df3ff57ea7c7@mail.gmail.com>	<FA44C867-4933-40F2-8EBA-5C9967005223@embeddedalley.com>	<20071113233906.GA32689@lixom.net>	<9e4733910711131553ked87330ubc0c439c42e51ace@mail.gmail.com>	<1195003078.28865.18.camel@pasglop>
	<9e4733910711131732i5ec5d226r4037e42399c38f59@mail.gmail.com>
In-Reply-To: <9e4733910711131732i5ec5d226r4037e42399c38f59@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> On 11/13/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>> That's why Dominic wants to get OpenOCD running on the PowerPC. All we
>>> need is the programming documentation for controlling the CPU via the
>>> debug hardware.
>> Note that this is basically different for every CPU around.
> 
> I'd like to get it for the MPC5200 because of the project I am working
> on, an open source audio device. It would be nice if there was a cheap
> hardware debugger available for hackers to use on it. Maybe one of the
> Freescale developers will see this and send me the right docs.
> 
> Is it radically different? Dominic has been able to support every ARM
> 7/9 chip he can get his hands on without too much trouble once the
> core support was written. I don't think he has ARM 11 working yet.
> 
>>> Obviously this documentation exist, all of the commercial vendors had
>>> to have it to develop their debuggers. Maybe it is already out there
>>> and we just don't know where to look.
>> Ben.

DISCLAIMER: Extrapolating grossly from almost no knowledge!

My understanding is that the Freescale PPC debugger interface is based 
on the JTAG interface using a proprietary command set.  Basically, if 
you do their magic BDM (JTAG extension) command, you get into an 
internal scan chain that allows you to read/write the processor 
internals (registers).

The problems are many...
* The documentation is only available under NDA, a problem for open 
source debuggers.
* The scan chain is different on every processor, and may be different 
on different revisions of the same processor.
* If you mess up with JTAG, you will probably burn up the CPU.  Very 
literally.  I've seen it done.  Twice.  (Thankfully not my screwup, and 
it wasn't a PPC so it deserved to die. ;-)  The internal scan chain is 
probably safer, but YMMV.

gvb
