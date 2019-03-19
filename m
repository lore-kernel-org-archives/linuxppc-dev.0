Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C7C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 08:46:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFAA20854
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 08:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="H2yafXhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFAA20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Nmqn6klzzDqLS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 19:46:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="H2yafXhC"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Nmns0mgnzDqHb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 19:44:47 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id c8so6557429pfd.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 01:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=qAR3a4Tp536S5BF0fcnDXo7BSqIJ+Wix2hz2G88QfYw=;
 b=H2yafXhCxww2Ui/9GWn4Ibv+5222qc24hBAoz7mopK6XBNEl8YsyIGoBL4mxVsgNv1
 GBLIgNc751rNEJNNZENFQqArXrc9hT/wJVJv9horcQyoLACuk68xKiqmJDy1NxWUxFva
 VQbtkyhDQ4rS0v3TVhd+NS2TH8HT5XPiJmO2JYXNLOncoVFhe9x//OOexFxs4/jcGHdm
 Xa15eF/S8SUSaWh1XHCQoRMwCEd1gqxIO8goZoHmaDIwUbJwUiyxWSZgNnfgofVsrtIV
 b2YcyuElYoq66Y/1fXxI3tZGT0u+gr9rRYiYlBRKIlW2MHnJDFRhsVBxbVMxnjBFoexi
 O4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=qAR3a4Tp536S5BF0fcnDXo7BSqIJ+Wix2hz2G88QfYw=;
 b=smvYPGVWuiKvutKVMbnXk+Czr6ENdPRh2LP1IeKu6/fA2pSQXuX67FYDCssG5jLDXL
 uEnxV9NUdmtg6sA33q5hS/WHmbDhIUXh09Q6hTfRMADT9WxFNDmQ/hD3YFJPKIlklcMj
 ltLVIBWCt/KSpljl3Uynpft/JbkdHjflnfGboSQ1mSmgfRQNBPveZnlKF+OvHOor4exC
 r73VjF+PDKfW8h4JsmCG0BqfF/+u50lPh8uCCEYfuGrFojwTMEoGMmZYRjMAhGkFN0HW
 b1LF0x05VWp90k5WwNolzvvJF/Z8h3QsjRKv7kqhYTNR4m/Ywwg5kY1+V8UpP/ylwWyp
 LH6Q==
X-Gm-Message-State: APjAAAVVmbxhqCM7b1Ec0IerpKHzcMtCgtTMm7Hblx44fadJK6J5dsNT
 joMWz7qcBdh13iv8tZ6MFJODVw==
X-Google-Smtp-Source: APXvYqwQJhhbuKxbG07ohl6GTw3nbB9v8fuYg7I4XK9bC/v/Mt1y46+7YdnuVQi/DtVjy6lZCh0v3A==
X-Received: by 2002:a63:f905:: with SMTP id h5mr723037pgi.223.1552985084044;
 Tue, 19 Mar 2019 01:44:44 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
 by smtp.gmail.com with ESMTPSA id g188sm23542592pfc.24.2019.03.19.01.44.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Mar 2019 01:44:43 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 5C088300B98; Tue, 19 Mar 2019 11:44:39 +0300 (+03)
Date: Tue, 19 Mar 2019 11:44:39 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
Message-ID: <20190319084439.eya2pisiirattuil@kshutemo-mobl1>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com>
 <20190306124453.126d36d8@naga.suse.cz>
 <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
 <CAPcyv4iLm09DSiF3niFprP3PTFrgB5pZPp9AysBpRa-m725tmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4iLm09DSiF3niFprP3PTFrgB5pZPp9AysBpRa-m725tmw@mail.gmail.com>
User-Agent: NeoMutt/20180716
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
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Oliver <oohall@gmail.com>,
 Ross Zwisler <zwisler@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 13, 2019 at 09:07:13AM -0700, Dan Williams wrote:
> On Wed, Mar 6, 2019 at 4:46 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> >
> > On 3/6/19 5:14 PM, Michal Suchánek wrote:
> > > On Wed, 06 Mar 2019 14:47:33 +0530
> > > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > >> Dan Williams <dan.j.williams@intel.com> writes:
> > >>
> > >>> On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
> > >>>>
> > >>>> On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> > >>>> <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > >> Also even if the user decided to not use THP, by
> > >> echo "never" > transparent_hugepage/enabled , we should continue to map
> > >> dax fault using huge page on platforms that can support huge pages.
> > >
> > > Is this a good idea?
> > >
> > > This knob is there for a reason. In some situations having huge pages
> > > can severely impact performance of the system (due to host-guest
> > > interaction or whatever) and the ability to really turn off all THP
> > > would be important in those cases, right?
> > >
> >
> > My understanding was that is not true for dax pages? These are not
> > regular memory that got allocated. They are allocated out of /dev/dax/
> > or /dev/pmem*. Do we have a reason not to use hugepages for mapping
> > pages in that case?
> 
> The problem with the transparent_hugepage/enabled interface is that it
> conflates performing compaction work to produce THP-pages with the
> ability to map huge pages at all.

That's not [entirely] true. transparent_hugepage/defrag gates heavy-duty
compaction. We do only very limited compaction if it's not advised by
transparent_hugepage/defrag.

I believe DAX has to respect transparent_hugepage/enabled. Or not
advertise its huge pages as THP. It's confusing for user.

-- 
 Kirill A. Shutemov
