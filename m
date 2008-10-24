Return-Path: <Steve.Gray@peek-traffic.co.uk>
Received: from uksv0008.peek.prv (mail.peek-traffic.co.uk [194.75.137.2])
	by ozlabs.org (Postfix) with ESMTP id B09C5DDD01
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Oct 2008 00:05:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Ucode/BD conflict on PowerPC 860
Date: Fri, 24 Oct 2008 14:03:42 +0100
Message-ID: <85A8D9AB423A3A4ABD022AD90C989C4D01090C6F@uksv0008.peek.prv>
In-Reply-To: <490098E4.6090908@freescale.com>
References: <48A15FC3.3060008@vastech.co.za><20080812181138.BEF53248BF@gemini.denx.de>	<48A2A99C.5000309@vastech.co.za>
	<85A8D9AB423A3A4ABD022AD90C989C4D010904A2@uksv0008.peek.prv>
	<490098E4.6090908@freescale.com>
From: "Gray, Steve - UK" <Steve.Gray@peek-traffic.co.uk>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Scott
Thanks for the notes on modifying the data subnode.=20
I am pleased to say this has fixed the problem and the console is
working now.


Kind Regards

Stve

-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]=20
Sent: 23 October 2008 16:32
To: Gray, Steve - UK
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Ucode/BD conflict on PowerPC 860

Gray, Steve - UK wrote:
> I have tried a few things, including setting the range of muram to=20
> ranges =3D <0x0 0x3000 0x1000>;
>=20
> Am I correct to assume this will push the muram above the microcode??

No, that will confuse the kernel into thinking that muram starts at IMMR

offset 0x3000.  You need to change the reg property of the data subnode=20
to <0x1000 0xc00>, so that you restrict the allocation range without=20
affecting the offset that is subtracted from the physical address to=20
obtain the value given to the CPM.

-Scott
