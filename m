Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61679C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 16:09:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9EC20643
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ev3mjXd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9EC20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KGxB5qKxzDqLS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:09:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="Ev3mjXd6"; 
 dkim-atps=neutral
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KGvN2qcfzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 03:07:27 +1100 (AEDT)
Received: by mail-ot1-x344.google.com with SMTP id m1so2241569otf.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/XfqRx4tzKzsjCcb8QbRLqX/uBHxzCtpu1uDPCItsOs=;
 b=Ev3mjXd6En91xODIUX56pYwhJLO9DdmQ95Gif+qABOQYxSXLSsL3HdkZ996LpFM0Ok
 BNFXboh0vkQcZET1UNi2xWbfJOgLi7YJOBlDe07HQIOTkXhyuZZtxYx1Jr323nQBINw1
 bCIVmxF4JR2efLcgr/ZOkQzDj5SYAbGOQud/xj7awoc+6yVUoor9qC0PAVErRf0dlx+t
 qM1zGEHB4PSIuwMXtFmThJuVWsfXkY8L4/6g612b2JAC90VycrbkkPGVtxjK+QjLV1tp
 zV3E3pIxFXDm4fJ1q4lhu5iiryNlMnlw3ajMFHOD83PMclLscUSXLEmMdZOnDZ62lqrK
 YZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/XfqRx4tzKzsjCcb8QbRLqX/uBHxzCtpu1uDPCItsOs=;
 b=t52i9uMFBHZuZN7UQ0d1R3J3Jc1ki5L0+hqXA3IY9VRhyjS5WuILXiAixY7j/o1cVH
 34XLGTSxesza6XA8MM2tI0Os7vml5eC/lAEIw/sP/eUf9ia+RbNXV7VOmt5KmwLZZnsb
 0gPYCJekOvqJS3RFbPw45OfK1SP4WPlQWeG4axOR5d7QRjv5tc5Fc+Q/c2JG8fQf/xai
 Cg5KWKGwkVzHRolSdkLOsjnOl1Fy1eCCTC2LilYpSwl75e7HUYZ2G0t7M7YzW4TcJdTw
 l5U3JbYYjoVQZwG609x74ibCOrFtNqqun6OEUzeQHeMUaHljwpcEPJDfmdxnWrt6GD8x
 OhVg==
X-Gm-Message-State: APjAAAX2sopdUFjxACf5ZFhfJKnpmCA2ZNP9HfYNax6SK+jtOjlL/PgC
 ANzb3kGa3wYjFTmdPDiiEy2GjmsaLfOukftoOkefXw==
X-Google-Smtp-Source: APXvYqzH9OHk6fwYw9vNd25aIvBEiA2sVSv1vjB2i+lT3GwQjeRBJM8aOKz1bJJDYo3s88am/imNu4byiUR9Jvcm8nc=
X-Received: by 2002:a9d:224a:: with SMTP id o68mr16122221ota.214.1552493244500; 
 Wed, 13 Mar 2019 09:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com> <20190306124453.126d36d8@naga.suse.cz>
 <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
In-Reply-To: <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 Mar 2019 09:07:13 -0700
Message-ID: <CAPcyv4iLm09DSiF3niFprP3PTFrgB5pZPp9AysBpRa-m725tmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Oliver <oohall@gmail.com>,
 Ross Zwisler <zwisler@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 6, 2019 at 4:46 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 3/6/19 5:14 PM, Michal Such=C3=A1nek wrote:
> > On Wed, 06 Mar 2019 14:47:33 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> >
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >>
> >>> On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
> >>>>
> >>>> On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> >>>> <aneesh.kumar@linux.ibm.com> wrote:
> >
> >> Also even if the user decided to not use THP, by
> >> echo "never" > transparent_hugepage/enabled , we should continue to ma=
p
> >> dax fault using huge page on platforms that can support huge pages.
> >
> > Is this a good idea?
> >
> > This knob is there for a reason. In some situations having huge pages
> > can severely impact performance of the system (due to host-guest
> > interaction or whatever) and the ability to really turn off all THP
> > would be important in those cases, right?
> >
>
> My understanding was that is not true for dax pages? These are not
> regular memory that got allocated. They are allocated out of /dev/dax/
> or /dev/pmem*. Do we have a reason not to use hugepages for mapping
> pages in that case?

The problem with the transparent_hugepage/enabled interface is that it
conflates performing compaction work to produce THP-pages with the
ability to map huge pages at all. The compaction is a nop for dax
because the memory is already statically allocated. If the
administrator does not want dax to consume huge TLB entries then don't
configure huge-page dax. If a hypervisor wants to force disable
huge-page-configured device-dax instances after the fact it seems we
need an explicit interface for that and not overload
transparent_hugepage/enabled.
