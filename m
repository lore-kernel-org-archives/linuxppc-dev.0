Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id A1C9E67A73
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 07:08:14 +1100 (EST)
Received: from edge1.siol.net ([10.10.10.210]) by mta1.siol.net with ESMTP
	id <20050303200811.KHVC8918.mta1.siol.net@edge1.siol.net>
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Mar 2005 21:08:11 +0100
Received: from linux.asist ([193.95.241.43]) by edge1.siol.net with ESMTP
	id <20050303200807.BKME1150.edge1.siol.net@linux.asist>
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Mar 2005 21:08:07 +0100
Received: from [192.168.254.58] (unknown [192.168.254.58])
	by linux.asist (Postfix) with ESMTP id CC21C644A9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 21:07:58 +0100 (CET)
Message-ID: <42276E9E.9010708@asist-traffic.com>
Date: Thu, 03 Mar 2005 21:07:58 +0100
From: Babarovic Ivica <ivica@asist-traffic.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: FEC_IEVENT_RFIFO_ERROR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sylvain, Dale and others!

Well, I went for a 5 minute walk to get some fresh air and gather my 
thoughts.
To put it shortly I'm mad as hell. I can't believe what a noob mistake 
I've made.
In one of my drivers I had a for loop that loops trough some IO range  
to discover
if hardware is there and instead  of  this for-expression  (i=0; i<31; 
i+=2), I wrote
this one (i=0; i<31; i=+2) . The difference is in =+ and += . Variable i 
never got
incremented past 2 and of course there was chaos because loop was 
running to infinity. :)
Function I was calling in 'infinite' runaway loop did some input and 
output with a custom
bus and read something from a GPIO register. Here it is:
--------------------------------------------------------------
static inline int ebus_echo(char * io)
{
       struct mpc52xx_gpio *gpio;
       volatile unsigned char dummy;

       gpio = (struct mpc52xx_gpio *)MPC52xx_GPIO;

       out_8(RESET_ECHO, 0);
       dummy=in_8(io);
       if (in_8(&gpio->sint_ival) & 0x02)
               return 1;
       return 0;
}
-----------------------------------------------------------------

This driver was initializing itself just before the NIC. I wonder how 
ethernet init
even started and got to the RFIFO part since there was an infinite loop 
running before it?
What a productive day I just had. A stupid typo cost me 12 hours of work 
and I have
nothing to show for. I apologize and I only hope something good comes 
out of this.

/me ducks

Best regards
I.


Sylvain Munaut wrote:

Hi

>
> I tried the patch you've sent and It's still the same.
> FEC_IEVENT_RFIFO_ERROR is still here.
> Can you/anyone think of something that I could do to make
> analyzing this problem easier?
>
Resetting the FEC early is a good thing so that patch should be there 
anyway, so we don't setup irq handlers for a hardware in unknow state.

However looking at fec code, there is another problem with it : The FEC 
is enabled in probe, once for all but the DMA tasks that should empty
the buffers are only enabled when the interface is up, so during it's 
down time, any received packed ends up in filling the FIFO ...

This problem goes away when the interface is up tough, so you should not 
experience 'crash' ... Do you nfs boot ? Try with a static image, just
to see, maybe having the error at boot screw something. If it doesn't 
boot with a static image then there is still another problem.


   Sylvain
