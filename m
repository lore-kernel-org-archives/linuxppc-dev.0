Message-ID: <003501c3b85e$eb138ef0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>,
	"Tom Rini" <trini@kernel.crashing.org>
Subject: tx_full v.s tx_free race fix in 8xx_io/enet.c?
Date: Tue, 2 Dec 2003 00:00:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't see the race the tx_free patch fixes. So I tried to generate a race by running 3-4 parallel
ping floods from my Linux PC. Still no race/malfunction. So I removed the spin_lock_irq()/
spin_unlock_irq() in scc_enet_start_xmit(). Still no race/malfunction. I applied
the tx_free patch. Got an oops after only a few seconds. Added the spin_lock_irq()/
spin_unlock_irq() again. Now it worked again.

It seems to me that the old tx_full stuff is working better that the new tx_free. Which
race is it supposed to fix and how do I generate it?

This is the changeset that introduces tx_free:
http://ppc.bitkeeper.com:8080/linuxppc_2_4_devel/diffs/arch/ppc/8xx_io/enet.c@1.12.1.8?nav=index.html|src/.|src/arch|src/arch/ppc|src/arch/ppc/8xx_io|hist/arch/ppc/8xx_io/enet.c

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
