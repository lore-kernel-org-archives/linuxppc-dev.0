Return-Path: <SRS0=DNDs=5F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE875C4332B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 09:53:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986CD20722
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 09:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986CD20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kJxc5WWpzDrg2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 20:53:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linutronix.de
 (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=bigeasy@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kJrw2RQHzDrcV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 20:49:19 +1100 (AEDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
 by Galois.linutronix.de with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1jFEH0-0000vL-B6; Fri, 20 Mar 2020 10:49:02 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: tglx@linutronix.de
Subject: [PATCH 0/5] Remove mm.h from arch/*/include/asm/uaccess.h
Date: Fri, 20 Mar 2020 10:48:51 +0100
Message-Id: <20200320094856.3453859-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200318204408.010461877@linutronix.de>
References: <20200318204408.010461877@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: rdunlap@infradead.org, peterz@infradead.org, linux-pci@vger.kernel.org,
 bigeasy@linutronix.de, linux-kernel@vger.kernel.org, joel@joelfernandes.org,
 will@kernel.org, mingo@kernel.org, dave@stgolabs.net, arnd@arndb.de,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 linuxppc-dev@lists.ozlabs.org, rostedt@goodmis.org, bhelgaas@google.com,
 kurt.schwemmer@microsemi.com, kvalo@codeaurora.org, balbi@kernel.org,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, oleg@redhat.com, netdev@vger.kernel.org,
 logang@deltatee.com, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The following mini-series removes linux/mm.h from the asm/uaccess.h of
the individual architecture. The series has been compile tested with the
defconfig and additionally for ia64 with the "special" allmodconfig
supplied by the bot. The regular allmod for the architectures does not
compile (even without the series).

Sebastian


