Return-Path: <SRS0=dcvz=7D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E20AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 15:20:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80006207D8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 15:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80006207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49SYGq0VwjzDqc5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 01:20:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49SY7t1p6yzDqbY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2020 01:14:47 +1000 (AEST)
IronPort-SDR: FVTdZNDKY662qZqm5WYSjbmutvHoV8F02LM7E0dleNGNXNki2lYA/2VKbQiMIA1Sv9POif/Jr3
 8xJwuv4IoIjQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2020 08:14:35 -0700
IronPort-SDR: BwOSx3SLn5hYh7lfJYATkuwRv9Xo1tXSYFTpHS0cfstI4AjJK34k6fviFeZkvn7yH1q1zzDePs
 kBoQRWM5dS5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; d="scan'208";a="255335714"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
 by fmsmga008.fm.intel.com with ESMTP; 21 May 2020 08:14:34 -0700
Date: Thu, 21 May 2020 08:14:34 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] arch/{mips,sparc,microblaze,powerpc}: Don't enable
 pagefault/preempt twice
Message-ID: <20200521151434.GA176262@iweiny-DESK2.sc.intel.com>
References: <20200507150004.1423069-8-ira.weiny@intel.com>
 <20200518184843.3029640-1-ira.weiny@intel.com>
 <20200519165422.GA5838@roeck-us.net>
 <20200519184031.GB3356843@iweiny-DESK2.sc.intel.com>
 <20200519194215.GA71941@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519194215.GA71941@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-mips@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>,
 Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 19, 2020 at 12:42:15PM -0700, Guenter Roeck wrote:
> > On Tue, May 19, 2020 at 09:54:22AM -0700, Guenter Roeck wrote:
> > > as do the nosmp sparc32 boot tests,
> > > but sparc32 boot tests with SMP enabled still fail with lots of messages
> > > such as:
> > > 
> > > BUG: Bad page state in process swapper/0  pfn:006a1
> > > page:f0933420 refcount:0 mapcount:1 mapping:(ptrval) index:0x1
> > > flags: 0x0()
> > > raw: 00000000 00000100 00000122 00000000 00000001 00000000 00000000 00000000
> > > page dumped because: nonzero mapcount
> > > Modules linked in:
> > > CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B             5.7.0-rc6-next-20200518-00002-gb178d2d56f29 #1
> > > [f00e7ab8 :
> > > bad_page+0xa8/0x108 ]
> > > [f00e8b54 :
> > > free_pcppages_bulk+0x154/0x52c ]
> > > [f00ea024 :
> > > free_unref_page+0x54/0x6c ]
> > > [f00ed864 :
> > > free_reserved_area+0x58/0xec ]
> > > [f0527104 :
> > > kernel_init+0x14/0x110 ]
> > > [f000b77c :
> > > ret_from_kernel_thread+0xc/0x38 ]
> > > [00000000 :
> > > 0x0 ]
> > > 
> > > Code path leading to that message is different but always the same
> > > from free_unref_page().
> > > 
> > > Still testing ppc images.
> > > 
> 
> ppc image tests are passing with this patch.

How about sparc?  I finally got your scripts to run on sparc and everything
looks to be passing?

Are we all good now?

Thanks again!
Ira
