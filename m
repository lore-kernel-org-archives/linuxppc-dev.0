From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Steven Scholz" <steven.scholz@imc-berlin.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	<s.coluccini@caen.it>
Subject: RE: Using ioctl from with the kernel ???
Date: Tue, 12 Nov 2002 16:57:17 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJKEAECLAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <3DD11A09.B58EDAE0@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Steve,

If you realy like to do so you can call the LEDDRIVER_ioctl() function
directly with some dummy parameter (the one of you LED driver, not the one
from user space wich is to be called using an file descriptor). But I would
prefer to move the functionality into some extra function and call these
function from LEDDRIVER_ioctl() and from OTHERDRIVER_change_led() (like
Stefano suggested).


Regards, Stephveano :)

>
>
> Hi,
>   the driver is linked to the kernel, so global (not static) functions
> declared in a driver can be called from the kernel and in particular from
> another driver, so you can bound the code of your ioctl in a function and
> call it from the ioctl handler and from the other driver ... using the
> protection mechanism suggested by Stephan.
>
> Bye.
>
> Stefano.
>
> > -----Messaggio originale-----
> > Da: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]Per conto di Steven
> > Scholz
> > Inviato: martedi 12 novembre 2002 16.11
> > A: Stephan Linke
> > Cc: Linuxppc-Embedded
> > Oggetto: Re: Using ioctl from with the kernel ???
> >
> >
> >
> > Hi Stephan,
> >
> > > Your right IOCTL is not applicable for this. You can simply
> > call the driver
> > > functions directly. If these functions are called different
> > from different
> > > context(s) (like your driver and the IOCTL function) you have
> > to add some
> > > protection mechanism. (The code is not reentrant right?) You may try
> > > spin_lock() for this job (linux/spinlock.h). If you are calling the
> > > functions from interrupt contect too some extra protection is
> > required...
> >
> > Thanks for your reply.
> >
> > But how could I call the ioctl handler of the driver?
> > I would need some (dummy) inode...
> >
> > Steven
> >
> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
