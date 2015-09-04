Return-Path: <sojkam1@fel.cvut.cz>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
 by lists.ozlabs.org (Postfix) with ESMTP id EC8161A0725
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 23:41:17 +1000 (AEST)
From: Michal Sojka <sojkam1@fel.cvut.cz>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org, 
Subject: memcpy regression 
Date: Fri, 04 Sep 2015 15:33:51 +0200
Message-ID: <871teeux4w.fsf@steelpick.2x.cz>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Christophe,

my MPC5200-based system stopped booting recently. I bisected the problem
to your commit below. If I revert that commit (on top of
807249d3ada1ff28a47c4054ca4edd479421b671 = v4.2-6663-g807249d), my
system boots again.

commit 0b05e2d671c40cfb57e66e4e402320d6e056b2f8
Author: LEROY Christophe <christophe.leroy@c-s.fr>
Date:   Tue May 19 12:07:55 2015 +0200

    powerpc/32: cacheable_memcpy becomes memcpy
    
    cacheable_memcpy uses dcbz instruction and is more efficient than
    memcpy when the destination is in RAM. If the destination is in an
    io area, memcpy_toio() is normally used, not memcpy
    
    This patch renames memcpy as generic_memcpy, and renames
    cacheable_memcpy as memcpy
    
    On MPC885, we get approximatly 7% increase of the transfer rate
    on an FTP reception
    
    Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
    Signed-off-by: Scott Wood <scottwood@freescale.com>

Best regards,
-Michal Sojka
