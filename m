Date: Thu, 27 Nov 2003 19:08:01 +0100 (MET)
From: Juergen Oberhofer <e9826367@student.tuwien.ac.at>
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Cc: Juergen Oberhofer <e9826367@student.tuwien.ac.at>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc / linux kernel - user space
In-Reply-To: <7E0B03AE-2100-11D8-BF18-003065E2BB06@aimsys.nl>
Message-ID: <Pine.GHP.4.58.0311271903490.4360@stud3.tuwien.ac.at>
References: <Pine.GHP.4.58.0311271703390.25225@stud3.tuwien.ac.at>
 <7E0B03AE-2100-11D8-BF18-003065E2BB06@aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you! You mean that the application should install a signal handler
and
the module sends on every interrupt a signal to the application process.
Do you know, Which function does exist to send a signal? I guess, the
module has to know the pid of the application process? How can the module
be informed about it?
Regards,
Juergen

On Thu, 27 Nov 2003, Jaap-Jan Boor wrote:

> Hi Juergen,
>
> That's normally not something you do and I don't know if it's possible.
> Application code normally communicates with your driver code using
> system
> calls (read/write). So either your appl procedure must be part
> of your module, or you must signal e.g. a user thread the timer
> interrupt happened, so the thread can execute that code.
> Hope this helps,
>
> Jaap-Jan
>
>
> On 27-nov-03, at 17:07, Juergen Oberhofer wrote:
>
> >
> > Hi,
> >
> > I have a module and an application program in user space:
> >
> > The Module performs the following task: at init it initializes the cpm
> > timer register of the mpc823,
> > such that an interrupt is generated every x microseconds. Thus, I
> > installed an interrupt handling function f that handles the timer
> > interrupts.
> >
> > My problem is that the module / the interrupt handling function should
> > execute a procedure defined in the application program. How can I pass
> > a
> > pointer (which points to that function) from the appl.program to the
> > module, such that the handler can execute this function every x
> > milliseconds? I thought to create a procedure in the module that
> > accepts
> > a function pointer as argument. But how can I achieve, that this module
> > procedure is visible to the application program? Does somebody have a
> > suggestion or know another way to do it?
> >
> > Regards,
> > Juergen
> >
> >
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
