Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 223201A0257
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 14:34:54 +1000 (EST)
Message-ID: <1407299684.3073.62.camel@pasglop>
Subject: Re: [PATCH v2 4/4] vfio_pci: spapr: Enable VFIO if EEH is not
 supported
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 06 Aug 2014 14:34:44 +1000
In-Reply-To: <1407296659.316.78.camel@ul30vt.home>
References: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
 <1407293313-24894-5-git-send-email-aik@ozlabs.ru>
 <1407296659.316.78.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-05 at 21:44 -0600, Alex Williamson wrote:
> >               ret = vfio_spapr_pci_eeh_open(vdev->pdev);
> > -             if (ret) {
> > -                     vfio_pci_disable(vdev);
> > -                     goto error;
> > -             }
> > +             if (ret)
> > +                     pr_warn_once("EEH is not supported\n");
> >       }
> >  
> >       return 0;
> 
> Now the next question, what's the point of vfio_spapr_pci_eeh_open()
> returning a value?  Couldn't it return void now and this warning can
> go into eeh specific code?  Thanks,

In order to call vfio_pci_disable() when that happens ?

Cheers,
Ben.
