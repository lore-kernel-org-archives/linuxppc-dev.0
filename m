Return-Path: <dadair@ariodata.com>
Received: from orion.ariodata.com (adsl-64-170-199-186.dsl.snfc21.pacbell.net
	[64.170.199.186]) by ozlabs.org (Postfix) with ESMTP id 920D32BF12
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 12:57:31 +1100 (EST)
From: "David Adair" <dadair@ariodata.com>
To: <dadair@ariodata.com>, <linuxppc-embedded@ozlabs.org>
Date: Wed, 10 Nov 2004 17:57:35 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <ORIONhx27kBnccYTjr800000173@orion.ariodata.com>
Message-ID: <ORIONnKGXlMuYtSACMa00000004@orion.ariodata.com>
Subject: RE: Problems with MII mode operation on 440GP ethernet
Reply-To: dadair@ariodata.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> > I have a custom board with the same configuration (on 2.6). The
> > driver in that tree works in this configuration. FWIW, the port
> > also uses ocp calls to remove the three unused interfaces. In
> 
> This sounds reasonable to me -- OCP stays cpu generic but exact
> use is refined by the board port.
> 
> Can you give me any hints were to find the "ocp calls?"
> 

Ok, this was too dumb to let stand -- asm/ocp.h is pretty clear
and:

    /* Remove emac1 -- this board uses MII so there can only be one */
    ocp_remove_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);

makes my board work without hacking up the ibm_emac driver.

Thanks again Matt.

David
