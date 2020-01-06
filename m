Return-Path: <SRS0=nzsQ=23=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE7EC33C8C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 19:29:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739972081E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 19:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739972081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csclub.uwaterloo.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47s5D80QvczDqHj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 06:29:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csclub.uwaterloo.ca (client-ip=129.97.134.17;
 helo=caffeine.csclub.uwaterloo.ca; envelope-from=lsorense@csclub.uwaterloo.ca;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=csclub.uwaterloo.ca
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca
 [129.97.134.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47s59c2HGPzDqDP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2020 06:26:59 +1100 (AEDT)
Received: by caffeine.csclub.uwaterloo.ca (Postfix, from userid 20367)
 id 2058E4611D0; Mon,  6 Jan 2020 14:26:57 -0500 (EST)
Date: Mon, 6 Jan 2020 14:26:57 -0500
To: Romain Dolbeau <romain@dolbeau.org>
Subject: Re: PPC64: G5 & 4k/64k page size (was: Re: Call for report -
 G5/PPC970 status)
Message-ID: <20200106192656.b2ckfsgof57bvlz7@csclub.uwaterloo.ca>
References: <87mubxl82x.fsf@igel.home>
 <CADuzgbqU-SVy5U_4Pkv2G8SJcT9JhyirhFGamnQusZBSRSgcPw@mail.gmail.com>
 <87immlkytp.fsf@igel.home>
 <CADuzgbo=Yr09hxrkbkwj7Crg0aUfx+RQZOt0sCSNOeYUfR0SmA@mail.gmail.com>
 <87lfr62tbf.fsf@linux.ibm.com>
 <CADuzgbq3V0F=vob-tB=rroBaLwNR4viS2-=39TRBMyQwdj+xuw@mail.gmail.com>
 <874kx81xxt.fsf@linux.ibm.com>
 <CADuzgbqtn7knixB+tO3m-r0m7fDDQXVA=z2EtGxsfQ_GjD0h7Q@mail.gmail.com>
 <20200106185437.z2aiq3v4zxqmy2x4@csclub.uwaterloo.ca>
 <CADuzgbrw911a45Ep14vVO9WLBryp+DLTX5d5q3_ENDUrpGrpXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADuzgbrw911a45Ep14vVO9WLBryp+DLTX5d5q3_ENDUrpGrpXQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 jjhdiederen <jjhdiederen@zonnet.nl>,
 PowerPC List Debian <debian-powerpc@lists.debian.org>,
 Andreas Schwab <schwab@linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 06, 2020 at 08:11:47PM +0100, Romain Dolbeau wrote:
> Interesting idea (and I have a 6600 aka NV43 in there, indeed) but I
> don't think so, as
> a) 'nouveau' works in 4.19 with 64 KiB pages
> b) using "module_blacklist=nouveau" doesn't help, I just tried
> c) my original 'bisect' was probably using 'nouveau' when the kernel
> was booting, so at least some 5.x w/o the offending commit and 64 KiB
> pages is fine
> d) to my untrained eye, the crash happens _before_ nouveau is loaded
> (it seems to me I'm still on the OpenFirmware framebuffer, font change
> occurs later).
> 
> Unfortunately I don't have a PCIe OpenFirmware ATI card to test the
> theory further.
> (... well I _do_ have a Sun XVR-300 ... technically it fits the bill ... )

Oh well.  I guess that means they did fix it for all cards and I just
don't see which change was relevant for the older chips then.

Unless something was missed that only triggers occationally.  That would
be annoying.

-- 
Len Sorensen
