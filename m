Return-Path: <nhickman@dtechlabs.com>
Received: from mail.dtechlabs.com (66.239.149.149.ptr.us.xo.net
	[66.239.149.149]) by ozlabs.org (Postfix) with SMTP id 04A40DDF4C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 04:41:16 +1000 (EST)
Subject: RE: mpc8270 & Intel 82551ER on 2.6.17.14
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Mon, 2 Jul 2007 14:41:13 -0400
Message-ID: <8140AAF341CC904BA92C3D6A5A1909782A300A@ditech-1.ditechllc.com>
In-Reply-To: <f87351060706290112o407f75e5h9dffd9939ab80ef9@mail.gmail.com>
References: <8140AAF341CC904BA92C3D6A5A1909782A2FA3@ditech-1.ditechllc.com>
	<f87351060706290112o407f75e5h9dffd9939ab80ef9@mail.gmail.com>
From: "Nicholas Hickman" <nhickman@dtechlabs.com>
To: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pradyumna,

With the help of some others I have finally figured it out.  I took a
step back and read the manual over and over along with debugging my
U-boot until it worked.  My issue there was with the SIUMCR. Since I now
had that working in U-boot I moved on to the kernel where I found that I
was redefining the SIUMCR here:

arch/ppc/syslib/m82xx_pci.c=20
approx line 248
#elif defined CONFIG_PQ2FADS || MYBOARD
        /*
         * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]),
         * and local bus for PCI (SIUMCR [LBPC]).
         */
        immap->im_siu_conf.siu_82xx.sc_siumcr =3D

I was entering this routine since I was basing my config off of the
PQ2FADS board.  I removed my board definition from the elif and
everything seems to be working fine.

Good luck!


-Nick


-----Original Message-----
From: Pradyumna Sampath [mailto:pradyumna.sampath@gmail.com]=20
Sent: Friday, June 29, 2007 4:12 AM
To: Nicholas Hickman
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8270 & Intel 82551ER on 2.6.17.14

Hi Nicholas,

On 6/29/07, Nicholas Hickman <nhickman@dtechlabs.com> wrote:
>
>
> I am having trouble getting two 82551ER Ethernet controllers running=20
> in Linux.  I am able to scan the PCI bus and see the devices and I was

> even able to program the EEPROM from U-boot.
>
> In the kernel I mapped the IRQ's through /arch/ppc/m82xx_pci.c.  I've=20
> been using the e100 drive that comes with the 2.6.17.14 kernel and=20
> have also tried the driver directly from Intel.  Both give the same=20
> results.  The PCI scan shows the correct output for how the device
should be configured.
<snip..>

I have the same, exact same problem. But there are some of the
differences with the setup though. I have an MPC5200B and the other
difference is that I have a 2.6.21-rt3. However its the same ethernet
controller.

I am trying out a few things here, some of them being complete guesses.
But if I hit something, I will let this list know. Anyone else had
similar issues ? Request you to please holler.

regards
prady
--
htp://prady.livejournal.com
