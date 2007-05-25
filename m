Return-Path: <dhlii@dlasys.net>
Message-ID: <46563226.8000000@dlasys.net>
Date: Thu, 24 May 2007 20:47:34 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: Xilinx git tree at source.mvista.com
References: <46555294.6040104@ru.mvista.com> <465561A4.9020403@dlasys.net>
	<46558E54.80909@ru.mvista.com>
In-Reply-To: <46558E54.80909@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:
> Hi David,
>
> David H. Lynch Jr. wrote:
>>>   
>> I have an almost working FIFO TEMAC driver. It is similarly based.
>> it started out based on the Trek webserver sample
>
> Is this a reference design by Xilinx? Linux based or standalone?
    I did a Local Link hard TEMAC driver - that I eventually got
working. However, I could not find anyway to
    enable interrupts in the Local Link TEMAC so the driver was strictly
polled and between that and other
    issues, perfomances was abysmal almost 50% of all inbound packets
were dropped, we switched to the
    PLB FIFO TEMAC I stripped out all the SG and DMA stuff (as it is not
in our hardware) and converted it to
    a fairly normal Linux ethernet driver. It sends, it receives, but I
beleive it is not properly confirming to Linux
    that packets were successfully sent.

    In the interim I have been using the posted driver that uses the EDK.
    Until more recently that has lacked features like
    autonegotiation.

    I beleive its current flaw is primarily massive violations of kernel
code style guidelines.


>
>> I spent probably 3-4 days de-EDKing it into something that fit into a
>> single source and was closer to ko norms.
>> It is based on approximately the EDK 8.1 stuff. You are welcome to it,
>> if it could be helpful in anyway.
>> I am all for getting an acceptable driver into the ko tree.
>
> You could post your driver to the list when you think it is in good
> enough shape.
> If your driver is based on the linux TEMAC driver from EDK, it shouldn't
> be very different from my version (my added value is mostly replacing the
> custom PHY code with the PHY lib stuff). Then we could merge our
> drivers (or
> whatever would make sense).
>
> I would be interested to have a look at your current code just to see
> how much has it cost to "de-EDK" the FIFO part. You could email me
> your (even not quite working) driver privately if you want.

    I will email you a copy separately. I do not care what you choose to
do with it.
    At the moment I have no time to take it further - something about
asses, alligators
    and clearing swamps.

    Mostly I would just like to see a Linux friendly driver make its way
into the kernel.

    I have almost exactly the same code working as a GHS integrity driver.
    In fact I sort of ported a mini shim layer to GHS to implement Linux
SKB's under GHS.
    I did trip over something with GHS. If I was able to 64bit align the
data part of the skb
    the send/receive code code be vastly simplified.
    I have not but I have not done that yet.






>
>
> Thanks,
> Andrei
>


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
