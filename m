Subject: Re: =?ISO-8859-1?Q?R=E9f=2E?= : Re: mpc / linux kernel - user space
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Aain_Devarenne%ZODIAC@zodiac.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <OF95DF83DD.B6DDC345-ONC1256DEC.0032FD05@zodiac-intranet>
References: <OF95DF83DD.B6DDC345-ONC1256DEC.0032FD05@zodiac-intranet>
Content-Type: text/plain
Message-Id: <1070012989.1263.43.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Fri, 28 Nov 2003 10:49:49 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-11-28 at 10:21, Aain_Devarenne%ZODIAC@zodiac.com wrote:
> Hi everybody
>
> I 'm pending on the same problem as Juergen,
> - How can a User Space Thread Wait for a signaling event set by KERNEL  ?

e.g. issue a read on some device driver (/dev/<your driver>
which will block until an interrupt has occured.
something like this:

DECLARE_WAIT_QUEUE_HEAD(mydriver_queue);

ssize_t mydriver_read(
    struct file *filp,
    char *buf,
    size_t count,
    loff_t *f_pos)
{
    /* wait on interrupt */
    while (1) {
       interruptible_sleep_on(&mydriver_queue);
       if (signal_pending (current))  /* a signal arrived */
           return -ERESTARTSYS; /* tell the fs layer to handle it */
       else break;
    }
    return 0;
}

void mydriver_irqhandler(unsigned long arg)
{
    wake_up_interruptible(&mydriver_queue);
}

Jaap-Jan

> - Can an IOCTL return pending,  and then do a completion after the event ?
> - Can we pass an Handle by IOCTL to Kernel from user space ?
>
> Ps: Calling a pointeur in UserSpce seems a bit weird and unsecure !!!
>
>
> Regards Alain Devarenne
>
>
>
>
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
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
