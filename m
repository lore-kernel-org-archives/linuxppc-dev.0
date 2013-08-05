Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53D9A2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 02:28:52 +1000 (EST)
Message-ID: <1375720094.13074.9.camel@snotra.buserror.net>
Subject: Re: [PATCH 6/6 v2] kvm: powerpc: use caching attributes as per
 linux pte
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 5 Aug 2013 11:28:14 -0500
In-Reply-To: <1375503938.15999.82.camel@pasglop>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-7-git-send-email-Bharat.Bhushan@freescale.com>
 <20130802233452.GA27636@home.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FE9@039-SN2MPN1-012.039d.mgd.msft.net>
 <1375503938.15999.82.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-08-03 at 14:25 +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2013-08-03 at 03:11 +0000, Bhushan Bharat-R65777 wrote:
> > 
> > > 
> > > Could you explain why we need to set dirty/referenced on the PTE, when we didn't
> > > need to do that before? All we're getting from the PTE is wimg.
> > > We have MMU notifiers to take care of the page being unmapped, and we've already
> > > marked the page itself as dirty if the TLB entry is writeable.
> > 
> > I pulled this code from book3s.
> > 
> > Ben, can you describe why we need this on book3s ?
> 
> If you let the guest write to the page you must set the dirty bit on the PTE
> (or the struct page, at least one of them), similar with accessed on any access.
> 
> If you don't, the VM might swap the page out without writing it back to disk
> for example, assuming it contains no modified data.

We've already marked the page itself as dirty using kvm_set_pfn_dirty(),
and if the VM swaps it out we'll get an MMU notifier callback.  If we
marked the PTE dirty/accessed instead, is there any guarantee it will
stay marked dirty/accessed until the next MMU notifier?

-Scott
