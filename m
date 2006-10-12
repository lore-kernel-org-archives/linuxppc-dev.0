Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E158B679E0
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 18:29:57 +1000 (EST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k9C8cPAu010475
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 03:38:26 -0500
Subject: [PATCH 0/4] powerpc: feature fixup updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 18:29:50 +1000
Message-Id: <1160641790.4792.132.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches are not to be merged yet as I haven't fully tested
them and I still want to do a few changes. I'm posting them for review
here.

They update the feature fixup mecanism to be nicer (C vs. asm), support
some level of nesting, and work with the vdso. This is needed for the
cell TB workaround which is the last patch of that serie

The remaining bits that need to be done before that queue can be merged,
in addition to testing, are:

 - add fixup of modules (should be easy. the __ftr_fixup and
__ftr_fw_fixup sections aren't fully filled at build time with modules,
there are relocs for them, so we need to be a bit careful there but it
should just work)

 - rework the cell workarounds to use a different method
