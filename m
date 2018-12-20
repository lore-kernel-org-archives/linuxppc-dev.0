Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB1FC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 09:53:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C78D2084A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 09:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cawo/LZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C78D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L6XX2zzRzDr0y
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 20:53:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cawo/LZy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="cawo/LZy"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L6TQ1zpczDqwB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 20:51:05 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id c123so670644pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 01:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=K9zzrRbAs14lLTCZYoWS/52u0ibfEdXn3/6zg6/SpNU=;
 b=cawo/LZyFHw0a9nn79FtBaUQ4o0n02ATimLl1BHixK3isAls4RqYinMz0vcvIlMupq
 US65dSQcksi+YlpEzqhBUDGpTcOWu99AOU6d4YCrQfaMFNNowj8LJNVcBjytOp55d2rC
 jA2NR2zDNO37sI78CvvxYGn/TVhdDq/O800R4jbUs3YNCfRiGhAYudWfvajTPt3PDqA4
 WBeM+MHNpYQo8UDXnV7tY4UAYHIubUHuSRKlVD/BYET0z5jUdBOHaVrXqDY7TPhNrQm9
 gQAsHC4H6DcXUUB7axSlNp8KYdJ996WGibUN/grzctgkeln2nxWQi6yP/mQF7LYklsOS
 UMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=K9zzrRbAs14lLTCZYoWS/52u0ibfEdXn3/6zg6/SpNU=;
 b=dDs74NFXc1AIaD43G+CfpcizVxkMVf5uZ3g+4X20nTrfcbs4rgO0fKjXUOwGyVzLGh
 UdFtTTczLyYohlgtVYNCm+choSGObL6fiVgO2UUh6oPo9EGZunD54DdH8tFyuj9YBiFV
 W5lvTa1zcZUZKTQklKDOVbd+Hw//FY1daE6/SQ2MtRgSj5N45m5TrcX6dt4vZxoZ5qG9
 Sr01FfBESRJxK3HKSf3bY09qlHXIxfd1zyYl7NT8fmLAuXPNgnViYggvSOtpiS/ipo3R
 2lPvGEO/isimed3OW/CG/VBp6tGOa5FCv5tiC+cAGvOzta5q5I2AbZNsKZFAlNBCN7FS
 jEhg==
X-Gm-Message-State: AA+aEWb1WyLdeaS/xqpoLNIfQEb8OidK5+LI6Cy43dAVGhIxpREgEmBg
 qBlXDnKsGFnzC2UtJJ3FnA==
X-Google-Smtp-Source: AFSGD/XeJOApkGvdkxd48eaI/6391uyxOM9NiHU/74wjWx2he8cZDiD+k3ub8z+DYADUJDzUDyikXQ==
X-Received: by 2002:a63:5518:: with SMTP id j24mr22083194pgb.208.1545299463150; 
 Thu, 20 Dec 2018 01:51:03 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 125sm33355206pfx.159.2018.12.20.01.50.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 01:51:02 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-mm@kvack.org
Subject: [PATCHv2 0/3] mm: bugfix for NULL reference in mm on all archs
Date: Thu, 20 Dec 2018 17:50:36 +0800
Message-Id: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Michal Hocko <mhocko@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 Pingfan Liu <kernelfans@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This bug is original reported at https://lore.kernel.org/patchwork/patch/1020838/
In a short word, this bug should affect all archs, where a machine with a
numa-node having no memory, if nr_cpus prevents the instance of nodeA, and the
device on nodeA tries to allocate memory with device->numa_node info.
And node_zonelist(preferred_nid, gfp_mask) will panic due to uninstanced nodeA.

And there are two alternative methods to fix it.
-1st. Fix it in mm system
-2nd. Fix it in all archs independently, by online all possible nodes.

Originaly, I tries to fix it by the 1st method, while Michal suggests the 2nd one.
This series [1-2/3] tries to resolve some defect in v1, pointed out by Michal.
For discussion purpose, I send [3/3] in this thread, which tries to show e.g of
the 2nd method on powerpc platform.
For x86, I still help Michal to verify his patch on my test machine, please see:
https://lore.kernel.org/patchwork/comment/1208479/
https://lore.kernel.org/patchwork/comment/1210452/

It has already cost a little long time to find a solution, cc x86 and ppc mailing list
and hope their maintainers to give some suggestion to speed up the final solution.

Pingfan Liu (3):
  mm/numa: change the topo of build_zonelist_xx()
  mm/numa: build zonelist when alloc for device on offline node
  powerpc/numa: make all possible node be instanced against NULL
    reference in node_zonelist()

 arch/powerpc/mm/numa.c | 13 ++++++--
 include/linux/gfp.h    | 10 +++++-
 mm/page_alloc.c        | 85 ++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 81 insertions(+), 27 deletions(-)

Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
-- 
2.7.4

