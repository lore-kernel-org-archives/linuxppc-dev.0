Return-Path: <andreas.ruprecht@fau.de>
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de
 [131.188.11.21])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D02A1A074A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 04:33:32 +1000 (AEST)
Message-ID: <552C0AA6.4010403@fau.de>
Date: Mon, 13 Apr 2015 20:27:50 +0200
From: Andreas Ruprecht <andreas.ruprecht@fau.de>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
Subject: powerpc: Dead code in commit bdc728a849a7
Content-Type: text/plain; charset=utf-8
Cc: Paul Bolle <pebolle@tiscali.nl>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Stefan Hengelein <stefan.hengelein@fau.de>,
 Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,

your commit bdc728a849a7 ("powerpc: move find_and_init_phbs() to pSeries
specific code") in today's Linux next tree moves a function into the
pSeries specific setup.c file. I noticed it because I'm running an
automated bot on top of linux-next which looks for variability-related
defects with undertaker-checkpatch[0].

Inside the function, there is an #ifdef block which depends on
CONFIG_PPC32 to be set. However, the file at
arch/powerpc/platforms/pseries/setup.c will only be built if
CONFIG_PPC_PSERIES is enabled[1], which through its Kconfig dependencies
can only be selected if CONFIG_PPC64 is enabled[2]. As CONFIG_PPC32 and
CONFIG_PPC64 are mutually exclusive, the #ifdef can never evaluate to
true, and the corresponding code is dead.

Should I send a patch which removes the #ifdef and the dead code or
would you prefer to do this yourself?

Best regards,

Andreas

[0] https://undertaker.cs.fau.de
[1] arch/powerpc/platforms/Makefile, line 18
[2] arch/powerpc/platforms/pseries/Kconfig, line 2
