Return-Path: <SRS0=6H9d=RF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C406C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 00:41:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2891206DD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 00:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2891206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44B6sk1d65zDqVJ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 11:41:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linutronix.de
 (client-ip=2a01:7a0:2:106d:700::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44B6qs33f3zDqTY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 11:39:37 +1100 (AEDT)
Received: from p5492e5b8.dip0.t-ipconnect.de ([84.146.229.184] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gzs3x-0008CO-RD; Sat, 02 Mar 2019 00:59:34 +0100
Date: Sat, 2 Mar 2019 00:59:33 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: PROBLEM: monotonic clock going backwards on ppc64
In-Reply-To: <877edik9qu.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.DEB.2.21.1903020052530.1638@nanos.tec.linutronix.de>
References: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
 <877edik9qu.fsf@concordia.ellerman.id.au>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
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
Cc: John Stultz <john.stultz@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Jakub Drnec <jaydee@email.cz>, Stephen Boyd <sboyd@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2 Mar 2019, Michael Ellerman wrote:
> > The problem seems to be in vDSO code in arch/powerpc/kernel/vdso64/gettimeofday.S.
> 
> You're right, the wall-to-monotonic offset (wtom_clock_sec) is a signed
> 32-bit value, so that seems like it's going to have problems.
> 
> If I do `date -s 2037-1-1` I see:
> 
> [   26.024061] update_vsyscall: tk->wall_to_monotonic.tv_sec -2114341175
> [   26.042633] update_vsyscall: vdso_data->wtom_clock_sec    -2114341175
> 
> Which looks sane.
> 
> But then 2040-1-1 shows:
> 
> [   32.617020] update_vsyscall: tk->wall_to_monotonic.tv_sec -2208949168
> [   32.632642] update_vsyscall: vdso_data->wtom_clock_sec     2086018128
> 
> ie. the larger negative offset has overflowed and become positive.
> 
> But then when we go back to 2037 we get a negative offset again and
> monotonic time appears to go backward and things are unhappy.
> 
> I don't know this code well, but the patch below *appears* to work. I'll
> have a closer look on Monday.

Looks about right. The core hands in the 64bit offset already.

Thanks,

	tglx


