Message-ID: <384E7C14.ECF75B72@pacbell.net>
Date: Wed, 08 Dec 1999 07:41:08 -0800
From: David Brownell <david-b@pacbell.net>
MIME-Version: 1.0
To: "Gregory P. Smith" <greg@electricrain.com>
Cc: iweiny@pacbell.net, linuxdev <linuxppc-dev@lists.linuxppc.org>,
        usb <linux-usb@suse.com>
Subject: Re: [linux-usb] OHCI fix for Belkin BusPort card on PowerMac
References: <199912062223.OAA05538@batcave2.localdomain> <19991206152414.B8929@yyz.electricrain.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Gregory P. Smith" wrote:
> 
> On Mon, Dec 06, 1999 at 02:23:12PM -0800, iweiny@pacbell.net wrote:
> >
> > I am running:
> > PowerMac 8500 (604 processor)
> > USB BusPort from Belkin (Model: F5U005-MAC) PCI USB card
> > 2.2.12 kernel (self compiled)
> > 2.3.29 USB stack from Paul Mackerras's rsync tree
> > opendis-0.0.3-pre4 from http://digitalux.netpedia.net

(and a DC-265 camera)

> ...
> > However, when requesting more data then the camera had to give the returned
> > status was "9" and not "0".  The OHCI driver interpreted this as an error and
> > subsequently the user level program would think no data had been returned.
> ...
> 
> Data underrun means the controller received less data that it asked
> for in a transfer.  This is not really an error in many situations;
> try modifying the dc2xx driver to accept it.

I'd not be sure it should be OK in this situation, though.  Or that
the "opendis-0.0.3-pre4" release is really free of dependencies on
serial I/O models, where such cases are the norm.  (By the way, the
page above lists 0.0.2 -- dated August, with no USB support -- as the
most current version!)


> It's not your card, its all controllers and a general "all slightly
> different" state of the HCDs at the moment.  We're working on fixing
> this with a move to a new cleaner device <-> usb stack/hcd interface.

That'll be very good to have.


As a quick sanity check, though, is USB working nicely on that
PowerMac for anyone else?  I've not heard many success reports,
pro or con, on Mac USB support.

- Dave

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
