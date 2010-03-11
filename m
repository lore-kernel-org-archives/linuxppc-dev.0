Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-4.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 32E39B7D94
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 07:08:08 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 25/37] drivers/infiniband: use .dev.of_node instead of
	.node in struct of_device
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180605.4824.3613.stgit@angua>
Date: Thu, 11 Mar 2010 11:57:53 -0800
In-Reply-To: <20100311180605.4824.3613.stgit@angua> (Grant Likely's message of
	"Thu, 11 Mar 2010 11:06:06 -0700")
Message-ID: <adavdd2d41q.fsf@roland-alpha.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com,
	linux-ide@vger.kernel.org, James.Bottomley@suse.de,
	linux-i2c@vger.kernel.org, sparclinux@vger.kernel.org,
	jeremy.kerr@canonical.com, sfr@canb.auug.org.au,
	linux-scsi@vger.kernel.org, jgarzik@pobox.com,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, ben-linux@fluff.org,
	monstr@monstr.eu, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, gregkh@suse.de,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Seems fine... adding EHCA guys just to make sure.

 > .node is being removed
 > 
 > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
 > ---
 > 
 >  drivers/infiniband/hw/ehca/ehca_main.c |   11 ++++++-----
 >  1 files changed, 6 insertions(+), 5 deletions(-)
 > 
 > diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
 > index 129a6be..2639185 100644
 > --- a/drivers/infiniband/hw/ehca/ehca_main.c
 > +++ b/drivers/infiniband/hw/ehca/ehca_main.c
 > @@ -291,8 +291,9 @@ static int ehca_sense_attributes(struct ehca_shca *shca)
 >  	};
 >  
 >  	ehca_gen_dbg("Probing adapter %s...",
 > -		     shca->ofdev->node->full_name);
 > -	loc_code = of_get_property(shca->ofdev->node, "ibm,loc-code", NULL);
 > +		     shca->ofdev->dev.of_node->full_name);
 > +	loc_code = of_get_property(shca->ofdev->dev.of_node, "ibm,loc-code",
 > +				   NULL);
 >  	if (loc_code)
 >  		ehca_gen_dbg(" ... location lode=%s", loc_code);
 >  
 > @@ -720,16 +721,16 @@ static int __devinit ehca_probe(struct of_device *dev,
 >  	int ret, i, eq_size;
 >  	unsigned long flags;
 >  
 > -	handle = of_get_property(dev->node, "ibm,hca-handle", NULL);
 > +	handle = of_get_property(dev->dev.of_node, "ibm,hca-handle", NULL);
 >  	if (!handle) {
 >  		ehca_gen_err("Cannot get eHCA handle for adapter: %s.",
 > -			     dev->node->full_name);
 > +			     dev->dev.of_node->full_name);
 >  		return -ENODEV;
 >  	}
 >  
 >  	if (!(*handle)) {
 >  		ehca_gen_err("Wrong eHCA handle for adapter: %s.",
 > -			     dev->node->full_name);
 > +			     dev->dev.of_node->full_name);
 >  		return -ENODEV;
 >  	}
 >  
 > 
 > -- 
Roland Dreier  <rolandd@cisco.com>
For corporate legal information go to:
http://www.cisco.com/web/about/doing_business/legal/cri/index.html
