Message-ID: <38C466B5.8C832308@ict.ac.cn>
Date: Tue, 07 Mar 2000 10:17:25 +0800
From: LiuTao <tliu@ict.ac.cn>
MIME-Version: 1.0
To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem on MPC8xx
References: <200003061503.KAA21814@hoover.gilbarco.com>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi:

> Hmmmm... Well, I remember when I got to this point it took a week or so to
> get the bash prompt to actually come out.  It was rather irritating being
> 95% of the way and stumped.  Try this, since bash is the first real process
> that runs it really stresses the board and the memory timings, etc.  Make
> sure that the libraries are being loaded and it isn't hanging half-way.  Try
> modifying fs/namei.c and put a printk at the top of open_namei to print the
> pathname.... that should dump which files are being loaded... email me the
> results of that.
I added printk() in open_namie(), the output is:

pathname:/dev/conle
pathname:/sbin/init
pathname:/etc/init
pathname:/bin/initstarting /bin/sh...

pathname:/bin/sh
pathname:/lib/ld.so.1
pathname:/etc/ld.so.preload
pathname:/etc/ld.so.cache
pathname:/lib/libtermcap.so.2
pathname:/lib/libdl.so.2
pathname:/lib/libc.so.6

Is that all right?
Another question, I don't have a PowerPC box, I build Linux on a x86 box
with cross compile environment, can I make a ramdisk? The ramdisk I am
using
is a little large, I want to make a smaller one.

Thanks!

LiuTao

> Hi Jason:
>
> I am sorry that another problem appeared.
> After the /bin/sh ran, I can't see anything from console.
> I open the compile switch "SERIAL_DEBUG_INTR" in uart.c,
> then I can see the following message on console:
>
> THRE...rs_interrupt_single(0, 2)...end.
> THRE...rs_interrupt_single(0, 2)...end.
> .
> .
> .
>
> It means that the transmit interrupt is triggered, right?
> But why I can't see anything?
> And can you tell me that when shell outputs message to console,
> which function it uses in uart.c? I think it should be
> rs_8xx_write(), right? But I found that this function was not
> called before interrupt happened.
>
> Thanks!
>
> LiuTao
>
> >
> > I'm glad to hear you resolved your problem.  If I can lend you any other
> > assistance, let me know, I have gone all the way through porting the
> kernel
> > to a custom 860 board now and are familiar with solutions to some
> stumbling
> > blocks.
> >
> > Jason
> >
> > -----Original Message-----
> > From: LiuTao [mailto:tliu@ict.ac.cn]
> > Sent: Thursday, March 02, 2000 5:24 AM
> > To: Jason Wohlgemuth
> > Subject: Re: problem on MPC8xx
> >
> > Hi Jason:
> >
> > Thanks for your attention!
> > I found the problem in uart.c, the BRG is setup incorrectly.
> > I have resolved the problem.
> > Now, I can see message from console port.
> >
> > Thanks.
> >
> > LiuTao
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
