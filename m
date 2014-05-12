Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 37D95140087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 14:12:09 +1000 (EST)
Message-ID: <1399867920.17624.73.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix "attempt to move .org backwards" error
 (again)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 14:12:00 +1000
In-Reply-To: <1399680478-4970-1-git-send-email-linux@roeck-us.net>
References: <1399680478-4970-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-09 at 17:07 -0700, Guenter Roeck wrote:
> Commit 4e243b7 (powerpc: Fix "attempt to move .org backwards" error) fixes the
> allyesconfig build by moving machine_check_common to a different location.
> While this fixes most of the errors, both allmodconfig and allyesconfig still
> fail as follows.
> 
> arch/powerpc/kernel/exceptions-64s.S:1315: Error: attempt to move .org backwards
> 
> Fix by moving machine_check_common after the offending address.

This suffers from the same problem as previous attempts, on some of my
test configs I get:

arch/powerpc/kernel/head_64.o:(__ftr_alt_97+0xb0): relocation truncated to fit: R_PPC64_REL14 against `.text'+1c90
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2

IE, it breaks currently working configs.

So we need to move more things around and I haven't had a chance to
sort it out.

Cheers,
Ben.
