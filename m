Return-Path: <dcogley@uslinc.com>
Received: from mtao01.charter.net (mtao01.charter.net [209.225.8.186])
	by ozlabs.org (Postfix) with ESMTP id 0609ADDE10
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Sep 2007 02:45:21 +1000 (EST)
From: "Dave Cogley" <dcogley@uslinc.com>
To: "'Josh Boyer'" <jwboyer@jdub.homelinux.org>
References: <005301c7fedf$c46f7770$9601a8c0@DCOGLEYNEW>
	<20070924184210.484d39b3@vader.jdub.homelinux.org>
Subject: RE: EBC peripheral, access causing Machine Check
Date: Tue, 25 Sep 2007 09:44:59 -0700
Message-ID: <000601c7ff93$6b2f0ef0$9601a8c0@DCOGLEYNEW>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01C7FF58.BED036F0"
In-Reply-To: <20070924184210.484d39b3@vader.jdub.homelinux.org>
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

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C7FF58.BED036F0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Yes I thought it might be a problem with the TLB.  Where does the TLB
initialization take place in the Linux kernel?  I am able to access any
other peripherals on the chip as there TLB entries appear to be properly
allocated. I am remapping the physical address for all peripherals that I am
working with.  I have attached the driver code for reference.

Dave

-----Original Message-----
From: Josh Boyer [mailto:jwboyer@jdub.homelinux.org] 
Sent: Monday, September 24, 2007 4:42 PM
To: Dave Cogley
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: EBC peripheral, access causing Machine Check

On Mon, 24 Sep 2007 12:19:01 -0700
"Dave Cogley" <dcogley@uslinc.com> wrote:

> Good Afternoon,
> 
>  
> 
> I am using an AMCC 440EPx processor with an FPGA peripheral attached to
the
> EBC.  I am doing the entire bank configuration in the u-boot boot loader
> before Linux is loaded.  I can directly read and write registers using
> memory read and write (md, nm) within area 0xC0000000 to 0xC000FFFF direct
> memory I/O within the context of u-boot without any faults.  When I
attempt
> to access any register in area 0xC000000 within the context of my Linux
> device driver I get a Machine Check fault (attached text) which appears to
> be an access permission violation.  I am currently running the DENX ELDK
> 2.6.19.2 platform that was specific to the "Sequoia" platform.
> 
>  
> 
> I have configured the EBC access permissions and control resisters as
> follows for bank 1:
> 
>  
> 
> PB1CR: 0xC003C000
> 
> PB1AP: 0x80040380

You need proper TLB entries set up before you can access things.  Linux
discards the MMU settings that U-Boot does.  So your driver needs to call 
ioremap on the physical address. 

Other than that, we can't help you much without your driver code.

josh

------=_NextPart_000_0007_01C7FF58.BED036F0
Content-Type: application/x-gzip;
	name="banjodecoder.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="banjodecoder.tar.gz"

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

------=_NextPart_000_0007_01C7FF58.BED036F0--
