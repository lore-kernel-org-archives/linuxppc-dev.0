Return-Path: <cml3227@eircom.net>
Received: from stanley (unknown [193.120.93.48])
	by ozlabs.org (Postfix) with ESMTP id 68A172BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Oct 2004 19:49:05 +1000 (EST)
Message-ID: <41738D27.4060007@eircom.net>
Date: Mon, 18 Oct 2004 10:30:15 +0100
From: Conor McLoughlin <cml3227@eircom.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <1098072098.751.32.camel@nighteyes.localdomain>
In-Reply-To: <1098072098.751.32.camel@nighteyes.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Does kmalloc on MPC82xx work correctly with GFP_DMA?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have been looking at the ethernet device driver (fcc_enet) for the
mpc82xx platform. This allocates buffer descriptors using kmalloc with
the GFP_DMA flag. As far as I can see on my platform, this allocates
from the regular kernel memory (0xCxxxxxxx). As the attributes of this
block of memory are controlled by the block address translation
registers, this cannot be DMA safe, can it?
Is there something I am missing here?

I am using the linuxppc-2.5 tree.

Conor
