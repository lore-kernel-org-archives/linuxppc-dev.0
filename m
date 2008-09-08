Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E63C5DDE1B
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Sep 2008 10:29:23 +1000 (EST)
Subject: Re: [PATCH] ibm_newemac: Add support for GPCS, SGMII and M88E1112 PHY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Victor Gallardo <vgallardo@amcc.com>
In-Reply-To: <1220658734-13944-1-git-send-email-vgallardo@amcc.com>
References: <1220658734-13944-1-git-send-email-vgallardo@amcc.com>
Content-Type: text/plain
Date: Mon, 08 Sep 2008 10:29:14 +1000
Message-Id: <1220833754.4879.228.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-09-05 at 16:52 -0700, Victor Gallardo wrote:
> From: Victor Gallardo <vgallardo@amcc.com>
> 
> This patch adds GPCS, SGMII and M88E1112 PHY support
> for the AMCC PPC460GT/EX processors.

So if I understand the patch correctly, either there is an *MII PHY in
which case phy_address is used, or there's a GPCS one and phy_address is
-1 and gpcs_address is used right ?

Why not instead always use phy_address, and have a flag indicating
whether it's an MII or GPCS PHY ? This would avoid the added
gpcs_read/write functions, among other things, and I believe would look
cleaner... Or am I missing something ?

Cheers,
Ben.
