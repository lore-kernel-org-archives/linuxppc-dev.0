Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.2.20030115075248.02669e88@falcon.si.com>
Date: Wed, 15 Jan 2003 08:00:28 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: RE: 8xx SCC and SMC uart latency
In-Reply-To: <0066D2AC.C21188@rokonet.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Eli,

Yes, you can leave HZ at 1000 if that works for you.  HZ is a tradeoff
between switching tasks more rapidly (as you noticed, it can help response
time) and overhead of handling a high frequency interrupt (which can hurt
response time :-).

I am guessing that you have two or more tasks that are polling things,
requiring a task switch to get your job done.  Now that you have a "proof
of concept" working, you should really look at how your code is structured
and take advantage of real multitasking and associated control mechanisms
such as semaphores.  This allows tasks to be event driven rather than
polling and can make a huge difference in response time and make the code
cleaner as an additional benefit.

The idea is that your processing task waits on a semaphore: when someone
has something for it to do, they release (post/signal) the semaphore which
unblocks the processing task.  This allows the processing task to (a) not
consume processor resources when it doesn't have anything to do and (b)
start up immediately when there is something to do (as opposed to having to
wait for its slice of processor time).

gvb


At 02:37 PM 1/15/2003 -0500, elib@rokonet.co.il wrote:
>Dear Jerry and Wolfgang,
>
>Thank you for your reply.
>
>I have changed the kernel clock rate to 1000 (/include/asm-ppc/param.h,
>#define HZ 1000). It helped.
>We reply in about 2mSec and we are within the 4mSec timeout.
>
>As we are new to Linux, we imigrated from windows :), it took us some time.
>
>We have a C++ program that listens to the serial port and reads the data.
>If a packete has the address of our program we parse the data, and reply.
>
>In parallel the program listens on a TCP port and waits for commands.  Those
>commands are sent through the serial port.
>We use goap (soap xml for c/c++).
>
>The initial tests where done witout all the parsing and TCP overhead.  We
>just replied imidiatly to packets addressed to us, and we got 5-8mSec delay
>from the last char we received and the first char we send.  Now (HZ=1000)
>it's 2mSec with the parsing and TCP/IP.
>
>Can we leave the HZ to 1000 ?
>
>Now that is works we can commit our project to Linux and use the RTAI.
>
>Thanks again, and
>Best Regards
>Eli Brin
>
>
>
>-----Original Message-----
>From: Jerry Van Baren [mailto:gerald.vanbaren@smiths-aerospace.com]
>Sent: Monday, January 13, 2003 5:40 PM
>To: linuxppc-embedded@lists.linuxppc.org
>Subject: Re: 8xx SCC and SMC uart latency
>
>
>
>Your last line on the i386 makes me think you are polling the UART and
>immediately sending back the response.  This is a totally different model
>than what you are running under linux.
>
>You can approach that model under linux only by writing a custom device
>driver that understand your communications protocol and, in the Rx handler,
>processes the received packet, generates data, and queues it to be sent.  Of
>course, this is going to take some effort and has a pretty good sized
>learning curve to climb.  There are some device driver toolkits that can
>help here.
>
>Your 10mSec timeout and 5-8mSec latency numbers sound suspiciously like task
>switch (clock tick) times of 100Hz.  You need to tell us more about how your
>code is structured and what happens along the path from when the first byte
>comes in to when the first byte goes out, including all the separate tasks
>that get involved and how they communicate with each other.  As a quick
>test, increase your kernel clock rate to 1000Hz and see if it improves your
>timings by about 10x.
>
>gvb
>
>
>At 04:14 PM 1/13/2003 -0500, wd@denx.de wrote:
>
> >Dear Eli,
> >
> >in message <75DF04AC5ED4D511A9810090273CB4163A66F0@ROKONET-E> you
> >wrote:
> > >
> > > We have a device that communicates over RS232 at 9600 bps.  This
> > > device has a 4 mSec timeout, i.e we have to reply in less then
> > > 4mSec.
> >
> >Which parts of your software are included in this timeout?
> >
> >Do you mean something like that:
> >
> >* driver receives data
> >* application reads data from driver
> >* application generates response
> >* application writes response to driver
> >* driver sends data
> >
> >?
> >
> > > The packets are usually small (4-6 Bytes).  We communicate
> > > successfully
> > with
> > > the device, but only if we change the timeout to above 10mSec. It
> > > seems that it takes 5-8 mSec for us to reply.  This is the same if
> > we use
> >
> >You might try to run your code with LTT instrumentation so  that  you
> >can  see  where  it  takes  the  time.  I  guess  it's just that your
> >application takes that long before it gets scheduled.
> >
> > > SMC or SCC.  We tried to play with the MAX_IDL and the Tx/Rx buffer
> > > sized, but with no success.
> > >
> > > Has anyone an idea on how to minimize the uart latency?
> >
> >I don't think that this has anything to do with the UART driver.
> >
> > > If we use the same code on a PC (i386) we reply in 300 microSec.
> >
> >If you have to guarantee a response time, you will have  to  consider
> >using a real-time extension like RTAI. The standard Linux kernel does
> >not guarantee any latencies.
> >
> >Best regards,
> >
> >Wolfgang Denk
> >
> >--
> >Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> >Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> >You can love it, change it, or leave it.    There is NO other option.
> >But do not complain - it is your own choice...                  -- wd
> >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
