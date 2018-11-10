Return-Path: <SRS0=qQPY=NV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5886C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 19:23:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188B420815
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Nov 2018 19:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HIgT0xWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188B420815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42sn4Z11gCzF14W
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 06:23:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HIgT0xWf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rere.qmqm.pl
 (client-ip=91.227.64.183; helo=rere.qmqm.pl;
 envelope-from=mirq-linux@rere.qmqm.pl; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HIgT0xWf";
 dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42smhN3xbjzF3Zk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 06:06:12 +1100 (AEDT)
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVL4zmZzBr;
 Sat, 10 Nov 2018 19:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1541876254; bh=7rQkWEZsCQfjIv+pT7sNkq69mXmlLknPPBmoeqeMNi8=;
 h=Date:From:Subject:To:Cc:From;
 b=HIgT0xWfizkbiexBP4DXIBLNK148Db5gKTPEWPO/lsxJwGcW2gWGtFL1lNrTND4H5
 AOhAsaORwRobZUIR1Wewwnic+33WGgRrTFJE6hYkQM6jSX4QsmGUijNMS6QUXlWadY
 lA7PKdx/OSO3QF46SY0wpc5Yn2c+2VhFxpTTSbXRnelkOatdS2mHmJ3D+q0vChZ1Ao
 alpXJLL/CZvrOJVuloP8PM7gdksO9LxK67kL6WNQvUBTXOKx1fCBh25N6wWppjr2YA
 sheg90lDfF5Vt9dZ5N/vxE96YE8P6YoQycZN9vTUpxTSfgNmBI0OkfLc6v05WMyA7s
 3SGFtgiZrbgOg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Sat, 10 Nov 2018 19:58:29 +0100
Message-Id: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 0/6] Remove VLAN.CFI overload
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: netdev@vger.kernel.org
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
Cc: linux-mips@linux-mips.org, Daniel Borkmann <daniel@iogearbox.net>,
 James Hogan <jhogan@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix BPF code/JITs to allow for separate VLAN_PRESENT flag
storage and finally move the flag to separate storage in skbuff.

This is final step to make CLAN.CFI transparent to core Linux
networking stack.

An #ifdef is introduced temporarily to mark fragments masking
VLAN_TAG_PRESENT. This is removed altogether in the final patch.

---
Michał Mirosław (6):
  net/skbuff: add macros for VLAN_PRESENT bit
  net/bpf: split VLAN_PRESENT bit handling from VLAN_TCI
  net/bpf_jit: MIPS: split VLAN_PRESENT bit handling from VLAN_TCI
  net/bpf_jit: PPC: split VLAN_PRESENT bit handling from VLAN_TCI
  net/bpf_jit: SPARC: split VLAN_PRESENT bit handling from VLAN_TCI
  net: remove VLAN_TAG_PRESENT

 arch/mips/net/bpf_jit.c          | 18 ++++++++---------
 arch/powerpc/net/bpf_jit_comp.c  | 15 +++++++-------
 arch/sparc/net/bpf_jit_comp_32.c | 13 ++++++------
 include/linux/if_vlan.h          | 11 ++++++-----
 include/linux/skbuff.h           | 10 +++++++++-
 lib/test_bpf.c                   | 14 +++++++------
 net/core/filter.c                | 34 ++++++++++++++------------------
 7 files changed, 60 insertions(+), 55 deletions(-)

-- 
2.19.1

