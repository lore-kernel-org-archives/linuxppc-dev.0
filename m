Return-Path: <srs0=j3d0=f3=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw0j12CmszF09h
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 00:13:41 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zw0j109T0z8sk5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 00:13:41 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zw0hz6nqFz9sZ2
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2018 00:13:39 +1100 (AEDT)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 75FE6ACB1
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2018 13:13:36 +0000 (UTC)
Date: Mon, 5 Mar 2018 14:13:35 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: barrier_nospec for POWER
Message-ID: <20180305141335.086c4a52@kitsune.suse.cz>
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

Hello,

there is x86 barrier_nospec which implements the same barrier as the
earlier out-of-tree gmb() barrier but instead of sprinkling the barrier
randomly in kernel code it put it in copy_from_user. We have the
firmware support for barrier_nospec already reported from the hcall
which is used for RFI flushes. So copy-pasting this from x86 should not
be that difficult.

However, there is separate patch which protects the NR_syscalls check of
syscall entry which does not apply on powerpc because the check is done
in assembly. I did not manage to write a barrier_nospec that compiles
both in C and asm so you are spared a RFC patch.

Is there some work in progress on addressing this?

Thanks

Michal
