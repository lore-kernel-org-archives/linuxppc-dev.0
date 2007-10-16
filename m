Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 02C75DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 20:55:45 +1000 (EST)
Date: Tue, 16 Oct 2007 14:55:32 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 2/2] [POWERPC] MPC8568E-MDS: add support for flash
Message-ID: <20071016105532.GB1169@localhost.localdomain>
References: <20071015155730.GA30008@localhost.localdomain>
	<20071015161631.GB30512@localhost.localdomain>
	<4713A474.1000301@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4713A474.1000301@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 09:33:40PM +0400, Sergei Shtylyov wrote:
> Anton Vorontsov wrote:
>
>> MPC8568E-MDS have 1 32MB Spansion x16 CFI flash chip. Let's use it.
>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
>> diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts 
>> b/arch/powerpc/boot/dts/mpc8568mds.dts
>> index 8e15dba..1198363 100644
>> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
>> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
>> @@ -47,12 +47,45 @@
>>  		#address-cells = <2>;
>>  		#size-cells = <1>;
>>  		reg = <e0005000 d8>;
>> -		ranges = <1 0 f8000000 0008000>;
>> +		ranges = <1 0 f8000000 0008000
>> +			  0 0 fe000000 2000000>;
>>   		bcsr@1,0 {
>>  			device_type = "board-control";
>>  			reg = <1 0 8000>;
>>  		};
>> +
>> +		flash@0,0 {
>> +			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
>> +			reg = <0 0 2000000>;
>> +			probe-type = "CFI";
>
>    I don't get it -- has physmap_of.c rewrite been already committed?
> If yes, you don't need probe_type; if no, your "compatible" won't work...

I see.

/* Helper function to handle probing of the obsolete "direct-mapped"
 * compatible binding, which has an extra "probe-type" property [...]

Obsolete, very good.

> Well, I see that the driver rewrite has been committed (when I wasn't 
> looking 8-)...
>> +			bank-width = <2>;
>> +			device-width = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			hrcw@0 {
>> +				label = "hrcw";
>> +				reg = <0 20001>;
>
>    What?! Odd sized partition? Don't try to follow both the old and new 
> partition device tree specs -- you'll only get yourself into trouble with 
> this.  The size-cell doesn't bear r/o flag in the new paritions spec.

Thanks for spotting this. It's, of course, forward-porting "thinko".

>> +				read-only;
>> +			};
>> +
>> +			kernel@20000 {
>> +				label = "kernel";
>> +				reg = <20000 200000>;
>> +			};
>> +
>> +			rootfs@220000 {
>> +				label = "rootfs";
>> +				reg = <220000 1d60000>;
>> +			};
>> +
>> +			uboot@1f80000 {
>> +				label = "u-boot";
>> +				reg = <1f80000 80000>;
>> +				read-only;
>
>    Well, this is not even consistent... :-)

Yup, it was a thinko in the hrcw node, not something I really
meant to spread over all ro nodes.

>> +			};
>> +		};
>>  	};
>
> WBR, Sergei

Much thanks for the review,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
