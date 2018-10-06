Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA72DC65C30
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 12:30:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A41E2084D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 12:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A41E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42S5YY15kbzF3ct
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 22:30:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42S5WM1dR2zDqf1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 22:28:14 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w96CRqUH028316;
 Sat, 6 Oct 2018 07:27:52 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id w96CRokM028295;
 Sat, 6 Oct 2018 07:27:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 6 Oct 2018 07:27:50 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Raz <raziebe@gmail.com>
Subject: Re: Looking for architecture papers
Message-ID: <20181006122750.GF29268@gate.crashing.org>
References: <CAPB=Z-rEoVWFFDBS_XhuOQyL+YxR8jScSAAQfO1X-n_Lbm=StA@mail.gmail.com>
 <87sh1nk70y.fsf@concordia.ellerman.id.au>
 <CAPB=Z-pLCkXcsAXD5YWt5pwPzFzJrdZsdDye_bZjE0-ea-Ur6A@mail.gmail.com>
 <20181004101640.t3o7v73fcipsjg3k@lt-gp.iram.es>
 <CAPB=Z-pW6FWEp=0PgphCo-mAh9pPgt0frjz_MkPp6YHuhX3-pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPB=Z-pW6FWEp=0PgphCo-mAh9pPgt0frjz_MkPp6YHuhX3-pQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 06, 2018 at 12:19:45PM +0300, Raz wrote:
> Hey
> How does HVSC works ?
> I looked in the code and LoPAR documentation. It looks like there is
> vector called
> system_call_pSeries ( at 0xc00 ) that is supposed to be called when we
> invoke HVSC from kernel
> mode.
> Now, I wrote a NULL call HSVC and patched the exceptions-64s.S to
> return RFID immediately.
> This does not work.
> Would you be so kind to explain how HVSC works ?
> thank you

If your kernel is not running in hypervisor mode, sc 1 does not call the
kernel (but the hypervisor, instead).  If your kernel _is_ running in
hypervisor mode, sc 1 does the same as sc 0, a normal system call.

I don't know which it is for you; you didn't say.

I have no idea what "a NULL call HSVC" means.  If you make exception c00
return immediately (as you suggest) then you have made all system calls
non-functional, which indeed is unlikely to work as you want.


Segher
