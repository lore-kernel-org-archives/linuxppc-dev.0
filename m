Return-Path: <benh@kernel.crashing.org>
Subject: Cell and new CPU feature bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 19 May 2006 14:07:01 +1000
Message-Id: <1148011621.13249.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Cell has a couple of "features" that should be exposed to userland
in a way or another. That raises some questions however about how those
should be done. Among others that come to mind:

 - The timebase errata (should we use a separate aux vector for "bugs"
than for "features" ?
 - Additional Altivec instructions (load/store right/left). A new
feature bit for these ?
 - Lack of data stream instructions. Until now, it was assumed that
those were tied to the presence
   of an Altivec (and they are documented in the Altivec manual). Maybe
we should split that to a
   new bit. I don't know if existing applications use them though, if
they do, there will be a 
   problem to get them updated as the new bit isn't present on older
kernels...
 - Extended implementation of dcbt. (Another bit ? Or sould we just have
a "CELL" bit ? In which
   case should it cover the altivec additions too or are those likely to
exist in future non-Cell 
   processors ?)
 - Not strictly Cell specific but we currently don't expose the support
for optional instructions
   fres and frsqte (which are supported by Cell)

Part of the problem is that we only have 32 userland feature bits and
for some reason decided to put the microarchitecture in there, thus we
are running out fast...

Ben.
