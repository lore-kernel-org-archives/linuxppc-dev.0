Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0B7C62BF0A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Oct 2004 13:29:14 +1000 (EST)
Date: Fri, 29 Oct 2004 20:29:08 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20041030032908.GB29945@gate.ebshome.net>
References: <642F8D42-2A11-11D9-A860-000393C30512@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <642F8D42-2A11-11D9-A860-000393C30512@freescale.com>
Subject: Re: RFC: performance monitor/oprofile support for e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 29, 2004 at 08:16:56PM -0500, Andy Fleming wrote:

[snip] 

+static int genmii_read_status(struct phy_mii_info *mii_info)
+{
+       u16 status;
+       int err;
+
+       /* Update the link, but return if there
+        * was an error */
+       err = genmii_update_link(mii_info);
+       if (err)
+               return err;
+
+       if (mii_info->autoneg) {
+               status = phy_read(mii_info, MII_LPA);

MII_LPA should be masked with MII_ADVERTISE here. 
E.g.
	status = phy_read(mii_info, MII_LPA) & phy_read(mii_info, MII_ADVERTISE);

--
Eugene
