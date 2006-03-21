Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2215767A00
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 05:20:59 +1100 (EST)
In-Reply-To: <20060321114806.6bcf3885.kim.phillips@freescale.com>
References: <20060320195945.004fdf26.kim.phillips@freescale.com>
	<200603202014.44879.hollis@penguinppc.org>
	<20060321114806.6bcf3885.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3C6218C3-3FC0-437E-A798-3AD6FEB69713@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add FSL SEC node to documentation
Date: Tue, 21 Mar 2006 12:21:47 -0600
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 21, 2006, at 11:48 AM, Kim Phillips wrote:

> On Mon, 20 Mar 2006 20:14:43 -0600
> Hollis Blanchard <hollis@penguinppc.org> wrote:
>
>> On Monday 20 March 2006 19:59, Kim Phillips wrote:
>>> diff --git a/Documentation/powerpc/booting-without-of.txt
>> b/Documentation/powerpc/booting-without-of.txt
>>> index d02c649..72f3241 100644
>>> --- a/Documentation/powerpc/booting-without-of.txt
>>> +++ b/Documentation/powerpc/booting-without-of.txt
>>> @@ -1365,6 +1365,79 @@ platforms are moved over to use the flat
>>>       };
>>>
>>>
>>> +   g) Freescale SOC SEC Security Engines
>>> +
>>> +   Required properties:
>>> +
>>> +    - device_type : Should be "crypto"
>>> +    - model : Model of the device.  Should be "SEC1" or "SEC2"
>>> +    - compatible : Should be "talitos"
>> [snip]
>>
>> Have you consulted with any other vendors regarding these  
>> properties? I know
>> there is no IEEE1275 binding for these sorts of devices, but we  
>> can at least
>> attempt to standardize it (even in the absence of the Open  
>> Firmware Working
>> Group)...
>>
>> -Hollis
>
> I took a look at some equivalent devices, the problem is they're  
> all so different, architecturally.  otoh, I'm open to collaborate  
> with others on the list in an effort to standardize it.
>
> btw, I had omitted some descriptor types.  Here's a replacement patch:
>
>
> Documentation: Added FSL SOC SEC node definition
>
> Updated the documentation to include the definition of the SEC device
> node format for Freescale SOC devices.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>
> ---
> commit 97d971c1d30e77a453cacaef72c32e00381ab02a
> tree 4b815caece1c05b33309f8852eeccd90f020ca49
> parent c4a1745aa09fc110afdefea0e5d025043e348bae
> author Kim Phillips <kim.phillips@freescale.com> Mon, 20 Mar 2006  
> 19:31:21 -0600
> committer Kim Phillips <kim.phillips@freescale.com> Mon, 20 Mar  
> 2006 19:31:21 -0600
>
>  Documentation/powerpc/booting-without-of.txt |   73 +++++++++++++++ 
> +++++++++++
>  1 files changed, 73 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index d02c649..72f3241 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1365,6 +1365,79 @@ platforms are moved over to use the flat
>  	};
>
>
> +   g) Freescale SOC SEC Security Engines
> +
> +   Required properties:
> +
> +    - device_type : Should be "crypto"
> +    - model : Model of the device.  Should be "SEC1" or "SEC2"
> +    - compatible : Should be "talitos"
> +    - reg : Offset and length of the register set for the device
> +    - interrupts : <a b> where a is the interrupt number and b is a
> +      field that represents an encoding of the sense and level
> +      information for the interrupt.  This should be encoded based on
> +      the information in section 2) depending on the type of  
> interrupt
> +      controller you have.
> +    - interrupt-parent : the phandle for the interrupt controller  
> that
> +      services interrupts for this device.
> +    - num-channels : An integer representing the number of channels
> +      available.  Most modern SEC's have 4 channels.

Drop the part about Most modern... in five years when someone reads  
this it will not be modern anymore.

> +    - channel-fifo-len : An integer representing the number of  
> descriptor
> +      pointers each channel fetch fifo can hold.  Most modern SEC  
> channel
> +      fetch fifos can hold 24 descriptor pointers.

ditto about modern.

> +    - exec-units-mask : The bitmask representing what execution  
> units (EUs)
> +      are available. It's a single 32 bit cell. EU information  
> should be
> +      encoded following the SEC's Descriptor Header Dword EU_SEL0  
> field
> +      documentation, i.e. as follows:
> +
> +        bit 0 = reserved - should be 0
> +        bit 1 = set if SEC has the ARC4 EU (AFEU)
> +        bit 2 = set if SEC has the DES/3DES EU (DEU)
> +        bit 3 = set if SEC has the message digest EU (MDEU)
> +        bit 4 = set if SEC has the random number generator EU (RNG)
> +        bit 5 = set if SEC has the public key EU (PKEU)
> +        bit 6 = set if SEC has the AES EU (AESU)
> +        bit 7 = set if SEC has the Kasumi EU (KEU)
> +
> +      bits 8 through 31 are reserved for future SEC EUs.
> +
> +    - descriptor-types-mask : The bitmask representing what  
> descriptors
> +      are available. It's a single 32 bit cell. Descriptor type  
> information
> +      should be encoded as follows:
> +
> +        bit 0  = set if SEC supports the aesu_ctr_nonsnoop  
> descriptor type
> +        bit 1  = set if SEC supports the ipsec_esp descriptor type
> +        bit 2  = set if SEC supports the common_nonsnoop  
> descriptor type
> +        bit 3  = set if SEC supports the 802.11i AES ccmp  
> descriptor type
> +        bit 4  = set if SEC supports the hmac_snoop_no_afeu  
> descriptor type
> +        bit 5  = set if SEC supports the srtp descriptor type
> +        bit 6  = set if SEC supports the non_hmac_snoop_no_afeu  
> descriptor type
> +        bit 7  = set if SEC supports the pkeu_assemble descriptor  
> type
> +        bit 8  = set if SEC supports the aesu_key_expand_output  
> descriptor type
> +        bit 9  = set if SEC supports the pkeu_ptmul descriptor type
> +        bit 10 = set if SEC supports the common_nonsnoop_afeu  
> descriptor type
> +        bit 11 = set if SEC supports the pkeu_ptadd_dbl descriptor  
> type
> +
> +      ..and so on and so forth, following the SEC's Descriptor  
> Header Dword
> +      DESC_TYPE field definition in reference documentation.

Would this be a bit more clear, if you explicitly stated that the  
DESC_TYPE value directly corresponds to the bit encoding, like you  
did for EU_SEL0.

> +
> +  Example:
> +
> +	/* MPC8548E */
> +	crypto@30000 {
> +		device_type = "crypto";
> +		model = "SEC2";
> +		compatible = "talitos";
> +		reg = <30000 10000>;
> +		interrupts = <1d 3>;
> +		interrupt-parent = <40000>;
> +		num-channels = <4>;
> +		channel-fifo-len = <24>;
> +		exec-units-mask = <000000fe>;
> +		descriptor-types-mask = <073f1127>;
> +	};
> +
> +
>     More devices will be defined as this spec matures.
>
>
>
>
>
> -- 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
