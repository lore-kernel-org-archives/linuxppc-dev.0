Return-Path: <SRS0=0bRz=5P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BA1C43331
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2020 07:46:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60D12073B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2020 07:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60D12073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48rPfM0RqpzDqhN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2020 18:46:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.128.68; helo=mail-wm1-f68.google.com;
 envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48rPcH2hg3zDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2020 18:44:31 +1100 (AEDT)
Received: by mail-wm1-f68.google.com with SMTP id r16so1011033wmg.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2020 00:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+lQxT4rOXYS7igvmWe+aSLt8H9b/hooDSaFj9dpIoBo=;
 b=i5O/veoN5JDzwFsXyGck4IwX2+e53LuHnVxjhLVXqGvi746tfgGIxRL7QHZtVOL+ST
 M0vNT5nSzsFLmG3/ZZG3RJQRohH7vm1KrPWCdwgBfbHUVwDlvZRZVi06VR2p/Z9XTeAu
 FwTC3D9hQfYFt1b4m0kfBH1BHjI9TkREFaPDuWxptZqMKdpbrmgl53kfm08kC8Zqh7u3
 HCgmU8PJMin+sqsC46unoZ2d/mCvg5U7FNa1n9zPJqk/JHdOzBWltJhKJhEROSdIMwyx
 yZOlVb1vjX+Fr2XTFo5mUUfqLVTx+4yqkXDpqUMR4P9gu9T/7tbljTZMd36FwTiNYLSp
 cqpA==
X-Gm-Message-State: ANhLgQ1YBX2RoNr1+1ymCLHmDgC2hAnzTL2+xTzcxRR959QApXkoIJmv
 hXL0SKB7+bnZ6+GQenGgmRM=
X-Google-Smtp-Source: ADFU+vv5zPfvR6n12LY62/oTKOim3ahnJoTy88I5ftZ61ckUgrrKlF39ljyabbjxRYuNzhw3oecv9w==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr11831239wmh.65.1585554268222; 
 Mon, 30 Mar 2020 00:44:28 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
 by smtp.gmail.com with ESMTPSA id p16sm20037964wmi.40.2020.03.30.00.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 00:44:27 -0700 (PDT)
Date: Mon, 30 Mar 2020 09:44:26 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20200330074426.GB14243@dhcp22.suse.cz>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200329001924.GS3039@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329001924.GS3039@MiWiFi-R3L-srv>
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
Cc: mmorana@amperecomputing.com, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Hoan Tran <Hoan@os.amperecomputing.com>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>, lho@amperecomputing.com,
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun 29-03-20 08:19:24, Baoquan He wrote:
> On 03/28/20 at 11:31am, Hoan Tran wrote:
> > In NUMA layout which nodes have memory ranges that span across other nodes,
> > the mm driver can detect the memory node id incorrectly.
> > 
> > For example, with layout below
> > Node 0 address: 0000 xxxx 0000 xxxx
> > Node 1 address: xxxx 1111 xxxx 1111
> 
> Sorry, I read this example several times, but still don't get what it
> means. Can it be given with real hex number address as an exmaple? I
> mean just using the memory layout you have seen from some systems. The
> change looks interesting though.

Does this make it more clear?
           physical address range and its node associaion
         [0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1]
-- 
Michal Hocko
SUSE Labs
