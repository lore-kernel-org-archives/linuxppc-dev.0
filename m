To: Eli Brin <elib@rokonet.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx SCC and SMC uart latency 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 13 Jan 2003 11:37:28 +0200."
             <75DF04AC5ED4D511A9810090273CB4163A66F0@ROKONET-E>
Date: Mon, 13 Jan 2003 16:14:18 +0100
Message-Id: <20030113151423.A4145C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Eli,

in message <75DF04AC5ED4D511A9810090273CB4163A66F0@ROKONET-E> you wrote:
>
> We have a device that communicates over RS232 at 9600 bps.  This device has
> a 4 mSec timeout, i.e we have to reply in less then 4mSec.

Which parts of your software are included in this timeout?

Do you mean something like that:

* driver receives data
* application reads data from driver
* application generates response
* application writes response to driver
* driver sends data

?

> The packets are usually small (4-6 Bytes).  We communicate successfully with
> the device, but only if we change the timeout to above 10mSec.
> It seems that it takes 5-8 mSec for us to reply.  This is the same if we use

You might try to run your code with LTT instrumentation so  that  you
can  see  where  it  takes  the  time.  I  guess  it's just that your
application takes that long before it gets scheduled.

> SMC or SCC.  We tried to play with the MAX_IDL and the Tx/Rx buffer sized,
> but with no success.
>
> Has anyone an idea on how to minimize the uart latency?

I don't think that this has anything to do with the UART driver.

> If we use the same code on a PC (i386) we reply in 300 microSec.

If you have to guarantee a response time, you will have  to  consider
using a real-time extension like RTAI. The standard Linux kernel does
not guarantee any latencies.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can love it, change it, or leave it.    There is NO other option.
But do not complain - it is your own choice...                  -- wd

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
