Date: Mon, 15 Feb 1999 10:39:27 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Meissner <meissner@cygnus.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Bootstrap code with egcs
In-Reply-To: <19990214152229.011973@smtp.calvacom.fr>
Message-ID: <Pine.HPP.3.96.990215103235.5352e-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sun, 14 Feb 1999, Benjamin Herrenschmidt wrote:

> 
> On Sat, Feb 13, 1999, Michael Meissner <meissner@cygnus.com> wrote:
> 
> Thanks for the reply !
> 
> >Using the standard PowerPC GCC Linux compiler, if you use the -mrelocatable
> >switch, and call __eabi immediately in the startup code after setting up the
> >stack, it will generate position independent code.  The -mrelocatable switch
> >tells the compiler to put all non-call addresses used in a table, that the
> >__eabi function fixes up to the appropriate address.  The text and data
> >section
> >must be loaded at the same relative location to each other.  If you
> configured
> >the compiler for powerpc-eabi instead of powerpc-linux, it would generate the
> >__eabi call automatically for the main function, but since the Linux compiler
> >doesn't do this, you need to do it by hand.
> 
> Ok. That is what I need.

Note that this not exactl ywhat I do in my prepboot code, I wrote directly
the relocation code in assembly (with the help of a few linker
tricks) because I did not know about __eabi.

The other problem I had to solve (and I donn't know if a call to __eabi
would work) is that I need to relocate twice: 
- the 1st time just after the loaded image is given control.
- the 2nd time after a minimal startup code has been executed which
determines memory layout and moves itself to the highest possible address
(because in some machines the initial image loaded at low addresses where
I want to put the kernel).

The code between both relocation has to be very carefully written because
it has very little stack space and it basically can't do any pointer
manipulation.

	Gabriel. 



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
