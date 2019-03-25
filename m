Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A84CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 22:38:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0A7206DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 22:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GiML85P6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0A7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Sq0j66q9zDqMg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 09:38:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="GiML85P6"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Spz01LD3zDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 09:36:43 +1100 (AEDT)
Received: by mail-ot1-x342.google.com with SMTP id u15so9628127otq.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 15:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sTcPY30C0OSYzeNRaa/EPMGmie/8U7JXyLn50zJf1Pw=;
 b=GiML85P6LCslgtDlslKCCUhWvbv1y+nvEc56Q0X8Qjel5DMzDzfar6+H7s6fmu2h3d
 dLEyyqXH0XMmCTgsIn3yhKqlcM+JBYc0UTK5/fEknfFXNcWh7vZB4qk8YZDtnv5IAp1l
 JJmvxmcMseSRffwnab8HmvfayPrxqWL01+eSLrgeJSA/9velnAvwDxgjJF0ugNsd/ZFW
 LpEP4qbgPu6yg3gM3ufLilvbIHnGxS7z2m60QKWTsLURCVB/tyWdotVRQdzsF7WEone8
 YAzkam1P/6bRoe78GssUpwMMiqKYpvFyZCQg0hkxWxLA+GhGDSF3+u1c5KgRvgkutwHN
 +uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sTcPY30C0OSYzeNRaa/EPMGmie/8U7JXyLn50zJf1Pw=;
 b=JfYXmMdk1D1B0G//DkiXI7vV518S13c+X6kN+UWehnBO7EhpLmElMuqN5TCsX6UNQ2
 tA0wNBVMMfGTIeOLWOCjRdb/s/ut96MEoTZxcIT9NWFatG4Bt9o4cG4xFPsVEVWV5hUx
 3XXI6nhqIch9Yw9TU9XJiFRk5aTJ5kqMqJA/A8SnrBkjDK8eqYErQoV6Adh7fsgUgdHn
 tcUYxskDbExZc6Nb+i7gtww9fdQE49CQoZ9wR3sgaPRwieDCEUDGXGYFqjRAApgqE7/7
 UohwagAWbjEG2ryFSOxNEf13QR0vpR/E7D8uM6gaukOdgyUEWtGdm0SXIErKaH13ivWG
 mqRw==
X-Gm-Message-State: APjAAAWqgbl22Fb+vAPNGC64Xp347pQtNFK5Y/sJm2oJWmIWXLsh0vFX
 W8kwHdYcmn5rTC9UTwewqaDasSWXEGcr1MRSm7UhRg==
X-Google-Smtp-Source: APXvYqxFqrAkIeS5L2WYBPBcjU2Ckw+9rPMAalcwIDZdE3acnVShZDDWo5M3SQr2UUBKcI362os2eQY4GbHhvkhCzss=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr20655282ota.214.1553553400410; 
 Mon, 25 Mar 2019 15:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-5-ira.weiny@intel.com>
 <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
 <20190325084225.GC16366@iweiny-DESK2.sc.intel.com>
 <20190325164713.GC9949@ziepe.ca>
 <20190325092314.GF16366@iweiny-DESK2.sc.intel.com>
 <20190325175150.GA21008@ziepe.ca>
 <20190325142125.GH16366@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190325142125.GH16366@iweiny-DESK2.sc.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 25 Mar 2019 15:36:28 -0700
Message-ID: <CAPcyv4hG8WDhsWinXHYkReHKS6gdQ3gAHMcfVWvuP4c4SYBzXQ@mail.gmail.com>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
To: Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Michal Hocko <mhocko@suse.com>, Linux-sh <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-rdma <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ingo Molnar <mingo@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2019 at 3:22 PM Ira Weiny <ira.weiny@intel.com> wrote:
[..]
> FWIW this thread is making me think my original patch which simply implemented
> get_user_pages_fast_longterm() would be more clear.  There is some evidence
> that the GUP API was trending that way (see get_user_pages_remote).  That seems
> wrong but I don't know how to ensure users don't specify the wrong flag.

What about just making the existing get_user_pages_longterm() have a
fast path option?
