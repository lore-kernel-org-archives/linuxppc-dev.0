From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Steven Scholz" <steven.scholz@imc-berlin.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Using ioctl from with the kernel ???
Date: Tue, 12 Nov 2002 16:07:21 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJCEACCLAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <3DD114B7.EFA6E6CE@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Steven,

Your right IOCTL is not applicable for this. You can simply call the driver
functions directly. If these functions are called different from different
context(s) (like your driver and the IOCTL function) you have to add some
protection mechanism. (The code is not reentrant right?) You may try
spin_lock() for this job (linux/spinlock.h). If you are calling the
functions from interrupt contect too some extra protection is required...

Regards, Stephan


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Steven
> Scholz
> Sent: Dienstag, 12. November 2002 15:48
> To: LinuxPPC
> Subject: Using ioctl from with the kernel ???
>
>
>
> Hi there,
>
> I use a device driver (/dev/status_led from DENX) to manipulate
> some frontpanel
> LEDs from user space via some ioctls.
>
> Now I'd like to access them from the kernel space. How can I do
> that? AFAIK I
> can't use fopen and ioctl...
>
> Thanks,
>
> Steven
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
