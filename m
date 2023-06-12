Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89DCC7EE2E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Jun 2023 16:43:14 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LQsZ9l51;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LsxfhaCW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QfyDJ57Fsz30XN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Jun 2023 02:43:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LQsZ9l51;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=LsxfhaCW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 451 seconds by postgrey-1.37 at boromir; Tue, 13 Jun 2023 02:42:19 AEST
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QfyCH3hq5z2yHs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2023 02:42:19 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686587682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYtSFWUwn9WeOG6ywaxCGLfcJEaLF6HVkDFCg6qR+Ck=;
	b=LQsZ9l51ZyERdBDY/oRFCecvIwE+OJgolEZLC4ju8TGaR2glRAeJkEh/gxmEEQdxccSBRn
	Nkl9fXN70FUGW8Vrk6QTB/EDkIx7KZeYmZ+6hqkw88Wj6xBlfn1lu+Axpx6v3exlkZA5qF
	xn2GoaB3iJJ9RyU+3AX5GakUlntQiVF6Hibsxe8KSuHme8DQAkGCpjlVrcKHcoU8CP84Gi
	tUjnTx26rAeD+Vkfrk88Jsc7seiQoKzogTWC3YOM2gU68500pq1a60LRxCGTeSHmS+D7Za
	Sh+Iz2iXp9c3W8f61IDOAPWsoCQmy1klWt0eQN6qeuRKQF37olv78N0KfobMdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686587682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYtSFWUwn9WeOG6ywaxCGLfcJEaLF6HVkDFCg6qR+Ck=;
	b=LsxfhaCWfQgNL2N4GKoci45k10Ud9BYivUCi/b7WfELtf3iXReMHlqJTp3PRRnpDSGYtJr
	yTdbFkV+sUvvFNAA==
To: Laurent Dufour <ldufour@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] powerpc: Add HOTPLUG_SMT support
In-Reply-To: <c0fe7b2c-1ce7-3d2f-0175-e61920fc3dee@linux.ibm.com>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-8-mpe@ellerman.id.au>
 <5752a488-be54-61a0-6d18-647456abc4ee@linux.ibm.com>
 <6e86aedb-9349-afd4-0bcb-1949e828f997@linux.ibm.com> <87h6rf81n9.ffs@tglx>
 <c0fe7b2c-1ce7-3d2f-0175-e61920fc3dee@linux.ibm.com>
Date: Mon, 12 Jun 2023 18:34:41 +0200
Message-ID: <87cz207i72.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-arch@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 12 2023 at 17:20, Laurent Dufour wrote:
> On 10/06/2023 23:10:02, Thomas Gleixner wrote:
>> This needs more thoughts to avoid a completely inconsistent duct tape
>> mess.
>
> Despite the test against smt_enabled_at_boot, mentioned above, I can't see
> anything else to rework. Am I missing something?

See my comments on the core code changes.

>> Btw, the command line parser and the variable smt_enabled_at_boot being
>> type int allow negative number of threads too... Maybe not what you want.
>
> I do agree, it should an unsigned type.

I assume you'll fix that yourself. :)

Thanks,

        tglx
