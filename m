Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp05.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C47F3B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 07:54:33 +1100 (EST)
Received: from /spool/local by br.ibm.com with XMail ESMTP
	for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
	Mon, 3 Oct 2011 17:54:15 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p93KqtIv3379268
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Oct 2011 17:52:59 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p93Krvi0019208
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Oct 2011 17:53:57 -0300
Date: Mon, 3 Oct 2011 17:53:58 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Yevgeny Petrilin <yevgenyp@mellanox.co.il>
Subject: Re: [PATCH] mlx4_en: fix transmit of packages when blue frame is
	enabled
Message-ID: <20111003205358.GB3596@oc1711230544.ibm.com>
References: <1317388995-411-1-git-send-email-cascardo@linux.vnet.ibm.com>
	<953B660C027164448AE903364AC447D2235D9A8C@MTLDAG02.mtl.com>
	<20111003143721.GA3596@oc1711230544.ibm.com>
	<953B660C027164448AE903364AC447D2235DAA9D@MTLDAG02.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <953B660C027164448AE903364AC447D2235DAA9D@MTLDAG02.mtl.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"eli@dev.mellanox.co.il" <eli@dev.mellanox.co.il>,
	linuxppc-dev@lists.ozlabs.org, Eli Cohen <eli@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 03, 2011 at 02:56:08PM +0000, Yevgeny Petrilin wrote:
> > Hello, Yevgeny.
> > 
> > We use a MT26448 (lspci -v output bellow) on a POWER7. Any other
> > information, tests or debug patches you want me to try, just tell me.
> > 
> > I expected this was really not the proper fix, but thought it would be
> > better to send it than just guess. Any clues what the problem might be?
> > Perhaps, we would have to disable blue frame for this particular device?
> > 
> > Regards,
> > Cascardo.
> > 
> > ---
> > lspci output
> > 0006:01:00.0 Ethernet controller: Mellanox Technologies MT26448 [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)
> > ---
> > lspci -v output
> > 0006:01:00.0 0200: 15b3:6750 (rev b0)
> >         Subsystem: 1014:0416
> >         Flags: bus master, fast devsel, latency 0, IRQ 31
> >         Memory at 3da47be00000 (64-bit, non-prefetchable) [size=1M]
> >         Memory at 3da47c000000 (64-bit, prefetchable) [size=32M]
> >         Expansion ROM at 3da47bf00000 [disabled] [size=1M]
> >         Capabilities: [40] Power Management version 3
> >         Capabilities: [48] Vital Product Data
> >         Capabilities: [9c] MSI-X: Enable+ Count=128 Masked-
> >         Capabilities: [60] Express Endpoint, MSI 00
> >         Capabilities: [100] Alternative Routing-ID Interpretation (ARI)
> >         Capabilities: [148] Device Serial Number 00-02-c9-03-00-0f-50-be
> >         Kernel driver in use: mlx4_core
> >         Kernel modules: mlx4_en, mlx4_core
> > ---
> 
> Cascardo,
> 
> Can you also send me the output of ethtool -i?
> It seems that there is a problem with write combining on Power processors, we will check this issue.
> 
> Yevgeny

Hello, Yevgeny.

You will find the output of ethtool -i below.

I am copying Ben and powerpc list, in case this is an issue with Power
processors. They can provide us some more insight into this.

Thanks,
Cascardo.

---
# ethtool -i eth10
driver: mlx4_en
version: 1.5.4.1 (March 2011)
firmware-version: 2.9.4130
bus-info: 0006:01:00.0
