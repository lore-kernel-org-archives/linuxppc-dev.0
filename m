Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 9A2BAB6EEA
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Aug 2010 20:54:24 +1000 (EST)
Received: by bwz11 with SMTP id 11so1789422bwz.15
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Aug 2010 03:54:22 -0700 (PDT)
Date: Sun, 1 Aug 2010 14:54:19 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Scott Wood <scottwood@freescale.com>
Subject: [PATCH] edac: mpc85xx: Add support for new MPCxxx/Pxxxx EDAC
	controllers (fix)
Message-ID: <20100801105419.GA352@oksana.dev.rtsoft.ru>
References: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
	<20100716151224.21d499a3@schlenkerla.am.freescale.net>
	<20100721153933.64d02086.akpm@linux-foundation.org>
	<20100721182108.5a22c822@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100721182108.5a22c822@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Peter Tyser <ptyser@xes-inc.com>,
	Doug Thompson <dougthompson@xmission.com>,
	linux-kernel@vger.kernel.org, Dave Jiang <djiang@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 21, 2010 at 06:21:08PM -0500, Scott Wood wrote:
[...]
> > > > +	{ .compatible = "fsl,p4080-l2-cache-controller", },
> > >
> > > L2 on the p4080 is quite different from those other chips.  It's part
> > > of the core, controlled by SPRs.
> >
> > erm, was that an ack or a nack?
>
> NACK, p4080 doesn't belong in this table, at least not its L2.
>
> L3 on p4080 is similar to L2 on these other chips, though, and it
> wouldn't take much to get this driver working on it -- but the match
> table entry should wait until the differences are accommodated.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---

Scott, thanks for catching this!

Andrew, please merge this patch into
edac-mpc85xx-add-support-for-new-mpcxxx-pxxxx-edac-controllers.patch

Thanks!

 drivers/edac/mpc85xx_edac.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index cfa86f7..b178cfa 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -652,7 +652,6 @@ static struct of_device_id mpc85xx_l2_err_of_match[] = {
 	{ .compatible = "fsl,p1020-l2-cache-controller", },
 	{ .compatible = "fsl,p1021-l2-cache-controller", },
 	{ .compatible = "fsl,p2020-l2-cache-controller", },
-	{ .compatible = "fsl,p4080-l2-cache-controller", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpc85xx_l2_err_of_match);
-- 
1.7.0.5
