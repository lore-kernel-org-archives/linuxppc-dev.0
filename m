Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0E1BD2C013D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 14:31:36 +1000 (EST)
Message-ID: <1371357080.21896.115.camel@pasglop>
Subject: Re: [PATCH 2/4] powerpc: Prepare to support kernel handling of
 IOMMU map/unmap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Sun, 16 Jun 2013 14:31:20 +1000
In-Reply-To: <1371356818.21896.114.camel@pasglop>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-3-git-send-email-aik@ozlabs.ru>
 <1371356818.21896.114.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-16 at 14:26 +1000, Benjamin Herrenschmidt wrote:
> > +int realmode_get_page(struct page *page)
> > +{
> > +     if (PageCompound(page))
> > +             return -EAGAIN;
> > +
> > +     get_page(page);
> > +
> > +     return 0;
> > +}

Shouldn't it be get_page_unless_zero ?

Cheers,
Ben.
