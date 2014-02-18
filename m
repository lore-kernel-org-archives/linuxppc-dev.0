Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C0AC92C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 11:51:16 +1100 (EST)
Message-ID: <1392684659.6733.668.camel@snotra.buserror.net>
Subject: Re: PCI-PCI bridge configuration in linux device tree
From: Scott Wood <scottwood@freescale.com>
To: Anand Mistry <anand.mistry@Spectross.com>
Date: Mon, 17 Feb 2014 18:50:59 -0600
In-Reply-To: <20140215115045.M44796@Spectross.com>
References: <20140215115045.M44796@Spectross.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-02-15 at 18:03 +0530, Anand Mistry wrote:
> Hello,
> 
> We are working on a cPCI based application involving MPC8313 processor. The
> cPCI back-plane has a PCI-PCI bridge on it. 
> 
> While booting, the linux kernel(2.6.23)

2.6.23 is over 6 years old.  Why are you using it for new hardware
support?  Note that this code looks very different now.

Plus, from the file number in the crash output, it looks like you're not
dealing with vanilla 2.6.23, as there is no BUG on line 589 of pci_32.c.
If this is Freescale BSP/SDK code, support requests should be addressed
to support@freescale.com or https://community.freescale.com/ -- though
again I suggest going with current upstream code given the age of the
BSP code.

There is a BUG_ON on line 588 -- if it's that one (BUG_ON(rc) after
pci_assign_resource) then look into why pci_assign_resource is failing.

Also please ensure that you have CONFIG_KALLSYMS enabled when submitting
crash dumps.

-Scott
