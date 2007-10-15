Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D88F9DE9FD
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 01:57:36 +1000 (EST)
Date: Mon, 15 Oct 2007 19:57:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [RFC][POWERPC] MPC8568E-MDS: create localbus node
Message-ID: <20071015155730.GA30008@localhost.localdomain>
References: <20071015153525.GA28761@localhost.localdomain>
	<47138A54.8030307@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47138A54.8030307@ru.mvista.com>
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

On Mon, Oct 15, 2007 at 07:42:12PM +0400, Sergei Shtylyov wrote:
> Anton Vorontsov wrote:
>
>> This patch creates localbus node, moves bcsr into it, and adds
>> localbus to the probe path.
>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
>> diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts 
>> b/arch/powerpc/boot/dts/mpc8568mds.dts
>> index 5439437..296adc3 100644
>> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
>> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
>> @@ -42,9 +42,17 @@
>>  		reg = <00000000 10000000>;
>>  	};
>>  -	bcsr@f8000000 {

Heh, this is wrong.

>> -		device_type = "board-control";
>> -		reg = <f8000000 8000>;
>> +	localbus@f0000000 {
>> +		compatible = "fsl,mpc8568mds-localbus";
>
>    Is the entity described as "localbus" indeed so *board* specific?

That's what booting-without-of.txt gives as an example.

>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		reg = <f0000000 10000000>;
>> +		ranges = <0 0 f8000000 0008000>;
>
>    Isn't that range a part of "reg"?

Heh. Right you are.

>> +
>> +		bcsr@0,0 {

Hrm, wrong.

>> +			device_type = "board-control";
>> +			reg = <0 0 8000>;
>> +		};
>>  	};
>>   	soc8568@e0000000 {
>
> WBR, Sergei

I'll repost fixed version shortly.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
