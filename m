Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C435DB710B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 02:50:07 +1100 (EST)
Date: Mon, 01 Nov 2010 08:50:30 -0700 (PDT)
Message-Id: <20101101.085030.226787287.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: All Applied micro boards are failing with current mainline kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <20101102023650.bc553e74.sfr@canb.auug.org.au>
References: <AANLkTikWWGpAM8+_z9fnngYuYSpT3NWgM7xeGkOzZ3jg@mail.gmail.com>
	<AANLkTikQuUcAMZKqZ3Rz5HVzOs+63-Y4VYUo5-3EM30H@mail.gmail.com>
	<20101102023650.bc553e74.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: eric.dumazet@gmail.com, rsarmah@apm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, therbert@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 2 Nov 2010 02:36:50 +1100

> Hi Josh,
> 
> On Mon, 1 Nov 2010 11:05:53 -0400 Josh Boyer <jwboyer@gmail.com> wrote:
>>
>> A few hints would be appreciated.
> 
> Remove the call to netif_stop_queue() from emac_probe().  Apparently,
> calling this before register_netdev() is now wrong (maybe always was).

Right.

I'll add this to net-2.6

--------------------
ibm_newemac: Remove netif_stop_queue() in emac_probe().

Touching the queue state before register_netdev is not
allowed, and besides the queue state before ->open()
is "don't care"

Reported-by: Josh Boyer <jwboyer@gmail.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ibm_newemac/core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 385dc32..06bb9b7 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -2871,7 +2871,6 @@ static int __devinit emac_probe(struct platform_device *ofdev,
 	SET_ETHTOOL_OPS(ndev, &emac_ethtool_ops);
 
 	netif_carrier_off(ndev);
-	netif_stop_queue(ndev);
 
 	err = register_netdev(ndev);
 	if (err) {
-- 
1.7.3.2
