From: "Ron Bianco" <ronb@junction.net>
To: "Ian Abbott" <abbotti@mev.co.uk>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: which errno should I use
Date: Wed, 31 Jan 2001 15:45:20 -0800
Message-ID: <000501c08bdf$df460610$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <00933BFA237CD2119B3400409543582704A2AE@MEV01>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Ian,

In your driver's read() fileop implementation, assuming you're using a non-blocking
technique, if the count parameter is not 1024 just return 0 for num byes written to
user's buffer.  The error codes are actually used as -EINVAL for example, any
positive return value or 0 indicates the bytes actually processed.   Also if you're
intending the user program to select() your device then you need to implement the
poll() fileop.

I just finished writing a non-blocking char device driver, so can offer some tips if
need be.

Cheers, Ron

Ron Bianco
Computer Systems Technologist
Level Control Systems
email: ronb@junction.net
phone: 250-549-2558 Ext 8
web:  www.lcsaudio.com


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Ian
> Abbott
> Sent: Wednesday, January 31, 2001 10:48 AM
> To: Embedded Linux list
> Subject: RE: which errno should I use
>
>
>
> On Tuesday, January 30, 2001 4:53 PM, Ralph Blach
> <rcblach@raleigh.ibm.com> wrote:
>
> > I am writing a character device driver.  I want this device driver to
> > return an error if the user request less than say 1024 byte of data.
> > What errno should I use?  Is it legal to return an error if not enouth
> > bytes are requested?
>
> I have a similar driver that wants exactly one long's worth of data to
> be read. If the supplied buffer is smaller than a long, I return 0,
> otherwise I return sizeof(long) (assuming their are no other errors).
> Admittedly this does not let the user level distinguish "buffer too
> small" from "no data", but I let the programmer at the user level deal
> with that! Just mention it in the documentation for your driver, if
> there is any.
>
> Wolfgang Denk suggested EINVAL. I didn't use that as the man page for
> read(2) says that means "fd is attached to an object which is unsuitable
> for reading." There's no harm in overloading this meaning though. Just
> document what your driver does.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
