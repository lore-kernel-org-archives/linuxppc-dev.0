Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A4F002C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 09:57:37 +1000 (EST)
Message-ID: <1372204646.3944.223.camel@pasglop>
Subject: Re: [PATCH 1/6] powerpc/eeh: Don't collect PCI-CFG data on PHB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2013 09:57:26 +1000
In-Reply-To: <20130625234917.GA4556@shangw.(null)>
References: <1372154461-29674-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372154461-29674-2-git-send-email-shangw@linux.vnet.ibm.com>
 <1372161315.3944.201.camel@pasglop> <20130625234917.GA4556@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-26 at 07:49 +0800, Gavin Shan wrote:
> It's something like the followings. For ER on PE#0, we will have
> PE with type of EEH_PE_BUS marked as isolated, instead of the
> one with EEH_PE_PHB.
> 
> 
>         [ EEH_PE_PHB] <---> [ EEH_PE_PHB] <---> [ EEH_PE_PHB]
>                                   |
>                             [ EEH_PE_BUS ] PE#0
>                                   |

So we actually have two PEs here ? One real (PE#0) and one imaginary
(PHB PE) with no PE# associated ?

>                         -------------------------
>                         |                       |
>                    [ EEH_PE_BUS ] PE#1     [ EEH_PE_BUS] PE#2
> 
> >I would either not bother and collect the FF's, or make this specific
> >to fence and only fence.
> >
> 
> I'd like to keep it specific to fenced PHB and it's already be
> that :-)

Cheers,
Ben.
