Return-Path: <bwaite@irobot.com>
Received: from irobot.com (unknown [67.130.105.243])
	by ozlabs.org (Postfix) with ESMTP id 41058682FA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 03:13:25 +1000 (EST)
From: Brian Waite <bwaite@irobot.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 20 Sep 2005 13:13:48 -0400
References: <B8561865DB141248943E2376D0E85215014202FE@DHOST001-17.DEX001.intermedia.net>
In-Reply-To: <B8561865DB141248943E2376D0E85215014202FE@DHOST001-17.DEX001.intermedia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200509201313.48945.bwaite@irobot.com>
Subject: Re: GT64260_eth (Ethernet) Driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 20 September 2005 12:02 pm, Earl Olsen wrote:
> Does anybody know if this issue was solved?
> I'm running into the exact same problem with 2.6.10.
>
> Thanks
>
> Dieu Morales wrote:
> >Greetings, I am working with the latest 2.6.7 kernel
> >source on a ppc radstone PPC7A board and was curious
> >if anyone was in the process or planned on porting the
> >gt64260_eth driver to support the 2.6.x kernel.
2.6.7 is a really early version. I don't know of any working Marvel 64260 o=
r=20
64360 code in this time frame. I do know that the 64360 was patched to=20
mainline at ~2.6.13. Since then all real Marvel work should have been done =
on=20
mainline. I'd reccommend moving forward.
> >
> >Not being familiar with the gt64260 Ethernet device or
> >code, I plan to take it line by line.=20
That is probably a mistake for a number of reasons. First,  you will not be=
=20
able to get this into the mainline because it does not use the=20
platform_device structures like the Marvell 64360 ethernet device. Secondly=
,=20
most of the developers doing Marvell work, are using the 64360 chipset. I'd=
=20
reccommend using a newer kernel and backporting the 64360 ethernet code to=
=20
64260. I just looked at my baseline tree (2.6.12-rc1) and see the only=20
platform using the 64260 chip, besides the eval board, was the cpci690.c. I=
=20
would look and see ifthis is still a working platform and base your platfor=
m=20
code off of that.

> >I have attempted=20
> >to use the driver from the ppc.bkbits.net 2.4
> >development tree and currently have only changed the
> >dev =3D init_etherdev(dev, sizeof (gt_eth_priv));
> >to
> >dev =3D alloc_etherdev(sizeof (gt_eth_priv_struct ));
> >Shortly after, when attempting to allocate the Tx and
> >Rx page buffers, I get an exception in the
> >uncachedPages function.  I have traced the problem to
> >the pmd_present=C3=B2(*pmd) function in va_to_pte(addr)
> >returning 0.  I dumped td the values seemed O.K., so
> >I commented out the pmd_present=C3=B2(*pmd) check but was
> >once again stopped by the pte_present(*pte) check.  I
> >have seen the driver operate under 2.4.26 dev tree
> >from ppc.bkbits.net where this problem does not occur.
> >One difference I have noticed is that during
> >initialization of the 2.6.7 kernel, I do not get the
> >following output.
> >Buffer-cache hash table entries:
> >Page-cache hash table entries:
> >The filemap.c, where the "Page-cache " printk resides
> >in 2.4, looks heavily reworked, so I don't suspect
> >this is an issue?
>
> Dieu,
>
> You should sync up with Brian Waite (look at CC: list) who has been
> looking at writing a new enet driver for the 2.6 kernel using the latest
> bridge support code.  You can get a look at the latest support code by
> cloning bk://source.mvista.com/linux-2.5-marvell. =20
No. Only use mainline kernel.org for latest support. Nothing else is workin=
g=20
100%. In the kernel.org tree the MPSC driver is working along with the 360=
=20
ethernet device.=20

> Note the the mpsc=20
> driver that's there still isn't working correctly.
I haven't loked at the 64260 for well over a year since we went to the 6436=
0.=20
The 260 was just too bad in too many respects. I was willing to test the 26=
0=20
code with my old hardware if there was a merged driver and even develop the=
=20
merged driver, but it became obvious the merged driver was going to be ugly


Thanks
Brian
