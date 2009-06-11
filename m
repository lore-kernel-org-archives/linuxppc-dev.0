Return-Path: <tony@bakeyournoodle.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 81335B7222
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 12:22:01 +1000 (EST)
Date: Thu, 11 Jun 2009 12:22:01 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [PATCH] Re:[BUILD FAILURE 04/04] Next June 04:PPC64 randconfig
	[drivers/net/ucc_geth.o]
Message-ID: <20090611022201.GI16602@bilbo.ozlabs.org>
References: <20090610174323.28045.70169.sendpatchset@subratamodak.linux.ibm.com>
	<20090611110523.1fd56a41.sfr@canb.auug.org.au>
	<1244685364.6494.14.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1244685364.6494.14.camel@subratamodak.linux.ibm.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, netdev@vger.kernel.org,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>, Li Yang <leoli@freescale.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 07:26:04AM +0530, Subrata Modak wrote:
> On Thu, 2009-06-11 at 11:05 +1000, Stephen Rothwell wrote:
> > Hi Subrata,
> > 
> > On Wed, 10 Jun 2009 23:13:23 +0530 Subrata Modak <subrata@linux.vnet.ibm.com> wrote:
> > >
> > >  	/* Find the TBI PHY.  If it's not there, we don't support SGMII */
> > > -	ph = of_get_property(np, "tbi-handle", NULL);
> > > +	ph = (phandle *)of_get_property(np, "tbi-handle", NULL);
> > 
> > You don't need this cast because of_get_property() returns "void *".
> 
> Stephen,
> 
> True. But without this gcc complains:
> 
> CC [M]  drivers/net/ucc_geth.o
> drivers/net/ucc_geth.c: In function ‘ucc_geth_probe’:
> drivers/net/ucc_geth.c:3824: warning: assignment discards qualifiers
> from pointer target type
> 
> Else gcc just builds fine:
> 
> CC [M]  drivers/net/ucc_geth.o
> 
> This is an just an extra caution to fix both the build and warning
> regression(s).

ph needs to be const.

I think the following untested (and hence un-signed-off-by) patch is closer,
however I also think that the whole SGMII setup code could use the various OF
helper functions better :)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index e2f2e91..796253d 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3603,6 +3603,7 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	struct resource res;
 	struct device_node *phy;
 	int err, ucc_num, max_speed = 0;
+	const phandle *ph;
 	const u32 *fixed_link;
 	const unsigned int *prop;
 	const char *sprop;
@@ -3821,7 +3822,7 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	/* Find the TBI PHY.  If it's not there, we don't support SGMII */
 	ph = of_get_property(np, "tbi-handle", NULL);
 	if (ph) {
-		struct device_node *tbi = of_find_node_by_phandle(*ph);
+		struct device_node *tbi = of_find_node_by_phandle(*ph), *mdio;
 		struct of_device *ofdev;
 		struct mii_bus *bus;
 		const unsigned int *id;

Yours Tony
