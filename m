Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60DBF1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 15:13:04 +1100 (AEDT)
Date: Thu, 11 Feb 2016 15:11:09 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 1/6] KVM: PPC: Rework H_PUT_TCE/H_GET_TCE
 handlers
Message-ID: <20160211041109.GA9757@oak.ozlabs.ibm.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-2-git-send-email-aik@ozlabs.ru>
 <20160122004245.GL27454@voom.redhat.com>
 <56A18D13.9050908@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56A18D13.9050908@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 22, 2016 at 12:59:47PM +1100, Alexey Kardashevskiy wrote:
> On 01/22/2016 11:42 AM, David Gibson wrote:
> >On Thu, Jan 21, 2016 at 06:39:32PM +1100, Alexey Kardashevskiy wrote:
[snip]
> >>+	if ((ioba & mask) || (idx + npages > size))
> >
> >It doesn't matter for the current callers, but you should check for
> >overflow in idx + npages as well.
> 
> 
> npages can be only 1..512 and this is checked in H_PUT_TCE/etc handlers.
> idx is 52bit long max.
> And this is not going to change because H_PUT_TCE_INDIRECT will always be
> limited by 512 (or one 4K page).
> 
> Do I still need the overflow check here?

You could add "|| npages > TCES_PER_PAGE" and that would make it clear
that there can't be any overflow, and it should get removed by the
compiler for the calls with constant npages.

Paul.
