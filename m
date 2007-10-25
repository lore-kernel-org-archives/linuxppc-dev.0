Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id B1353DDED4
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 01:46:51 +1000 (EST)
Message-ID: <4720BA4B.5090707@semihalf.com>
Date: Thu, 25 Oct 2007 17:46:19 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 05/11] [POWERPC] TQM5200 DTS
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>	<20071023231333.29359.35252.stgit@hekate.izotz.org>	<13403420.post@talk.nabble.com>
	<fa686aa40710250653o6e7df26y1890d5c485a6d508@mail.gmail.com>
In-Reply-To: <fa686aa40710250653o6e7df26y1890d5c485a6d508@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org, Martin Krause <Martin.Krause@tqs.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 10/25/07, Martin Krause <Martin.Krause@tqs.de> wrote:
>>
>> < +             flash@00000000 {
>> < +                     compatible = "cfi-flash";
>> < +                     reg = <00000000 02000000>;
>> < +                     bank-width = <4>;
>> < +                     device-width = <2>;
>> < +                     #size-cells = <1>;
>> < +                     #address-cells = <1>;
>> < +                     partition@0 {
>> < +                             label = "firmware";
>> < +                             reg = <0 a0000>;
>> < +                     };
>> < +                     partition@a0000 {
>> < +                             label = "dtb";
>> < +                             reg = <a0000 20000>;
>> < +                     };
>> < +                     partition@c0000 {
>> < +                             label = "kernel";
>> < +                             reg = <c0000 240000>;
>> < +                     };
>> < +                     partition@300000 {
>> < +                             label = "initrd";
>> < +                             reg = <300000 200000>;
>> < +                     };
>> < +                     partition@500000 {
>> < +                             label = "small-fs";
>> < +                             reg = <500000 400000>;
>> < +                     };
>> < +                     partition@900000 {
>> < +                             label = "misc";
>> < +                             reg = <900000 800000>;
>> < +                     };
>> < +                     partition@1100000 {
>> < +                             label = "big-fs";
>> < +                             reg = <1100000 f00000>;
>> < +                     };
>> < +             };
>> < +     };
>>
>> This MTD layout only works on boards with 32 MiB (or 64 MiB) flash
>> memory. On TQM5200 boards with smaller Flashes (16 MiB, 8 MiB and 4 MiB)
>> the MTD partition borders do not match with the physikal memory borders.
> 
> If there is a variant board with a different configuration, then the
> device tree needs to be changed for that variant board; either by
> having multiple .dts files in arch/powerpc/boot/dts or by having the
> bootloader populate the correct information.  A dtb as passed to the
> kernel must exactly represent the hardware.
> 
> That also means that there is going to be a different flash map for
> each possible flash size configuration.

Agree, that's one particular configuration (I guess I should add
proper comment), that should be updated if needed. But I'am not sure
if we should have multiple .dts files if it's only flash layout that
changes.

>> On a board with 16 MiB FLASH for example the "big-fs" _and_ the "misc"
>> partition could not be used. "big-fs", because the memory is too small
>> (which is OK) and "misc", because it overlaps 1 MiB over the physikal
>> flash border. So only the first 9 MiB of the flash could be used in Linux.
>> The remaining 7 MiB couldn't be accessed.
> 
> Perhaps it would be better to drop the flash layout from the in-kernel
> dts files entirely since flash layout can be a fluid thing.

Well, but that would not be really user friendly, I'd rather stick
with some default config.

m.
