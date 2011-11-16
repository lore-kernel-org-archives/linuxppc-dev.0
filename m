Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0BE3CB70C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 05:42:42 +1100 (EST)
Received: from mail49-va3 (localhost [127.0.0.1])	by mail49-va3-R.bigfish.com
 (Postfix) with ESMTP id 04BAA1804AD	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 16 Nov 2011 18:37:44 +0000 (UTC)
Received: from VA3EHSMHS023.bigfish.com (unknown [10.7.14.236])	by
 mail49-va3.bigfish.com (Postfix) with ESMTP id B8C916C0159	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 18:37:28 +0000 (UTC)
Message-ID: <4EC40406.1030408@freescale.com>
Date: Wed, 16 Nov 2011 12:42:14 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync disabled
 by KEXEC patch
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
> From: Li Yang <leoli@freescale.com>
> 
> The timebase sync is not only necessary when using KEXEC. It should also
> be used by normal boot up and cpu hotplug. Remove the ifdef added by
> the KEXEC patch.

Again, no it should not be used by normal boot up (whether KEXEC support
is enabled or not).  We should only do timebase sync when we actually
need to (when we've actually just reset a core), and we should do it the
way U-Boot does rather than with smp-tbsync.c.

-Scott
