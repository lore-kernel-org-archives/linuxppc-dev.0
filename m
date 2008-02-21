Return-Path: <rwoodworth@securics.com>
Received: from securics.com (mail.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 87CACDE013
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 06:12:03 +1100 (EST)
Subject: Re: TLB Miss booting linux kernel on ppc 405
From: Robert Woodworth <rwoodworth@securics.com>
To: David Baird <dhbaird@gmail.com>
In-Reply-To: <440abda90802211004h3833ed00ke1cdc1257e2b0379@mail.gmail.com>
References: <5ee408090802130850w130ce09an507ca5c4d41cc5a8@mail.gmail.com>
	<440abda90802130917x79c3c990j6a1fc7c12ba05ed7@mail.gmail.com>
	<5ee408090802130938u7d069636g42a496e489fe5b80@mail.gmail.com>
	<440abda90802130951h7a23743asc85454bf089c7e55@mail.gmail.com>
	<5ee408090802131003m4b8e632cu931769bc77f9b439@mail.gmail.com>
	<440abda90802131032l6e11eef7gbd7eb57352c2ce4@mail.gmail.com>
	<5ee408090802131049u652ef867wff034b4ccb1067f1@mail.gmail.com>
	<440abda90802131102q234e870fx2cbf12fb3119fd0a@mail.gmail.com>
	<1203542646.4812.38.camel@PisteOff>
	<440abda90802211004h3833ed00ke1cdc1257e2b0379@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 21 Feb 2008 12:12:03 -0700
Message-Id: <1203621123.5231.36.camel@PisteOff>
Mime-Version: 1.0
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

I'm no expert but....

I did configure my device with the DCR enabled and connected the PLBv46
DCR to the PPC.  In the TLB miss ISR I read the PLB registers and the
MCSR I *DID* notice that the PLB error registers were set.

I added some asm code to read MCSR (see Xilinx UG011.pdf, page 213) and
I also added the asm code to read the DCR of the PLB.  Sure enough, the
MCSR and PLB-DCR registers showed a DPLBError.

It's only a couple of asm statements:

mfspr   r30, 0x23c



Question to Xilinx experts:
What would cause the PLB to issue the DPLBError?????




<note to Xilinx>

Hey Xilinx guys!
Can you hack the gdb included with EDK such that it will recognize the
MCSR when gdb reads registers!

</note to Xilinx>

 


On Thu, 2008-02-21 at 11:04 -0700, David Baird wrote:
> Hi Robert,
> 
> On Wed, Feb 20, 2008 at 2:24 PM, Robert Woodworth
> <rwoodworth@securics.com> wrote:
> >  I'm under the suspicion that the PLB is issuing an error when switching
> >  to virtual mode and that there is either a timing/synthesis error or a
> >  fundamental error with the way the FPGA is getting synthesized with the
> >  PLB.
> 
> Can you offer a suggestion how I can check to see if the PLB is
> issuing an error (a good application note for me to read or anything)?
>  I was having a similar problem in virtual mode on one of my systems,
> and I might be able to see also if I am having a problem with the PLB
> bus.
> 
> -David
