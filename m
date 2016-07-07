Return-Path: <danielwa@cisco.com>
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlqYs5L6xzDrFF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 06:52:17 +1000 (AEST)
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
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <577EC0FC.8020304@cisco.com>
Date: Thu, 7 Jul 2016 13:52:12 -0700
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB1928FF35ABE36D8E07BAA079913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2016 01:34 PM, Scott Wood wrote:
> On 07/07/2016 02:44 PM, Daniel Walker wrote:
>> It seems natual that if cspr is in the device tree, you would also want
>> cspr_ext because both are used to identify the device. The fact that
>> it's missing to me is strange. As I said in my prior email, even if
>> uboot sets those, you could have cases when it's wrong. Why would I not
>> be able to simply change the device tree to correct it ?
> CSPR is not in the device tree.  The physical address of each chipselect
> is in the device tree (via the ranges property on the IFC node) and that
> covers both the address portion of CSPR, and CSPR_EXT.
>
> What I do see missing from the driver is using CSPR_EXT to match the
> device, most likely because the initial IFC version didn't have
> CSPR_EXT.  Fixing that doesn't require a device tree change.

Ok ..

>
>>>>> The information that is missing from the device tree, that currently
>>>>> must come from boot software programming the registers, is the various
>>>>> attributes that get programmed in CSPR/CSOR.
>>>>>
>>>> Like I said mine doesn't do this, so it's required that it be set in an
>>>> alternative way. The only alternative we have currently is adding some
>>>> code to manually set the values but it's not ideal (and not upstreamable).
>>> I wouldn't have a problem merging code in a platform board file that
>>> writes a single register that a hard-to-update bootloader forgot to write.
>> I can submit it to you, but I would much prefer a general solution that
>> others can use without having to create board files. Our goal has been
>> to reduce board files as much as possible, do you not agree with that?
> I do agree that board files are not ideal, but they're still a
> reasonable place to put board-specific quirks.
>
> I don't want to put a half-measure into the main driver and pretend it's
> a general solution.  If the driver is to set the address, it should also
> set the rest of CSPR/CSOR, which requires that information to be added
> to the device tree.  If you want to propose the latter I have no problem
> with that, as long as compatibility is maintained.

I suspect that add the usage of cspr_ext into the driver would fix the 
issue we have. It reads like you would find that acceptable ?

I'm not really stuck on a particular device tree solution, but it was 
what we initial though of.

So you would support adding usage of of_address_to_resource to set the 
cspr and cspr_ext in the driver ?

Daniel
