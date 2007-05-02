Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id 69264DDFB1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 00:09:10 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HjFVz-0005MO-Dk
	for linuxppc-embedded@ozlabs.org; Wed, 02 May 2007 16:09:07 +0200
From: Peter Korsgaard <peter.korsgaard@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] uartlite driver MicroBlaze compatability
References: <4636C836.4050502@itee.uq.edu.au>
	<528646bc0704302255j3a825f10vbffd4bac961b28d7@mail.gmail.com>
	<4636E142.8010104@itee.uq.edu.au>
	<528646bc0705012247p4a0fff63oa8d98364d5f639b0@mail.gmail.com>
Date: Wed, 02 May 2007 16:09:07 +0200
In-Reply-To: <528646bc0705012247p4a0fff63oa8d98364d5f639b0@mail.gmail.com>
	(Grant Likely's message of "Tue, 1 May 2007 23:47:43 -0600")
Message-ID: <87wszr48sc.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

GL> Hmm, I think I was smoking something last night.

;)

GL>  Address used for 8 bit access should not be affected by CPU
GL> endianess.  After David's comments, I reread the uartlite
GL> documentation.  The current design is definately for 32bit OPB bus
GL> connections, but it looks like there is a posibility for xilinx to
GL> add a 16 or 8 bit attachment.  Since the uartlite design
GL> explicitly supports 8, 16 and 32 bit access, sticking with 8 bit
GL> io may be the safest.  However, I still think the application of
GL> the 3 byte offset should be done in the driver, and not in the
GL> platform bus registration.

That would effectively make the driver big endian only. What if Xilinx
would come out with a FPGA with a ARM core in it?

GL> I've reworked the patch with the following changes - remove 3 byte
GL> offset from platform bus registration.  - added ulite_in/ulite_out
GL> macros to make changing bus attachment details simpler if xilinx
GL> changes the uartlite design.  - stick with 8 bit IO.

Russell didn't like those accessor macros back when it was submitted
last year:

http://thread.gmane.org/gmane.linux.serial/1237/focus=1251

-- 
Bye, Peter Korsgaard
