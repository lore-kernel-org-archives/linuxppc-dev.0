Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0070.outbound.protection.outlook.com [104.47.2.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpD9J3KGyzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 04:27:47 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Daniel Walker <danielwa@cisco.com>, Raghav Dogra <raghav.dogra@nxp.com>,
 Brian Norris <computersforpeace@gmail.com>, Jaiprakash Singh
 <b44839@freescale.com>, Scott Wood <scottwood@freescale.com>, Lijun Pan
 <Lijun.Pan@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "xe-kernel@external.cisco.com"
 <xe-kernel@external.cisco.com>
Subject: Re: t1040 IFC flash driver Extended Chip Select
Date: Mon, 11 Jul 2016 18:27:40 +0000
Message-ID: <DB5PR0401MB1928A2DB8C8F8EBEC544A80E913F0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <577D68B8.8020305@cisco.com>
 <DB5PR0401MB1928C329F9B0FF9AAF5A607B913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577E79D4.1010709@cisco.com>
 <DB5PR0401MB1928CD680EFFD3A1712AA9F6913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577EB10B.7010601@cisco.com>
 <DB5PR0401MB1928FF35ABE36D8E07BAA079913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577EC0FC.8020304@cisco.com>
 <DB5PR0401MB1928FBF1769BCE0DE0E3E503913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577ECE6C.3000100@cisco.com>
 <DB5PR0401MB192848637D543D8B95B6092D913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577ED12C.30105@cisco.com>
 <DB5PR0401MB1928F9E528E4873AC7C17F6F913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577EEA56.3070300@cisco.com>
 <DB5PR0401MB192830653731568F86FEB37D913D0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <5783CB03.4030806@cisco.com>
 <DB5PR0401MB1928CAA554662FF41C34210D913F0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <5783D31A.3090609@cisco.com>
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

On 07/11/2016 12:10 PM, Daniel Walker wrote:=0A=
> On 07/11/2016 09:55 AM, Scott Wood wrote:=0A=
>> On 07/11/2016 11:36 AM, Daniel Walker wrote:=0A=
>>> On 07/08/2016 06:12 PM, Scott Wood wrote:=0A=
>>>> On 07/07/2016 06:48 PM, Daniel Walker wrote:=0A=
>>>>> On 07/07/2016 03:37 PM, Scott Wood wrote:=0A=
>>>>>> On 07/07/2016 05:01 PM, Daniel Walker wrote:=0A=
>>>>>>> On 07/07/2016 02:59 PM, Scott Wood wrote:=0A=
>>>>>>>> On 07/07/2016 04:49 PM, Daniel Walker wrote:=0A=
>>>>>>>>> On 07/07/2016 02:23 PM, Scott Wood wrote:=0A=
>>>>>>>>>> I suspect that add the usage of cspr_ext into the driver would f=
ix the=0A=
>>>>>>>>>> issue we have. It reads like you would find that acceptable ?=0A=
>>>>>>>>>> What specifically is the problem you're having?  Is it that CSPR=
_EXT is=0A=
>>>>>>>>>> not getting written to, and thus the device does not appear at t=
he=0A=
>>>>>>>>>> address that it should?=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> Or is the driver matching incorrectly?  The only way the driver'=
s lack=0A=
>>>>>>>>>> of using CSPR_EXT to match would be a problem would be if you ha=
ve=0A=
>>>>>>>>>> multiple chipselects with the same address in the lower 32 bits,=
 and=0A=
>>>>>>>>>> only CSPR_EXT distinguishing them.  Since you proposed a device =
tree=0A=
>>>>>>>>>> binding that assumes all devices have the same CSPR_EXT, I doubt=
 that's=0A=
>>>>>>>>>> the case, so I doubt adding CSPR_EXT matching to the driver will=
 solve=0A=
>>>>>>>>>> your problem.=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> -Scott=0A=
>>>>>>>>>>=0A=
>>>>>>>>> I didn't do the debug on this. From my perspective it's either fl=
ash=0A=
>>>>>>>>> works, or it doesn't work. We need the code below for it to work,=
=0A=
>>>>>>>> Adding CSPR_EXT matching to the driver will not accomplish the sam=
e=0A=
>>>>>>>> thing as that code.=0A=
>>>>>>>>=0A=
>>>>>>> So from u-boot perspective, the values in the device tree under "ra=
nges"=0A=
>>>>>>> or parts of it, are place into the cspr and cspr_ext ? Is that how =
it's=0A=
>>>>>>> suppose to work ?=0A=
>>>>>> U-Boot writes values that are hardcoded in the board config header.=
=0A=
>>>>>> These values (as well as the area covered by the IFC LAW) need to ma=
tch=0A=
>>>>>> the address in the device tree, but U-Boot doesn't get them from the=
=0A=
>>>>>> device tree.=0A=
>>>>>>=0A=
>>>>> I was suggesting the values it writes are the same as the ones inside=
=0A=
>>>>> the device tree. So we could have both csrp and csrp_ext written from=
=0A=
>>>>> the driver and the values would=0A=
>>>>> come from the ranges property.=0A=
>>>> There's more to CSPR than just the address.  The driver should either =
be=0A=
>>>> able to assume that all of CSPR/CSOR has been correctly initialized, o=
r=0A=
>>>> it should assume none of that has been initialized -- which again,=0A=
>>>> requires the attribute information to be in the device tree.  If you'r=
e=0A=
>>>> doing something in between, then that's a board quirk rather than a=0A=
>>>> general solution.=0A=
>>>>=0A=
>>>> -Scott=0A=
>>>>=0A=
>>> It would seems like a good idea to add it then. I think it can be piece=
=0A=
>>> mail, rather than all or nothing tho. How difficult is adding the other=
=0A=
>>> part to the driver , v.s. just the cspr_ext ?=0A=
>> Writing only cspr_ext is a hack to work around a bug and should not be=
=0A=
>> disguised as a "piecemeal" implementation of something different.=0A=
>>=0A=
>> -Scott=0A=
> =0A=
> Ok .. How hard is it to do all the stuff your asking for ?=0A=
=0A=
It shouldn't be hard.  Add properties (at the chipselect level -- not=0A=
IFC controller) that hold the non-address portions of CSPR, CSOR, and=0A=
(if applicable to the IFC version) CSOR_EXT, as well as the chipselect=0A=
number.  If the chipselect property is present then the others must be=0A=
as well.  Code to handle this should go in drivers/memory/fsl_ifc.c=0A=
rather than the NAND driver.=0A=
=0A=
If the chipselect property is absent, then the driver will assume that=0A=
the loader has set up all chipselect registers correctly.=0A=
=0A=
-Scott=0A=
=0A=
