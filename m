Message-ID: <00933BFA237CD2119B3400409543582704A2AE@MEV01>
From: Ian Abbott <abbotti@mev.co.uk>
To: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: which errno should I use
Date: Wed, 31 Jan 2001 18:48:23 -0000
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday, January 30, 2001 4:53 PM, Ralph Blach
<rcblach@raleigh.ibm.com> wrote:

> I am writing a character device driver.  I want this device driver to
> return an error if the user request less than say 1024 byte of data.
> What errno should I use?  Is it legal to return an error if not enouth
> bytes are requested?

I have a similar driver that wants exactly one long's worth of data to
be read. If the supplied buffer is smaller than a long, I return 0,
otherwise I return sizeof(long) (assuming their are no other errors).
Admittedly this does not let the user level distinguish "buffer too
small" from "no data", but I let the programmer at the user level deal
with that! Just mention it in the documentation for your driver, if
there is any.

Wolfgang Denk suggested EINVAL. I didn't use that as the man page for
read(2) says that means "fd is attached to an object which is unsuitable
for reading." There's no harm in overloading this meaning though. Just
document what your driver does.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
