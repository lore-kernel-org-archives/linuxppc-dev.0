Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0t8f2g5MzDvck
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 04:34:25 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9LHYBjH071631
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:34:22 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 267nh9x4yk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:34:21 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 18:34:20 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8A37717D805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 18:36:30 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9LHYHFn24510620
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 17:34:17 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9LHYGvn010755
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 11:34:17 -0600
Subject: Re: [RESEND PATCH] cxl: Fix leaking pid refs in some error paths
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1477041833-8302-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 gkurz@linux.vnet.ibm.com, stable@vger.kernel.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 21 Oct 2016 19:34:14 +0200
MIME-Version: 1.0
In-Reply-To: <1477041833-8302-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e1b4db59-7932-40d0-1386-b8ba74843ceb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 21/10/2016 à 11:23, Vaibhav Jain a écrit :
> In some error paths in functions cxl_start_context and
> afu_ioctl_start_work pid references to the current & group-leader tasks
> can leak after they are taken. This patch fixes these error paths to
> release these pid references before exiting the error path.
>
> Fixes: 7b8ad495("cxl: Fix DSI misses when the context owning task exits")
> Cc: stable@vger.kernel.org
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reported-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---

Thanks for taking care of it!

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
