Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C7AAB6F1C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 06:07:03 +1100 (EST)
Message-ID: <4B3118A9.6000704@embedded-sol.com>
Date: Tue, 22 Dec 2009 21:06:17 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: I2C bus clock on MPC85XX systems
References: <4B30E7F5.8080201@embedded-sol.com>	<4B30F165.2060300@grandegger.com>	<4B310D10.4090307@embedded-sol.com>
	<4B311281.6020801@grandegger.com>
In-Reply-To: <4B311281.6020801@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Wolfgang

Wolfgang Grandegger wrote:
> Felix Radensky wrote:
>   
>> Hi, Wolfgang
>>
>> Wolfgang Grandegger wrote:
>>     
>>> Felix Radensky wrote:
>>>  
>>>       
>>>> Hi,
>>>>
>>>> Almost all MPC85XX based systems have the compatible=:"fsl-i2c" in
>>>> respective
>>>> i2c device tree nodes. This causes FSL i2c driver to use the following
>>>> "backward
>>>> compatible" values: FSR=0x31 DFSR=0x10. This is regardless of CCB clock
>>>> frequency and i2c clock prescaler.
>>>>
>>>> On my custom MPC8536 based board with 432MHz CCB clock this results in
>>>> 65KHz i2c clock frequency (checked with scope). U-Boot correctly
>>>> configures
>>>> the clock to 400KHz.
>>>>
>>>> I've fixed the problem by modifying device tree to use different
>>>> compatible value,
>>>> similar to what socrates board does. Is this the right approach ?
>>>>     
>>>>         
>>> Are you aware of the properties described in
>>> "Documentation/powerpc/dts-bindings/fsl/i2c.txt":
>>>
>>> http://lxr.linux.no/#linux+v2.6.32/Documentation/powerpc/dts-bindings/fsl/i2c.txt
>>>
>>>
>>> Wolfgang.
>>>
>>>   
>>>       
>> Sure, I'm aware of these properties. I've used
>>
>> compatible = "fsl,mpc8543-i2c", "fsl-i2c";
>> clock-frequency = <400000>;
>>
>> for my custom board.
>>
>> I think, however, that device trees for FSL reference designs should use
>> them as well, to avoid setting i2c
>> clock to some strange values. I may be wrong, but I think most custom
>>     
>
> The FSR=0x31 DFSR=0x10 are not strange values. They have been used in
> mainline kernels (< 2.6.30) for a long time.
>
>   
>> board developers borrow from
>> reference device trees, so having a sane starting point would help.
>>     
>
> The trees provided by Freescale are usually based on older kernel
> version. Borrow from such trees is OK, but the project developers should
> use a recent kernel version for development.
>   

I was talking about modern vanilla kernels for Freescale reference 
boards. See, for example
http://lxr.linux.no/#linux+v2.6.32/arch/powerpc/boot/dts/mpc8536ds.dts

Felix.
