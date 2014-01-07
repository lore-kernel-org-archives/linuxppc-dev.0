Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 417122C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 18:14:01 +1100 (EST)
Message-ID: <1389078829.11795.138.camel@snotra.buserror.net>
Subject: Re: [03/12,v3] pci: fsl: add PCI indirect access support
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <b31939@freescale.com>
Date: Tue, 7 Jan 2014 01:13:49 -0600
In-Reply-To: <52CA40D8.1090805@freescale.com>
References: <1382524894-15164-3-git-send-email-Minghuan.Lian@freescale.com>
 <20140103223306.GC22546@home.buserror.net> <52CA40D8.1090805@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-01-06 at 13:36 +0800, Lian Minghuan-b31939 wrote:
> HI Scott,
> 
> please see my comments inline.
> 
> On 01/04/2014 06:33 AM, Scott Wood wrote:
> > A lot of this seems duplicated from arch/powerpc/sysdev/indirect_pci.c.
> >
> > How generally applicable is that file to non-PPC implementations?  At a
> > minimum I see a similar file in arch/microblaze.  It should probably
> > eventually be moved to common code, rather than duplicated again.  A
> > prerequisite for that would be making common the dependencies it has on
> > the rest of what is currently arch PCI infrastructure; until then, it's
> > probably better to just have the common fsl-pci code know how to
> > interface with the appropriate PPC/ARM code rather than trying to copy
> > the infrastructure as well.
> [Minghuan] Yes, This is a duplicate except it uses struct fsl_pci. But 
> it is hard to be move to common code.
> because every indirect read/write functions use different PCI controller 
> structure which is very basic structure and ARM has no this structure.
> If we can not establish a unified pci controller structure, we can only 
> abstract out a simple structure which includes indirect access related 
> fields,
> and need a callback function to get the pointer like this: 
> ((powerpc/microblaze/mips/ pci_controller 
> *)(pci_bus->sysdata))->indirect_struct.
> Should we provide the common code for indirect access API or wait for 
> the common PCI controller structure?

Either work with the PCI maintainer to come up with a common structure,
or leave the code where it is and call into it.

-Scott
