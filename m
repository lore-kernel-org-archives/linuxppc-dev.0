Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7662C2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 06:09:08 +1100 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Wed, 5 Feb 2014 17:09:02 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 573FD3520064
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 14:08:57 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s15J96P84317214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 17:09:06 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s15J8wSY012652
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Feb 2014 17:08:58 -0200
Date: Wed, 5 Feb 2014 17:08:56 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/eeh: drop taken reference to driver on
 eeh_rmv_device
Message-ID: <20140205190856.GD31582@oc0268524204.ibm.com>
References: <1391624445-9095-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <20140205184338.GA5433@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140205184338.GA5433@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 05, 2014 at 10:43:38AM -0800, Nishanth Aravamudan wrote:
> On 05.02.2014 [16:20:45 -0200], Thadeu Lima de Souza Cascardo wrote:
> > Commit f5c57710dd62dd06f176934a8b4b8accbf00f9f8 ("powerpc/eeh: Use
> > partial hotplug for EEH unaware drivers") introduces eeh_rmv_device,
> > which may grab a reference to a driver, but not release it.
> > 
> > That prevents a driver from being removed after it has gone through EEH
> > recovery.
> > 
> > This patch drops the reference if it was taken.
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> > Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/eeh_driver.c |    8 ++++++--
> >  1 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> > index 7bb30dc..fdc679d 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -362,9 +362,13 @@ static void *eeh_rmv_device(void *data, void *userdata)
> >  	 */
> >  	if (!dev || (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE))
> >  		return NULL;
> > +
> 
> This appears to be unnecessary whitespace change?
> 
> -Nish
> 

Hi, Nish.

I originally add it there for readability, giving both more evidence to
the code below, where a driver reference is get and put, and to the code
above and its respective comment. Leaving those together could give the
impression the comment also applies to the code below.

But I have no strong feelings about that.

Ben, do you want me to send a new version?

Regards.
Cascardo.

> >  	driver = eeh_pcid_get(dev);
> > -	if (driver && driver->err_handler)
> > -		return NULL;
> > +	if (driver) {
> > +		eeh_pcid_put(dev);
> > +		if (driver->err_handler)
> > +			return NULL;
> > +	}
> > 
> >  	/* Remove it from PCI subsystem */
> >  	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
> > -- 
> > 1.7.1
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
