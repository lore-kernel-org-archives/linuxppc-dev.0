Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D9EC3DA6E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Dec 2023 11:09:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T2xGG3Gvqz3dPs
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Dec 2023 22:09:42 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T2xDl5j2nz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Dec 2023 22:08:23 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T2xDk5KHSz4wxv;
	Sun, 31 Dec 2023 22:08:22 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20231221044510.1802429-1-haokexin@gmail.com>
References: <20231221044510.1802429-1-haokexin@gmail.com>
Subject: Re: [PATCH 0/3] powerpc: Fixes and optimization for the freezable kthread
Message-Id: <170402086352.3311386.15890824571777680274.b4-ty@ellerman.id.au>
Date: Sun, 31 Dec 2023 22:07:43 +1100
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Geoff Levand <geoff@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Pavel Machek <pavel@ucw.cz>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 21 Dec 2023 12:45:07 +0800, Kevin Hao wrote:
> The main changes include:
>   - Invoke set_freezable() for the kthread which could be frozen
>   - Drop redundant try_to_freeze() invocation
> 
> Kevin Hao (3):
>   powerpc: mpc83xx: Add the missing set_freezable() for
>     agent_thread_fn()
>   powerpc: mpc83xx: Use wait_event_freezable() for freezable kthread
>   powerpc: ps3: Add missing set_freezable() for ps3_probe_thread()
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc: mpc83xx: Add the missing set_freezable() for agent_thread_fn()
      https://git.kernel.org/powerpc/c/6addc560e69cd1b2e68ef43ad62a878ac1956f51
[2/3] powerpc: mpc83xx: Use wait_event_freezable() for freezable kthread
      https://git.kernel.org/powerpc/c/11611d254c15cce1f58431b2965c6edb5aa7e610
[3/3] powerpc: ps3: Add missing set_freezable() for ps3_probe_thread()
      https://git.kernel.org/powerpc/c/ccc0f7b7673e63139ba9d916f4567d4fadb14b55

cheers
