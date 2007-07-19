Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71AB3DDE34
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 00:55:02 +1000 (EST)
In-Reply-To: <469E408F.1080300@freescale.com>
References: <20070718013538.GB15238@ld0162-tx32.am.freescale.net>
	<8DC2DA02-3D10-4D14-AC91-E34AEA68E04F@kernel.crashing.org>
	<469E408F.1080300@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <624A5740-A6D3-4AF3-8AA7-100D0FFFF045@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 30/61] fsl_soc: Update the way get_brgfreq() finds things
	in the device tree.
Date: Thu, 19 Jul 2007 09:55:32 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2007, at 11:32 AM, Scott Wood wrote:

> Kumar Gala wrote:
>>> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/  
>>> boot/dts/mpc8272ads.dts
>>> index 4d09dca..16a77f4 100644
>>> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
>>> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
>>> @@ -119,12 +119,11 @@
>>>              #address-cells = <1>;
>>>              #size-cells = <1>;
>>>              #interrupt-cells = <2>;
>>> -            device_type = "cpm";
>>> -            model = "CPM2";
>>> +            compatible = "fsl,mpc8272-cpm", "fsl,cpm2", "fsl,cpm";
>> Does 'fsl,cpm' really mean anything useful?
>
> Yes.  It's can't be used on its own to show the complete  
> programming model, but there are lots of common things that it does  
> indicate.
>
> get_brgfreq() uses it to locate nodes which have an fsl,brg- 
> frequency property.

I think we should introduce 'fsl,cpm' in a second pass once its clear  
what all the common points are.  We can than also see if QE fits into  
it at that point.

>
>>>              ranges = <00000000 00000000 20000>;
>>>              reg = <0 20000>;
>>>              command-proc = <119c0>;
>>> -            brg-frequency = <17D7840>;
>>> +            fsl,brg-frequency = <d#25000000>;
>> Leave brg-frequency, and make a note about it being deprecated.
>
> The CPM binding is changed in so many other ways that are much  
> harder to make backward compatible that I don't really see much  
> point in doing so here.

Can you enumerate some of the other changes.

>> Also, take a look at QE it has a similar concept.
>
> It'd be nice to extend this binding to include QE (and at some  
> point down the road, merge the code)...  I just didn't have time  
> this time around.

Understand.

As I stated above, I think we should drop 'fsl,cpm' for now until we  
can come up with a good defn. of what it means rather than a  
convenience to mean (fsl-cpm2 and fsl-cpm1).

- k
