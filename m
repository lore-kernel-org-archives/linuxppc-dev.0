Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 180D1B6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Apr 2011 12:11:29 +1000 (EST)
Date: Thu, 28 Apr 2011 12:11:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: linux-next: ibmveth runtime errors
Message-Id: <20110428121124.39c036ff.sfr@canb.auug.org.au>
In-Reply-To: <20110427103622.GA22781@rere.qmqm.pl>
References: <20110427144901.4c3f79b3.sfr@canb.auug.org.au>
	<20110427103622.GA22781@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
	Santiago Leon <santil@linux.vnet.ibm.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michał,

On Wed, 27 Apr 2011 12:36:22 +0200 Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
>
> Please test the following patch. It's just a blind guess, as this error
> is not descriptive.
> 
> Best Regards,
> Michał Mirosław
> 
> ---
> 
> net: ibmveth: force reconfiguring checksum settings on startup
> 
> Commit b9367bf3ee6d ("net: ibmveth: convert to hw_features") accidentally
> removed call to ibmveth_set_csum_offload() in ibmveth_probe(). Put the
> call back where it was, but with additional error checking provided
> by ibmveth_set_features().
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> ---
>  drivers/net/ibmveth.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
> index 4855f1f..0d1fea2 100644
> --- a/drivers/net/ibmveth.c
> +++ b/drivers/net/ibmveth.c
> @@ -1397,6 +1397,8 @@ static int __devinit ibmveth_probe(struct vio_dev *dev,
>  
>  	netdev_dbg(netdev, "registering netdev...\n");
>  
> +	ibmveth_set_features(dev, dev->features);
> +
>  	rc = register_netdev(netdev);
>  
>  	if (rc) {

This worked after I changed both "dev"s to "netdev".  And the boot
succedded.  I will apply this patchg to linux-next today and hopefully
Dave can apply it to the net tree.  I have added a copy fo the patch I
used below.

From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 28 Apr 2011 11:59:15 +1000
Subject: [PATCH] net: ibmveth: force reconfiguring checksum settings on
 startup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit b9367bf3ee6d ("net: ibmveth: convert to hw_features") accidentally
removed call to ibmveth_set_csum_offload() in ibmveth_probe(). Put the
call back where it was, but with additional error checking provided
by ibmveth_set_features().

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
[sfr: dev -> netdev]
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ibmveth.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
index 4855f1f..be3fe71 100644
--- a/drivers/net/ibmveth.c
+++ b/drivers/net/ibmveth.c
@@ -1397,6 +1397,8 @@ static int __devinit ibmveth_probe(struct vio_dev *dev,
 
 	netdev_dbg(netdev, "registering netdev...\n");
 
+	ibmveth_set_features(netdev, netdev->features);
+
 	rc = register_netdev(netdev);
 
 	if (rc) {
-- 
1.7.4.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
