Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5119F1A020A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 10:15:03 +1100 (AEDT)
Message-ID: <1426029296.17565.11.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 03/29] vfio: powerpc/spapr: Check that TCE page size
 is equal to it_page_size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 11 Mar 2015 10:14:56 +1100
In-Reply-To: <1426028606.25026.86.camel@redhat.com>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
 <1425910045-26167-4-git-send-email-aik@ozlabs.ru>
 <1426017408.25026.79.camel@redhat.com> <54FF76F4.5020503@ozlabs.ru>
 <1426028606.25026.86.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-10 at 17:03 -0600, Alex Williamson wrote:
> > > return (PAGE_SHIFT + compound_order(compound_head(page) >= page_shift);
> > 
> > This won't be "bool" though.
> 
> Yes, it will.

Don't you have your parenthesis in the wrong place, Alex ? :-)

> >  This will (I'll do this)
> > 
> > shift = PAGE_SHIFT + compound_order(compound_head(page));
> > return (shift >= page_shift);
