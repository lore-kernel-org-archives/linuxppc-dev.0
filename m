Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F423C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:48:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BB1206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="K6TPrF6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BB1206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KGT20wdpzDqMW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 02:48:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="K6TPrF6G"; 
 dkim-atps=neutral
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KGRD3l5yzDqL7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 02:46:25 +1100 (AEDT)
Received: by mail-oi1-x241.google.com with SMTP id g16so1824069oib.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W+oPxX+piVpJ30lMLFWLXO5frI9ICTeBZDbNkkINo68=;
 b=K6TPrF6Gd0Rm8cnqAH4FSX4ju5kqgdcKWeArLF3aGlkb0COO9WtMkBFFqWX8vuBCC1
 1Oh8FfmxaaVfNPqid3tlVqyGC0CXaNmDrxv1Bm+iFBSgkUq+i00Xr40a/+Rhdcmus0Tp
 Ue/QgklPhjO9XyX9oDRWrZ98rO5KJnn6yCWoA4qey9uEof4IQmZnl3HSOMNmU2yQbAQy
 2SGJw6v5tfq0+7g5u/8dcDgm+SNhEPzr3++427mI5YjCNGHd3vioHbBD3Ue6zJJwZStg
 D76rbhciwPIu6TyS0LptOspjwLG0urszdpdESrAi3MpzIrfODP4ilNp5855L4KiF5vBI
 IiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W+oPxX+piVpJ30lMLFWLXO5frI9ICTeBZDbNkkINo68=;
 b=jdbwWthiR6CNHV6fY464cKHaVGu7+LZCu49/g/f7gvfnlSX5TeZ6SkgoNVjYLhasWT
 Xm/0c+P5PnAs/36ulXxX6/THXrmt9zrHSQxWhW+75ROqt/DtdNNda9je6Q6r39RjXO2Z
 d7csAySo7WMgRxbLVY3MRS/zOmsY7obZsG0xcpGTmvapxJeN0oT8nFxCLILn27ifKZx9
 +PHhqa3pIzs24EOO2Q47sA1XBHGVVDB5f9mI5jLE4uTehXI3+8cH2Q5xGz+MGpzEp8u9
 9OKHWJo12iO/qW26vd8xUcTBjIDT8aM1L10txUQ7czKr5E2SOYVGDRDbzbjiaGGs04ks
 ze7Q==
X-Gm-Message-State: APjAAAWp+Xh03byGGFu563HACX1dCe5V/P6hCYb0j5NsbpqtUMIb0K6O
 4gVCasR9TnRjtOjtmZFdhwT3MFeaWtnaMOAbxhJoEA==
X-Google-Smtp-Source: APXvYqzeFUEG6z2e2O4tKclCB8I51BgRRqaAVbxJi1OegFmDCC35wG8DixTGq05LsFK9tKxgwi01c1gRidpmHJjcdKc=
X-Received: by 2002:aca:54d8:: with SMTP id i207mr2145761oib.0.1552491981719; 
 Wed, 13 Mar 2019 08:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190309120721.21416-1-aneesh.kumar@linux.ibm.com>
 <8736nrnzxm.fsf@linux.ibm.com> <20190313095834.GF32521@quack2.suse.cz>
In-Reply-To: <20190313095834.GF32521@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 Mar 2019 08:46:10 -0700
Message-ID: <CAPcyv4irZP2F1acuco7UVbvTARzn5SXvCAWstFYtP7ygLRSXTg@mail.gmail.com>
Subject: Re: [PATCH v2] fs/dax: deposit pagetable even when installing zero
 page
To: Jan Kara <jack@suse.cz>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Linux MM <linux-mm@kvack.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Ross Zwisler <zwisler@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 13, 2019 at 2:58 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-03-19 10:17:17, Aneesh Kumar K.V wrote:
> >
> > Hi Dan/Andrew/Jan,
> >
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >
> > > Architectures like ppc64 use the deposited page table to store hardware
> > > page table slot information. Make sure we deposit a page table when
> > > using zero page at the pmd level for hash.
> > >
> > > Without this we hit
> > >
> > > Unable to handle kernel paging request for data at address 0x00000000
> > > Faulting instruction address: 0xc000000000082a74
> > > Oops: Kernel access of bad area, sig: 11 [#1]
> > > ....
> > >
> > > NIP [c000000000082a74] __hash_page_thp+0x224/0x5b0
> > > LR [c0000000000829a4] __hash_page_thp+0x154/0x5b0
> > > Call Trace:
> > >  hash_page_mm+0x43c/0x740
> > >  do_hash_page+0x2c/0x3c
> > >  copy_from_iter_flushcache+0xa4/0x4a0
> > >  pmem_copy_from_iter+0x2c/0x50 [nd_pmem]
> > >  dax_copy_from_iter+0x40/0x70
> > >  dax_iomap_actor+0x134/0x360
> > >  iomap_apply+0xfc/0x1b0
> > >  dax_iomap_rw+0xac/0x130
> > >  ext4_file_write_iter+0x254/0x460 [ext4]
> > >  __vfs_write+0x120/0x1e0
> > >  vfs_write+0xd8/0x220
> > >  SyS_write+0x6c/0x110
> > >  system_call+0x3c/0x130
> > >
> > > Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >
> > Any suggestion on which tree this patch should got to? Also since this
> > fix a kernel crash, we may want to get this to 5.1?
>
> I think this should go through Dan's tree...

I'll merge this and let it soak in -next for a week and then submit for 5.1-rc2.
