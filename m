Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D78DBDDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 14:07:50 +1100 (EST)
In-Reply-To: <000b01c746cf$35accc40$6405a8c0@absolut>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
	<0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
	<000001c7454b$69a25ae0$6405a8c0@absolut>
	<0A655A39-4101-48B4-BE9C-50A30163679C@kernel.crashing.org>
	<000701c7457a$d180e300$6405a8c0@absolut>
	<183E66A5-E983-4D17-96E9-2EEAE6FDF7B6@kernel.crashing.org>
	<000f01c74587$10bc5cf0$6405a8c0@absolut>
	<1546691E-0CCF-41C9-8B8A-7C6326CEEF7E@kernel.crashing.org>
	<000301c7458b$b9eb1330$6405a8c0@absolut>
	<829261C6-F534-4B85-A04D-8D280E46B2CF@kernel.crashing.org>
	<000401c74591$8a3a4ec0$6405a8c0@absolut>
	<BC5846DA-A217-43B7-8060-6EA05CC62913@kernel.crashing.org>
	<000801c7460d$211e46e0$6405a8c0@absolut>
	<974C77BD-19A0-4843-8E7B-3B430DB4ADE9@kernel.crashing.org>
	<001101c74629$28797380$6405a8c0@absolut>
	<AF782BFC-5262-462B-A522-8F685DC59158@kernel.crashing.org>
	<001001c74674$b17bf4f0$6405a8c0@absolut>
	<567B131D-57F5-4972-AF09-5373D041368C@kernel.crashing.org>
	<000b01c746cf$35a! ccc40$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F0A735A1-FC11-477B-8C89-616C38CFA7C1@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: 8360E - PCI / DTC Blob Setup
Date: Wed, 7 Feb 2007 21:07:25 -0600
To: rmcguire@videopresence.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 2, 2007, at 07:36, Russell McGuire wrote:

>
> Well I am getting smarter on this:
>
> I have read through the PCI Bridge Specs and found another issue  
> that might
> have been causing a problem with the IDSEL lines. Unless you are  
> interested
> I'll forgo that explanation and just go with fact that I have  
> changed the
> IDSEL mappings to be legal when they are issued from the 83xx.
>
> I have changed the IDSELs to be as follows, does this look correct?
> I agree with placing the NODE for the bridge into the dts file to be
> correct. Except I get stuck immediately at trying to come up with an
> address. I.e. the PCI host has a PCI@8500, which makes sense. But  
> the Bridge
> chip doesn't have a mapped address to place in the file. I did read  
> the PCI
> OF node spec <dated 1996> it hints that PCI-PCI bridges are  
> essentially the
> same domain and may not need translation.
>
> Another concern I have now is that the interrupt mask may be  
> incorrect.
> i.e. currently it is <f800 0 0 7>, should I change this to <3f800 0  
> 0 7>
> since I am using an extra 2 bits to indicate bus? This would make  
> sense if
> the ((Bus << 16) | Dev << 11))

Yeah, you need to do that.  Take a look at mpc8548cds.dts.  We have a  
mapping for the VIA chip hanging off a P2P bridge on PCI1.  But I  
think you've pretty much got it figured out.  Just sending you a  
"working" example (we've got it working internally, now, we just need  
to find the right code path.  But the dts is correct).


Andy
