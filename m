Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3DECB67B35
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 00:22:53 +1000 (EST)
Date: Tue, 30 May 2006 18:22:50 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: [SOLVED] LXT973 support (dual PHY with single MDIO)
Message-ID: <20060530182250.6ec4fb3b@vitb.ru.mvista.com>
In-Reply-To: <200605301128.48580.laurent.pinchart@tbox.biz>
References: <200605301048.01209.laurent.pinchart@tbox.biz>
	<200605301128.48580.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 30 May 2006 11:28:48 +0200
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

> Hi,
> 
> once again, posting to a mailing list helped me solving my problem. It should 
> have been obvious that the MDIO bus is really a bus, and can as such support 
> several devices. The issue was that the drivers/net/fs_enet driver set 
> bus->phy_mask to ~0x9, and the LXT973 uses addresses 0 and 1. Address 1 thus 
> never got probed. What's the reason for probing addresses 0 and 3 only ?

The reason is obvious: bitbang read of PHY id with not-existent PHY, does not return expected (0, iirc), that confuse mdio bus device-driver bound (it assumes error and returns -1), and prevents from probing other phys. So, as that seems to be a "feature" on CPM2 only, we are working that around specifying phy_mask to prevent probing inexistent phys w/over bitbang thing.


-- 
Sincerely, 
Vitaly
