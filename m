Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41FPb85Lt1zF1D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2018 21:54:11 +1000 (AEST)
Date: Tue, 26 Jun 2018 19:54:02 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv2 2/2] drivers/base: reorder consumer and its children
 behind suppliers
Message-ID: <20180626115402.GB30256@kroah.com>
References: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
 <1529912859-10475-3-git-send-email-kernelfans@gmail.com>
 <20180625104505.GA3058@kroah.com>
 <CAFgQCTt6MTwXbbcQCcJroM3wGdx+5c7A+eVy+dXJscu1JtfA-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFgQCTt6MTwXbbcQCcJroM3wGdx+5c7A+eVy+dXJscu1JtfA-w@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2018 at 11:29:48AM +0800, Pingfan Liu wrote:
> On Mon, Jun 25, 2018 at 6:45 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 25, 2018 at 03:47:39PM +0800, Pingfan Liu wrote:
> > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > > introduces supplier<-consumer order in devices_kset. The commit tries
> > > to cleverly maintain both parent<-child and supplier<-consumer order by
> > > reordering a device when probing. This method makes things simple and
> > > clean, but unfortunately, breaks parent<-child order in some case,
> > > which is described in next patch in this series.
> >
> > There is no "next patch in this series" :(
> >
> Oh, re-arrange the patches, and forget the comment in log
> 
> > > Here this patch tries to resolve supplier<-consumer by only reordering a
> > > device when it has suppliers, and takes care of the following scenario:
> > >     [consumer, children] [ ... potential ... ] supplier
> > >                          ^                   ^
> > > After moving the consumer and its children after the supplier, the
> > > potentail section may contain consumers whose supplier is inside
> > > children, and this poses the requirement to dry out all consumpers in
> > > the section recursively.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > ---
> > > note: there is lock issue in this patch, should be fixed in next version
> >
> > Please send patches that you know are correct, why would I want to
> > review this if you know it is not correct?
> >
> > And if the original commit is causing problems for you, why not just
> > revert that instead of adding this much-increased complexity?
> >
> Revert the original commit, then it will expose the error  order
> "consumer <- supplier" again.
> This patch tries to resolve the error and fix the following scenario:
> step0:  before the consumer device's probing,  (note child_a is a
> supplier of consumer_a, etc)
> [ consumer-X,  child_a, ...., child_z]     [.... consumer_a, ...,
> consumer_z, ....]    supplier-X
>                                                              ^^^
> affected range during moving^^^
> step1: When probing, moving consumer-X after supplier-X
> [ child_a, ...., child_z]     [.... consumer_a, ...,     consumer_z,
> ....]   supplier-X, consumer-X
> But it breaks "parent <-child" seq now, and should be fixed like:
> step2:
> [.... consumer_a, ...,     consumer_z, ....]  supplier-X  [
> consumer-X,  child_a, ...., child_z]    <---
> descendants_reorder_after_pos() does it.
> Again, the seq "consumer_a <- child_a" breaks the "supplier<-consumer"
>  order, should be fixed like:
> step3:
> [....  consumer_z, .....]  supplier-X  [ consumer-X,  child_a,
> consumer_a ...., child_z]   <--- __device_reorder_consumer() does it.
> ^^ affected range^^
> The moving of consumer_a brings us to face the same scenario of step1,
> hence we need an external recursion.

Something really got messed up here, and this all does not make any
sense :(

Can you try again?

Also, please cc: Rafael on all of this, as he wrote all of this
consumer/supplier logic and I am not that familiar with it at all.

thanks,

greg k-h
