Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0129.outbound.protection.outlook.com [207.46.100.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE16B1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 08:34:47 +1000 (AEST)
Message-ID: <1442961271.19102.289.camel@freescale.com>
Subject: Re: [PATCH v2 22/25] powerpc32: move xxxxx_dcache_range() functions
 inline
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Joakim Tjernlund <joakim.tjernlund@transmode.se>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 22 Sep 2015 17:34:31 -0500
In-Reply-To: <5601C0CC.6090503@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <c1c88096cb3f6ee71048dbab44ffb9ac260b07a3.1442939410.git.christophe.leroy@c-s.fr>
 <1442945547.29498.50.camel@transmode.se>
 <1442948339.19102.270.camel@freescale.com>
 <1442950473.29498.54.camel@transmode.se>
 <1442950926.19102.280.camel@freescale.com>
 <1442951752.29498.58.camel@transmode.se>
 <1442952852.19102.281.camel@freescale.com>
 <1442953971.29498.76.camel@transmode.se>
 <1442954101.19102.286.camel@freescale.com>
 <1442954285.29498.79.camel@transmode.se> <5601C0CC.6090503@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-22 at 22:57 +0200, Christophe Leroy wrote:
> Here is what I get in asm. First one is with "if (i) mb();". We see gcc 
> puts a beqlr. This is the form that is closest to what we had in the 
> former misc_32.S
> Second one if with "mb()". Here we get a branch to sync for a useless sync

I was more concerned with keeping the code simple than the asm output.

> c000e0ac <my_flush_dcache_range1>:
> c000e0ac:       54 63 00 36     rlwinm  r3,r3,0,0,27
> c000e0b0:       38 84 00 0f     addi    r4,r4,15
> c000e0b4:       7d 23 20 50     subf    r9,r3,r4
> c000e0b8:       55 29 e1 3f     rlwinm. r9,r9,28,4,31
> c000e0bc:       4d 82 00 20     beqlr
> c000e0c0:       7d 29 03 a6     mtctr   r9
> c000e0c4:       7c 00 18 6c     dcbst   0,r3
> c000e0c8:       38 63 00 10     addi    r3,r3,16
> c000e0cc:       42 00 ff f8     bdnz    c000e0c4 
> <my_flush_dcache_range1+0x18>
> c000e0d0:       7c 00 04 ac     sync
> c000e0d4:       4e 80 00 20     blr
> 
> c000e0d8 <my_flush_dcache_range2>:
> c000e0d8:       54 63 00 36     rlwinm  r3,r3,0,0,27
> c000e0dc:       38 84 00 0f     addi    r4,r4,15
> c000e0e0:       7d 23 20 50     subf    r9,r3,r4
> c000e0e4:       55 29 e1 3f     rlwinm. r9,r9,28,4,31
> c000e0e8:       41 82 00 14     beq     c000e0fc 
> <my_flush_dcache_range2+0x24>
> c000e0ec:       7d 29 03 a6     mtctr   r9
> c000e0f0:       7c 00 18 6c     dcbst   0,r3
> c000e0f4:       38 63 00 10     addi    r3,r3,16
> c000e0f8:       42 00 ff f8     bdnz    c000e0f0 
> <my_flush_dcache_range2+0x18>
> c000e0fc:       7c 00 04 ac     sync
> c000e100:       4e 80 00 20     blr

Who cares whether the case that should rarely if ever happen gets a beqlr or a
branch to sync+blr?

-Scott
