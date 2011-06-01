Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06333B6F8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 02:48:38 +1000 (EST)
Date: Wed, 1 Jun 2011 11:48:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/2] ppc/85xx: create a platform node for PCI EDAC device
Message-ID: <20110601114823.2e57c691@schlenkerla.am.freescale.net>
In-Reply-To: <BANLkTi=xFcZRd4x1FQSKJzmt3A7_tZs+sQ@mail.gmail.com>
References: <1306931292-2313-1-git-send-email-dbaryshkov@gmail.com>
	<20110601132519.GA16125@oksana.dev.rtsoft.ru>
	<BANLkTi=xFcZRd4x1FQSKJzmt3A7_tZs+sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Paul Mackerras <paulus@samba.org>, Anton Vorontsov <avorontsov@mvista.com>,
	linuxppc-dev@lists.ozlabs.org, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Jun 2011 18:55:35 +0400
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:

> On 6/1/11, Anton Vorontsov <avorontsov@mvista.com> wrote:
> > On Wed, Jun 01, 2011 at 04:28:11PM +0400, Dmitry Eremin-Solenikov wrote:
> > [...]
> > Also, why not add this call to the fsl_add_bridge(), so you
> > won't need to touch board files at all.
> 
> Because fsl_add_bridge is called too early, so allocation
> of platform device fails.

That doesn't seem like a good reason for putting more stuff in board
files that isn't board-specific.  Why not just make fsl_add_pci_err() an
initcall?  It already only works when a compatible device tree node is
found.  Is there any case where a board would not want this PCI code to be
used, even if the device tree node is present?  If so, fsl_add_bridge could
set a flag that fsl_add_pci_err() could check -- but I doubt it's needed.

-Scott
