Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B10F8679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 11:00:41 +1000 (EST)
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHKEJOCLAA.Joakim.Tjernlund@lumentis.se>
References: <BCEFJBPJCGFCNMMMIDBHKEJOCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a94ed840e6b2cf1aba35fc0beadff22d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 7 May 2005 21:00:28 -0400
To: Joakim.Tjernlund@lumentis.se
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: How to fix 8xx dcbst bug? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 7, 2005, at 6:47 PM, Joakim Tjernlund wrote:

> I was once told by a senior kernel hacker(Dan?) that using swap could 
> make an already
> populated pte invalid. This was for 2.4 kernels.

The original problem was I didn't pay attention to the swap PTE when
constructing the originals for the 8xx.  The swap PTE has to be 
indicated
as such in one of the lowest 2 bits of the PTE, as the rest of the PTE 
is
used for the swap block number.  What would happen is there would
be the occasion where some control bit was set in the PTE within the
swap block number, and upon restoring from disk the wrong block
would be brought into memory (or the fact it was swapped was lost).

Thanks.


	-- Dan
