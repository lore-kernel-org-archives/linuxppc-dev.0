From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: arch/ppc/kernel clutter
Date: Fri, 19 Oct 2001 16:43:18 +0200
Message-Id: <20011019144318.13741@smtp.adsl.oleane.com>
In-Reply-To: <15312.6740.808012.183783@cargo.ozlabs.ibm.com>
References: <15312.6740.808012.183783@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Another thing I would like to do is to generalize the drivers for the
>various on-chip peripherals a bit more.  The platform code would then
>specify in some way "this platform has an XYZZY on-chip ethernet
>controller with registers at 0xabcdef00, using interrupt 123, with
>quirks A, D and F".  (This sort of thing is what the OF device tree
>was designed for and does very well, BTW.)

And which is also what the bi_rec's can do well if designed properly.
The idea here is when you deal with several revs of your embedded
board, you just need the firmware or the wrapper to pass proper HW
infos to your kernel via bi_recs and keep a common kernel for your
entire product range.

>The configuration scripts could force CONFIG_XYZZY on when this
>platform is selected and that would compile in the xyzzy driver.
>The xyzzy driver initialization would get called during boot and would
>look up whether the platform has any XYZZY's, and if so, what
>addresses and interrupts to use.  So the XYZZY code doesn't need to
>know anything about which platforms have an XYZZY at all.
>
>This would be a bit of work in the short term to implement but would
>mean that we could potentially reuse code more easily for new
>platforms.  The idea is that if a new platform has an XYZZY, the
>platform setup code just has to create a device tree (or whatever)
>node for it, make sure the XYZZY driver is configured in, and it
>should (hopefully :) Just Work.
>
>This could extend to things like interrupt controllers and PCI host
>bridges as well as regular I/O devices, too.
>
>Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
