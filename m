Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE1C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:24:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26B120645
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26B120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445SBK57J7zDq7k
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:24:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RND2rKWzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:47:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 445RNC6KmQz9sNQ; Fri, 22 Feb 2019 20:47:55 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RNC1yrvz9sMx; Fri, 22 Feb 2019 20:47:53 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 19f8a5b5be2898573a5e1dc1db93e8d40117606a
X-Patchwork-Hint: ignore
In-Reply-To: <20190212005829.GB7353@blackberry>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/powernv: Don't reprogram SLW image on every KVM guest
 entry/exit
Message-Id: <445RNC1yrvz9sMx@ozlabs.org>
Date: Fri, 22 Feb 2019 20:47:53 +1100 (AEDT)
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
Cc: Michael Ellerman <michael@ellerman.id.au>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-02-12 at 00:58:29 UTC, Paul Mackerras wrote:
> Commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via stop-api
> only on Hotplug", 2017-07-21) added two calls to opal_slw_set_reg()
> inside pnv_cpu_offline(), with the aim of changing the LPCR value in
> the SLW image to disable wakeups from the decrementer while a CPU is
> offline.  However, pnv_cpu_offline() gets called each time a secondary
> CPU thread is woken up to participate in running a KVM guest, that is,
> not just when a CPU is offlined.
> 
> Since opal_slw_set_reg() is a very slow operation (with observed
> execution times around 20 milliseconds), this means that an offline
> secondary CPU can often be busy doing the opal_slw_set_reg() call
> when the primary CPU wants to grab all the secondary threads so that
> it can run a KVM guest.  This leads to messages like "KVM: couldn't
> grab CPU n" being printed and guest execution failing.
> 
> There is no need to reprogram the SLW image on every KVM guest entry
> and exit.  So that we do it only when a CPU is really transitioning
> between online and offline, this moves the calls to
> pnv_program_cpu_hotplug_lpcr() into pnv_smp_cpu_kill_self().
> 
> Fixes: 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via stop-api only on Hotplug")
> Cc: stable@vger.kernel.org # v4.14+
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/19f8a5b5be2898573a5e1dc1db93e8d4

cheers
