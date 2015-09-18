Return-Path: <bethencourt@gmail.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com
 [IPv6:2a00:1450:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 13A621A2C9B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 07:05:32 +1000 (AEST)
Received: by wicgb1 with SMTP id gb1so47569616wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 14:05:28 -0700 (PDT)
Sender: Luis de Bethencourt <bethencourt@gmail.com>
From: Luis de Bethencourt <luis@debethencourt.com>
Date: Fri, 18 Sep 2015 23:05:27 +0200
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@fb.com>,
 Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <matthew.r.wilcox@intel.com>,
 Hannes Reinecke <hare@suse.de>, Wolfram Sang <wsa@the-dreams.de>,
 Uwe =?unknown-8bit?B?S2xlaW5lLUvDg8K2bmln?= <u.kleine-koenig@pengutronix.de>,
 Ross Zwisler <ross.zwisler@linux.intel.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: axonram: Fix module autoload for OF platform
 driver
Message-ID: <20150918210527.GA6733@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 arch/powerpc/sysdev/axonram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index d2b79bc..51b41c9 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -312,6 +312,7 @@ static const struct of_device_id axon_ram_device_id[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, axon_ram_device_id);
 
 static struct platform_driver axon_ram_driver = {
 	.probe		= axon_ram_probe,
-- 
2.4.6
