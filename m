Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BDDB72C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 14:24:22 +1000 (EST)
Message-ID: <1375503847.15999.80.camel@pasglop>
Subject: Re: [PATCH 5/6 v2] kvm: powerpc: booke: Add linux pte lookup like
 booke3s
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Sat, 03 Aug 2013 14:24:07 +1000
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FCC@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1375484319.26902.4.camel@snotra.buserror.net>
 <1375485408.15999.67.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FCC@039-SN2MPN1-012.039d.mgd.msft.net>
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

On Sat, 2013-08-03 at 02:58 +0000, Bhushan Bharat-R65777 wrote:
> One of the problem I saw was that if I put this code in
> asm/pgtable-32.h and asm/pgtable-64.h then pte_persent() and other
> friend function (on which this code depends) are defined in pgtable.h.
> And pgtable.h includes asm/pgtable-32.h and asm/pgtable-64.h before it
> defines pte_present() and friends functions.
> 
> Ok I move wove this in asm/pgtable*.h, initially I fought with myself
> to take this code in pgtable* but finally end up doing here (got
> biased by book3s :)).

Is there a reason why these routines can not be completely generic
in pgtable.h ?

Ben.
