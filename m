Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17208.37250.577664.621993@cargo.ozlabs.ibm.com>
Date: Tue, 27 Sep 2005 10:25:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have pushed a commit to the powerpc-merge.git tree which gets us far
enough to be able to build a 32-bit powermac kernel with
ARCH=powerpc.  It's still very rough in places, and it uses bits out
of arch/ppc/kernel and arch/ppc/syslib, but it is a start.

Of course, this means that we are about to bump up against the really
hard bits of the merge.  Things like

* converting ppc32 to use the lmb infrastructure
* introducing the device-tree flattening/unflattening to ppc32
* working out how to deal with the early hash table initialization
  that POWER4 needs on ppc32
* reconciling the fact that ppc64 needs RELOC in the prom_init code,
  whereas ppc32 doesn't; but ppc64 doesn't need RELOC when running
  with the MMU off but ppc32 does (or needs -mrelocatable).

I look forward to people sending me patches to push this on a bit
further, and in particular to populate arch/powerpc/platforms a bit
more. :)

Paul.
