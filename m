Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	"Tom Rini" <trini@kernel.crashing.org>
Subject: Performance bug in 8xx_io/enet.c?
Date: Tue, 6 Apr 2004 12:15:37 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLAEILIKAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am seeing a severe performance drop in 8xx_io/enet.c in some cases I can't explain. The cause of
the performance drop is the 1.12.1.8 ChangeSet to enet.c. Changeset comments
 "Original comments:
  Fixed potential race condition in transmit routine.
  Eliminated erroneous "BSY can't happen" error message.

  I believe this race condition is actualized under
  heavy load."

The testcase is simple:
NFS mount root fs on target.
Do a "time cp big_file new_bigfile" to warm up.
start a "ping -f <target IP> on the NFS server.
Do a few more "time cp big_file new_bigfile"

The last step takes about 10-20 seconds(big_file is 8356 KB) before the
above change. After the change it takes
about 1 minute.

Can anyone confirm this behavior?

 Jocke

http://ppc.bitkeeper.com:8080/linuxppc_2_4_devel/diffs/arch/ppc/8xx_io/enet.c@1.12.1.8?nav=index.html|src/.|src/arch|src/arch/ppc|sr
c/arch/ppc/8xx_io|hist/arch/ppc/8xx_io/enet.c


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
