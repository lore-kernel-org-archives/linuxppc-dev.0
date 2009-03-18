Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3F21DDDEE7
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 18:35:04 +1100 (EST)
Message-ID: <49C0A422.3040704@grandegger.com>
Date: Wed, 18 Mar 2009 08:34:58 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/4] powerpc/85xx: TQM8548: Update DTS file for	multi-chip
	support
References: <1237281143-8768-1-git-send-email-wg@grandegger.com>
	<1237281143-8768-2-git-send-email-wg@grandegger.com>
	<1237281143-8768-3-git-send-email-wg@grandegger.com>
	<1237281143-8768-4-git-send-email-wg@grandegger.com>
	<1237281143-8768-5-git-send-email-wg@grandegger.com>
	<20090317192341.GB4287@oksana.dev.rtsoft.ru>
In-Reply-To: <20090317192341.GB4287@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Tue, Mar 17, 2009 at 10:12:22AM +0100, Wolfgang Grandegegr wrote:
>> From: Wolfgang Grandegger <wg@grandegger.com>
>>
>> This patch adds multi-chip support for the Micron MT29F8G08FAB NAND
>> flash memory on the TQM8548 modules.
>>
>> This patch should go through the powerpc/85xx channel.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>  arch/powerpc/boot/dts/tqm8548.dts |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
>> index 81d3fbb..e5c3c67 100644
>> --- a/arch/powerpc/boot/dts/tqm8548.dts
>> +++ b/arch/powerpc/boot/dts/tqm8548.dts
>> @@ -389,6 +389,11 @@
>>  			reg = <3 0x0 0x800>;
>>  			fsl,upm-addr-offset = <0x10>;
>>  			fsl,upm-cmd-offset = <0x08>;
>> +			wait-flags = <0x05>;
> 
> Should be at least fsl,upm-wait-flags. (And the flags should
> be documented in dts-bindings ;-).

OK.

>> +			/* Multi-chip device */
>> +			fsl,upm-mar-chip-offset = <0x200>;
>> +			max-chips = <2>;
> 
> num-chips would be more appropriate, no?

Yep.

> 
>> +			chip-offset = <0x200>;
> 
> I believe this is from some old code...

No, it's the address offset between the multiple chips. As Kumar already
pointed out, I also need to document the new properties.

Wolfgang.
