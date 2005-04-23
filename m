Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 754B967AC6
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 07:51:35 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Date: Sat, 23 Apr 2005 23:51:25 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHGEIJCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <42b1a4ca0138e9576d010ec2754eb29a@embeddededge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> On Apr 23, 2005, at 1:35 PM, Joakim Tjernlund wrote:
> 
> > Is it possible to handle the _PAGE_ACCESSED handling at pte creation 
> > in fault.c instead
> > of doing it for every TLB miss? That should make the TLB Miss handler 
> > faster.
> 
> No.  As part of VM management to determine working sets, it's possible 
> to have
> this flag change state but the page to remain valid.

OK, strange though. I would have expected this flag to stay untouched until the
pte is invalidated.

> The cost of 
> setting this properly
> in the miss handler is minimal compared to the other stuff that we 
> should try
> and streamline.

Well, every instruction counts. I this case we would have saved
2 in ITLB Miss, 3 in DTLB Miss and a cache line write in both.

Would be nice to do away with the kernel space test, but thats a lot harder.

> 
> Thanks.
> 
> 	-- Dan
> 
