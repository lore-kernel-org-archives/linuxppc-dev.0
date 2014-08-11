Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9356A1A0881
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 13:16:52 +1000 (EST)
Message-ID: <1407726995.4508.64.camel@pasglop>
Subject: Re: [PATCH] powerpc: non-GPL export for eeh_dev_check_failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Date: Mon, 11 Aug 2014 13:16:35 +1000
In-Reply-To: <20140805155140.2b200061@alan.etchedpixels.co.uk>
References: <53E0ED41.8030804@linux.vnet.ibm.com>
 <20140805155140.2b200061@alan.etchedpixels.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Vishal Mansur <vmansur@linux.vnet.ibm.com>,
 gwshan@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-05 at 15:51 +0100, One Thousand Gnomes wrote:
> On Tue, 05 Aug 2014 20:12:09 +0530
> Vishal Mansur <vmansur@linux.vnet.ibm.com> wrote:
> 
> > EEH kernel services are inconsistently exported by the 
> > kernel. eeh_check_failure is exported for any use, but 
> > eeh_dev_check_failure is exported only for GPL use. 
> > While eeh_check_failure is implemented for a specific 
> > purpose to be used by services such as readl, it is 
> > not suited for a purpose where caller needs eeh status. 
> > This functionality is provided by eeh_dev_check_failure.
> > 
> > This patch relaxes the export for eeh_dev_check_failure
> > to make it consistent with eeh_check_failure() and 
> > usable by non-GPL modules.
> 
> The GPL covers all derivative works. Tweaking this doesn't magically
> allow you to use the feature in non GPL code. Your legal department can I
> am sure explain in detail further.

This is an interesting case... I assume this has to do with a well known
GPU manufacturer...

The PCI APIs are generally exported in such a way that a non-GPL driver
can use them (regardless of whether one considers a non-GPL driver to be
legal here or not, this is besides the point).

eeh_dev_check_failure() can be considered as powerpc specific extension
of the PCI API for use by PCI drivers and as such, it *could* be
construed that we should be consistent (and consistent with
eeh_check_failure()) and expose it as an EXPORT_SYMBOL without the GPL
suffix.

So I'm somewhat tempted to take this patch, but Vishal, the driver in
question could, I suppose, as a workaround, use a readl to some scratch
register of some description, no ?

Cheers,
Ben.

> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
