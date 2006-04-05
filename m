Return-Path: <sha@pengutronix.de>
Date: Wed, 5 Apr 2006 13:38:26 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: MPC5200 + LocalPlus Bus + memcpy
Message-ID: <20060405113825.GA9110@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I try to use jffs2 on a flash device connected to the mpc5200
LocalPlus Bus. This bus does not allow misaligned accesses.
The jffs2 code uses memcpy to copy from a word aligned address to an
odd address. The ppc memcpy implementation first copies three bytes to get
the target address word aligned, but then the source address is on an
odd address. The following word accesses on this unaligned address fail
badly.

I have fixed my problem by modifying the physmap mtd driver, but some
day someone wants to connect SRAM to the LocalPlus Bus and I guess he
will expect memcpy to work.

(BTW the arm implementation of memcpy seems to work around this problem)

Sascha
