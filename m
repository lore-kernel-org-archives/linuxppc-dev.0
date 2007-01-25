Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:07 +1100
Subject: [RFC/PATCH 0/16] Ops based MSI Implementation
Message-Id: <1169714047.65693.647693675533.qpush@cradle>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

OK, here's a first cut at moving ops based MSI into the generic code. I'm
posting this now to make sure I'm not heading off into the weeds.

The fifth patch contain the guts of it, I've included the MPIC and
RTAS backends as examples. In fact they actually work.

In order to smoothly merge this with the old MSI code, the two will need to
coexist in the tree for at least a few commits, so I've added (invisible)
Kconfig symbols to allow that.

I plan to merge the Intel code by:
 * copying it into drivers/pci/msi/intel.c with zero changes.
 * providing a minimal shim to connect the ops code to the intel code.
 * at this point the code should be functional but ugly as hell.
 * via a longish series of patches, adapt the intel code to better match
   the new ops code.
 * this should allow us to bisect through to find any mistakes.

If people think that's crazy and or stupid please let me know :)

TBD are:
 * suspend / resume hooks in the ops - this shouldn't be too tricky with
   the power management API cleaned up a touch.
 * working out why the hell msi_remove_pci_irq_vectors() is a special case ?

cheers
