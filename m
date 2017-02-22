Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vT2NW5ZryzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 03:08:43 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MFwfPn062763
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 11:08:40 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28s9r45471-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 11:08:40 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 09:08:37 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A058619D8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:07:46 -0700 (MST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] cxl: Route eeh events to all slices for
 pci_channel_io_perm_failure state
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <20170222105105.11676-1-vaibhav@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 10:08:20 -0600
Cc: linuxppc-dev@lists.ozlabs.org,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 frederic.barrat@fr.ibm.com, Ian Munsie <ianmunsi@au1.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
References: <20170222105105.11676-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Message-Id: <D20E1975-4902-43BF-9A8A-2F5DE3E47E4C@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Feb 22, 2017, at 4:51 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> =
wrote:
>=20
> Fix a boundary condition where in some cases an eeh event with
> state =3D=3D pci_channel_io_perm_failure wont be passed on to a driver
> attached to the virtual pci device associated with a slice. This will
> happen in case the slice just before (n-1) doesn't have any vph bus
> associated with it, that results in an early return from
> cxl_pci_error_detected callback.
>=20
> This also simplifies branch that handles this eeh state by returning
> PCI_ERS_RESULT_DISCONNECTED in all cases as the adapter is will be
> removed irrespective of the return value of cxl_pci_error_detected
> callback.

This sentence could be cleaned up a bit.

>=20
> Fixes: e4f5fc001a6("cxl: Do not create vPHB if there are no AFU =
configuration records")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Fix looks good!

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
