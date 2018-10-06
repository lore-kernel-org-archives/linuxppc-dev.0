Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C72C65C30
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 12:17:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AE32147D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 12:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AE32147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42S5HR6nn2zF3bv
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 22:17:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42S5CC264ZzF3bY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 22:14:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42S5CC1YCdz9s47; Sat,  6 Oct 2018 22:14:15 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42S5CC1Bmcz9s5b; Sat,  6 Oct 2018 22:14:15 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a932ed3b718147c6537da290b7a91e990fdedb43
In-Reply-To: <20181005132123.6038-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Don't print kernel instructions in
 show_user_instructions()
Message-Id: <42S5CC1Bmcz9s5b@ozlabs.org>
Date: Sat,  6 Oct 2018 22:14:15 +1000 (AEST)
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
Cc: jannh@google.com, muriloo@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-10-05 at 13:21:23 UTC, Michael Ellerman wrote:
> Recently we implemented show_user_instructions() which dumps the code
> around the NIP when a user space process dies with an unhandled
> signal. This was modelled on the x86 code, and we even went so far as
> to implement the exact same bug, namely that if the user process
> crashed with its NIP pointing into the kernel we will dump kernel text
> to dmesg. eg:
> 
>   bad-bctr[2996]: segfault (11) at c000000000010000 nip c000000000010000 lr 12d0b0894 code 1
>   bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a10028 38810020 fb810050 7f8802a6
>   bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1b79> 4082002c e8010080 eb610048
> 
> This was discovered on x86 by Jann Horn and fixed in commit
> 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on usermode RIP").
> 
> Fix it by checking the adjusted NIP value (pc) and number of
> instructions against USER_DS, and bail if we fail the check, eg:
> 
>   bad-bctr[2969]: segfault (11) at c000000000010000 nip c000000000010000 lr 107930894 code 1
>   bad-bctr[2969]: Bad NIP, not dumping instructions.
> 
> Fixes: 88b0fe175735 ("powerpc: Add show_user_instructions()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/a932ed3b718147c6537da290b7a91e

cheers
