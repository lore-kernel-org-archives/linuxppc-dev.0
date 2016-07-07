Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0065.outbound.protection.outlook.com [104.47.2.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlqdl0MsVzDrFy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 06:55:38 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Daniel Walker <danielwa@cisco.com>, Raghav Dogra <raghav.dogra@nxp.com>,
 Brian Norris <computersforpeace@gmail.com>, Jaiprakash Singh
 <b44839@freescale.com>, Scott Wood <scottwood@freescale.com>, Lijun Pan
 <Lijun.Pan@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "xe-kernel@external.cisco.com"
 <xe-kernel@external.cisco.com>
Subject: Re: t1040 IFC flash driver Extended Chip Select
Date: Thu, 7 Jul 2016 19:26:20 +0000
Message-ID: <DB5PR0401MB1928CD680EFFD3A1712AA9F6913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <577D68B8.8020305@cisco.com>
 <DB5PR0401MB1928C329F9B0FF9AAF5A607B913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <577E79D4.1010709@cisco.com>
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

On 07/07/2016 10:48 AM, Daniel Walker wrote:=0A=
> On 07/06/2016 05:57 PM, Scott Wood wrote:=0A=
>> On 07/06/2016 03:23 PM, Daniel Walker wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> We are using the t1040 platform, and we have found that we need to=0A=
>>> populate this register. In the Technical Reference Manual it's=0A=
>>> description is section 24.3.2. This option appears in the driver, but i=
t=0A=
>>> doesn't appears to be used anyplace.=0A=
>> I'm not sure what you mean by "in the driver".  U-boot sets these regist=
ers.=0A=
> =0A=
> My hardware doesn't use u-boot , and it doesn't set these values. =0A=
> However, there are other reasons to have this. For example, you use =0A=
> u-boot but it's got a defect which sets the values incorrectly. You may =
=0A=
> not be able to update your bootloader on a shipped product.=0A=
=0A=
How did you get to the point of shipping a product with this wrong?  Did=0A=
previous software versions not use IFC?=0A=
=0A=
We could have the Linux driver initialize things, but as I said, the=0A=
missing piece from the device tree isn't this register, it's the attributes=
.=0A=
=0A=
What else does/doesn't your loader do?  Does it set up a LAW that covers=0A=
IFC?  You only put this one register here -- does your loader set up=0A=
CSPR/CSOR?  If it's just this one register that was overlooked, and you=0A=
can't update the bootloader, simplest may be to just have your board's=0A=
platform code write it.=0A=
=0A=
>>> We we're considered adding something to the device tree to allow=0A=
>>> populating this value, but I'm wondering if any of you have specific=0A=
>>> considerations on how this is done. Or maybe it's not needed at all, an=
d=0A=
>>> we're just missing something.=0A=
>>>=0A=
>>> (not a good patch, just an example.)=0A=
>>>=0A=
>>> diff --git=0A=
>>> a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt=0A=
>>> b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt=0A=
>>> index 89427b0..b506001 100644=0A=
>>> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt=
=0A=
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt=
=0A=
>>> @@ -24,6 +24,8 @@ Properties:=0A=
>>>    - ranges : Each range corresponds to a single chipselect, and covers=
=0A=
>>>               the entire access window as configured.=0A=
>>>=0A=
>>> +- cspr_ext : This value sets the extended chip select for all banks.=
=0A=
>> I see no reason to put this here.  Boot software should be setting the=
=0A=
>> chipselect registers, and if for some reason you don't want to do that,=
=0A=
>> you could just translate the address through ranges to find the value to=
=0A=
>> write.  Why would you have the binding assume it's the same for all bank=
s?=0A=
> =0A=
> It was only an example, to start the conversation. I don't understand =0A=
> what you mean by translating the address thru ranges?=0A=
=0A=
of_address_to_resource()=0A=
=0A=
>> The information that is missing from the device tree, that currently=0A=
>> must come from boot software programming the registers, is the various=
=0A=
>> attributes that get programmed in CSPR/CSOR.=0A=
>>=0A=
> =0A=
> Like I said mine doesn't do this, so it's required that it be set in an =
=0A=
> alternative way. The only alternative we have currently is adding some =
=0A=
> code to manually set the values but it's not ideal (and not upstreamable)=
.=0A=
=0A=
I wouldn't have a problem merging code in a platform board file that=0A=
writes a single register that a hard-to-update bootloader forgot to write.=
=0A=
=0A=
-Scott=0A=
=0A=
