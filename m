Message-ID: <004101c3efa8$530d4a70$30c8a8c0@zorans>
From: "Zoran Stojsavljevic" <zoransto@dkts.co.yu>
To: "Antonios Fornaro" <afor@intracom.gr>,
	"Gilad Rom" <gilad@romat.com>,
	"Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: <linux-atm-general@lists.sourceforge.net>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <1075117282.1504.17.camel@zambia.cambridgebroadband.com> <019201c3e413$7f45d3a0$026810ac@gilad> <1075125571.1504.28.camel@zambia.cambridgebroadband.com> <01a701c3e415$3a49ff40$026810ac@gilad> <001601c3ebe7$5ba13490$30c8a8c0@zorans> <007101c3ec8c$3ea8eae0$80227c92@intranet.gr>
Subject: Re: Announcement: MPHY now supported inmpc860sar
Date: Tue, 10 Feb 2004 08:32:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Antonio,

Thank you for your reply... Just In Time... I needed somebody to verify
my thoughts. :)

For the future users... Few thoughts...

About I/Os...
Just to recap few things about MPC8250 ATM driver... Under
CONFIG_ATM_VADS there are port A, C and D pin definitions, relevant for
Utopia L2 interface (I think, file is utopia.c) ... So these must be
carefully considered, when connecting with the PHY... The best is to use
generic VADS phy. FCC1 is used, and port pins are set for 8 bit Utopia
I/F, although remaining 8 bits Utopia remains set, I cleared them.

The additional things to consider is which BRG to use as internal, and
which as external. You might need to redefine BRG accordingly!

Regards,
Zoran

----- Original Message -----
From: "Antonios Fornaro" <afor@intracom.gr>
Sent: Friday, February 06, 2004 9:35 AM
Subject: Re: [Linux-ATM-General] Announcement: MPHY now supported in mpc860sar

> Pete's driver DOES support MPHY mode. You have to set the
> UTOPIA_LAST_PHY parameter greater than zero to enable it.
>
> Of course, you also have to manually set the harware I/Os for the
> extra address signals. Don't forget to set the cmx_uar register
> according to which FCC you are using, to define the right multiplexing
> options for the address signals.
>
> ----- Original Message -----
> From: "Zoran Stojsavljevic" <zoransto@dkts.co.yu>
> Sent: Thursday, February 05, 2004 2:54 PM
> Subject: Re: [Linux-ATM-General] Announcement: MPHY now supported in mpc860sar
>
> > Quick question to you all... I walked through Pete's 8260 ATM
> > driver, and I saw (as far as I can understand) that Pete's driver is
> > set to support single PHY mode.
> >
> > So, the question here is: do we need Rodolfo Giometti's patch to be
> > applied to mpc8260 ATM driver?
> >
> > It is obvious that different set-up should be applied for mpc8260
> > ATM driver MPHY mode anyway...
> >
> > ----- Original Message -----
> > From: "Gilad Rom" <gilad@romat.com>
> > Sent: Monday, January 26, 2004 3:03 PM
> > Subject: Re: [Linux-ATM-General] Announcement: MPHY now supported in mpc860sar
> >
> > > And now for my next question - Do you think the driver should run
> > > on the 82xx family of chips? (e.g. 8260 and the likes) these guys
> > > have 2 Utopia-II ports with support for up to 31 devices per port.
> > > Coupled with this software, it could make for a highly efficient
> > > DSLAM.
> > >
> > > ----- Original Message -----
> > > From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
> > > Sent: Monday, January 26, 2004 3:59 PM
> > > Subject: Re: [Linux-ATM-General] Announcement: MPHY now supported in mpc860sar
> > >
> > > > It is currently only supported in SAR mode, and in that mode
> > > > there is an upper limit of 4 UTOPIA phys. However, there's no
> > > > reason that support can't be added for MPHY in ESAR mode - in
> > > > which the limit is 31 phys. I suspect that adding such support
> > > > would be easier now that Rodolfo has done most of the work.
> > > >
> > > > PS I'm not the expert on this. Rodolfo's sourceforge username is
> > > > "zaigor".
> > > >
> > > > On Mon, 2004-01-26 at 13:51, Gilad Rom wrote:
> > > > > This is very exciting news! (well, for me it is)
> > > > >
> > > > > How many PHY's in parallel are we talking about here?
> > > > >
> > > > > ----- Original Message -----
> > > > > From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
> > > > > Sent: Monday, January 26, 2004 1:41 PM
> > > > > Subject: [Linux-ATM-General] Announcement: MPHY now supported in mpc860sar
> > > > >
> > > > > > Just a quick note to say that multi-phy is now supported
> > > > > > by the mpc860sar ATM driver, thanks to a patch by Rodolfo
> > > > > > Giometti.
> > > > > >
> > > > > > Page: http://sourceforge.net/projects/mpc860sar/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
