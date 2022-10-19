Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5FBC4332F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Oct 2022 09:14:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MslRr5Mbmz3drW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Oct 2022 20:14:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mVjvQ8+v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=linux.intel.com (client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mVjvQ8+v;
	dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MslQp6pLZz3blY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2022 20:13:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170835; x=1697706835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1SnEG++lmkrZFM5w3ZM3z5ZQmAONQeCxSy4cYq4nyY8=;
  b=mVjvQ8+vFBs/pxpiAMx0ACPVcRn3Eot+YOIxcjzNOUmOYFEY8ub5xEhr
   9SrfFQovPC0dZjdaBSVb/qSjTMdKrSIZBVB3N1Cdsv88NpOHEw3xWY+GM
   kXkZ03g9j/SVuGuenIUSv7ypm3nejZDbHrQyjnn8sRrEdvHVghhZcxhfM
   PXnPaHI3rG6xn1KNVWXC2/T+viaIjqqUOfmn3kE+dB2UEwLlE0MK9P+im
   7ihUdymmcRFUf4PKQW2J10v5szs3eG8v/89jdNAXNooiQp5KAR0/aCqAO
   dVPu3xeS6WJ6EoktROIlmUBZgjYrB7pEOjkUjTlCOWNT2TbKrxSI9p1pO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306344507"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="306344507"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119003"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119003"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-serial@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 26/44] serial: pmac_zilog: Use uart_xmit_advance()
Date: Wed, 19 Oct 2022 12:11:33 +0300
Message-Id: <20221019091151.6692-27-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Take advantage of the new uart_xmit_advance() helper.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/pmac_zilog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index fe2e4ec423f7..13668ffdb1e7 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -410,8 +410,7 @@ static void pmz_transmit_chars(struct uart_pmac_port *uap)
 	write_zsdata(uap, xmit->buf[xmit->tail]);
 	zssync(uap);
 
-	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-	uap->port.icount.tx++;
+	uart_xmit_advance(&uap->port, 1);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&uap->port);
@@ -627,8 +626,7 @@ static void pmz_start_tx(struct uart_port *port)
 			return;
 		write_zsdata(uap, xmit->buf[xmit->tail]);
 		zssync(uap);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
+		uart_xmit_advance(port, 1);
 
 		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 			uart_write_wakeup(&uap->port);
-- 
2.30.2

