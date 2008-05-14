Return-Path: <BenGardiner@nanometrics.ca>
Received: from nmxmail.nanometrics.ca (mail.nanometrics.ca [206.191.47.130])
	by ozlabs.org (Postfix) with ESMTP id 3F7C7DDFDD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 01:01:54 +1000 (EST)
Message-ID: <482AFCC5.2070907@nanometrics.ca>
Date: Wed, 14 May 2008 10:52:53 -0400
From: Ben Gardiner <BenGardiner@nanometrics.ca>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: 8xx: Work around CPU15 erratum.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

This is my first post to the linuxppc-embedded list. Please forgive me 
for jumping in late onto the CPU15 workaround discussions, but my 
company is very interested in finding an efficient fix for this silicon 
errata on our devices.

I applied the patch submitted by Scott Wood to our patched denx 2.4.24 
tree and did some timing measurements to compare its effect on 
performance. We noted a worst case 37% slowdown -- this was during 
program load, where the PC is moving all over the place, so the penalty 
for all the tlbie's is felt heavily. This is solely anecdotal, I don't 
mean to imply that this fix will result in any particular slowdown on 
anyone else's systems.

I would like to start a discussion on the possibility of implementing a 
selective invalidation of pages on i-tlb miss. On July 20th, 2007 Scott 
Wood wrote:
 >The only lower-overhead workaround I know of requires compiler 
modifications (and I made it configurable to allow for that possibility).

So there likely are reasons why the following is not possible:
In the errata document from Freescale 
(http://www.freescale.com/files/32bit/doc/errata/MPC860CE.pdf?fpsp=1), 
they list an alternative to the "invalidate previous and next page" itlb 
miss handler (see pg 57), where they use the SPS/SH/CI bits of a L2 page 
entry to indicate whether: 1) a page is unchecked, 2) it does not 
contain a bad branch, 3) it does contain a bad branch, or 4) it has a 
previous page with a bad branch. These bits are zeroed before being 
written to MI_RPN. In loose terms the itlb miss handle does the 
following: If the page is unchecked, they check the last instruction the 
current page or the previous page and write the status bits to the L2 
entry accordingly. If the page has been checked the status bits are used 
to selectively invalidate the next or previous page as needed.

Since MI_RPN is always written with bits 24,25,26 and 27 set; could we 
use bits 24, 25 and 26 in memory to indicate the 4 possible page states 
and perform selective page invalidation as demonstrated in their example 
listing?

Regards,
Ben Gardiner

Nanometrics Inc.
250 Herzberg Rd.
Kanata ON
K2K 2A1
Telephone 613 592 6776 ext 239
