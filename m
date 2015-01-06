Return-Path: <stern+54ad1fae@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by lists.ozlabs.org (Postfix) with SMTP id 7A4151A092A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 03:48:05 +1100 (AEDT)
Date: Tue, 6 Jan 2015 11:48:01 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Michael Tessier <michael.tessier@axiontech.ca>
Subject: RE: PROBLEM: USB isochronous urb leak on EHCI driver
In-Reply-To: <66A26A9AA227D947AF088537F041526E2009B9@VSVR-EX10-MB1.pocatec.com>
Message-ID: <Pine.LNX.4.44L0.1501061144320.1602-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Jan 2015, Michael Tessier wrote:

> > > That is interresting, however, I have an older kernel running an OHCI 
> > > driver which is able to handle 4 codecs. Same usb hardware (codecs and 
> > > hub), but older kernel on a different CPU, with much less power. This 
> > > makes me believe that there's a solution to make it work...
> > 
> > Of course there is: Install an OHCI host controller and use it to drive your codecs.  It should work fine.
> > 
> > The periodic scheduling algorithm for OHCI is very different from the algorithm for EHCI.
> 
> According to your knowledge, how much time would you think it takes to
> change the EHCI driver with an OHCI one?

I don't understand the question.

>  And can you tell if the OHCI driver
> will work on my hardware given that the Host controller of the i.MX512 is
> a USB2.0 host controller? (OHCI was implemented for USB 1.x from what I
> understand)

The OHCI driver works with OHCI hardware and the EHCI driver works with 
EHCI hardware.  OHCI is USB-1.1 and EHCI is USB-2.  They are not 
interchangeable.

> I tried to do so several days ago with the built-in configurator
> (I am using "ltib"), but the configurator does not allow selecting the
> OHCI driver; I tried manually but it turned into compiler errors...

It looks like the configurator is smart; it won't let you select the 
wrong driver for your hardware.

Alan Stern
