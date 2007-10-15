Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C350DE10A
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 04:00:27 +1000 (EST)
In-Reply-To: <4713A474.1000301@ru.mvista.com>
References: <20071015155730.GA30008@localhost.localdomain>
	<20071015161631.GB30512@localhost.localdomain>
	<4713A474.1000301@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F248D8A0-B412-41B8-B7F8-FD158576785D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] [POWERPC] MPC8568E-MDS: add support for flash
Date: Mon, 15 Oct 2007 13:00:24 -0500
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 15, 2007, at 12:33 PM, Sergei Shtylyov wrote:

> Anton Vorontsov wrote:
>
>> MPC8568E-MDS have 1 32MB Spansion x16 CFI flash chip. Let's use it.
>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
>> diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/ 
>> boot/dts/mpc8568mds.dts
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
>>
>>  		bcsr@1,0 {
>>  			device_type = "board-control";
>>  			reg = <1 0 8000>;
>>  		};
>> +
>> +		flash@0,0 {
>> +			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
>> +			reg = <0 0 2000000>;
>> +			probe-type = "CFI";
>
>     I don't get it -- has physmap_of.c rewrite been already committed?
> If yes, you don't need probe_type; if no, your "compatible" won't  
> work...
> Well, I see that the driver rewrite has been committed (when I  
> wasn't looking
> 8-)...

Any NOR flash nodes should conform to the "new" bindings from David  
Gibson, et al.  Not sure about the status of those being in  
physmap_of.c w/regards to 2.6.24.

- k
