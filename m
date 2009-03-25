Return-Path: <wg@grandegger.com>
Message-ID: <49CA9899.30604@grandegger.com>
Date: Wed, 25 Mar 2009 21:48:25 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 3/4] powerpc: NAND: FSL UPM: document new bindings
References: <1237975701-23201-1-git-send-email-wg@grandegger.com>	<1237975701-23201-2-git-send-email-wg@grandegger.com>	<1237975701-23201-3-git-send-email-wg@grandegger.com>	<1237975701-23201-4-git-send-email-wg@grandegger.com>
	<fa686aa40903251048g479d63f8i5a715defdbfc33d4@mail.gmail.com>
In-Reply-To: <fa686aa40903251048g479d63f8i5a715defdbfc33d4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> (cc'ing devicetree-discuss)
> 
> On Wed, Mar 25, 2009 at 4:08 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> This patch adds documentation for the new NAND FSL UPM bindings for:
>>
>>  NAND: FSL-UPM: add multi chip support
>>  NAND: FSL-UPM: Add wait flags to support board/chip specific delays
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> 
> Mostly looks good to me; but some comments below.
> 
>> ---
>>  .../powerpc/dts-bindings/fsl/upm-nand.txt          |   39 +++++++++++++++++++-
>>  1 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt b/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
>> index 84a04d5..0272e70 100644
>> --- a/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
>> +++ b/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
>> @@ -5,9 +5,22 @@ Required properties:
>>  - reg : should specify localbus chip select and size used for the chip.
>>  - fsl,upm-addr-offset : UPM pattern offset for the address latch.
>>  - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
>> -- gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
>>
>> -Example:
>> +Optional properties:
>> +- fsl,upm-wait-flags : add chip-dependent short delays after running the
>> +                      UPM pattern (0x1), after writing a data byte (0x2)
>> +                      or after writing out a buffer (0x4).
>> +- gpios : may specify optional GPIOs connected to the Ready-Not-Busy pins
>> +         (R/B#). For multi-chip devices, "num-chips" GPIO definitions are
>> +         required.
>> +- chip-delay : chip dependent delay for transfering data from array to
>> +              read registers (tR). Required if property "gpios" is not
>> +              used (R/B# pins not connected).
>> +- num-chips : number of chips per device for multi-chip support.
>> +- chip-offset : address offset between chips for multi-chip support. The
>> +               corresponding address lines are used to select the chip.
> 
> Since these properties (chip-delay, num-chips and chip-offset) are
> currently controller specific, it would probably be a good idea to
> prefix 'fsl,' onto them.  That way when common NAND controller
> properties start getting defined then there won't be any concern about
> conflicting with existing meanings.  If you do see these as properties
> that other NAND controllers will use, then maybe a 'nand-' prefix is
> appropriate (like the SPI binding in booting-without-of).

The chip-delay is NAND device specific. The proper value can be find in
the data sheet. num-chip is also quite generic. A prefix 'nand-' would
be fine for me. But fsl,upm-chip-offset would be more appropriate than
just chip-offset, indeed.

> For the chip offset, it's not clear what the meaning is.  First, does
> the UPM controller support access of multiple chips simultaneously?

The offset drives the corresponding address lines, which are used to
select the chip. That's how it's done on the TQM8548 board. In
principle, the chips could also be selected through dedicated GPIO pins.
Well, I'm not a hardware guy.

> If so, then can you elaborate in the description on how board design
> translates to a chip-offset value.  If it cannot, then it might be
> better to have multiple tuples in the 'reg' property for each discrete
> chip.  Multiple reg tuples would also remove the need for the
> num-chips property.

The node still describes one device mapping all relevant control
registers. How about using fsl,upm-chip-offsets = <0x200 0x400>. It
would be more generic and makes num-chips obsolete as well. And the
property would be reserved for that way of implementing the chip select
in hardware.

Wolfgang.
