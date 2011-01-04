Return-Path: <scottwood@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8647CB7104
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 08:20:36 +1100 (EST)
Date: Tue, 4 Jan 2011 15:20:18 -0600
From: Scott Wood <scottwood@freescale.com>
To: <Bruce_Leonard@selinc.com>
Subject: Re: Question about combining a PCI driver with an OF driver
Message-ID: <20110104152018.080ff075@udp111988uds.am.freescale.net>
In-Reply-To: <OF2F9BC586.7E8383F3-ON8825780E.0072ACEA-8825780E.00735E90@selinc.com>
References: <OF413F3FA8.B1C9F99A-ON8825780E.006706F6-8825780E.00683E0B@selinc.com>
	<20110104132317.006ead39@udp111988uds.am.freescale.net>
	<OF2F9BC586.7E8383F3-ON8825780E.0072ACEA-8825780E.00735E90@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Jan 2011 13:00:07 -0800
<Bruce_Leonard@selinc.com> wrote:

> Okay, I get that and it makes sense with what I know so far about how the 
> kernel device model works (which I'm still learning).  So how would I 
> manually add a device?  Say I create the PCI wrapper driver that claims 
> the clone-TSEC, is there a "register device" type call similar to 
> pci_register_driver() that I could put in the wrapper code that causes the 
> gfar_probe() to be called?

Create an OF node (probably under the root node) programatically with
all the information the gianfar driver will want, based on what you
detect on PCI, and call of_platform_device_create().

-Scott
