From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Steven Scholz" <steven.scholz@imc-berlin.de>,
	"Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: R: Using ioctl from with the kernel ???
Date: Tue, 12 Nov 2002 16:36:28 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMKEEIEOAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <3DD11A09.B58EDAE0@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  the driver is linked to the kernel, so global (not static) functions
declared in a driver can be called from the kernel and in particular from
another driver, so you can bound the code of your ioctl in a function and
call it from the ioctl handler and from the other driver ... using the
protection mechanism suggested by Stephan.

Bye.

Stefano.

> -----Messaggio originale-----
> Da: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]Per conto di Steven
> Scholz
> Inviato: martedi 12 novembre 2002 16.11
> A: Stephan Linke
> Cc: Linuxppc-Embedded
> Oggetto: Re: Using ioctl from with the kernel ???
>
>
>
> Hi Stephan,
>
> > Your right IOCTL is not applicable for this. You can simply
> call the driver
> > functions directly. If these functions are called different
> from different
> > context(s) (like your driver and the IOCTL function) you have
> to add some
> > protection mechanism. (The code is not reentrant right?) You may try
> > spin_lock() for this job (linux/spinlock.h). If you are calling the
> > functions from interrupt contect too some extra protection is
> required...
>
> Thanks for your reply.
>
> But how could I call the ioctl handler of the driver?
> I would need some (dummy) inode...
>
> Steven
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
