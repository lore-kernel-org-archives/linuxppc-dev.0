Return-Path: <gerickson@nuovations.com>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
	by ozlabs.org (Postfix) with SMTP id C0B38DDF23
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 11:09:21 +1100 (EST)
Date: Wed, 17 Dec 2008 16:09:05 -0800
Subject: Re: [PATCH] powerpc/4xx: DTS: Add Add'l SDRAM0 Compatible and
	Interrupt Info
From: Grant Erickson <gerickson@nuovations.com>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <C56ED4A1.1380F%gerickson@nuovations.com>
In-Reply-To: <20081217234610.GA11185@yookeroo.seuss>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/17/08 3:46 PM, David Gibson wrote:
> On Wed, Dec 17, 2008 at 11:56:07AM -0800, Grant Erickson wrote:
>> Added additional information for type and compatibility strings and
>> interrupt information to the SDRAM0 memory-controller device tree
>> nodes for AMCC PowerPC 405EX[r]-based boards to facilitate binding
>> with the new "ibm,sdram-4xx-ddr2" EDAC memory controller adapter driver.
>> 
>> Signed-off-by: Grant Erickson <gerickson@nuovations.com>
>> ---
>> As support in the associated EDAC adapter driver is added over time,
>> similar changes will/should be made to the DTS files for boards
>> leveraging realizations of this "ibm,sdram-4xx-ddr2" controller,
>> including the 440SP, 440SPe, 460EX, 460GT and 460SX.
>> 
>>  arch/powerpc/boot/dts/haleakala.dts |   11 ++++++++++-
>>  arch/powerpc/boot/dts/kilauea.dts   |   11 ++++++++++-
>>  arch/powerpc/boot/dts/makalu.dts    |   11 ++++++++++-
>>  3 files changed, 30 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/powerpc/boot/dts/haleakala.dts
>> b/arch/powerpc/boot/dts/haleakala.dts
>> index 513bc43..e45ce7e 100644
>> --- a/arch/powerpc/boot/dts/haleakala.dts
>> +++ b/arch/powerpc/boot/dts/haleakala.dts
>> @@ -89,8 +89,17 @@
>> clock-frequency = <0>; /* Filled in by U-Boot */
>>  
>> SDRAM0: memory-controller {
>> -   compatible = "ibm,sdram-405exr";
>> +   device_type = "memory-controller";
> 
> This should not have a device_type.

I'm still growing my device tree expertise. Can you elaborate on why SDRAM0
shouldn't be described generically as a "memory-controller" device in the
same way the EMAC0 is generically described as a "network" device? A URL to
said elaboration would be sufficient.

>> +   compatible = "ibm,sdram-405exr", "ibm,sdram-4xx-ddr2";
>> dcr-reg = <0x010 0x002>;
>> +   #address-cells = <0>;
>> +   #size-cells = <0>;
> 
> This seems odd.  These should only be present if the node does, or at
> least can, have subnodes - I don't see that it would.

See above qualifier; will remove.

Thanks for the prompt review!

Regards,

Grant
