Return-Path: <dhlii@comcast.net>
Received: from sccrmhc11.comcast.net (sccrmhc11.comcast.net [204.127.202.55])
	by ozlabs.org (Postfix) with ESMTP id AF09368672
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Nov 2005 07:27:39 +1100 (EST)
Message-ID: <436BC435.4090203@comcast.net>
Date: Fri, 04 Nov 2005 15:27:33 -0500
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


I am working through bringing up Linux 2.6.14 on a Xilinx V4 based
ppc405. with memory from 0x0 through 0x7fffffff

I have a debugging port at XPAR_KEYHOLE, I basically copied the code to 
setup a tlb entry for the serial debugging console to get an additional 
entry for my debugging port.

I am not particularly sharp on memory management.
Can I just cut and paste that code changing the address, and the tlb 
slot as below ?

     /* Load a TLB entry for the Keyhole, We use a 4k real==virtual 
mapping. */

     lis    r3,XPAR_KEYHOLE@h
     ori    r3,r3,XPAR_KEYHOLE@l
     mr    r4,r3
     clrrwi    r4,r4,12
     ori    r4,r4,(TLB_WR|TLB_I|TLB_M|TLB_G)

     clrrwi    r3,r3,12
     ori    r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_4K))

     li    r0,1            /* TLB slot 1 */
     tlbwe    r4,r0,TLB_DATA
     tlbwe    r3,r0,TLB_TAG
