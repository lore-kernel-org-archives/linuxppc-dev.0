Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tb4sR6kSyzDvym
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 08:20:59 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB9LJhav091559
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2016 16:20:57 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 277ymhp30u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Dec 2016 16:20:57 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sat, 10 Dec 2016 07:20:55 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 18BB93578052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 08:20:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB9LKrZn55443500
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 08:20:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB9LKqS8004302
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 08:20:53 +1100
Subject: Re: [PATCH] ibmvscsi: add write memory barrier to CRQ processing
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 brking@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Date: Sat, 10 Dec 2016 08:20:52 +1100
In-Reply-To: <1481153486-5185-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1481153486-5185-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1481318452.17253.27.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-12-07 at 17:31 -0600, Tyrel Datwyler wrote:
> The first byte of each CRQ entry is used to indicate whether an entry is
> a valid response or free for the VIOS to use. After processing a
> response the driver sets the valid byte to zero to indicate the entry is
> now free to be reused. Add a memory barrier after this write to ensure
> no other stores are reordered when updating the valid byte.

Which "other stores" specifically ? This smells fishy without that
precision. It's important to always understand what exactly barriers
order with.

Cheers,
Ben.

> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> ---
>  drivers/scsi/ibmvscsi/ibmvscsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
> index d9534ee..2f5b07e 100644
> --- a/drivers/scsi/ibmvscsi/ibmvscsi.c
> +++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
> @@ -232,6 +232,7 @@ static void ibmvscsi_task(void *data)
> >  		while ((crq = crq_queue_next_crq(&hostdata->queue)) != NULL) {
> >  			ibmvscsi_handle_crq(crq, hostdata);
> >  			crq->valid = VIOSRP_CRQ_FREE;
> > +			wmb();
> >  		}
>  
> >  		vio_enable_interrupts(vdev);
> @@ -240,6 +241,7 @@ static void ibmvscsi_task(void *data)
> >  			vio_disable_interrupts(vdev);
> >  			ibmvscsi_handle_crq(crq, hostdata);
> >  			crq->valid = VIOSRP_CRQ_FREE;
> > +			wmb();
> >  		} else {
> >  			done = 1;
> >  		}
