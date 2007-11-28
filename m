Return-Path: <SRS0+703ff539752438bf2049+1557+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E89D2DDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 06:56:42 +1100 (EST)
Subject: [PATCH] Stop phy code from returning success to unknown ioctls.
From: David Woodhouse <dwmw2@infradead.org>
To: jgarzik@pobox.com
In-Reply-To: <1196273071.30806.46.camel@pmac.infradead.org>
References: <1196273071.30806.46.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Wed, 28 Nov 2007 19:56:34 +0000
Message-Id: <1196279794.30806.54.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This kind of sucks, and prevents the Fedora installer from using the
device for network installs...

[root@efika phy]# iwconfig eth0                                                                                                                
Warning: Driver for device eth0 has been compiled with an ancient version                                                                      
of Wireless Extension, while this program support version 11 and later.                                                                        
Some things may be broken...                                                                                                                   
                                                                                                                                               
eth0        ESSID:off/any  Nickname:""                                                                                                         
          NWID:0  Channel:0  Access Point: 00:00:BF:81:14:E0                                                                                   
          Bit Rate:-1.08206e+06 kb/s   Sensitivity=0/0                                                                                         
          RTS thr:off   Fragment thr:off                                                                                                       
          Encryption key:<too big>                                                                                                             
          Power Management:off                                                                                                                 
                                                                                                                                               
Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 9bc1177..7c9e6e3 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -406,6 +406,9 @@ int phy_mii_ioctl(struct phy_device *phydev,
 				&& phydev->drv->config_init)
 			phydev->drv->config_init(phydev);
 		break;
+
+	default:
+		return -ENOTTY;
 	}
 
 	return 0;

-- 
dwmw2
