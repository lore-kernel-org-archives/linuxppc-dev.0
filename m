Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070924050709.GM8058@localhost.localdomain>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E067DB91-3047-4924-967D-AA63D091DE4B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Date: Mon, 24 Sep 2007 01:13:05 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 24, 2007, at 12:07 AM, David Gibson wrote:

> On Fri, Sep 21, 2007 at 09:35:03AM +0200, Peter Korsgaard wrote:
>>>>>>> "Scott" == Scott Wood <scottwood@freescale.com> writes:
>>
>> Hi,
>>
>>  Scott> #size-cells is zero on i2c, so it should just be reg = <68>.
>>
>>  Scott> You'll probably need to add #address-cells and #size-cells  
>> to the
>>  Scott> controller node, as well.
>
> Uh.. yes.. i2c interfaces should really always have #a and #s.
>
>> Ahh - Thanks. This should be better.
>> ---
>>
>> [PATCH] mpc8349emitx.dts: Add ds1339 RTC
>>
>> Add ds1339 I2C RTC chip as child of 2nd I2C controller.
>>
>> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>> ---
>>  arch/powerpc/boot/dts/mpc8349emitx.dts |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> Index: linux/arch/powerpc/boot/dts/mpc8349emitx.dts
>> ===================================================================
>> --- linux.orig/arch/powerpc/boot/dts/mpc8349emitx.dts
>> +++ linux/arch/powerpc/boot/dts/mpc8349emitx.dts
>> @@ -62,12 +62,21 @@
>>  		};
>>
>>  		i2c@3100 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>>  			device_type = "i2c";
>
> Hrm... we probably want an "i2c" device_type class, but I don't think
> we've actually defined one, which is a prob

suggestions on how to handle this?  We've described that fsl-i2c  
nodes in booting-without-of.txt should have it. (which may have been  
wrong at the time).

- k

>
>>  			compatible = "fsl-i2c";
>>  			reg = <3100 100>;
>>  			interrupts = <f 8>;
>>  			interrupt-parent = < &ipic >;
>>  			dfsrr;
