Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6711DC282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 09:55:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175FA20842
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 09:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175FA20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zJ1p1jX9zDqNj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:55:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.208.65; helo=mail-ed1-f65.google.com;
 envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zHzm1yLyzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 20:53:56 +1100 (AEDT)
Received: by mail-ed1-f65.google.com with SMTP id x7so1622881eds.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 01:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EFijitDAnYbGumAIWyNs+KdKOOdzXlmahj3GLOHXWfY=;
 b=Uf90/+o31PVKlHhFzjNYBleUTku/THjewJMa7w6IMv7snLRyl63lqpA28C/R8K8Um5
 fb8jpT3aByjCadnQYFoF8pFm8kBT4dIwHrxt02zw4VT4i7gmf8kwSLVvRPUOk9cULtsu
 ybCz1a+0BuAlUqJmyuYRNFOMizwTy7YvQhLTEYTQLkVjk9gVViC1q47bLdqh1O1is/Co
 XNw1XTgKwh97zb8nIUI7Dr2M3F7ZbPJoSPf019LO4dP3mYuqm+JW8jd54H2gaCVI49ly
 b8pLP5+GHR7J6iGpv8Unmc1kHzaoQjuBNYKbRlKIPvMRk2GeHzHlSMrEkVyXKuS29v2J
 S5yg==
X-Gm-Message-State: AHQUAuZg60XNRXVTh7tH+CayccZA9ZjhMexUb3Bo70s9EmCKmmARE0pq
 dDcrCTrQSOMSao69BWHwRh4=
X-Google-Smtp-Source: AHgI3IZuQQu7DIy+YQkt/vIiKLToazp6FM++4dnhmcZqF3E9VfSmrDOChUquc2Ds0W5XPmXFSJDecA==
X-Received: by 2002:a17:906:32c7:: with SMTP id
 k7mr2066905ejk.180.1549965233523; 
 Tue, 12 Feb 2019 01:53:53 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com.
 [213.151.95.130])
 by smtp.gmail.com with ESMTPSA id i14sm2876791ejy.25.2019.02.12.01.53.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 01:53:52 -0800 (PST)
From: Michal Hocko <mhocko@kernel.org>
To: <linux-mm@kvack.org>
Subject: [PATCH 0/2] x86, numa: always initialize all possible nodes
Date: Tue, 12 Feb 2019 10:53:41 +0100
Message-Id: <20190212095343.23315-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Pingfan Liu <kernelfans@gmail.com>,
 Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@elte.hu>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,
this has been posted as an RFC previously [1]. There didn't seem to be
any objections so I am reposting this for inclusion. I have added a
debugging patch which prints the zonelist setup for each numa node
for an easier debugging of a broken zonelist setup.

[1] http://lkml.kernel.org/r/20190114082416.30939-1-mhocko@kernel.org


