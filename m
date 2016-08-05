Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5fZh3V4jzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 07:09:48 +1000 (AEST)
Message-ID: <1470431358.25630.249.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: york sun <york.sun@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: "morbidrsa@gmail.com" <morbidrsa@gmail.com>, Stuart Yoder
 <stuart.yoder@nxp.com>, "bp@alien8.de" <bp@alien8.de>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Kevin Hao <haokexin@gmail.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>,  Yinghai Lu <yinghai@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 05 Aug 2016 16:09:18 -0500
In-Reply-To: <AM4PR0401MB1732CBF31450B03C8F5087D19A180@AM4PR0401MB1732.eurprd04.prod.outlook.com>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
 <877fbvkhi3.fsf@concordia.ellerman.id.au>
 <AM4PR0401MB1732CBF31450B03C8F5087D19A180@AM4PR0401MB1732.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-05 at 20:29 +0000, york sun wrote:
> On 08/04/2016 08:43 PM, Michael Ellerman wrote:
> > 
> > Does the driver really need to use these routines? They're meant for use
> > early in boot, before PCI is setup.
> > 
> > AFAICS this is just a regular driver, so when it's probed the PCI
> > devices should have already been scanned. In which case pci_get_device()
> > could work couldn't it? (I see other edac drivers doing that).
> I am trying to fix this but need some help. We are dealing with PCIe 
> controller here. Does it have a bus number assigned at this point? If 
> yes, how can I find it? I seem not able to find out where the 
> platform_data is filled as well. Can someone kindly point it out to me?


The platform data comes from add_err_dev() in arch/powerpc/sysdev/fsl_pci.c.

-Scott
