Return-Path: <Hiroshi.DOYU@nokia.com>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Class 3 International Server CA - G3" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33FCDB716A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 19:48:47 +1100 (EST)
Date: Mon, 14 Feb 2011 09:21:56 +0200 (EET)
Message-Id: <20110214.092156.806824256640411558.Hiroshi.DOYU@nokia.com>
To: meador_inge@mentor.com
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
In-Reply-To: <4D55A7F7.5090700@mentor.com>
References: <4D55A7F7.5090700@mentor.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: openmcapi-dev@googlegroups.com, Hollis_Blanchard@mentor.com,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Meador,

From: ext Meador Inge <meador_inge@mentor.com>
Subject: [RFC] Inter-processor Mailboxes Drivers
Date: Fri, 11 Feb 2011 15:19:51 -0600

> Hi All,
> 
> I am currently working on building AMP systems using OpenMCAPI
> (https://bitbucket.org/hollisb/openmcapi/wiki/Home) as the
> inter-processor communication mechanism.  With OpenMCAPI we, of
> course,
> need a way to send messages to various cores.  On some Freescale PPC
> platforms (e.g. P1022DS, MPC8572DS), we have been using message
> registers to do this work.  Recently, I was looking at the OMAP4
> mailboxes to gear up for moving into ARM based platforms.
> 
> With that, I noticed 'arch/arm/plat-omap/mailbox.c'.  This is very
> specific to the OMAP4 boards.  I am looking at designing a new set of
> drivers to expose a mailbox service to userspace that will be used
> for inter-processor communication.  This would entail the traditional
> generic/specific driver split:
> 
>     1. Hardware specific bits somewhere under '.../arch/*'.  Drivers
>        for the MPIC message registers on Power and OMAP4 mailboxes, for
>        example.
>     2. A higher level driver under '.../drivers/mailbox/*'.  That the
>        pieces in (1) would register with.  This piece would expose the
>        main kernel API.
>     3. Userspace interfaces for accessing the mailboxes.  A
>        '/dev/mailbox1', '/dev/mailbox2', etc... mapping, for example.
> 
> Now I have the following questions:
> 
>     1. Do others see value in this?

Yes.

I discussed this with TI(Hari) long time ago, but it didn't proceed
with some reason, not techinical one.

>     2. Does something like this already exist?
>     3. Is someone else already working on this?
> 
> Any feedback will be greatly appreciated.

Now the basic concpet can be devided into 3 parts, (1)HW dependent,
(2) generic driver, (3) character device interface. I guess that it
might be good to have one _pseudo_ H/W instance, then easier for
verification without real H/W and firmwares, across multiplatforms.
