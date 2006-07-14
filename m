Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [63.240.77.83])
	by ozlabs.org (Postfix) with ESMTP id 3859267B7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jul 2006 02:54:54 +1000 (EST)
Message-ID: <44B7CC4F.2060401@dlasys.net>
Date: Fri, 14 Jul 2006 12:54:39 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Xilinx hard TEMAC
References: <689CB232690D8D4E97DA6C76DA098E6C029DC841@XCO-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C029DC841@XCO-EXCHVS1.xlnx.xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rick Moleres wrote:
> David,
>
> I'll see if I can clarify a bit.  In Virtex-4, there is a silicon-based
> Hard TEMAC.  But in order to get to it (and have things like buffering
> and DMA) you need a soft wrapper - which comes in two flavors.  One is
> the LL_TEMAC, which is released as part of the GSRD reference design.
> The other is PLB_TEMAC, which is released in the EDK.  The fundamental
> difference between the two (I'm simplifying) is that the LL_TEMAC and
> GSRD system keep data off the PLB bus, using LocalLink point-to-point
> connections between the LL_TEMAC and the memory and DMA controllers.
> The PLB_TEMAC's data path is over the PLB.  The LL_TEMAC also supports
> both channels of the Hard TEMAC, whereas the PLB_TEMAC does not (yet).
> Both are comparable in performance.  The PLB_TEMAC, as part of the EDK,
> has the official Xilinx support that other EDK IP has, whereas LL_TEMAC
> and GSRD are just a reference design.
>   
    Thanks, you have clarified things somewhat. I was vaguely aware of
the differences between the locallink and PLB.

    Though I still have some confusion.

    In my environment FPGA space is precious. The FPGA firmware for
Linux uses the UartLite, and does not include a PIC.
    The objective is to leave as much of the FPGA available for
application use as possible. Some current uses of the remaining FPGA
space have included
    decryption engines and FFT's. I am not part of the firmware process
- I am just responsible for Linux and any requests I make that require
more FPGA realestate
    tend to get stomped on.

    The choice and configuration of the TEMAC was driven by FPGA realestate.

    My perception was that the "Hard" Temac was based on silicon already
in the FX (much like the PowerPC) while the "Soft" TEMAC is primarily
implimented within the FPGA (much like the MicroBlaze).

    Is that distinction between "soft" and "hard" correct ?

     If not is the only significant distinction between the PLB_TEMAC
supported by the EDK and the LL_TEMAC the bus interface ?
     I should not think the difference between different bus interfaces
should be radically different in terms of FPGA cells. While implimenting
the MAC in the FPGA would likely be expensive in realestate.
      I can try to argue for the PLB_TEMAC - as something that will have
Xilinx/MV support and may get incorporated in the standard Kernel - If
the cost in cells is not substantial.
   
   

> The Linux driver posted for the TEMAC (by MontaVista) is for the
> PLB_TEMAC.  Updates to this driver may also be released with the EDK
> (e.g., EDK 8.1.2 updated the driver to include checksum offload).  There
> is a Linux driver for the LL_TEMAC that comes with GSRD, but my group's
> efforts go toward the PLB_TEMAC as that is the EDK IP we want to promote
> and whose drivers we'd like to see in kernel.org.
>   
    How can I get a copy of the GSRD LL_TEMAC ? Is it a 2.4 or 2.6 driver ?

> By the way, there is no relation to the IBM EMAC.
>   
    These things are worth knowing.

    The T still means Tri. is there some specific EMAC that was used as
a reference for the design or is the TEMAC entirely a Xilinx creation ?

> Hope that helps,
> -Rick
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
