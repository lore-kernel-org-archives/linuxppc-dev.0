Return-Path: <kumar.gala@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <93f533baba2b2f73ac9ec46b5401747e@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 6 Apr 2005 01:51:08 -0500
To: Paul Mackerras <paulus@samba.org>,
	Matt Porter <mporter@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

I've tracked down a bug I've been having to the fact that pte_update 
assumes a pte is a unsigned long.  I need to look into what the exact 
implications this has.  I was wondering what the thoughts were with 
respect to how this is suppose to work properly on 440 with its 64-bit 
pte?  I'm looking at a 64-bit pte for some Freescale book-e parts as we 
move to 36-bit physical address support.

The problem I found was ptep_get_and_clear() would return back only a 
32-bit value and thus we loose any information in the upper 32-bits.  I 
found the call in sys_mprotect ... -> change_pte_range -> 
ptep_get_and_clear()

Will provide some update on this tomorrow.

- kumar
