Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH34Z0m85zDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 18:06:04 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9I74awl032844
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 03:06:01 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dnyf9xdp3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 03:06:01 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Wed, 18 Oct 2017 08:05:57 +0100
Subject: Re: [PATCH] cxl: Rework the implementation of cxl_stop_trace_psl9()
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
References: <20171011123020.17594-1-vaibhav@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 09:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <20171011123020.17594-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <89d1d44f-b5d2-429a-8544-e6e23510ab64@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 11/10/2017 à 14:30, Vaibhav Jain a écrit :

> Presently the PSL9 specific cxl_stop_trace_psl9() only stops the RX0
> traces on the CXL adapter when a PSL error irq is triggered. The patch
> updates the function to stop all the traces arrays and move them to
> the FIN state. The implementation issues the mmio to TRACECFG register
> to stop the trace array iff it already not in FIN state. This prevents
> the issue of trace data being reset in case of multiple stop mmio
> issued for a single trace array.
>
> Also the patch does some refactoring of existing cxl_stop_trace_psl9()
> and cxl_stop_trace_psl8() functions by moving them to 'pci.c' from
> 'debugfs.c' file and marking them as static.

agree.


> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/cxl.h     | 14 ++++----------
>   drivers/misc/cxl/debugfs.c | 22 ----------------------
>   drivers/misc/cxl/pci.c     | 38 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+), 32 deletions(-)

Thanks

Acked-by:  Christophe Lombard<clombard@linux.vnet.ibm.com>
