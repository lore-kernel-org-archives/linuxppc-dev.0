Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0712BC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 13:55:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F23208AE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 13:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F23208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P3gp0nrgzF39F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:55:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=diac24.net
 (client-ip=2a07:2ec0:2185::; helo=eidolon.nox.tf;
 envelope-from=equinox@diac24.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=diac24.net
Received: from eidolon.nox.tf (eidolon.nox.tf [IPv6:2a07:2ec0:2185::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P3by3WkrzDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 23:51:39 +1000 (AEST)
Received: from equinox by eidolon.nox.tf with local (Exim 4.90_1)
 (envelope-from <equinox@diac24.net>)
 id 1g6ybe-001QEG-Dy; Mon, 01 Oct 2018 15:51:26 +0200
Date: Mon, 1 Oct 2018 15:51:26 +0200
From: David Lamparter <equinox@diac24.net>
To: York Sun <york.sun@nxp.com>
Subject: Re: [PATCH ppc-next] powerpc/fsl-booke: don't load early TLB at once
Message-ID: <20181001135126.GP487685@eidolon.nox.tf>
References: <20180920224856.GJ487685@eidolon.nox.tf>
 <1537489893.7689.38.camel@redhat.com>
 <DB7PR04MB4298A6AD0F866804A3F4FB6F9A120@DB7PR04MB4298.eurprd04.prod.outlook.com>
 <666d304e5aeae639dbae2f5e9f62d7234041d6d2.camel@buserror.net>
 <DB7PR04MB4298007BF024E96CB6B2A02D9A120@DB7PR04MB4298.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR04MB4298007BF024E96CB6B2A02D9A120@DB7PR04MB4298.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
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
Cc: Scott Wood <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Scott Wood <swood@redhat.com>, David Lamparter <equinox@diac24.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

(Sorry about the delay on my end, deadlines ...)

On Fri, Sep 21, 2018 at 06:07:48PM +0000, York Sun wrote:
> On 09/21/2018 10:47 AM, Scott Wood wrote:
> > On Fri, 2018-09-21 at 17:40 +0000, York Sun wrote:
> >> On 09/20/2018 05:31 PM, Scott Wood wrote:
> >>> On Fri, 2018-09-21 at 00:48 +0200, David Lamparter wrote:
> >>>> My dusty old P4080DS just completely fails to boot (no output at all)
> >>>> without this revert.  I have no clue what's going on here, I just
> >>>> bisected it down and since it looks like an optimization to me I just
> >>>> reverted it - and voilá, the P4080 boots again.
> >>>
> >>> It's not an optimization; it was required to get kdump working, at least
> >>> for certain choices of crash kernel location.
[...]
> >>> York, can you try booting the latest kernel on p4080ds?
[...]
>
> Thanks for the instruction. Linux comes up OK with corenet32_smp_defconfig.
>
> root@p4080ds:~# uname -a
> Linux p4080ds 4.19.0-rc4-00206-ga27fb6d #1 SMP Fri Sep 21 10:56:36 PDT
> 2018 ppc GNU/Linux

Well, shoot.  I guess the next likely thing is that I have something
weird enabled in my .config, so I'll try booting corenet32_smp_defconfig
on my P4080DS.  (I vaguely think I did that at some point but I can't
swear to it so I'll just retry.)  If that doesn't boot, could either of
you provide me with your built uImage so I can exclude toolchain
stupidity?

=> I'll send another mail when I got to try corenet32_smp_defconfig.


Aaaand, during the past week I noticed this is a rev1.0 P4080 chip, which
apparently only exists on some early P4080DS boards - and Freescale even
did a replacement program to get rev2.0 boards out (I guess this one was
sitting in some broom closet.)  I don't have access to erratas for this,
I only know the entire QMan/FMan stuff is royally f*cked - no idea
whether the PPC core has issues too.

FWIW, my board is running perfectly stable with that patch I posted and
I'll just carry it locally if it's an issue for this one specific board
I have here.  I just don't have sufficient information to tell if that
is indeed the case.

Thanks a lot for your input and help,


-David
