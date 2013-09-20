Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E28E2C018F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 04:08:20 +1000 (EST)
Message-ID: <1379700490.16231.19.camel@aoeu.buserror.net>
Subject: Re: [PATCH 5/6 v5] kvm: booke: clear host tlb reference flag on
 guest tlb invalidation
From: Scott Wood <scottwood@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Fri, 20 Sep 2013 13:08:10 -0500
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0717AEA1@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379570566-3715-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1379624878.16231.3.camel@aoeu.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07179BBE@039-SN2MPN1-011.039d.mgd.msft.net>
 <1379693889.16231.11.camel@aoeu.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717AEA1@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-20 at 13:04 -0500, Bhushan Bharat-R65777 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, September 20, 2013 9:48 PM
> > To: Bhushan Bharat-R65777
> > Cc: Wood Scott-B07421; benh@kernel.crashing.org; agraf@suse.de;
> > paulus@samba.org; kvm@vger.kernel.org; kvm-ppc@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH 5/6 v5] kvm: booke: clear host tlb reference flag on guest
> > tlb invalidation
> > 
> > On Thu, 2013-09-19 at 23:19 -0500, Bhushan Bharat-R65777 wrote:
> > > We uses these bit flags only for TLB1 and if size of stlbe is 4K then
> > > we set E500_TLB_TLB0  otherwise we set E500_TLB_BITMAP. Although I
> > > think that E500_TLB_BITMAP should be set only if stlbe size is less
> > > than gtlbe size.
> > 
> > Why?  Even if there's only one bit set in the map, we need it to keep track of
> > which entry was used.
> 
> If there is one entry then will not this be simple/faster to not lookup bitmap and guest->host array?
> A flag indicate it is 1:1 map and this is physical address.

The difference would be negligible, and you'd have added overhead (both
runtime and complexity) of making this a special case.

-Scott
