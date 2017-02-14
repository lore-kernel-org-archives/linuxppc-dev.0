Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNJS63FTCzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 10:25:26 +1100 (AEDT)
Message-ID: <1487114720.6496.1.camel@russell.cc>
Subject: Re: [bug report] powerpc/powernv: Support EEH reset for VF PE
From: Russell Currey <ruscur@russell.cc>
To: Dan Carpenter <dan.carpenter@oracle.com>, weiyang@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 15 Feb 2017 10:25:20 +1100
In-Reply-To: <20170214133944.GA24595@mwanda>
References: <20170214133944.GA24595@mwanda>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-14 at 16:39 +0300, Dan Carpenter wrote:
> Hello Wei Yang,
> 
> The patch 9312bc5bab59: "powerpc/powernv: Support EEH reset for VF
> PE" from Mar 4, 2016, leads to the following static checker warning:
> 
> 	arch/powerpc/platforms/powernv/eeh-powernv.c:1033 pnv_eeh_reset_vf_pe()
> 	info: return a literal instead of 'ret'

Hey Dan,

Out of curiosity, what static analysis tool are you using?

> 
> arch/powerpc/platforms/powernv/eeh-powernv.c
>   1019  static int pnv_eeh_reset_vf_pe(struct eeh_pe *pe, int option)
>   1020  {
>   1021          struct eeh_dev *edev;
>   1022          struct pci_dn *pdn;
>   1023          int ret;
>   1024  
>   1025          /* The VF PE should have only one child device */
>   1026          edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev,
> list);
>   1027          pdn = eeh_dev_to_pdn(edev);
>   1028          if (!pdn)
>   1029                  return -ENXIO;
>   1030  
>   1031          ret = pnv_eeh_do_flr(pdn, option);
>   1032          if (!ret)
>   1033                  return ret;
> 
> Presumably if pnv_eeh_do_flr() succeeds then we don't need to continue?
> pnv_eeh_do_af_flr() is a fall back option?  Doing a:
> 
> 			return 0;
> 
> Makes this more deliberate looking.  Sometimes people get their if
> statements reversed is the other option.

I can send a patch for this.

> 
>   1034  
>   1035          return pnv_eeh_do_af_flr(pdn, option);
>   1036  }
> 
> regards,
> dan carpenter
