Return-Path: <danielwa@cisco.com>
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlj3Q6YbczDr0V
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 01:58:58 +1000 (AEST)
Subject: Re: t1040 IFC flash driver Extended Chip Select
To: Scott Wood <scott.wood@nxp.com>, Raghav Dogra <raghav.dogra@nxp.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Jaiprakash Singh <b44839@freescale.com>, Scott Wood
 <scottwood@freescale.com>, Lijun Pan <Lijun.Pan@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>
References: <577D68B8.8020305@cisco.com>
 <DB5PR0401MB1928C329F9B0FF9AAF5A607B913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <577E79D4.1010709@cisco.com>
Date: Thu, 7 Jul 2016 08:48:36 -0700
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB1928C329F9B0FF9AAF5A607B913B0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2016 05:57 PM, Scott Wood wrote:
> On 07/06/2016 03:23 PM, Daniel Walker wrote:
>> Hi,
>>
>> We are using the t1040 platform, and we have found that we need to
>> populate this register. In the Technical Reference Manual it's
>> description is section 24.3.2. This option appears in the driver, but it
>> doesn't appears to be used anyplace.
> I'm not sure what you mean by "in the driver".  U-boot sets these registers.

My hardware doesn't use u-boot , and it doesn't set these values. 
However, there are other reasons to have this. For example, you use 
u-boot but it's got a defect which sets the values incorrectly. You may 
not be able to update your bootloader on a shipped product.

>
>> We we're considered adding something to the device tree to allow
>> populating this value, but I'm wondering if any of you have specific
>> considerations on how this is done. Or maybe it's not needed at all, and
>> we're just missing something.
>>
>> (not a good patch, just an example.)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
>> b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
>> index 89427b0..b506001 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
>> @@ -24,6 +24,8 @@ Properties:
>>    - ranges : Each range corresponds to a single chipselect, and covers
>>               the entire access window as configured.
>>
>> +- cspr_ext : This value sets the extended chip select for all banks.
> I see no reason to put this here.  Boot software should be setting the
> chipselect registers, and if for some reason you don't want to do that,
> you could just translate the address through ranges to find the value to
> write.  Why would you have the binding assume it's the same for all banks?

It was only an example, to start the conversation. I don't understand 
what you mean by translating the address thru ranges?

>
> The information that is missing from the device tree, that currently
> must come from boot software programming the registers, is the various
> attributes that get programmed in CSPR/CSOR.
>

Like I said mine doesn't do this, so it's required that it be set in an 
alternative way. The only alternative we have currently is adding some 
code to manually set the values but it's not ideal (and not upstreamable).

Daniel
