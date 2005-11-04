Return-Path: <dhlii@comcast.net>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [204.127.202.59])
	by ozlabs.org (Postfix) with ESMTP id 6527C68679
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Nov 2005 07:33:05 +1100 (EST)
Message-ID: <436BC360.20908@comcast.net>
Date: Fri, 04 Nov 2005 15:24:00 -0500
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <20050906130029.74727.qmail@web8405.mail.in.yahoo.com>
	<43688AAD.5050208@comcast.net>
In-Reply-To: <43688AAD.5050208@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Board Bringup problem with 2.6.13.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr wrote:
I am working through bringing up Linux 2.6.14 on a Xilinx V4 based 
ppc405. with memory from 0x0 through 0x7fffffff
I get to this point in head_4xx.S:

/* We now have the lower 16 Meg mapped into TLB entries, and the caches
 * ready to work.
 */
turn_on_mmu:
    lis    r0,MSR_KERNEL@h
    ori    r0,r0,MSR_KERNEL@l
    mtspr    SPRN_SRR1,r0
    lis    r0,start_here@h            // SPRN_SRR0 is where the rfi 
resumes execution
    ori    r0,r0,start_here@l
    mtspr    SPRN_SRR0,r0
    SYNC
    rfi                /* enables MMU */
    b    .            /* prevent prefetch past rfi */

The value of SPRN_SRRO is 0xffffc00000002218 and SPRN_SRR1 is 
0x0000000200001032
I have not checked the bits in SPRN_SRR1 but isn't 0xffffc00000002218 
wrong ? it looks like it was sign
extended. physical 0x2218 is start_here so that part  is corect.
