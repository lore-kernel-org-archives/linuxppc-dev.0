Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN3Sg13YLzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 00:40:02 +1100 (AEDT)
Date: Tue, 14 Feb 2017 16:39:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: weiyang@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] powerpc/powernv: Support EEH reset for VF PE
Message-ID: <20170214133944.GA24595@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wei Yang,

The patch 9312bc5bab59: "powerpc/powernv: Support EEH reset for VF
PE" from Mar 4, 2016, leads to the following static checker warning:

	arch/powerpc/platforms/powernv/eeh-powernv.c:1033 pnv_eeh_reset_vf_pe()
	info: return a literal instead of 'ret'

arch/powerpc/platforms/powernv/eeh-powernv.c
  1019  static int pnv_eeh_reset_vf_pe(struct eeh_pe *pe, int option)
  1020  {
  1021          struct eeh_dev *edev;
  1022          struct pci_dn *pdn;
  1023          int ret;
  1024  
  1025          /* The VF PE should have only one child device */
  1026          edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, list);
  1027          pdn = eeh_dev_to_pdn(edev);
  1028          if (!pdn)
  1029                  return -ENXIO;
  1030  
  1031          ret = pnv_eeh_do_flr(pdn, option);
  1032          if (!ret)
  1033                  return ret;

Presumably if pnv_eeh_do_flr() succeeds then we don't need to continue?
pnv_eeh_do_af_flr() is a fall back option?  Doing a:

			return 0;

Makes this more deliberate looking.  Sometimes people get their if
statements reversed is the other option.

  1034  
  1035          return pnv_eeh_do_af_flr(pdn, option);
  1036  }

regards,
dan carpenter
