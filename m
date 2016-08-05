Return-Path: <york.sun@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0057.outbound.protection.outlook.com [104.47.2.57])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5fpg0vDLzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 07:20:10 +1000 (AEST)
From: york sun <york.sun@nxp.com>
To: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC: "morbidrsa@gmail.com" <morbidrsa@gmail.com>, Stuart Yoder
 <stuart.yoder@nxp.com>, "bp@alien8.de" <bp@alien8.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Kevin Hao
 <haokexin@gmail.com>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
Date: Fri, 5 Aug 2016 21:20:03 +0000
Message-ID: <AM4PR0401MB1732B0DB22A85A35D9C570679A180@AM4PR0401MB1732.eurprd04.prod.outlook.com>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
 <877fbvkhi3.fsf@concordia.ellerman.id.au>
 <AM4PR0401MB1732CBF31450B03C8F5087D19A180@AM4PR0401MB1732.eurprd04.prod.outlook.com>
 <1470431358.25630.249.camel@buserror.net>
Reply-To: york sun <york.sun@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2016 02:09 PM, Scott Wood wrote:=0A=
> On Fri, 2016-08-05 at 20:29 +0000, york sun wrote:=0A=
>> On 08/04/2016 08:43 PM, Michael Ellerman wrote:=0A=
>>>=0A=
>>> Does the driver really need to use these routines? They're meant for us=
e=0A=
>>> early in boot, before PCI is setup.=0A=
>>>=0A=
>>> AFAICS this is just a regular driver, so when it's probed the PCI=0A=
>>> devices should have already been scanned. In which case pci_get_device(=
)=0A=
>>> could work couldn't it? (I see other edac drivers doing that).=0A=
>> I am trying to fix this but need some help. We are dealing with PCIe=0A=
>> controller here. Does it have a bus number assigned at this point? If=0A=
>> yes, how can I find it? I seem not able to find out where the=0A=
>> platform_data is filled as well. Can someone kindly point it out to me?=
=0A=
>=0A=
>=0A=
> The platform data comes from add_err_dev() in arch/powerpc/sysdev/fsl_pci=
.c.=0A=
>=0A=
=0A=
Thanks, Scott.=0A=
=0A=
When add_err_dev() is called, pci is not scanned, is using =0A=
early_find_capability() justified?=0A=
=0A=
York=0A=
