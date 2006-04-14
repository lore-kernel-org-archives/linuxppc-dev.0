Return-Path: <aris@cathedrallabs.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF22B679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 23:52:17 +1000 (EST)
Received: from tate.cathedrallabs.org
	(201-25-163-155.ctame704.dsl.brasiltelecom.net.br [201.25.163.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tinc.cathedrallabs.org (Postfix) with ESMTP id 7AB27104BD
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 09:31:44 -0400 (EDT)
Date: Fri, 14 Apr 2006 10:31:38 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: linuxppc-dev@ozlabs.org
Subject: bisect results for powerbook G4 not booting on latest git tree
Message-ID: <20060414133138.GG16901@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
	I was unable to find someone who already did it, so here it
	the possible culprit of latest git tree (pulled both Linus' and
	Paul's tree) not booting on a powerbook G4:

a0652fc9a28c3ef8cd59264bfcb089c44d1b0e06 is first bad commit
diff-tree a0652fc9a28c3ef8cd59264bfcb089c44d1b0e06 (from 55aab8cd3a498201b769a19de861c77516bdfd45)
Author: Paul Mackerras <paulus@samba.org>
Date:   Mon Mar 27 15:03:03 2006 +1100

    powerpc: Unify the 32 and 64 bit idle loops

    This unifies the 32-bit (ARCH=ppc and ARCH=powerpc) and 64-bit idle
    loops.  It brings over the concept of having a ppc_md.power_save
    function from 32-bit to ARCH=powerpc, which lets us get rid of
    native_idle().  With this we will also be able to simplify the idle
    handling for pSeries and cell.

    Signed-off-by: Paul Mackerras <paulus@samba.org>

:040000 040000 c6998a13a214b16c0cb936526d9e087095530eb39282cff1b1d6a5893c17319c0fbe13d93f5369f7 M      arch
:040000 040000 44489477a1708a022f564892e233207434ab79ee78d125804d5c52fef1ebc089bce121773bc8f5b7 M      include

if there's any other info that I can provide or a patch to try, please
let me know

-- 
Aristeu
