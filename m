Return-Path: <dja@axtens.net>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBfvT33CjzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 17:42:13 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 204so30755262pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jan 2017 22:42:13 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 0/3] powerpc/sparse: constify addresses in get_user macros
Date: Mon, 30 Jan 2017 17:41:52 +1100
Message-Id: <20170130064155.30281-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looking through the sparse warnings, I noticed that we were getting
warnings about dropping const qualifiers in get_user calls. This took
a while to figure out: it turns out that if you pass a const pointer
in, sparse will complain when we drop the const qualifier deep inside
the __get_user_ macros. This simple series fixes that, squashing over
60 warnings.

Daniel Axtens (3):
  powerpc/sparse: constify the address pointer in __get_user_check
  powerpc/sparse: constify the address pointer in __get_user_nocheck
  powerpc/sparse: constify the address pointer in __get_user_nosleep

 arch/powerpc/include/asm/uaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.9.3
