Return-Path: <SRS0=Akx6=S5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E61C43218
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:03:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51BB208C2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 13:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51BB208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rrhc2DZBzDqW1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 23:03:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=212.227.126.130; helo=mout.kundenserver.de;
 envelope-from=info@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rrSd4HvVzDqYM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 22:53:21 +1000 (AEST)
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mspy4-1gVqbE43aa-00tCHb; Sat, 27 Apr 2019 14:52:37 +0200
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/41] drivers: tty: serial: dz: fix use fix bare 'unsigned'
Date: Sat, 27 Apr 2019 14:51:45 +0200
Message-Id: <1556369542-13247-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:CBJBinnswYpZ8Sdk7wFOAsULywVOOhB0O51QI1ZS6aG2XtvP5Ax
 rUdddfq4rw+u/9EFqOQzXc3/JM5V7fsK23L/z85bPCOANxd2GuzAoLWyurSK9Ii+GNlroRp
 D+hqD+3RuR/9qgEHat/Ucs2oZfFOYySxVG+wr6Q+wrWn6MY4YELLqYiMi6+Z1GHMHZ9Sbi6
 A0dnBU9i+mqDN3d/fmLxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MH/lZafoCx0=:C6VQMV1HsKH9OxnmfiwWwi
 ls6ASJ0mneciKIXS+1V+wSxBJcpan2IpZ08XLTD6SYv7YXOIMII1L/KWbG0T9oFUOLphs/Fg3
 l2AlwPRiDgZqonUsBVKpGTsKSv27ETHk1u8CP6XiFhZ9cNW2T3FLm/M/RZiJJEVU+b4hat+oG
 V/t5hoDjxIiN6XeMIGY3ZKep3tzRsiG+Yf5WrxF7xmHK3ns0GM3BNTiW1nXz2EqwNDtGAyeZq
 Vvqo3PBXcwPXiB6IUXXnKOdfKgojhgqctY7SufpZAYrm+1D2LBSe3PgUHcGQeS6y3DDBI1EER
 ik2lMkxjtSrUzyrZhTKgo1kjcSBthFwMG5B29FUWZC9SlsTzEYflKLY1mlrZ/DBKrktMH6+KG
 e3fXGk80CchhUtjMmL7Eyykp3o924p2zhQIBYAL0puuxE6/cYR/3HyeTlGe42KZuMH9EZn0+g
 n/3ogS9RFBh7aesoWqrAsTgXRq6ILeiUjg/9gPYWefwJguOeS1NTOW2WOOrphR2Dfrcvy72gC
 mu2hsdgjoNnA4njyhs3XxuFnlYyWLsuBOT3jqHXTTXDPK9vFMOFSfp50AeuB6lwEo12Rxs0Ip
 8eo0NdOrxwE+PMaT+iD6IJzKHMvoTFwflMb6JOcc69Pg8tOMFpOm2QWk0WlCbVyrrlaOAVFD2
 JxVH/iny2tox/lLVNnjx1smE1j9T7d7BKieB2e6XjF/H3MzZFm2Qw/hD3pnmYq+Kcy8sdTENK
 uVS7NH13R3Km3ewXsX6v4Ea4yuju79Q+cCDxjQ==
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org,
 linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org,
 sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org,
 vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org,
 khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com,
 matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org,
 andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix checkpatch warnings:

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #103: FILE: dz.c:103:
    +static u16 dz_in(struct dz_port *dport, unsigned offset)

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #110: FILE: dz.c:110:
    +static void dz_out(struct dz_port *dport, unsigned offset, u16 value)

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/dz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index b3e9313..559d076 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -100,14 +100,14 @@ static inline struct dz_port *to_dport(struct uart_port *uport)
  * ------------------------------------------------------------
  */
 
-static u16 dz_in(struct dz_port *dport, unsigned offset)
+static u16 dz_in(struct dz_port *dport, unsigned int offset)
 {
 	void __iomem *addr = dport->port.membase + offset;
 
 	return readw(addr);
 }
 
-static void dz_out(struct dz_port *dport, unsigned offset, u16 value)
+static void dz_out(struct dz_port *dport, unsigned int offset, u16 value)
 {
 	void __iomem *addr = dport->port.membase + offset;
 
-- 
1.9.1

