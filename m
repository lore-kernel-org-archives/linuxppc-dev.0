Return-Path: <SRS0=DyCn=ZM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E77C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 03:48:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950D22068F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 03:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nqvgh4pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950D22068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HpZv2qBgzDqnx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 14:48:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::341;
 helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="nqvgh4pk"; 
 dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HpXX4sRwzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 14:46:46 +1100 (AEDT)
Received: by mail-ot1-x341.google.com with SMTP id l14so19968971oti.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 19:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3qnLjkAQvsDWjadsTnrIPLiPzwT4BVVRmoZBHUtE63M=;
 b=nqvgh4pkFJrULBILgmm4jLkZM4n9K4lvU1sF9KX4nvAQW8FI0K7xCHfyqnidJJK+Kn
 Mz8O1miZgT0lUDfwwM50xMYAuKiukJCeu7hKmv53waJwKrmTghMM0s6iyfLYYb/eftIN
 ei5EkF+WlEg5NUlacpgv00l91/rwg9S36kupwKlmbaC2AXy/nt0YM574UVOEAXIzNMRJ
 XS9CMoEU7RLyXqyHLDDfu/el5BhcbTmW7DmMj1gsOiUzWaQJ/Jcn1UeAKNqleMleLHQd
 YLDsmd7bbKDXsfYhYiCupVrjvNXLi6Aj0rtbThS/aKjBaInbPvFiej1G48F3qauZFjZx
 v8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3qnLjkAQvsDWjadsTnrIPLiPzwT4BVVRmoZBHUtE63M=;
 b=g8y94PFmAQWOpXfLYhrsEHQc3xBu0+BtXSaVXj2AYU1x6wi/BY4uwBdtnAiOzt249I
 tMU2ntHe9DHQpamZJVnF31psYxmcnmxBuJ+Y2bKxvNC5EoO7h+N26xU1rjrUUjEU0rAA
 Rpfvt4PGniLgqveXXsm2bi4su7JTlXUcn8ocE1Rf4hweOnPqhHgJWgWasInsGxPlSBca
 lctfBf+WKdBjXArrJL5gjd/rBpY90zIOIXiOFLPVO2V7YUj8imjGfSucojmnM88pBeWi
 dSxVN1q0tUF3f7lChnJMfvLkL3K3Ga62S2U589saG5LQaHcuDz8FyuO7Pvuw4WMySw28
 aR9w==
X-Gm-Message-State: APjAAAUYKvKAR8M2buO3tpXu8cKSmOqFao+IK57zY82f30ZbIbmbU0i9
 eoZqwXm7A3oti+D3lfuv+L1uDjqOMNO+zrJONT1iSA==
X-Google-Smtp-Source: APXvYqwuEnjwj3Y53BLmq0qAZHHKArCZir8aQLMD50GiTMGTDqSHrw0JdA8bRbYsPfTf8sGoem5BHXLNz40Bbjc0ysI=
X-Received: by 2002:a05:6830:1b70:: with SMTP id
 d16mr277226ote.71.1574221603278; 
 Tue, 19 Nov 2019 19:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com>
 <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com>
 <CAPcyv4gMnSe26QfSBABx0zj3XuFqy=K1XaGnmE3h3sP3Y76nRw@mail.gmail.com>
 <4c6e5743-663e-853b-2203-15c809965965@linux.ibm.com>
 <CAPcyv4h42_1deZDaaW1RqX0Ls+maiFO_1e=6xJuHTa3wdWvVvA@mail.gmail.com>
 <87o8xp5lo9.fsf@linux.ibm.com> <8736eohva1.fsf@linux.ibm.com>
 <CAPcyv4hroohsrXT1YHQB-L8ZFa2kUW+bKy03We4Mt7afeJgu3Q@mail.gmail.com>
 <87o8x9h5qa.fsf@linux.ibm.com>
 <CAPcyv4gv52NK4+=3wcJ2uKX7xnaYVaF-H6O-XfJK8MiRX60SBg@mail.gmail.com>
 <7e9a19c1-992f-a92a-172d-bcbad1298c41@linux.ibm.com>
In-Reply-To: <7e9a19c1-992f-a92a-172d-bcbad1298c41@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 19 Nov 2019 19:46:31 -0800
Message-ID: <CAPcyv4hTVqdj9_8SYfkeohiQYuvRPf1MA7dvFmC8GqV1y4tN5w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size
 validation arch dependent
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 19, 2019 at 7:19 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 11/19/19 11:28 PM, Dan Williams wrote:
> > On Mon, Nov 18, 2019 at 1:52 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >>
> >>> On Sat, Nov 16, 2019 at 4:15 AM Aneesh Kumar K.V
> >>> <aneesh.kumar@linux.ibm.com> wrote:
> >>>>
> >>
> >> ....
> >>
> >>
> >>>>
> >>>> Considering the direct-map map size is not going to be user selectable,
> >>>> do you agree that we can skip the above step 0 configuration you
> >>>> suggested.
> >>>>
> >>>> The changes proposed in the patch series essentially does the rest.
> >>>>
> >>>> 1) It validate the size against the arch specific limit during
> >>>> namespace creation. (part of step 1)
> >>>
> >>> This validation is a surprise failure to ndctl.
> >>>
> >>>> 2) It also disable initializing a region if it find the size not
> >>>> correctly aligned as per the platform requirement.
> >>>
> >>> There needs to be a way for the user to discover the correct alignment
> >>> that the kernel will accept.
> >>>
> >>>> 3) Direct map  mapping size is different from supported_alignment for a
> >>>> namespace. The supported alignment controls what possible PAGE SIZE user want the
> >>>> namespace to be mapped to user space.
> >>>
> >>> No, the namespace alignment is different than the page mapping size.
> >>> The alignment is only interpreted as a mapping size at the device-dax
> >>> level, otherwise at the raw namespace level it's just an arbitrary
> >>> alignment.
> >>>
> >>>> With the above do you think the current patch series is good?
> >>>
> >>> I don't think we've quite converged on a solution.
> >>
> >> How about we make it a property of seed device. ie,
> >> we add `supported_size_align` RO attribute to the seed device. ndctl can
> >> use this to validate the size value. So this now becomes step0
> >>
> >> sys/bus/nd/devices/region0> cat btt0.0/supported_size_align
> >> 16777216
> >> /sys/bus/nd/devices/region0> cat pfn0.0/supported_size_align
> >> 16777216
> >> /sys/bus/nd/devices/region0> cat dax0.0/supported_size_align
> >> 16777216
> >
> > Why on those devices and not namespace0.0?
>
> sure.
>
> >
> >> We follow that up with validating the size value written to size
> >> attribute(step 1).
> >>
> >> While initializing the namespaces already present in a region we again
> >> validate the size and if not properly aligned we mark the region
> >> disabled.
> >
> > The region might have a mix of namespaces, some aligned and some not,
> > only the misaligned namespaces should fail to enable. The region
> > should otherwise enable successfully.
> >
>
> One misaligned namespace would mean, we get other namespace resource
> start addr wrongly aligned. If we allow regions to be enabled with
> namespace with wrong size, user would find further namespace creation in
> that regions failing due to wrongly aligned resource start. IMHO that is
> a confusing user experience.
>

Why would one wrongly aligned namespace prevent other namespaces from
being aligned? There's no requirement that consecutive namespaces are
allocated contiguously. Also consider a namespace that starts
misaligned, but ends aligned. That subsequent namespace can be enabled
without issue.
