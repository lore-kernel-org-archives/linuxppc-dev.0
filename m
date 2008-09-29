Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 106E3DDE1C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 23:32:39 +1000 (EST)
Date: Mon, 29 Sep 2008 17:32:36 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20080929133236.GA19675@oksana.dev.rtsoft.ru>
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn>
	<2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
	<20080925104847.GA311@oksana.dev.rtsoft.ru>
	<48E05742.1030609@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48E05742.1030609@pobox.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Wang Jian <lark@linux.net.cn>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When no irq specified the pata_of_platform fills the irq_res with -1,
which is wrong to do for two reasons:

1. By definition, 'no irq' should be IRQ 0, not some negative integer;
2. pata_platform checks for irq_res.start > 0, but since irq_res.start
   is unsigned type, the check will be true for `-1'.

Reported-by: Steven A. Falco <sfalco@harris.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Mon, Sep 29, 2008 at 12:19:14AM -0400, Jeff Garzik wrote:
> Anton Vorontsov wrote:
>> On Thu, Sep 25, 2008 at 06:40:59PM +0800, Li Yang wrote:
>>> On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
>>>> The alternative fix can be.
>>> This one is better as 0 is defined as 'invalid irq' for all
>>> architectures.  Added linux-ide and Anton to cc.
>>
>> Thanks for the correct Cc.
>>
>> I've sent a patch to fix the issue more than a month ago.
>>
>> http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg22851.html
>>
>> Jeff, could you apply the patch?
>
> Can you resend, I don't seem to have it...

Here it is.

Thanks,

 drivers/ata/pata_of_platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 408da30..1f18ad9 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
 
 	ret = of_irq_to_resource(dn, 0, &irq_res);
 	if (ret == NO_IRQ)
-		irq_res.start = irq_res.end = -1;
+		irq_res.start = irq_res.end = 0;
 	else
 		irq_res.flags = 0;
 
-- 
1.5.6.3
