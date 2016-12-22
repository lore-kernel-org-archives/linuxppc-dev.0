Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tkZY06YCjzDwXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 13:02:44 +1100 (AEDT)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tkZY02J9Nz9t0G
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2016 13:02:44 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id i5so8639737pgh.2
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2016 18:02:44 -0800 (PST)
Date: Thu, 22 Dec 2016 12:02:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, Michal Marek
 <mmarek@suse.com>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Subject: Re: Build warning on 32-bit PPC - bisected to commit 989cea5c14be
Message-ID: <20161222120224.36202396@roar.ozlabs.ibm.com>
In-Reply-To: <53d94073-6e7e-af83-a29a-e811ab5fd802@lwfinger.net>
References: <53d94073-6e7e-af83-a29a-e811ab5fd802@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Dec 2016 13:49:07 -0600
Larry Finger <Larry.Finger@lwfinger.net> wrote:

> I am getting the following warning when I build kernel 4.9-git on my PowerBook 
> G4 with a 32-bit PPC processor:
> 
>    AS      arch/powerpc/kernel/misc_32.o
> arch/powerpc/kernel/misc_32.S:299:7: warning: "CONFIG_FSL_BOOKE" is not defined 
> [-Wundef]
> 
> This problem has been bisected to commit 989cea5c14be ("kbuild: prevent 
> lib-ksyms.o rebuilds").
> 
> Thanks,
> 
> Larry

Hi Larry,

This is strange you've bisected it there, I can't see how that patch would
trigger it. That said, powerpc has had a few small build system glitches.

It looks like this warning could be fixed by changing #elif CONFIG_FSL_BOOKE
to #elif defined (CONFIG_FSL_BOOKE). Want to send a patch (if it works)?

Thanks,
Nick
