Return-Path: <mel@csn.ul.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9D91B7B6C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 23:16:53 +1100 (EST)
From: Mel Gorman <mel@csn.ul.ie>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/4] powerpc: Fix minor build issues on 2.6.32-rc7 without
	CONFIG_XICS set
Date: Tue, 17 Nov 2009 12:07:35 +0000
Message-Id: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KConfig doesn't require CONFIG_XICS to be set with CONFIG_PSERIES but if
it's not set, there are numerous small build errors. This is a small series
of patches to allow CONFIG_XICS to be unset in the config.

XICS appears to be some sort of interrupt controller but I'm not sure how
common it is on systems that require CONFIG_PSERIES. If CONFIG_PSERIES
universally requires CONFIG_XICS, the better path might be to force it to
be set.

Testing was building with make oldconfig a configuration from 2.6.31 on
a PPC970.
