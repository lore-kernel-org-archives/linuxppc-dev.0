Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0FB74679F9
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Feb 2006 11:32:56 +1100 (EST)
Date: Sat, 11 Feb 2006 16:32:53 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-embedded@ozlabs.org
Subject: CONFIG_DEBUG_SLAB and non-cache coherent CPUs
Message-ID: <20060212003253.GA32060@gate.ebshome.net>
Mime-Version: 1.0
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

Hi!

I just wanted to let people on this list know that turning slab 
debugging may cause slab corruption on non-coherent cache CPUs (4xx, 
8xx).

The reason for this is that usually drivers which use DMA assume 
L1 cache line alignment for buffers (e.g. returned from alloc_skb). 
Unfortunately, with slab debugging enabled this is no longer the case, 
and during cache invalidates we corrupt slab cache (or at least slab 
poison markers).

I tried to define ARCH_KMALLOC_MINALIGN and/or ARCH_SLAB_MINALIGN but 
it didn't work (and even if it did, it'd effectively disabled slab 
debugging anyway).

I don't understand why slab debugging feature has to change allocation 
alignment, as it can be obviously implemented without breaking this 
alignment. Probably the reason is the usual one - nobody cares/cared 
about non-coherent cache CPUs and saving couple of bytes was more 
important :).

Anyway, I made a hack for my EMAC driver:

 http://kernel.ebshome.net/emac_slab_debug.diff 

which helps with this problem, although other drivers may experience 
the same problem when used on 4xx/8xx with slab debugging enabled. In 
fact, 3COM 905 driver crashed Ocotea in this configuration too.

-- 
Eugene
