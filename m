Date: Fri, 10 May 2002 00:50:05 +1000
From: Anton Blanchard <anton@samba.org>
To: Bill Fink <billfink@mindspring.com>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>,
	jes@trained-monkey.org
Subject: Re: 2.4.19-pre8-ben0 acenic driver and 867 MHz G4 sound problems
Message-ID: <20020509145005.GP10468@krispykreme>
References: <20020509103702.528f1a7c.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020509103702.528f1a7c.billfink@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> Unfortunately, I now have
> a new problem as the acenic driver is now broken (using a NetGear GA620
> NIC).  The previously working version was from a 2.4.17-pre2-ben0 kernel.
> I can send a diff between the two sources if that would be of any help.

Does this patch help?

Jes could you please send this patch on to Marcelo/Linus, they want your
OK before taking it.

Anton

diff -urN linux-2.5/drivers/net/acenic.c linux-2.5_work/drivers/net/acenic.c
--- linux-2.5/drivers/net/acenic.c	Thu Apr  4 23:19:50 2002
+++ linux-2.5_work/drivers/net/acenic.c	Tue Apr  9 14:44:56 2002
@@ -2692,7 +2692,7 @@
 	flagsize &= ~BD_FLG_COAL_NOW;
 #endif

-	if (!ACE_IS_TIGON_I(ap)) {
+	if (ACE_IS_TIGON_I(ap)) {
 		writel(addr >> 32, &desc->addr.addrhi);
 		writel(addr & 0xffffffff, &desc->addr.addrlo);
 		writel(flagsize, &desc->flagsize);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
