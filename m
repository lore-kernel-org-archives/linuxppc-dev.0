Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id ECC3DDDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jun 2008 07:49:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PCI DMA Problems With 82xx?
Date: Tue, 17 Jun 2008 16:49:29 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B048F2E21@ismail.innsys.innovsys.com>
In-Reply-To: <48582CC6.60004@freescale.com>
References: <4858113F.4050203@vecimanetworks.com>
	<48582CC6.60004@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"Mike Winter" <mike.winter@vecimanetworks.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

linuxppc-embedded-bounces+runet=3Dinnovsys.com@ozlabs.org wrote:
> Mike Winter wrote:
>> We are developing with an 8248-based platform, and we have a vendor
>> telling us that the PCI hardware is unreliable on this CPU family, in
>> particular the DMA functionality.  A quick search of this list
>> doesn't turn up any horror stories, although the processor does have
>> some PCI errata listed.  Does anybody have any practical experience
>> using PCI on the 8248 or similar that they can share with me? =20
>> Thanks.=20

We're using all four PCI DMA's on 8265 and 8280 CPU's.
The only issue we have run into was that we get an occational bus error
(timeout) reading the PCI-DMA status registers...
We've worked around that by using an exception handler to just retry the
access when (not if) it fails.

Freescale has addmitted to us that there might be an issue reading the
DMA status register (no errata though).
