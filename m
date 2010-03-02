Return-Path: <pppeterpppan@gmail.com>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185]) by ozlabs.org (Postfix) with ESMTP id 20209B7DDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 13:20:28 +1100 (EST)
Received: by qyk15 with SMTP id 15so2212156qyk.10
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Mar 2010 18:20:26 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 2 Mar 2010 10:20:26 +0800
Message-ID: <48abf2c21003011820k4e259734ma5b1d0fd79fc4af9@mail.gmail.com>
Subject: something gets odd when I set the mtd.dev.parent
From: Peter Pan <pppeterpppan@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/2/27 Peter Pan <pppeterpppan@gmail.com>:
> 2010/2/27 Scott Wood <scottwood@freescale.com>:
>> On Fri, Feb 26, 2010 at 10:08:09AM +0800, Peter Pan wrote:
>> There isn't one. =A0I was not under the impression that such a configura=
tion
>> was even possible (how do you control ALE/CLE, for example?). =A0There i=
s a
>> NAND driver that uses UPM, though -- perhaps you could use that?
>>
>> How specifically is NAND connected to the SoC on your board? =A0What abo=
ut it
>> suggests GPCM?
>>
>> -Scott
>>

We use Address A20 and A21 connect to ALE and CLE, the data bus is
connected through a buffer.
The RE is OE AND with CS. the WE is PBS0 AND with CS. CE pin is
connect to ground. It works
fine in VxWorks. And also in our previous Linux version 2.6.22.

Now, I get a odd problem. My GPCM Nand flash driver is mostly copied
from fsl_upm.c. In the fun_probe
function, I have printed out the of_device pointer status as follows:
ofdev=3D 0xcf851ca0
ofdev->dev=3D 0xcf851cb0
ofdev->dev.class=3D 0xcf851d50

Then I set the &ofdev->dev to mtd.dev.parent using
fun->mtd.dev.parent =3D &ofdev->dev;

Then I print out the values:
fun->mtd.dev.parent=3D 0xcf851cb0
fun->mtd.dev.parent->class=3D 0x0

The parent pointer is identical, but the class member is NULL, which
makes the access of NULL pointer oops
later.

I'm wondering why this could happen. The pointer points at the same
address, shouldn't all the members be the
same?
