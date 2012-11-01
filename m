Return-Path: <gmane@reliableembeddedsystems.com>
Received: from delivery.mailspamprotection.com
 (delivery.mailspamprotection.com [69.175.69.93])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5ED322C02BC
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2012 20:48:06 +1100 (EST)
Received: from ns1.siteground150.com ([184.154.230.7]
 helo=serv01.siteground150.com)
 by se4.mailspamprotection.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.80.1) (envelope-from <gmane@reliableembeddedsystems.com>)
 id 1TTr4M-0002G6-1W
 for linuxppc-dev@ozlabs.org; Thu, 01 Nov 2012 04:28:22 -0500
Message-ID: <50924096.3020807@reliableembeddedsystems.com>
Date: Thu, 01 Nov 2012 11:27:50 +0200
From: Robert Berger <gmane@reliableembeddedsystems.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: APM/AMCC Kilauea board broken with 3.5+ kernel
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Roese <sr@denx.de>, rsarmah@apm.com, Mai La <mla@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Please correct me if I'm wrong, but I thought that one of the reasons to
bring a board to mainline is that if someone breaks it he/she also fixes
it (at least this is what I tell to the attendees of my trainings).

... but maybe that's not always the case ...

Before the commit[1] it worked, now it does not.

So I guess there are two options:
[] fix it
[] if not even APM cares about their own Kilauea board[2] it should be
thrown out of mainline

[1]git bisect tells us this:

247540b03bfcbbe26b86692c9424195d76eb67f0 is the first bad commit
commit 247540b03bfcbbe26b86692c9424195d76eb67f0
Author: Mai La <mla@apm.com>
Date:   Sun Mar 18 17:59:08 2012 +0000

    powerpc/44x: Fix PCI MSI support for Maui APM821xx SoC and Bluestone
board

    This patch consists of:
    - Enable PCI MSI as default for Bluestone board
    - Change definition of number of MSI interrupts as it depends on SoC
    - Fix returning ENODEV as finding MSI node
    - Fix MSI physical high and low address
    - Keep MSI data logically

    Signed-off-by: Mai La <mla@apm.com>
    Signed-off-by: Josh Boyer <jwboyer@gmail.com>

:040000 040000 607afba6ee61212756f2bcf5acd687d6266c39a8
2868a82b0ede19c9e38ec8a571a1004e555e1098 M      arch

[2]
https://myapm.apm.com/MyAMCC/retrieveDocument/PowerPC/405EX/PPC405EX_PB2051_EVK.pdf

Regards,

Robert..."As soon as we started programming, we found to our surprise
that it wasn't as easy to get programs right as we had thought.
Debugging had to be discovered.  I can remember the exact instant when I
realized that a large part of my life from then on was going to be spent
in finding mistakes in my own programs." - Maurice Wilkes discovers
debugging, 1949

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1
