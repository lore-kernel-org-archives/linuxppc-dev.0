Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 40DE82C0040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2012 06:24:41 +1000 (EST)
Message-ID: <5012F8FD.8030905@freescale.com>
Date: Fri, 27 Jul 2012 15:24:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <ACC8975F-CA31-4AA0-9824-4C3F6C70CD45@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A289D8@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A289D8@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/27/2012 05:10 AM, Jia Hongtao-B38951 wrote:
> Hi kumar,
> 
> I know "duplicate code from pci_process_bridge_OF_ranges()" is
> hard to accept but "refactor the code to have a shared function"
> is knotty. Actually this is the reason I didn't do the refactor.

Maybe we should keep doing the init early?  We could still have a
platform device for the PM stuff, but some init would be done before probe.

Another possibility is to try to handle swiotlb init later -- possibly
by reserving memory for it if the platform indicates it's a possibility
that it will be needed, then freeing the memory if it's not needed.

-Scott
