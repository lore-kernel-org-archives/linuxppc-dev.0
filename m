Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id E6DA1B70EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 03:41:26 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 30908-09 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Nov 2010 16:41:11 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PowerQUICC II PCIe dma
Date: Wed, 10 Nov 2010 16:40:23 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ABA2@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AB8C@saturn3.aculab.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> I'm trying to get a ppc 831x to do PCIe dma transfers, PIO transfers
> work ok but are somewhat lethargic (partially due to the slave).

After much soul searching I've finally got it to work!
For the benefit of anyone else...

- The lowest address of the dma descriptor contains the 'command' bits.
- Set 'Next descriptor valid' with a zero pointer to get the chain to
complete.
- Set the dma descriptor status word to zero (might just need 'done'
clear).
- Set the 'snoop for CSB' bit in the descriptor command (errata).

My big problem was that I'd set the descriptor status to 0xdeadbeef in
order to detect writes :-(

I also used the st_le32() and ld_le32() defines from
arch/powerpc/include/asm/swab.h with explicit iosync() requests
rather than the out_le32() and in_le32() from io.h.
The latter (especially in_le32()) contain unwanted slow instructions.

Getting the correct swab.h included was a problem in itself!

	David
