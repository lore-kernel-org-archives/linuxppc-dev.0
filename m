Return-Path: <kernelppc@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 7CCD9DDF4B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 18:29:48 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so984604nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 01:29:46 -0700 (PDT)
From: "mojtaba" <kernelppc@gmail.com>
To: "'Stephen Neuendorffer'" <stephen.neuendorffer@xilinx.com>,
	<linuxppc-embedded@ozlabs.org>
References: <012401c8b9c3$74b947c0$5e2bd740$@com>
	<20080519165845.4430019C0055@mail16-wa4.bigfish.com>
In-Reply-To: <20080519165845.4430019C0055@mail16-wa4.bigfish.com>
Subject: RE: Instruction OCM
Date: Tue, 20 May 2008 10:31:15 +0200
Message-ID: <015e01c8ba53$df25afa0$9d710ee0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: mike.koss@ngc.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Actually there is no overlapping between IOCM and DDR. The IOCM region
addre4sses are:
PARAMETER C_BASEADDR = 0xc0a00000
PARAMETER C_HIGHADDR = 0xc0a1ffff
And the DDR addresses are:
PARAMETER C_MEM0_BASEADDR = 0x00000000
PARAMETER C_MEM0_HIGHADDR = 0x0fffffff
Furthermore, if such a conflict existed, the synthesizer would have
identified it.


-----Original Message-----
From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com] 
Sent: Monday, May 19, 2008 6:59 PM
To: mojtaba; linuxppc-embedded@ozlabs.org
Subject: RE: Instruction OCM

The traps are down there in low memory.  trap 700 is probably the one
that deals with MMU exceptions.  My guess is your OCM region is
overlapping with the DDR memory containing that code.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of mojtaba
> Sent: Monday, May 19, 2008 8:17 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Instruction OCM
> 
> Dear all,
> 
> I cannot run Linux when I have an instruction OCM in my design but,
without instruction OCM
> everything is fine. I tried to do some debugging. It seems that the
Linux memory management unit has
> a problem with that.  After entering the MMU initialization phase, it
suddenly jumps to address
> 0x00000700 it get stuck there. Is there anybody who have tried a
design with instruction OCM? Do I
> need to do special configuration for the Linux kernel?
> 
> Regards,
> 
> Mojtaba


This email and any attachments are intended for the sole use of the named
recipient(s) and contain(s) confidential information that may be
proprietary, privileged or copyrighted under applicable law. If you are not
the intended recipient, do not read, copy, or forward this email message or
any attachments. Delete this email message and any attachments immediately.
