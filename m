Message-ID: <412CE415.6010201@mvista.com>
Date: Wed, 25 Aug 2004 12:10:13 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Patrick Huesmann <tricknology@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org, v2p@mind.be
Subject: Re: ppc-linux still not booting on my virtexII board
References: <24181.1093452013@www39.gmx.net>
In-Reply-To: <24181.1093452013@www39.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patrick Huesmann wrote:
 > Then there is a possibility of cache problems. Someone on this list
 > suggested that I better flush the caches before booting, using a code
 > snippet like this:
 >
 > for(i=0; i<16384; i+=32) {
 >   asm("dccci 0,%0" :: "r"(i));
 > }
 > asm("iccci 0,0");
 > asm("sync;isync");
You should probably invalidate the cache before you flush it.  There is
code to do this for the ML300.  Search for "mfdccr" in:

http://ppc.bkbits.net:8080/linuxppc-2.4/anno/arch/ppc/boot/simple/embed_config.c@1.24?nav=index.html|src/|src/arch|src/arch/ppc|src/arch/ppc/boot|src/arch/ppc/boot/simple

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
