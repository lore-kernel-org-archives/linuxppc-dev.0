Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27EE267B25
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 07:15:22 +1000 (EST)
Date: Thu, 9 Jun 2005 13:26:50 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050609162650.GA8125@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: 8xx fixes GIT tree
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, 

I've put up a GIT tree with some 8xx fixes. 

I plan to continue collecting fixes there - I encourage other folks 
working with v2.6 on 8xx to join in and contribute.

Its about time to setup a "TODO" list for v2.6 8xx, a few which I 
remember from the top of my head:

- merge CPU15 workaround
- merge PCMCIA driver
- merge arch/ppc/8xx_io/fec.c v2.6 update
- Remove misc-embedded.c

It should live somewhere in the web (wiki would be ideal).

It contains the following changes at the moment:

commit f17c5c6e4e1d1b7e8b01f323dfd2bd2197a0743f
tree ee66f3f546b0b68f8af3debf1ade40d3ce67f74a
parent 8d2fde72d6a5921136d6e605168e3c4995288b64
author Marcelo <marcelo@xeon.cnet> Thu, 09 Jun 2005 17:47:50 -0300
committer Marcelo Tosatti <marcelo.tosatti@cyclades.com> Thu, 09 Jun 2005 17:47:50 -0300

    [PATCH] handle access to non-present IO ports on 8xx

    Accessing non present "IO ports" on 8xx generates MCE's. The exception
    is easily triggered during insertion/removal/suspension of PCMCIA cards.

    The following adds exception table entries for I/O instructions on 8xx (copied
    from the original Paul's PowerMac code), and changes MachineCheckException() slightly 
    to cover 8xx specific's (on 8xx the MCE can be generated while
    executing the IO access instruction itself, which is not the case on
    PowerMac's, as the comment on traps.c details).

    Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

commit 8d2fde72d6a5921136d6e605168e3c4995288b64
tree ba3161acbeab3b4559c63a4d08eff435a53f378a
parent 65df60a129cc12e89b93cec068f527a9650e5914
author Marcelo Tosatti <marcelo.tosatti@cyclades.com> Sat, 04 Jun 2005 14:13:34 -0700
committer Marcelo Tosatti <marcelo.tosatti@cyclades.com> Wed, 08 Jun 2005 22:17:47 -0300

    [PATCH] 8xx: avoid "dcbst" misbehaviour with unpopulated TLB

     On 8xx, cache control instructions (particularly "dcbst" from
     flush_dcache_icache) fault as write operation if there is an
     unpopulated TLB entry for the address in question. To workaround
     that, we invalidate the TLB here, thus avoiding dcbst misbehaviour.

commit 65df60a129cc12e89b93cec068f527a9650e5914
tree 2ed7d42019c3ee29435bb9c7e4dc5e002fa4690c
parent 97d26b8042a6f14cc4a19e84e911a953363e3d69
author Marcelo Tosatti <marcelo.tosatti@cyclades.com> Sat, 04 Jun 2005 14:13:34 -0700
committer Marcelo Tosatti <marcelo.tosatti@cyclades.com> Wed, 08 Jun 2005 22:16:50 -0300

    [PATCH] 8xx commproc: Do not touch pte directly - use dma coherent API instead

    Touching the pte directly causes the 8Mbyte TLB entry to be invalidated.

    This has been fixed in v2.4 for ages.
