Return-Path: <nyushchenko@dev.rtsoft.ru>
Received: from dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
 by lists.ozlabs.org (Postfix) with ESMTP id 73F531A1072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:21:55 +1100 (AEDT)
Message-ID: <54E2E654.3010605@dev.rtsoft.ru>
Date: Tue, 17 Feb 2015 09:57:24 +0300
From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: powerpc: fsl,pq2-localbus is broken for ages
Content-Type: text/plain; charset=utf-8
Cc: 'Alexey Lugovskoy' <lugovskoy@dev.rtsoft.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

arch/powerpc/sysdev/fsl_lbc.c driver claims that it is compatible with
fsl,pq2-localbus and fsl,pq2pro-localbus

arch/powerpc/sysdev/fsl_lbc.c driver requires irq configured in device
tree since very old times (commit 3ab8f2a2 from 2.6.37 times)

None of in-tree dts files that have either fsl,pq2-localbus or
fsl,pq2pro-localbus, ever defined irq for that. As far as I understand,
that hardware did not have an irq.

This leads to problems running recent kernels on legacy Freescale boards.

I don't know if support for legacy boards worths fixing. Especially
since nobody cared for years. But maybe at least remove these
"compatible" lines from the drivers (and perhaps completely remove
broken support for pq2 boards at all)?

Nikita
