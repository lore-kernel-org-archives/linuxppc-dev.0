Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: start/ load addresses for kernel
Date: Thu, 20 Mar 2003 15:23:37 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNIEOHCJAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1048108724.7459.6087.camel@hermes.chez-thomas.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

I just received a piece of advice on something I should pay attention to.
I am using u-boot, and the advice is as follows:

"A note, since you are building for a non openbios kernel, you will need
to change the make file.  The start/ load addresses and all are different"

Could someone point me in the proper direction, or section of the makefile
to look at - I am using the mvista ppc405gpr kernel.

In addition I was given one additional piece of advise:

"I have heard from people that they had to ensure that the booloader set
the 405GPr to legacy mode."

Has anyone had to do this?

Thanks

Jerry Walden

-----Original Message-----
From: Gary D. Thomas [mailto:gary.thomas@mind.be]
Sent: Wednesday, March 19, 2003 4:19 PM
To: Jerry Walden
Cc: linuxppc embedded
Subject: RE: CONFIG_SERIAL_TEXT_DEBUG causes exception


On Wed, 2003-03-19 at 14:04, Jerry Walden wrote:
> What other embedded board (hopefully a ppc) would you suggest -
> I don't see any special provisions in the kernel for a custom
> mapping of these registers based on a configuration option for any
> specific board - this appears to be generic code that meant for
> all platforms - I believe what you say regarding what I have to
> do:
>
> 1) I can't find sample code that you refer to.
> 2) I am confused as to why this code is in the kernel in the way it is
>    because it seems to me that most embedded processors have an MMU,
>    so why the comment in that section of code that says "assuming the
>    firmware setup the board properly...."
>

As soon as the kernel starts, there are *no* mappings, other than
RAM, unless explicitly set up.

Try looking at arch/ppc/platforms/pumaA.c (in the 2_4_devel kernel).
This explicit mapping  happens in the "platform_init" function,
near the end.

n.b. it's polite to copy such dialogue to the mailing list so that
everyone else can benefit.  If you want (or need) private help, you
can arrange for it.

> Thanks Much for Your Help
>
> Jerry Walden
>
> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Gary D.
> Thomas
> Sent: Wednesday, March 19, 2003 12:54 PM
> To: jwalden@digitalatlantic.com
> Cc: linuxppc embedded
> Subject: Re: CONFIG_SERIAL_TEXT_DEBUG causes exception
>
>
>
> On Wed, 2003-03-19 at 10:47, Jerry Walden wrote:
> >
> > Hello:
> >
> > I have a custom PPC405GPr board that I have successfully ported u-boot
to.
> >
> > I am now at the stage of trying to bring Linux up on the board.
> >
> > I have CONFIG_SERIAL_TEXT_DEBUG defined for the kernel that I am trying
to
> > bring up.  I would like to have this option so I can trace through the
> > kernel.
> > The comments in ppc4xx_setup.c in the function serial_putc indicate that
> as
> > long
> > as the firmware (in my case u-boot) has been initialized properly, then
> this
> > function
> > should work.  I have verified the addresses that the function is trying
to
> > write to
> > and they are correct.  However, when serial_putc calls the first readb,
I
> > get an
> > exception.
> >
> > Can someone please provide some pointers as to what might be wrong?
>
> You need to make sure that the serial registers are mapped at
> that point.  I don't know the details of your U-boot implementation,
> but the kernel will most certainly not have this region mapped
> unless you make it happen explicitly.  Look at some other embedded
> boards and you'll find code to set this up, typically using a BAT or
> some other special mapping.
>
> --
> .--------------------------------------------------------.
> |       Mind: Embedded Linux and eCos Development        |
> |--------------------------------------------------------|
> | Gary Thomas              email:  gary.thomas@mind.be   |
> | Mind ( http://mind.be )  tel:    +1 (970) 229-1963     |
> | gpg: http://www.chez-thomas.org/gary/gpg_key.asc       |
> '--------------------------------------------------------'
>
>
>
--
.--------------------------------------------------------.
|       Mind: Embedded Linux and eCos Development        |
|--------------------------------------------------------|
| Gary Thomas              email:  gary.thomas@mind.be   |
| Mind ( http://mind.be )  tel:    +1 (970) 229-1963     |
| gpg: http://www.chez-thomas.org/gary/gpg_key.asc       |
'--------------------------------------------------------'


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
