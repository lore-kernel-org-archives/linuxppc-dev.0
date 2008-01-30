Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth12.prod.mesa1.secureserver.net
	(smtpauth12.prod.mesa1.secureserver.net [64.202.165.35])
	by ozlabs.org (Postfix) with SMTP id 46747DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 16:10:52 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Andy Fleming'" <afleming@freescale.com>
References: <mailman.1.1201309203.24413.linuxppc-embedded@ozlabs.org>
	<000601c85fc5$41e48330$6405a8c0@absolut>
	<D71D9F25-4724-487E-AD07-E848B4608B97@freescale.com>
Subject: 83xx HDLC Driver Dev - Multiple PHYs?
Date: Tue, 29 Jan 2008 21:10:04 -0800
Message-ID: <000001c862fe$5ff16550$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <D71D9F25-4724-487E-AD07-E848B4608B97@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


All,

I have gotten my HDLC driver up to the point where it can register itself
with the Linux kernel. However now I am faced with a dilemma and style
question, that is probably best answered by you driver developers that have
more experience.

I am putting support for multiple PHY's into the HDLC driver, but after
converting it to use the of_device tree, and inserting a UCC@5000 for a
single UCC HDLC driver, it occurred to me that if I insert more devices
(UCC@6000, UCC@7000, UCC@8000) that the driver will attempt to load multiple
times.

So here is the question.

Solution 1:
Should I develop the system to have a single ucc@xxxx entry in the
platform.dts file and have a field(s) like phy-count=<4>, to support
multiple devices? And have each instance of the module contain private data
for one UCC, interrupt handling, etc...  

OR

Solution 2:
Is there a way to have a module know if it has already been loaded, so it
doesn't insert multiple times and then play the rest like Solution 3?

OR

Solution 3:
Have phy-count=4; defined in the driver header, or a module parameter, and
have a single module instance of the driver itself responsible for creating
a single private data structure and setting up multiple UCC's and PHY's?

This also feeds into a question on SET_NETDEV_DEV. How does it react to
multiple net devices attached to a single base driver?

-Russ

> -----Original Message-----
> From: Andy Fleming [mailto:afleming@freescale.com]
> Sent: Tuesday, January 29, 2008 2:33 PM
> To: rmcguire@videopresence.com
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: SET_NETDEV_DEV -> 83xx HDLC Driver??
> 
> 
> On Jan 25, 2008, at 20:43, Russell McGuire wrote:
> 
> > All,
> >
> > I am partly done porting a combination of the 83xx ATM driver and
> > dscc4 HDLC
> > driver into a 83xx HDLC driver.
> >
> > However, encounter a call I don't truly understand.
> >
> > SET_NETDEV_DEV(dev, pointer_to_some_handle);
> >
> > I can see plenty of examples of this registering some kind of PCI
> > device
> > handle, however in this case I am not using a PCI device. So what
> > should the
> > pointer be? Or can this call be ignored, and if so what are the
> > consequences?
> >
> > I see the some of the Freescale Ethernet devices don't use this call.
> >
> > Anyway, can somebody shed some light on if I am going to need this,
> > or a way
> > to get it to work, without creating a PCI device?
> 
> 
> Look at gianfar.c (which uses a platform_device) or ucc_geth (which
> uses an of_device).  Which freescale devices don't use that call?
> We'll fix them.
> 
> Andy
