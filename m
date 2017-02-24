Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVF4B02YVzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 02:13:45 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1OFBpM3114608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:13:43 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28t0awhwa5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:13:43 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 24 Feb 2017 15:13:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9060A1B08061
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 15:16:38 +0000 (GMT)
Subject: Re: [RESEND PATCH] cxl: Route eeh events to all slices for
 pci_channel_io_perm_failure state
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20170223032726.943-1-vaibhav@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 frederic.barrat@fr.ibm.com, Ian Munsie <ianmunsi@au1.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 16:13:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170223032726.943-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6bcbc1e5-4158-d51c-29e4-e76219f355b5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 23/02/2017 à 04:27, Vaibhav Jain a écrit :
> Fix a boundary condition where in some cases an eeh event with
> state == pci_channel_io_perm_failure wont be passed on to a driver
> attached to the virtual pci device associated with a slice. This will
> happen in case the slice just before (n-1) doesn't have any vPHB bus
> associated with it, that results in an early return from
> cxl_pci_error_detected callback.
>
> With state==pci_channel_io_perm_failure, the adapter will be removed
> irrespective of the return value of cxl_vphb_error_detected. So we now
> always return PCI_ERS_RESULT_DISCONNECTED for this case i.e even if
> the AFU isn't using a vPHB (currently returns PCI_ERS_RESULT_NONE).
>
> Fixes: e4f5fc001a6("cxl: Do not create vPHB if there are no AFU configuration records")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
