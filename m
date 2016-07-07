Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0075.outbound.protection.outlook.com [104.47.2.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlrwj0PK4zDr2b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 07:53:40 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Daniel Walker <danielwa@cisco.com>, Raghav Dogra <raghav.dogra@nxp.com>,
 Brian Norris <computersforpeace@gmail.com>, Jaiprakash Singh
 <b44839@freescale.com>, Scott Wood <scottwood@freescale.com>, Lijun Pan
 <Lijun.Pan@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "xe-kernel@external.cisco.com"
 <xe-kernel@external.cisco.com>
Subject: Re: t1040 IFC flash driver Extended Chip Select
Date: Thu, 7 Jul 2016 21:23:23 +0000
Message-ID: <DB5PR0401MB1928FBF1769BCE0DE0E3E503913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <577D68B8.8020305@cisco.com>
 <DB5PR0401MB1928C329F9B0FF9AAF5A607B913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577E79D4.1010709@cisco.com>
 <DB5PR0401MB1928CD680EFFD3A1712AA9F6913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577EB10B.7010601@cisco.com>
 <DB5PR0401MB1928FF35ABE36D8E07BAA079913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577EC0FC.8020304@cisco.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2016 03:52 PM, Daniel Walker wrote:=0A=
> On 07/07/2016 01:34 PM, Scott Wood wrote:=0A=
>> On 07/07/2016 02:44 PM, Daniel Walker wrote:=0A=
>>> It seems natual that if cspr is in the device tree, you would also want=
=0A=
>>> cspr_ext because both are used to identify the device. The fact that=0A=
>>> it's missing to me is strange. As I said in my prior email, even if=0A=
>>> uboot sets those, you could have cases when it's wrong. Why would I not=
=0A=
>>> be able to simply change the device tree to correct it ?=0A=
>> CSPR is not in the device tree.  The physical address of each chipselect=
=0A=
>> is in the device tree (via the ranges property on the IFC node) and that=
=0A=
>> covers both the address portion of CSPR, and CSPR_EXT.=0A=
>>=0A=
>> What I do see missing from the driver is using CSPR_EXT to match the=0A=
>> device, most likely because the initial IFC version didn't have=0A=
>> CSPR_EXT.  Fixing that doesn't require a device tree change.=0A=
> =0A=
> Ok ..=0A=
> =0A=
>>=0A=
>>>>>> The information that is missing from the device tree, that currently=
=0A=
>>>>>> must come from boot software programming the registers, is the vario=
us=0A=
>>>>>> attributes that get programmed in CSPR/CSOR.=0A=
>>>>>>=0A=
>>>>> Like I said mine doesn't do this, so it's required that it be set in =
an=0A=
>>>>> alternative way. The only alternative we have currently is adding som=
e=0A=
>>>>> code to manually set the values but it's not ideal (and not upstreama=
ble).=0A=
>>>> I wouldn't have a problem merging code in a platform board file that=
=0A=
>>>> writes a single register that a hard-to-update bootloader forgot to wr=
ite.=0A=
>>> I can submit it to you, but I would much prefer a general solution that=
=0A=
>>> others can use without having to create board files. Our goal has been=
=0A=
>>> to reduce board files as much as possible, do you not agree with that?=
=0A=
>> I do agree that board files are not ideal, but they're still a=0A=
>> reasonable place to put board-specific quirks.=0A=
>>=0A=
>> I don't want to put a half-measure into the main driver and pretend it's=
=0A=
>> a general solution.  If the driver is to set the address, it should also=
=0A=
>> set the rest of CSPR/CSOR, which requires that information to be added=
=0A=
>> to the device tree.  If you want to propose the latter I have no problem=
=0A=
>> with that, as long as compatibility is maintained.=0A=
> =0A=
> I suspect that add the usage of cspr_ext into the driver would fix the =
=0A=
> issue we have. It reads like you would find that acceptable ?=0A=
=0A=
What specifically is the problem you're having?  Is it that CSPR_EXT is=0A=
not getting written to, and thus the device does not appear at the=0A=
address that it should?=0A=
=0A=
Or is the driver matching incorrectly?  The only way the driver's lack=0A=
of using CSPR_EXT to match would be a problem would be if you have=0A=
multiple chipselects with the same address in the lower 32 bits, and=0A=
only CSPR_EXT distinguishing them.  Since you proposed a device tree=0A=
binding that assumes all devices have the same CSPR_EXT, I doubt that's=0A=
the case, so I doubt adding CSPR_EXT matching to the driver will solve=0A=
your problem.=0A=
=0A=
-Scott=0A=
=0A=
