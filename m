Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id EFC75DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 02:16:18 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so4100552rvb.3
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 07:16:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <131068.85091.qm@web25803.mail.ukl.yahoo.com>
References: <fa686aa40901200804l24a10f56g50c3812f8730a513@mail.gmail.com>
	<131068.85091.qm@web25803.mail.ukl.yahoo.com>
Date: Wed, 21 Jan 2009 10:16:17 -0500
Message-ID: <9e4733910901210716s7671c81cw9da8940d55460aa5@mail.gmail.com>
Subject: Re: Bestcomm tasks and interrupts on MPC5200(B)
From: Jon Smirl <jonsmirl@gmail.com>
To: arieswar24b@yahoo.de, Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2009 at 7:57 AM, Dave Best <arieswar24b@yahoo.de> wrote:
> Thanks for the driver.
> I am looking into this.
>
> I still have some trouble to compile and use the driver:
> - I currently use the 2.6.23.1 kernel source which was provide along with=
  the pcm030 board by Phytec. And i guess your driver was compile along wit=
h a newer driver as i can't find the "strict_strtoul" and "strict_strtol" f=
unctions in my kernel but i copied their source into my code. The same with=
 "of_find_matching_node" which i tried to exchange with "of_find_compatible=
_node" but somehow my devicetree does not include the neccesay compatible t=
ypes. Here I tried "of_find_node_by_type" with "soc" and it seemed to work.
> The biggest problem seems to be "irq_create_of_mapping" for the localplus=
 isr. It's giving me a kernel OOPS by trying to access data from 0x00000010=
.
>
> If you could point out if I have to use a newer Kernel, and which, to sol=
ve these problems or how i can code around these with my current kernel sou=
rce.

Current git kernel runs fine on the phytec board without patches.

Pengutronix makes the kernels for the phytec pcm030 boards. Their
2.6.23 kernel has probably been patched for real time support. If you
don't need real time there's no real downside to using current git.
Sascha may have some other patches that I'm unaware of.

>
>
> Anyway, I looked over your code and only found that you first create an i=
nterrupt routine for the localplus in general before creating the bestcomm =
task.
> As far as I thought it was enough to create the bestcomm task and enable =
it. And it was upon Bestcomm to watch over its tasks and to look for interr=
upt sources according to their initiators/requestors to trigger their ISR.
>
> In your example the local plus fifo would trigger its ISR when its done t=
ransfering the blocksize and reset the status bits and start over. The task=
 would run its ISR when its buffer is filled to create a new one.
>
> If thats the way to go, i will try it out.
>
> Thanks
> Dave
>
> --- Grant Likely <grant.likely@secretlab.ca> schrieb am Di, 20.1.2009:
>
>> Von: Grant Likely <grant.likely@secretlab.ca>
>> Betreff: Re: Bestcomm tasks and interrupts on MPC5200(B)
>> An: arieswar24b@yahoo.de
>> CC: linuxppc-dev@ozlabs.org
>> Datum: Dienstag, 20. Januar 2009, 17:04
>> On Tue, Jan 20, 2009 at 6:15 AM, Dave Best
>> <arieswar24b@yahoo.de> wrote:
>> > I'm trying to write a driver which uses the Local
>> Plus Bus on my MPC5200B and therefore have to use BestComm
>> DMA, which requires me to use a Gen_BD task for data
>> transfer with Local Plus.
>> > I tried to follow the fec driver that is currently
>> used and took a peek at the mpc52xx-ac97 driver which at
>> least uses the same kind of bus as I.
>> >
>> > Initialising the task, resetting and enabling works
>> fine. Even request_irq reports no error, but when I start a
>> transfer it hangs and if I am lucky, an interrupt occurs
>> after quite some time. But it's always the BestComm
>> ethernet rx task which produces an RFIFO interrupt,
>> presumably after the watchdog catches on.
>> > If this happens my interrupt occurs to.
>>
>> Are you using the LocalPlus fifo device for the transfer
>> (you need to
>> if you aren't)?
>>
>> I've attached a test driver that demonstrates how to do
>> FIFO only and
>> FIFO+DMA transfers over the localplus bus.
>>
>> g.
>>
>>
>>
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Jon Smirl
jonsmirl@gmail.com
