Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2ACC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 15:38:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F52C2083D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 15:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="aZpreJfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F52C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NxzB4gM6zDqGQ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 02:38:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="aZpreJfZ"; 
 dkim-atps=neutral
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NxxM6D2NzDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:36:54 +1100 (AEDT)
Received: by mail-ot1-x344.google.com with SMTP id q24so18098252otk.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1unbtIvY5Ht57/xExEoU7Ql118n/fJ7lA1QdHqj8Odk=;
 b=aZpreJfZigo3FKFLPUZju3pojwCEccRahWR3gpAo6ZfCqnm80KEjECkjhF+s7IRotx
 5hw8tXb+CaJesSAIWhgcGCpQA7hZzzrZ+9f9SO7gvkUW5tGowDM/3iommlzv6U6burYI
 BNmd+EJvqFeLxFn81SfbhyntCt4bNsllLQoFNgz1f2lITd61wl+htoOGhnjBl014kN16
 IUmyQXlvPOSXPDY++j0eWwbcpoyyqtUpOsmNnsshnqRnsUDfJiLYo9EeHXeyyaz763AC
 q8MEBln0Af2RbQ8eLac+I5cLVBSiQ1cCA2cpKMnBa4WuGFMYa31AV8rxXkUOkAyb1YHe
 A1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1unbtIvY5Ht57/xExEoU7Ql118n/fJ7lA1QdHqj8Odk=;
 b=tQQSQjtlpR5TCQg4XD1ZiBF5412Ru7r3tZbHiiyqqyPI2oNmeokWEqp2ZSXziKTS6G
 JRUq/GMCl+huEkH5PFzf9Wujwe7ax8pkCExnh7p7Uaug6k/Qs76OITL871rl1VD6OS/t
 5j8Ef+fXqJKT1Q714/cLcimnGLRyKq14GM8d4mWUV4lpR5No3lG3iDLdDTBdBevdJVxE
 F+DQMFgu8aMX8+tIn1zc3zKz5f98NvjL5nyO3c+FO3CynBRnQWPKVI68JdC/AwrnHa9X
 KBYKSndG/GUrbTL1nI0TecpvYE6iaEgSmEbtK6wut8rFEuIChb8MbJX91T28UgPL2t9i
 nTcQ==
X-Gm-Message-State: APjAAAUJBFyCLXz7LAJtR73Lf/pMZ0D2pE+ll59yS5wBJZ78+1twqTM9
 2QjITYN25m2S/yaFc8ZDUsnZZiYAq9uIxOU6crY+7A==
X-Google-Smtp-Source: APXvYqxPZKAs3Uy3oIgghMayYyNVrb3KfDYOGyNEqIq7hCNaT+fTAAGNpB3SAeibiLTtMxkc/Xc9qQ6zh78W8KexrOw=
X-Received: by 2002:a9d:2c23:: with SMTP id f32mr1985166otb.353.1553009810711; 
 Tue, 19 Mar 2019 08:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com> <20190306124453.126d36d8@naga.suse.cz>
 <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
 <CAPcyv4iLm09DSiF3niFprP3PTFrgB5pZPp9AysBpRa-m725tmw@mail.gmail.com>
 <20190319084439.eya2pisiirattuil@kshutemo-mobl1>
In-Reply-To: <20190319084439.eya2pisiirattuil@kshutemo-mobl1>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 19 Mar 2019 08:36:38 -0700
Message-ID: <CAPcyv4jAMAenu-WJ1P9E-q728OVpvcajPxqPrW0+gQg_Jk1+0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To: "Kirill A. Shutemov" <kirill@shutemov.name>
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
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Oliver <oohall@gmail.com>,
 Ross Zwisler <zwisler@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 19, 2019 at 1:45 AM Kirill A. Shutemov <kirill@shutemov.name> w=
rote:
>
> On Wed, Mar 13, 2019 at 09:07:13AM -0700, Dan Williams wrote:
> > On Wed, Mar 6, 2019 at 4:46 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > > On 3/6/19 5:14 PM, Michal Such=C3=A1nek wrote:
> > > > On Wed, 06 Mar 2019 14:47:33 +0530
> > > > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> > > >
> > > >> Dan Williams <dan.j.williams@intel.com> writes:
> > > >>
> > > >>> On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
> > > >>>>
> > > >>>> On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> > > >>>> <aneesh.kumar@linux.ibm.com> wrote:
> > > >
> > > >> Also even if the user decided to not use THP, by
> > > >> echo "never" > transparent_hugepage/enabled , we should continue t=
o map
> > > >> dax fault using huge page on platforms that can support huge pages=
.
> > > >
> > > > Is this a good idea?
> > > >
> > > > This knob is there for a reason. In some situations having huge pag=
es
> > > > can severely impact performance of the system (due to host-guest
> > > > interaction or whatever) and the ability to really turn off all THP
> > > > would be important in those cases, right?
> > > >
> > >
> > > My understanding was that is not true for dax pages? These are not
> > > regular memory that got allocated. They are allocated out of /dev/dax=
/
> > > or /dev/pmem*. Do we have a reason not to use hugepages for mapping
> > > pages in that case?
> >
> > The problem with the transparent_hugepage/enabled interface is that it
> > conflates performing compaction work to produce THP-pages with the
> > ability to map huge pages at all.
>
> That's not [entirely] true. transparent_hugepage/defrag gates heavy-duty
> compaction. We do only very limited compaction if it's not advised by
> transparent_hugepage/defrag.
>
> I believe DAX has to respect transparent_hugepage/enabled. Or not
> advertise its huge pages as THP. It's confusing for user.

What does "advertise its huge pages as THP" mean in practice? I think
it's confusing that DAX, a facility that bypasses System RAM, is
affected by a transparent_hugepage flag which is a feature for
combining System RAM pages into larger pages. For the same reason that
transparent_hugepage does not gate / control hugetlb operation is the
same reason that transparent_hugepage should not gate / control DAX. A
global setting to disable opportunistic large page mappings of
System-RAM makes sense, but I don't see why that should read on DAX?
