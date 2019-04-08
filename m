Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01841C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:56:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BEB21473
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 15:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FjEjH8oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BEB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dFQk484YzDqNR
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 01:56:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="FjEjH8oq"; 
 dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dFNr2ZSJzDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 01:54:46 +1000 (AEST)
Received: by mail-ot1-x343.google.com with SMTP id o74so12567761ota.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DOD1pypLe94jr/T7lBG/UY8aWm0TnxhhMUj6XEFllZg=;
 b=FjEjH8oqASAGoY3oWhMWbcEek46J4T/r5VapLKuGBvpq4vmONjSw5iWsfnAEXC+7hv
 MsxN8dQOHHWP+r8qb3MJDxkU9XCnlirLetcrl2HbFninvIDnIJ69eh991wXDkZMd5ylk
 qFN2a/kuGqQ6uB53FkrFvvONmCEsixonM7AsYataZ8BsbfpbUzekyl/fkuBQz1PAYA5/
 L/vlzsPUhhRlPfuZEFYWtyFd7x64Ptv25oIdAgsuLieGgzJR8wd6D4IovjSGYWSYZBPx
 5ZmlddVUiAnHOIX9iXg3MBXncSP5Kn7C/JppAFcXMh4ajrdrKJrFgCB7jKJBfquvrmtN
 B29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DOD1pypLe94jr/T7lBG/UY8aWm0TnxhhMUj6XEFllZg=;
 b=hd/DizmvsrZ07clhaNDdYadYaLp3ZEZN/zO0zg4VIx/0UC+aRbca9idt97aoHDOOe4
 HGC3Tx0EJd3T6y+I8RlAvUcXjklHQW8RwmFIjbIK9crOrvH1ar0JLM+PbSZmX/h3hkrU
 mHDRL17abDhPnbjFwePzKQfFltJ0uFGKzgcXoArJHYpE7EwQqpgJV0EQgIoA9T+XKqPR
 RT3WbzwNOMS5KCoqtQWd+PR7OmyOpVE5LfuMI8TeDRZqnH1Bz7f5PE6x68dGiiGFt0UO
 yLWDX6FAfvKOeUDF8DLHuz1dRgVVUURsobWdrO5eA0FArr++heeSmsBxxrH63ML7tIsT
 WR9w==
X-Gm-Message-State: APjAAAU50Li//+SQ7L/DKC7+JKz9vms59bHbDwZqrknBA44BcWYW8o+O
 laMe/OvKMk/dYP8wsnq6WJPaqwW38IYhAheHtFg+3w==
X-Google-Smtp-Source: APXvYqyxFdjNMvG4MYJS/CnnPmtKxS7OIbJ+X/ge0OkLU2Y7BpdOvqkSfNeWc8IFOetR4KsZfhoXfC86jEWkg34kP7g=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr20104391otc.246.1554738883389; 
 Mon, 08 Apr 2019 08:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190309120721.21416-1-aneesh.kumar@linux.ibm.com>
 <8736nrnzxm.fsf@linux.ibm.com> <20190313095834.GF32521@quack2.suse.cz>
 <CAPcyv4irZP2F1acuco7UVbvTARzn5SXvCAWstFYtP7ygLRSXTg@mail.gmail.com>
 <87r2acn8eq.fsf@linux.ibm.com>
In-Reply-To: <87r2acn8eq.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 8 Apr 2019 08:54:31 -0700
Message-ID: <CAPcyv4hJ=fhXNYXwtUKwSY=dZo540bLX+d12j3HQswkNWFugRg@mail.gmail.com>
Subject: Re: [PATCH v2] fs/dax: deposit pagetable even when installing zero
 page
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Ross Zwisler <zwisler@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 8, 2019 at 2:39 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
>
>  Hi Dan,
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Wed, Mar 13, 2019 at 2:58 AM Jan Kara <jack@suse.cz> wrote:
> >>
> >> On Wed 13-03-19 10:17:17, Aneesh Kumar K.V wrote:
> >> >
> >> > Hi Dan/Andrew/Jan,
> >> >
> >> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >> >
> >> > > Architectures like ppc64 use the deposited page table to store hardware
> >> > > page table slot information. Make sure we deposit a page table when
> >> > > using zero page at the pmd level for hash.
> >> > >
> >> > > Without this we hit
> >> > >
> >> > > Unable to handle kernel paging request for data at address 0x00000000
> >> > > Faulting instruction address: 0xc000000000082a74
> >> > > Oops: Kernel access of bad area, sig: 11 [#1]
> >> > > ....
> >> > >
> >> > > NIP [c000000000082a74] __hash_page_thp+0x224/0x5b0
> >> > > LR [c0000000000829a4] __hash_page_thp+0x154/0x5b0
> >> > > Call Trace:
> >> > >  hash_page_mm+0x43c/0x740
> >> > >  do_hash_page+0x2c/0x3c
> >> > >  copy_from_iter_flushcache+0xa4/0x4a0
> >> > >  pmem_copy_from_iter+0x2c/0x50 [nd_pmem]
> >> > >  dax_copy_from_iter+0x40/0x70
> >> > >  dax_iomap_actor+0x134/0x360
> >> > >  iomap_apply+0xfc/0x1b0
> >> > >  dax_iomap_rw+0xac/0x130
> >> > >  ext4_file_write_iter+0x254/0x460 [ext4]
> >> > >  __vfs_write+0x120/0x1e0
> >> > >  vfs_write+0xd8/0x220
> >> > >  SyS_write+0x6c/0x110
> >> > >  system_call+0x3c/0x130
> >> > >
> >> > > Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
> >> > > Reviewed-by: Jan Kara <jack@suse.cz>
> >> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> >
> >> > Any suggestion on which tree this patch should got to? Also since this
> >> > fix a kernel crash, we may want to get this to 5.1?
> >>
> >> I think this should go through Dan's tree...
> >
> > I'll merge this and let it soak in -next for a week and then submit for 5.1-rc2.
>
> Any update on this? Did you get to merge this?

Thanks for the reminder. Will send this week along with some other
libnvdimm related fixes.
