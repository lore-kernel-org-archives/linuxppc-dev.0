Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7834BC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 10:44:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97D720869
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 10:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uD4kXIYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97D720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pTnw6RY5zF1S0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 21:44:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="uD4kXIYF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uD4kXIYF"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pTl75sZvzF14S
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 21:42:11 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id v9-v6so1939528pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 02:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KaX4ickUP2xJqqvsEKJ5Vs4ivT5tvDy6g+wMhbatxDg=;
 b=uD4kXIYFb0UAD7CZH1sMfBl0Hl/LFkEALDbaOGnECc0Q+Z51M27D5Yxz6DIBQzULxm
 reRWEigl7oxEHTH3Fn/OKOD9eiAvK8e7gV30tjZpsXAZv0pYS7q8U7RiTcNqxePQGyWb
 T90R/KWkXBCybaDSGu1ZkXXtBvWTNe0giqDyGNVToyPsPqRTgliVKGA17jc5nJ83eZ7N
 ELs/9S+pFDhTuYcYR+fpof+7qUodT0LW64VlWUjgNp4y8P759N/NKsBrTuWF3g5ZiEcO
 A6ay8bQ6G7bIfdXRNSKS69FMjkzUkFZhTwz5EiVEesgFb1hcXJoPnIgOKAdO/HVysEYF
 T7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KaX4ickUP2xJqqvsEKJ5Vs4ivT5tvDy6g+wMhbatxDg=;
 b=ETCxa+CtVdl7qE6NnwF52tldV9w33dE+qxwmLNSd/AJl/HFKmph+78XXag8Fsgin9m
 TL3a4WNXyG09DbcAHiTaeJvTmWUOoiUXwRLwcfmw/e1ezJNq+RB/emI9ykaRIVV7zy56
 xCoy/Q3b5wWBhi2JZJ5pBjvi1eOk3NS/8XAVgnQx0abWWthBuhoXJE2FSwzYyLpi6+PP
 7zoIKjzEAdKigkc1P31BO6+AIRIbP65/C86V3QcOfwV7sgsLIJcfsuj1nzZJCW7avwqJ
 I03WuRTuYcuWJIerk/IxxCMQw5viIHJ63+EeT91RYiho+7agEAH9eb3+f/h37RnCL3vR
 ZnGg==
X-Gm-Message-State: AGRZ1gK4M+cDIb1fmeYax56b44eWcCk/UlK6gH6vwiXrzt8KY5Irf40X
 PZYyQpN42mDhKXbovqAb5Xk=
X-Google-Smtp-Source: AJdET5eS/IZYoAV405Xq3B/n/CYAETwSCEmsxF9chUXPV5oaUfcXsaMbgz5UtiaC5m5z2cKDeXYtqA==
X-Received: by 2002:a65:5bc4:: with SMTP id o4mr6132232pgr.426.1541414529233; 
 Mon, 05 Nov 2018 02:42:09 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 r1-v6sm59238353pfb.41.2018.11.05.02.42.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 05 Nov 2018 02:42:08 -0800 (PST)
Date: Mon, 5 Nov 2018 21:42:04 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v11 00/26] Speculative page faults
Message-ID: <20181105104204.GB9042@350D>
References: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526555193-7242-1-git-send-email-ldufour@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: jack@suse.cz, sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
 Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, Punit Agrawal <punitagrawal@gmail.com>, hpa@zytor.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, khandual@linux.vnet.ibm.com,
 Andrea Arcangeli <aarcange@redhat.com>, ak@linux.intel.com,
 Minchan Kim <minchan@kernel.org>, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>, paulmck@linux.vnet.ibm.com,
 npiggin@gmail.com, Jerome Glisse <jglisse@redhat.com>, dave@stgolabs.net,
 kemi.wang@intel.com, kirill@shutemov.name,
 Thomas Gleixner <tglx@linutronix.de>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>, aneesh.kumar@linux.vnet.ibm.com,
 akpm@linux-foundation.org, Tim Chen <tim.c.chen@linux.intel.com>,
 haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 17, 2018 at 01:06:07PM +0200, Laurent Dufour wrote:
> This is a port on kernel 4.17 of the work done by Peter Zijlstra to handle
> page fault without holding the mm semaphore [1].
> 
> The idea is to try to handle user space page faults without holding the
> mmap_sem. This should allow better concurrency for massively threaded

Question -- I presume mmap_sem (rw_semaphore implementation tested against)
was qrwlock?

Balbir Singh.
