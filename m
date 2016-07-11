Return-Path: <danielwa@cisco.com>
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpBSZ5Km3zDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 03:10:54 +1000 (AEST)
Subject: Re: t1040 IFC flash driver Extended Chip Select
To: Scott Wood <scott.wood@nxp.com>, Raghav Dogra <raghav.dogra@nxp.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Jaiprakash Singh <b44839@freescale.com>, Scott Wood
 <scottwood@freescale.com>, Lijun Pan <Lijun.Pan@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>
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
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <5783D31A.3090609@cisco.com>
Date: Mon, 11 Jul 2016 10:10:50 -0700
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB1928CAA554662FF41C34210D913F0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2016 09:55 AM, Scott Wood wrote:
> On 07/11/2016 11:36 AM, Daniel Walker wrote:
>> On 07/08/2016 06:12 PM, Scott Wood wrote:
>>> On 07/07/2016 06:48 PM, Daniel Walker wrote:
>>>> On 07/07/2016 03:37 PM, Scott Wood wrote:
>>>>> On 07/07/2016 05:01 PM, Daniel Walker wrote:
>>>>>> On 07/07/2016 02:59 PM, Scott Wood wrote:
>>>>>>> On 07/07/2016 04:49 PM, Daniel Walker wrote:
>>>>>>>> On 07/07/2016 02:23 PM, Scott Wood wrote:
>>>>>>>>> I suspect that add the usage of cspr_ext into the driver would fix the
>>>>>>>>> issue we have. It reads like you would find that acceptable ?
>>>>>>>>> What specifically is the problem you're having?  Is it that CSPR_EXT is
>>>>>>>>> not getting written to, and thus the device does not appear at the
>>>>>>>>> address that it should?
>>>>>>>>>
>>>>>>>>> Or is the driver matching incorrectly?  The only way the driver's lack
>>>>>>>>> of using CSPR_EXT to match would be a problem would be if you have
>>>>>>>>> multiple chipselects with the same address in the lower 32 bits, and
>>>>>>>>> only CSPR_EXT distinguishing them.  Since you proposed a device tree
>>>>>>>>> binding that assumes all devices have the same CSPR_EXT, I doubt that's
>>>>>>>>> the case, so I doubt adding CSPR_EXT matching to the driver will solve
>>>>>>>>> your problem.
>>>>>>>>>
>>>>>>>>> -Scott
>>>>>>>>>
>>>>>>>> I didn't do the debug on this. From my perspective it's either flash
>>>>>>>> works, or it doesn't work. We need the code below for it to work,
>>>>>>> Adding CSPR_EXT matching to the driver will not accomplish the same
>>>>>>> thing as that code.
>>>>>>>
>>>>>> So from u-boot perspective, the values in the device tree under "ranges"
>>>>>> or parts of it, are place into the cspr and cspr_ext ? Is that how it's
>>>>>> suppose to work ?
>>>>> U-Boot writes values that are hardcoded in the board config header.
>>>>> These values (as well as the area covered by the IFC LAW) need to match
>>>>> the address in the device tree, but U-Boot doesn't get them from the
>>>>> device tree.
>>>>>
>>>> I was suggesting the values it writes are the same as the ones inside
>>>> the device tree. So we could have both csrp and csrp_ext written from
>>>> the driver and the values would
>>>> come from the ranges property.
>>> There's more to CSPR than just the address.  The driver should either be
>>> able to assume that all of CSPR/CSOR has been correctly initialized, or
>>> it should assume none of that has been initialized -- which again,
>>> requires the attribute information to be in the device tree.  If you're
>>> doing something in between, then that's a board quirk rather than a
>>> general solution.
>>>
>>> -Scott
>>>
>> It would seems like a good idea to add it then. I think it can be piece
>> mail, rather than all or nothing tho. How difficult is adding the other
>> part to the driver , v.s. just the cspr_ext ?
> Writing only cspr_ext is a hack to work around a bug and should not be
> disguised as a "piecemeal" implementation of something different.
>
> -Scott

Ok .. How hard is it to do all the stuff your asking for ?

Daniel
