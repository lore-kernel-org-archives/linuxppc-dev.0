Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: ppc_8xx-gcc 2.95.3 Monta Vista does not do ANY loop unrolling
Date: Tue, 12 Nov 2002 10:40:41 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLGEOFFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3DD0B7E3.E8B63F6D@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I optimized the crc32() in JFFS2(fs/jffs2/crc.h) by manually unrolling
the crc32 loop. This gave me a speed increase of 22% in mounting JFFS2 FS

Later Alan Cox pointed out that my changes makes x86 run slower and it turns
out that on x86 and a fairly new gcc will automatically unroll loops 'where appropriate'

Removed my hand coded unrolling and added -funroll-loops to the JFFS2 Makefile,
I got similar results as my hand coded unrolling (a little better).

I therefore conclude that ppc_8xx-gcc 2.95.3 from Monta Vista does not do ANY unrolling
unless you specify -funroll-loops. Doing this for the whole kernel is NOT a good idea,
it will run slower due to big increase of size.

Now I wonder:
Is this a gcc 2.95.3, PPC or Monta Vista limitation?

Which compiler will do unrolling 'where appropriate' for 8xx PPC and
Where can I get a precompiled version?

The short term solution is to specify -funroll-loops for individual files/directories.
Obviously JFFS2 should be included, but what else?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
