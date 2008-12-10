Return-Path: <wmb@firmworks.com>
Message-ID: <493F7D99.5070400@firmworks.com>
Date: Tue, 09 Dec 2008 22:28:09 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] ndfc driver
References: <20081203222832.3fc77d28@lappy.seanm.ca>	<20081204090107.20269571@zod.rchland.ibm.com>	<20081208193446.37e27e26@lappy.seanm.ca>	<20081209021115.GA13948@oksana.dev.rtsoft.ru>	<20081208214512.461276d2@lappy.seanm.ca>	<20081208223227.19a702a9@zod.rchland.ibm.com>	<20081208235437.08323e3a@lappy.seanm.ca>	<493E24D8.6040406@firmworks.com>
	<20081209230135.35e1b9d1@lappy.seanm.ca>
In-Reply-To: <20081209230135.35e1b9d1@lappy.seanm.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> n Mon, 08 Dec 2008 21:57:12 -1000
> "Mitch Bradley" <wmb@firmworks.com> wrote:
>
>   
>> > One address/size cell isn't enough for the next generation of NAND
>> > FLASH chips.
>> > 
>>     
>
> I am no dts expert, but I thought I could put:
>
> 	nand {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
>
> in my dts and you could put:
>
> 	nand {
> 		#address-cells = <2>;
> 		#size-cells = <2>;
>
> and, assuming we specified the reg entry right, everything would just
> work. Is that assumption wrong?
>
> And if the assumption is true, should I make a note in the doc that you
> can make the address and size bigger?
>
> Cheers,
>    Sean
>
>   


In principle that is correct, but the device tree partition parser in 
the Linux kernel assumes one address cell and one size cell, or at least 
it did the last time I looked.

I wrote a patch to fix that and circulated it on the linuxppc list, but 
since lost interest. OLPC (my main focus) is probably going to switch to 
managed NAND (SSD, LBA-NAND, eMMC, or some such thing with a built-in 
Flash Translation Layer) at some point.  Raw NAND is starting to go by 
the wayside.
