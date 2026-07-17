Return-Path: <linuxppc-dev+bounces-24340-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B448EC44520
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 12:33:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1q7l1M06z2yZf;
	Fri, 17 Jul 2026 22:33:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784281549;
	cv=none; b=EWD2PABD7oaHXowpHsCuDbBcG71OrlHbbl6wHIw+mrhq8ImTkUC4vtyiJZB7kF3cSIb3ZweqBp+mBZHO/ZNgoCkgozMosNUIJTYhhaQmTyZJ9NWDtd+EqkMqwEEFMBC7k/0QzrA4mgTyVRM0Lao0ods2OLzpMwXPo2af1T04vja9awUs1ROJDXCxUAZpLv44x1AAFoE6YK6FQBWS2HW1WmIgOyYjeFNp+PYD0/OEdm0ZNJC2MbBov2OTZUvafF5szNdNqbY/jM8SbgUs69XgkIVpuCBZ9xE+NKk/+PCcE6+FOOsz9n5fcwikhxW+42fV1CK+BmDRmnBCvU3+36dQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784281549; c=relaxed/relaxed;
	bh=JeN6L9OQDa61aGIOj8TdZeM9r1wDWjCL4f4dro+sHvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWe3ITiW0LI2YEr2s6Yixlb7RhE50XJ0ivPmLxj7Gy95WZl5qRwU6piFeiwSjR0ByhxVa93qtYeI37cT8zLfsDMQxODHsSqd0TkLG1wx3AcUiFdKUMDZONObc9w4FUIH2bLfjyOkR6nJJPn8kAezj5X2vNqrQcbt7K+x7O43e1xFsnA8z+gj/5BfCH6cWRRtISBwVJROsK3hmsP1ZNwn8HQ4mDt/ugv8wClMpqA0c0mJjOww2MpebeT7m+FRFtGsFH+1T6tRlkZwpLZ+CvBVvK/bFaSqlaRCQcSA5250ps0notNhNSqehGqY0EmJD0dwJXTCiZuHZ8bny64znJDe/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k9dKMU2f; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VsoON9jG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k9dKMU2f; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VsoON9jG; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=fmancera@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k9dKMU2f;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VsoON9jG;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k9dKMU2f;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VsoON9jG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=fmancera@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1lQh385pz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 19:45:48 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 486F93E6A;
	Fri, 17 Jul 2026 09:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784281540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JeN6L9OQDa61aGIOj8TdZeM9r1wDWjCL4f4dro+sHvA=;
	b=k9dKMU2fMBSZyO5ixLb4oPu1SB18vmntYnB9fk4ZP0NI7ATI+mhNdmpwE+b0S38DkfxG0u
	O9eMNaMhtZPNyGoJq+jYM1VBvZtKPRZcAViyozs6YdLeaxbejRmX1mMRrHNt07jwhAgPQh
	dhY2HtM4Ox/WWGvFnBNt1mQMaYZ2Mqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784281540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JeN6L9OQDa61aGIOj8TdZeM9r1wDWjCL4f4dro+sHvA=;
	b=VsoON9jGFvPfo24ZXt3rxTLh7pmaRMr6K2LOTIQW02QRgMhULJhp6L5W7SIZCp/ErPNOwm
	HfsSvgxmmqleQ0AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784281540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JeN6L9OQDa61aGIOj8TdZeM9r1wDWjCL4f4dro+sHvA=;
	b=k9dKMU2fMBSZyO5ixLb4oPu1SB18vmntYnB9fk4ZP0NI7ATI+mhNdmpwE+b0S38DkfxG0u
	O9eMNaMhtZPNyGoJq+jYM1VBvZtKPRZcAViyozs6YdLeaxbejRmX1mMRrHNt07jwhAgPQh
	dhY2HtM4Ox/WWGvFnBNt1mQMaYZ2Mqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784281540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JeN6L9OQDa61aGIOj8TdZeM9r1wDWjCL4f4dro+sHvA=;
	b=VsoON9jGFvPfo24ZXt3rxTLh7pmaRMr6K2LOTIQW02QRgMhULJhp6L5W7SIZCp/ErPNOwm
	HfsSvgxmmqleQ0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5309779AA;
	Fri, 17 Jul 2026 09:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TplfJcP5WWrpCgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 17 Jul 2026 09:45:39 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	maddy@linux.ibm.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	sjitindarsingh@gmail.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH] char: powernv-op-panel: remove unnecessary reset of position pointer
Date: Fri, 17 Jul 2026 11:45:19 +0200
Message-ID: <20260717094519.20656-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,ellerman.id.au,linux.ibm.com,linuxfoundation.org,arndb.de,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

The position pointer is only advanced if the return value of the write
operation is positive at ksys_write(). Therefore no need to manually
reset it when doing error handling.

Assisted-by: coccinelle  # to find it
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: i found this while fixing the same pattern in ipv6/ipv4 sysctl
proc handlers. This is not my area of expertise but I thought it was
worth contributing it :-)
---
 drivers/char/powernv-op-panel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/powernv-op-panel.c b/drivers/char/powernv-op-panel.c
index 63175b765c90..a98acb199805 100644
--- a/drivers/char/powernv-op-panel.c
+++ b/drivers/char/powernv-op-panel.c
@@ -89,7 +89,6 @@ static int __op_panel_update_display(void)
 static ssize_t oppanel_write(struct file *filp, const char __user *userbuf,
 			     size_t len, loff_t *f_pos)
 {
-	loff_t f_pos_prev = *f_pos;
 	ssize_t ret;
 	int rc;
 
@@ -105,7 +104,6 @@ static ssize_t oppanel_write(struct file *filp, const char __user *userbuf,
 		if (rc != OPAL_SUCCESS) {
 			pr_err_ratelimited("OPAL call failed to write to op panel display [rc=%d]\n",
 				rc);
-			*f_pos = f_pos_prev;
 			return -EIO;
 		}
 	}
-- 
2.55.0


