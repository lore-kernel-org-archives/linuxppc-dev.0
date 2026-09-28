Return-Path: <linuxppc-dev+bounces-28420-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA05DCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 17:40:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htpVw1KdHz3bTR;
	Tue, 29 Sep 2026 03:40:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790617240;
	cv=none; b=c0F3O4V/Yqqh/LR1i0kpB1KiB2FH576EO9MBrjmhO9aPPbLIgCjJpsFDMi7rlMpwx4nQbHmkGIpgFT4VyyrJf1G/51pn5tafY9FOVwnrbbHKw7B46fPYbiMyB/xRgHhaFJqgQuDvLKyAcxiTHFW+AaDMuZkHeILA5nOkcP2G3b1MNSA+DyUcTmtWUUEaC7ZTImXbbc10Igkw9SMMpw8rmo94Rc+W0P8AgJgvHoyiiDMlC3Q8HcTsu3Up95leJU4zyYmyNMBTrXF+2oot809SeZufdBXWrRf/owxVbD8IWv1ZAK6qzTiXBxTWcwziAmXnZ34Op6MmHQnspNJJTmQHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790617240; c=relaxed/relaxed;
	bh=tB5j9Ieax5DH9zx0vt2uvs8E8GXW1JSopJdrsg1Gquo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bdRXoCr8bPhqYM6SyUtb1Ph0FFYYIDlJRYIND0kA9Y2E4R61i5bi76MYw2O/l8gOCVVvrU9TFfrMhk8/S5FydmKKhi8P+WBJkvB+px0gnIPevmoodxaeL05qUFUlbs/8U4JvrwPB1SF3e3ixK87h41QMb+RRnR6l5V/jInDxoCyDYa1rMaX83Ezl3RqmwnwywjS/8P5vC7EDqovLExvZ3M3gbrV/Rmi0NCeaAxY5wSLqosoVExPGQg5/NT8wahD9BRhY+RF+krdu2Uo+fkKSj4jf3EUC51fvN/sQZRw8lulU/tR85T358XNKwATOUor+Eoz9ZJZaVTKKDORNYQITGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Mqh6F/U7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3lka6ag0kdckwfymtiuwndfsplttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Mqh6F/U7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3lka6ag0kdckwfymtiuwndfsplttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htpVv0XDdz30Wg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 03:40:38 +1000 (AEST)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cc1b8088202so2291442a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617237; x=1791222037; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tB5j9Ieax5DH9zx0vt2uvs8E8GXW1JSopJdrsg1Gquo=;
        b=Mqh6F/U7yZA3laSgx/BNYgu5i7pAKYu2Lyt6RchoI6ZDmtagc3frkIBeU25cSJQ1Pw
         3jppSVaEvMsl5s8gzZCk+1EvMo1/oFzISJK82hGpVdSVgXd5/ejncnQG6f/Oo0QkNIqJ
         /3txHWHza4Hszjc/T1INkRucrG7Md/pnVOKsvdi0Ad4NXpDYiWWEx9RjjDE46q+V0uWC
         X5stNhrKMi2p98lvtiGLcXzazP8cJllS8tHEIUPNz4RINTDEBrzLhbLzWwE38k06Zb7m
         RDkGkCTHcbdKfbfIb9QJ3JOtVnnbSeln5wJ09UZ8szzevn7pkk4V59RJTQEq8Ar+H/yu
         sKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617237; x=1791222037;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tB5j9Ieax5DH9zx0vt2uvs8E8GXW1JSopJdrsg1Gquo=;
        b=wfoWpeXVtnP9DbSjlVpFKEHAJahLJybpQ3xh4H7mEGe3hVdVpjjSvLwUwxO0hbtO8K
         hoQq9f1TnpCM0xxUPqJb3f5IldOuem8phXJHUyOhfNvOzFzTRlKjdZH9FQchBQjZFbuO
         E4JMasWrhBew5Us3MWKyLiECC5dCdCYEsYzjgFBT0jtXpxTbEpH/iGfGFIGqvB0qgShU
         87RynUvqAj8hou/ai80t6vcfuALEXtgJrkLYJkgxD17Qc08FA2Hf3928AZ7tn2W5iMtn
         daNPQ2KHiKy8pCmGhCpF6pN2uzkxVer4uHhlTICap8dG/XJRSRjvujXP4XAvMJmD5Jbi
         Pmgw==
X-Forwarded-Encrypted: i=1; AKwUvByD+zbYbWei4ofGTaoiOXnSJ5P7WBOqHqNWZet70tJqLc0JJqyoJ5aCxj3Xr2vkyEABDnJv9HvDlOj0f/Y=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mWoCuhKF1I6btr/XH+YZKa/ddwLObzxVlkWsFL/e61lhVJLhjB
	XkVuMQpqd1BRSS08TP2bSw5O0a4ljHofgjDKxSOBiMws8CY4CBPuTznwHGwvSFwSjMxArqxZ9Fm
	QK4INw1Cdm4PDsciAZ9vwflkQ4n/PCfVuaw==
X-Received: from pgbgf16.prod.google.com ([2002:a05:6a02:2cd0:b0:cc7:b01e:d448])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d1d:b0:3d7:b3c1:cc34 with SMTP id adf61e73a8af0-3de0e76e738mr10931497637.26.1790617236401;
 Mon, 28 Sep 2026 10:40:36 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:40:14 +0000
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
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
Mime-Version: 1.0
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260928-b4-fix-aer-memleaks-v5-3-ba6b94c9c9a6@google.com>
Subject: [PATCH v5 3/3] PCI/AER: Document that aer_recover_queue() takes
 ownership of aer_regs
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

ghes_handle_aer() allocates the AER register snapshot that it passes to
aer_recover_queue() from ghes_estatus_pool.  aer_recover_queue() returns
void, so the caller cannot tell whether the record was queued, and the
AER code owns the buffer from then on and must free it on every path.

None of this is documented at the definition of this exported function.
With GHES enabled, a new caller that passed a buffer from any other
allocator would hit the BUG() in gen_pool_free_owner() when the AER code
returns the buffer to ghes_estatus_pool, and a caller that freed the
buffer itself would cause a double free.

Add a kernel-doc comment that describes the parameters and states that
aer_recover_queue() takes ownership of @aer_regs, which must have been
allocated from ghes_estatus_pool.

No functional change.

Suggested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://lore.kernel.org/r/4513e7d4-4e2f-42d8-8f0c-2f0e03815dee@linux.intel.com
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a6600801af6e..a58244e00bc4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1404,6 +1404,24 @@ static void aer_recover_work_func(struct work_struct *work)
 static DEFINE_SPINLOCK(aer_recover_ring_lock);
 static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
 
+/**
+ * aer_recover_queue - queue an AER error record reported by firmware
+ * @domain: PCI domain (segment) of the device that reported the error
+ * @bus: bus number of the device that reported the error
+ * @devfn: encoded device and function number, as returned by PCI_DEVFN()
+ * @severity: AER_CORRECTABLE, AER_NONFATAL or AER_FATAL
+ * @aer_regs: snapshot of the device's AER Capability registers
+ *
+ * Queue an error record received from firmware through APEI GHES.  The
+ * record is processed later from a workqueue, which logs the error and,
+ * for uncorrectable errors, attempts recovery of the device.
+ *
+ * Takes ownership of @aer_regs, which must have been allocated from
+ * ghes_estatus_pool with a size of sizeof(struct aer_capability_regs).
+ * The buffer is freed with ghes_estatus_pool_region_free() by the work
+ * item that processes the record, or immediately if the queue is full.
+ * The caller must not access or free @aer_regs after this call.
+ */
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs)
 {

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


