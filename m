Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A45822C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 14:25:52 +1000 (EST)
Message-ID: <1375503938.15999.82.camel@pasglop>
Subject: Re: [PATCH 6/6 v2] kvm: powerpc: use caching attributes as per
 linux pte
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Sat, 03 Aug 2013 14:25:38 +1000
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FE9@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-7-git-send-email-Bharat.Bhushan@freescale.com>
 <20130802233452.GA27636@home.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FE9@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-08-03 at 03:11 +0000, Bhushan Bharat-R65777 wrote:
> 
> > 
> > Could you explain why we need to set dirty/referenced on the PTE, when we didn't
> > need to do that before? All we're getting from the PTE is wimg.
> > We have MMU notifiers to take care of the page being unmapped, and we've already
> > marked the page itself as dirty if the TLB entry is writeable.
> 
> I pulled this code from book3s.
> 
> Ben, can you describe why we need this on book3s ?

If you let the guest write to the page you must set the dirty bit on the PTE
(or the struct page, at least one of them), similar with accessed on any access.

If you don't, the VM might swap the page out without writing it back to disk
for example, assuming it contains no modified data.

Cheers,
Ben.
