Return-Path: <arieswar24b@yahoo.de>
Received: from web25803.mail.ukl.yahoo.com (web25803.mail.ukl.yahoo.com
	[217.12.10.188]) by ozlabs.org (Postfix) with SMTP id C1379DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 23:57:40 +1100 (EST)
Date: Wed, 21 Jan 2009 12:57:38 +0000 (GMT)
From: Dave Best <arieswar24b@yahoo.de>
Subject: Re: Bestcomm tasks and interrupts on MPC5200(B)
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40901200804l24a10f56g50c3812f8730a513@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <131068.85091.qm@web25803.mail.ukl.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: arieswar24b@yahoo.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the driver.=20
I am looking into this.

I still have some trouble to compile and use the driver:
- I currently use the 2.6.23.1 kernel source which was provide along with  =
the pcm030 board by Phytec. And i guess your driver was compile along with =
a newer driver as i can't find the "strict_strtoul" and "strict_strtol" fun=
ctions in my kernel but i copied their source into my code. The same with "=
of_find_matching_node" which i tried to exchange with "of_find_compatible_n=
ode" but somehow my devicetree does not include the neccesay compatible typ=
es. Here I tried "of_find_node_by_type" with "soc" and it seemed to work.
The biggest problem seems to be "irq_create_of_mapping" for the localplus i=
sr. It's giving me a kernel OOPS by trying to access data from 0x00000010.

If you could point out if I have to use a newer Kernel, and which, to solve=
 these problems or how i can code around these with my current kernel sourc=
e.


Anyway, I looked over your code and only found that you first create an int=
errupt routine for the localplus in general before creating the bestcomm ta=
sk.
As far as I thought it was enough to create the bestcomm task and enable it=
. And it was upon Bestcomm to watch over its tasks and to look for interrup=
t sources according to their initiators/requestors to trigger their ISR.

In your example the local plus fifo would trigger its ISR when its done tra=
nsfering the blocksize and reset the status bits and start over. The task w=
ould run its ISR when its buffer is filled to create a new one.

If thats the way to go, i will try it out.

Thanks
Dave

--- Grant Likely <grant.likely@secretlab.ca> schrieb am Di, 20.1.2009:

> Von: Grant Likely <grant.likely@secretlab.ca>
> Betreff: Re: Bestcomm tasks and interrupts on MPC5200(B)
> An: arieswar24b@yahoo.de
> CC: linuxppc-dev@ozlabs.org
> Datum: Dienstag, 20. Januar 2009, 17:04
> On Tue, Jan 20, 2009 at 6:15 AM, Dave Best
> <arieswar24b@yahoo.de> wrote:
> > I'm trying to write a driver which uses the Local
> Plus Bus on my MPC5200B and therefore have to use BestComm
> DMA, which requires me to use a Gen_BD task for data
> transfer with Local Plus.
> > I tried to follow the fec driver that is currently
> used and took a peek at the mpc52xx-ac97 driver which at
> least uses the same kind of bus as I.
> >
> > Initialising the task, resetting and enabling works
> fine. Even request_irq reports no error, but when I start a
> transfer it hangs and if I am lucky, an interrupt occurs
> after quite some time. But it's always the BestComm
> ethernet rx task which produces an RFIFO interrupt,
> presumably after the watchdog catches on.
> > If this happens my interrupt occurs to.
>=20
> Are you using the LocalPlus fifo device for the transfer
> (you need to
> if you aren't)?
>=20
> I've attached a test driver that demonstrates how to do
> FIFO only and
> FIFO+DMA transfers over the localplus bus.
>=20
> g.
>=20
>=20
>=20
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.=0A=0A=0A      
