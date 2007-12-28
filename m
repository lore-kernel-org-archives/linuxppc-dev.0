Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 724DCDDE00
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 07:55:38 +1100 (EST)
Message-ID: <477562C9.8000805@pikatech.com>
Date: Fri, 28 Dec 2007 15:55:37 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: External int in dts
References: <47753CD3.3000209@pikatech.com> <200712282012.56516.sr@denx.de>
In-Reply-To: <200712282012.56516.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Friday 28 December 2007, Sean MacLennan wrote:
>   
>> I have an FPGA which uses external int 1, which is interrupt 24 on UIC0.
>> I tried the following entry in various places:
>>
>>         FPGA0: fpga {
>>             compatible = "pika,fpga";
>>             interrupts = <18 4>;
>>     
>
> Is the interrupt level sensitive and active high? Then "4" is correct here. 
> But if it is active low then you should use "8" here".
>   
It was active low. Thank you.

I got it working. You do need some glue logic. Basically the following 
two lines (ignoring all error checking):

 np = of_find_compatible_node(NULL, NULL, "pika,fpga");
 irq = irq_of_parse_and_map(np, 0);

Simple!

Cheers,
   Sean
