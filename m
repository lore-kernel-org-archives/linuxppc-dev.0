Return-Path: <grant.likely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9BA1B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Mar 2011 06:59:37 +1100 (EST)
Received: by iym7 with SMTP id 7so3562958iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Feb 2011 11:59:34 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH] powerpc/macintosh: Fix __devexit annotation in rack-meter.c
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 28 Feb 2011 12:59:31 -0700
Message-ID: <20110228195931.2044.69345.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following warning was seen building rack-meter.c

WARNING: drivers/built-in.o(.text+0xac784): Section mismatch in reference from the function rackmeter_shutdown() to the function .devexit.text:rackmeter_stop_cpu_sniffer()
The function rackmeter_shutdown() references a function in an exit section.
Often the function rackmeter_stop_cpu_sniffer() has valid usage outside the exit section
and the fix is to remove the __devexit annotation of rackmeter_stop_cpu_sniffer.

This patch resolves the warning by removing the __devexit annotation from
rackmeter_stop_cpu_sniffer().

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/rack-meter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 39f660b..2637c13 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -283,7 +283,7 @@ static void __devinit rackmeter_init_cpu_sniffer(struct rackmeter *rm)
 	}
 }
 
-static void __devexit rackmeter_stop_cpu_sniffer(struct rackmeter *rm)
+static void rackmeter_stop_cpu_sniffer(struct rackmeter *rm)
 {
 	cancel_delayed_work_sync(&rm->cpu[0].sniffer);
 	cancel_delayed_work_sync(&rm->cpu[1].sniffer);
