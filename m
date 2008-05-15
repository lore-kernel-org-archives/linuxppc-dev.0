Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 May 2008 16:47:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [patch 2/4] powerpc: add i2c pins to dts and board setup
Message-ID: <20080515064753.GC30996@yookeroo.seuss>
References: <200805142312.m4ENCrIb026259@imap1.linux-foundation.org>
	<482B74D7.7080508@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <482B74D7.7080508@freescale.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 14, 2008 at 06:25:11PM -0500, Scott Wood wrote:
> akpm@linux-foundation.org wrote:
>> From: Jochen Friedrich <jochen@scram.de>
>>
>> Initialize I2C pins on boards with CPM1/CPM2 controllers.
>>
>> Signed-off-by: Jochen Friedrich <jochen@scram.de>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>  arch/powerpc/boot/dts/mpc8272ads.dts         |   10 ++++++++++
>>  arch/powerpc/boot/dts/mpc866ads.dts          |   10 ++++++++++
>>  arch/powerpc/boot/dts/mpc885ads.dts          |   10 ++++++++++
>>  arch/powerpc/platforms/82xx/mpc8272_ads.c    |    4 ++++
>>  arch/powerpc/platforms/8xx/mpc86xads_setup.c |    4 ++++
>>  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    3 +++
>>  6 files changed, 41 insertions(+)
>>
>> diff -puN arch/powerpc/boot/dts/mpc8272ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup arch/powerpc/boot/dts/mpc8272ads.dts
>> --- a/arch/powerpc/boot/dts/mpc8272ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup
>> +++ a/arch/powerpc/boot/dts/mpc8272ads.dts
>> @@ -217,6 +217,16 @@
>>  				linux,network-index = <1>;
>>  				fsl,cpm-command = <0x16200300>;
>>  			};
>> +
>> +			i2c@11860 {
>> +				compatible = "fsl,mpc8272-i2c",
>> +					     "fsl,cpm2-i2c",
>> +					     "fsl,cpm-i2c";
>> +				reg = <11860 20 8afc 2>;
>> +				interrupts = <1 8>;
>> +				interrupt-parent = <&PIC>;
>> +				fsl,cpm-command = <29600000>;
>> +			};
>
> As I pointed out earlier, this patch is sticking dts-v0 style constants  
> into a dts-v1 file.  It will not work.

Enough of this.  *Sends patch converting all remaining dts files to
v1*.  With any luck we can merge that soon, and forget about the
mistakes of v0 forever.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
