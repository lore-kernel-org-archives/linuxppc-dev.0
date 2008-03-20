Return-Path: <jblack547@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.242])
	by ozlabs.org (Postfix) with ESMTP id 2519BDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 10:02:36 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1141919hsz.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 16:02:35 -0700 (PDT)
Message-ID: <b77025b40803201602q68fce3e1j703502a270351179@mail.gmail.com>
Date: Thu, 20 Mar 2008 17:02:35 -0600
From: "James Black" <jblack547@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
In-Reply-To: <47E2AADD.6090101@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
	<20080319174001.GF7962@ld0162-tx32.am.freescale.net>
	<b77025b40803191107x2f9a7884n9b7f062fcf45370@mail.gmail.com>
	<b77025b40803201102w200dde6fuc4235d9a3cb8b0dd@mail.gmail.com>
	<47E2AADD.6090101@freescale.com>
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

On Thu, Mar 20, 2008 at 12:20 PM, Scott Wood <scottwood@freescale.com> wrote:
> James Black wrote:
>  > Zone PFN ranges:
>  >   DMA             0 ->    16384
>  >   Normal      16384 ->    16384
>  > Movable zone start PFN for each node
>  > early_node_map[1] active PFN ranges
>  >     0:        0 ->    16384
>  > Unable to handle kernel paging request for data at address 0xe001a000
>  > Faulting instruction address: 0xc00e1a6c
>
>  What function is 0xc00e1a6c in?
Drilled down into the source and find that mm/bootmem.c:line 232

           : find_next_zero_bit()
may be the culprit. When I put printks in, the line moves around a bit.

JB

>  Is it possible that you have an SMC device initialized by your firmware
>  that is corrupting parameter RAM?
No other devices have been configured except FCC1, SCC1, SCC3. The
unused gpio pins have been set as outputs.

>  > muram@0 {
>  >    #address-cells = <1>;
>  >    #size-cells = <1>;
>  >    ranges = <0 0 10000>;
>  >
>  >    data@0 {
>  >       compatible = "fsl,cpm-muram-data";
>  >       reg = <0 4000 8000 1000 B000 1000>;
>
>  You can't use all of 0x8000-0x8fff; there is device parameter RAM in
>  there.  If you can figure out the portions that aren't in use, you can
>  use those, but I wouldn't bother unless you really need the extra muram.

So, are you are saying that the muram node is giving the ram to the
kernel and is no longer available for devices to use as buffer
descriptors? I imagined the opposite. I thought I was telling the
kernel where the parameter ram and buffer descriptors live. I am going
to turn on the MCC2 device eventually and will need all of the dpram
for buffer descriptors.

The memory map in my mind right now is
0x0000 - 0x3FFF --> buffer descriptors for SCCx and MCC2.
0x8000 - 0x8FFF --> paramter ram for SCCx and MCC2, et al. (reserved)
0xB000 - 0xB8FF --> FCCx specific (reserved)

In my case, I shouldn't define any of the dual port ram for the kernel?


Jim Black


>
>  -Scott
>
