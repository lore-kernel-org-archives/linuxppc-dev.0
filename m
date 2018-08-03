Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hjY959VGzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:13:17 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 41hjY92nc3z9ryn
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2018 20:13:17 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 0/4] powerpc/64: copy_tofrom_user exception handling
 improvements
Date: Fri,  3 Aug 2018 20:13:02 +1000
Message-Id: <1533291186-5374-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a repost of a series that I posted back in 2016 but which was
never applied.  It aims to make the exception handling code in
__copy_tofrom_user_base clearer and easier to verify, and strengthens
the selftests for the user copy code to test all the paths and to test
the exception handling.  Finally it then fixes a deficiency in that
when copying to userspace we don't always copy quite as many bytes as
we could.

I have rebased this series on top of the powerpc next branch as of
today.

Paul.

 arch/powerpc/lib/copyuser_64.S                     | 585 +++++++++------------
 arch/powerpc/lib/copyuser_power7.S                 |  21 +-
 arch/powerpc/lib/memcpy_64.S                       |   9 +-
 arch/powerpc/lib/memcpy_power7.S                   |  22 +-
 .../testing/selftests/powerpc/copyloops/.gitignore |  17 +-
 tools/testing/selftests/powerpc/copyloops/Makefile |  44 +-
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |  44 +-
 .../powerpc/copyloops/copy_tofrom_user_reference.S |  24 +
 .../selftests/powerpc/copyloops/exc_validate.c     | 124 +++++
 tools/testing/selftests/powerpc/copyloops/stubs.S  |  19 +
 10 files changed, 516 insertions(+), 393 deletions(-)
