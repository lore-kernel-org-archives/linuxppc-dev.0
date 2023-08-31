Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E42C83F10
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Aug 2023 04:07:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rbngt2qw5z3dsW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Aug 2023 14:07:54 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RbncJ4kv7z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2023 14:04:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbncJ3ltVz4x2Y;
	Thu, 31 Aug 2023 14:04:48 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20230821142820.497107-1-mpe@ellerman.id.au>
References: <20230821142820.497107-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/powernv: Fix fortify source warnings in opal-prd.c
Message-Id: <169345455028.11824.13478126684024151530.b4-ty@ellerman.id.au>
Date: Thu, 31 Aug 2023 14:02:30 +1000
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
Cc: jniethe5@gmail.com, mahesh@linux.ibm.com, joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 22 Aug 2023 00:28:19 +1000, Michael Ellerman wrote:
> As reported by Mahesh & Aneesh, opal_prd_msg_notifier() triggers a
> FORTIFY_SOURCE warning:
> 
>   memcpy: detected field-spanning write (size 32) of single field "&item->msg" at arch/powerpc/platforms/powernv/opal-prd.c:355 (size 4)
>   WARNING: CPU: 9 PID: 660 at arch/powerpc/platforms/powernv/opal-prd.c:355 opal_prd_msg_notifier+0x174/0x188 [opal_prd]
>   NIP opal_prd_msg_notifier+0x174/0x188 [opal_prd]
>   LR  opal_prd_msg_notifier+0x170/0x188 [opal_prd]
>   Call Trace:
>     opal_prd_msg_notifier+0x170/0x188 [opal_prd] (unreliable)
>     notifier_call_chain+0xc0/0x1b0
>     atomic_notifier_call_chain+0x2c/0x40
>     opal_message_notify+0xf4/0x2c0
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/powernv: Fix fortify source warnings in opal-prd.c
      https://git.kernel.org/powerpc/c/feea65a338e52297b68ceb688eaf0ffc50310a83
[2/2] powerpc/powernv: Use struct opal_prd_msg in more places
      https://git.kernel.org/powerpc/c/22b165617b779418166319a19fd926a9c6feb9a3

cheers
