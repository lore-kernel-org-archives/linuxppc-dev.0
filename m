Date: Wed, 10 Jan 2001 20:16:14 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Jerry Van Baren <vanbaren_gerald@si.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using realtime clock? 
In-Reply-To: <4.3.2.20010110114302.00ba2830@falcon.si.com>
Message-ID: <Pine.HPX.4.10.10101102007140.1811-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 10 Jan 2001, Jerry Van Baren wrote:

> Yup.  However, adjtimex() is a function call that tweaks the clock
> parameters in the kernel.  If you understood those parameters (I
> don't), you could keep your clock very accurate.

Indeed, but the hard part is to compute the parameters for adjtimex (BTW
never set the state bit to locked otherwise the kernel will rewrite the
RTC from the system clock, creating an interesting loop).

> If you tracked down some references (NTP source code, NTP RFCs, "David
> L. Mills' clock adjustment algorithm"), I suspect you would be able to
> figure out how to properly use adjtimex().  Further, I suspect
> adjtimex() a pretty lightweight routine since it merely adjusts the
> parameters that presumably already exist in your kernel.


It is.  ntp also is lightweight: about 5 minutes for the main server I
have here after >6 months of operation on a 200MHz 603e, serving about 10
machines at higher than average rate (to improve precision) and
broadcasting for less critical machines.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
