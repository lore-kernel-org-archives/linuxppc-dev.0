Date: Mon, 22 Mar 1999 09:48:41 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Dave Baukus <dbaukus@inetinc.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC8240
In-Reply-To: <36F2BA07.FDBBAA06@inetinc.com>
Message-ID: <Pine.LNX.3.96.990322092849.9545B-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Mar 1999, Dave Baukus wrote:

> Is there any support for linux on the PPC - MPC 8240.
> It is suppose to be a 603e processor core w/ embedded IO controlers (PCI, DMA,
> I2O, ...)
>
> Anybody tried this thing out yet ?

I haven't been able to touch our 8240-based VME board yet since others are
doing a VxWorks port, however I've already looked a bit at what's needed.

1) Yes, it's a 603e core so nothing new there like the 8xx MPUs.  I see
memory speed rated at 66mhz/83mhz but I heard that a 100mhz fsb version
may exist.  Clock speeds should go to 400mhz.
2) The PCI bridge is very similar to a MPC106 so no surprises there.  It's
a bit limited from my perspective since Raven/Hawk are very versatile in
their memory map programming whereas the MPC106 only allows hardcoded maps
A&B (PReP and CHRP).
3) The EPIC is OpenPIC compliant, allowing passthrough mode if your system
has legacy I/O.  You just need the OpenPIC patch (there are two versions
of this) and some mods to detect the EPIC to support it.
4) DMA controller is a new design AFAIK, you'd have to do some support for
that if you need that feature.
5) There is an I2C controller that needs support so you can gather
assuming you are bringing a system up from scratch and need to access the
SPD data in the SDRAMs.
6) I2O registers are of little interest.  They are simply compliant with
the spec.

For our board, I know the only thing I need to do is patch the Raven
OpenPIC support so it handles an EPIC.  The rest of the board is just a
16550, Universe II, and DEC21143.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
