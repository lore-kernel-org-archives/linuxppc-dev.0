Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA5EC7618D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 00:29:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsMnx61M0z3g3V
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 10:29:41 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsMlx3CKqz3fdw
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2023 10:27:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsMlx1vvnz4xDt;
	Thu,  6 Apr 2023 10:27:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.ibm.com>
In-Reply-To: <1d0e727e7dbd9a28627ef08ca9df9c86a50175e2.camel@linux.ibm.com>
References: <1d0e727e7dbd9a28627ef08ca9df9c86a50175e2.camel@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/pseries/vas: Ignore VAS update for DLPAR if copy/paste is not enabled
Message-Id: <168074081764.3666874.3878218257202547858.b4-ty@ellerman.id.au>
Date: Thu, 06 Apr 2023 10:26:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 20 Mar 2023 19:50:08 -0700, Haren Myneni wrote:
> The hypervisor supports user-mode NX from Power10. pseries_vas_dlpar_cpu()
> is called from lparcfg_write() to update VAS windows for DLPAR event in
> shared processor mode and the kernel gets -ENOTSUPP for HCALLs if the
> user-mode NX is not supported. The current VAS implementation also
> supports only with Radix page tables. Whereas in dedicated processor
> mode, pseries_vas_notifier() is registered only if the copy/paste
> feature is enabled. So instead of displaying HCALL error messages,
> update VAS capabilities if the copy/paste feature is available.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries/vas: Ignore VAS update for DLPAR if copy/paste is not enabled
      https://git.kernel.org/powerpc/c/eca9f6e6f83b6725b84e1c76fdde19b003cff0eb

cheers
