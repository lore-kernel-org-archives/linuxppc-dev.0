Message-Id: <5.1.0.14.2.20030113102943.02685c88@falcon.si.com>
Date: Mon, 13 Jan 2003 10:40:06 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: 8xx SCC and SMC uart latency
In-Reply-To: <00666C8E.C21188@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Your last line on the i386 makes me think you are polling the UART and
immediately sending back the response.  This is a totally different model
than what you are running under linux.

You can approach that model under linux only by writing a custom device
driver that understand your communications protocol and, in the Rx handler,
processes the received packet, generates data, and queues it to be
sent.  Of course, this is going to take some effort and has a pretty good
sized learning curve to climb.  There are some device driver toolkits that
can help here.

Your 10mSec timeout and 5-8mSec latency numbers sound suspiciously like
task switch (clock tick) times of 100Hz.  You need to tell us more about
how your code is structured and what happens along the path from when the
first byte comes in to when the first byte goes out, including all the
separate tasks that get involved and how they communicate with each
other.  As a quick test, increase your kernel clock rate to 1000Hz and see
if it improves your timings by about 10x.

gvb


At 04:14 PM 1/13/2003 -0500, wd@denx.de wrote:

>Dear Eli,
>
>in message <75DF04AC5ED4D511A9810090273CB4163A66F0@ROKONET-E> you wrote:
> >
> > We have a device that communicates over RS232 at 9600 bps.  This device has
> > a 4 mSec timeout, i.e we have to reply in less then 4mSec.
>
>Which parts of your software are included in this timeout?
>
>Do you mean something like that:
>
>* driver receives data
>* application reads data from driver
>* application generates response
>* application writes response to driver
>* driver sends data
>
>?
>
> > The packets are usually small (4-6 Bytes).  We communicate successfully
> with
> > the device, but only if we change the timeout to above 10mSec.
> > It seems that it takes 5-8 mSec for us to reply.  This is the same if
> we use
>
>You might try to run your code with LTT instrumentation so  that  you
>can  see  where  it  takes  the  time.  I  guess  it's just that your
>application takes that long before it gets scheduled.
>
> > SMC or SCC.  We tried to play with the MAX_IDL and the Tx/Rx buffer sized,
> > but with no success.
> >
> > Has anyone an idea on how to minimize the uart latency?
>
>I don't think that this has anything to do with the UART driver.
>
> > If we use the same code on a PC (i386) we reply in 300 microSec.
>
>If you have to guarantee a response time, you will have  to  consider
>using a real-time extension like RTAI. The standard Linux kernel does
>not guarantee any latencies.
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>You can love it, change it, or leave it.    There is NO other option.
>But do not complain - it is your own choice...                  -- wd
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
