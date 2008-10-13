Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AFFCFDE19E
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 19:47:31 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m9D8lKV5181282
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 08:47:20 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9D8lKkb3887248
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 09:47:20 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9D8lJlU019848
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 09:47:19 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 1/1] IB/ehca: Disallow creating UC QP with SRQ
Date: Mon, 13 Oct 2008 09:34:09 +0200
References: <200810011306.31544.hnguyen@linux.vnet.ibm.com>
	<adazllcku0c.fsf@cisco.com>
In-Reply-To: <adazllcku0c.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810130934.09592.hnguyen@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	general@lists.openfabrics.org, micfaath@de.ibm.com,
	stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland,
That looks good to me.
Thanks for all help.

Nam

On Friday 10 October 2008 23:41, Roland Dreier wrote:
> thanks, applied -- it didn't apply to the latest tree, because of the
> flush CQE changes, so I merged it manually as below -- let me know if
> this is wrong:
> 
> commit 0540bbbe455e123a1692d26205ad1a29983883b0
> Author: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
> Date:   Fri Oct 10 14:40:39 2008 -0700
> 
>     IB/ehca: Don't allow creating UC QP with SRQ
>     
>     This patch prevents a UC QP to be created attached to an SRQ, since
>     current firmware does not support this feature.
>     
>     Signed-off-by: Michael Faath <micfaath@de.ibm.com>
>     Signed-off-by: Roland Dreier <rolandd@cisco.com>
> 
> diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
> index 4dbe287..40b578d 100644
> --- a/drivers/infiniband/hw/ehca/ehca_qp.c
> +++ b/drivers/infiniband/hw/ehca/ehca_qp.c
> @@ -502,6 +502,12 @@ static struct ehca_qp *internal_create_qp(
>  	if (init_attr->srq) {
>  		my_srq = container_of(init_attr->srq, struct ehca_qp, ib_srq);
> 
> +		if (qp_type == IB_QPT_UC) {
> +			ehca_err(pd->device, "UC with SRQ not supported");
> +			atomic_dec(&shca->num_qps);
> +			return ERR_PTR(-EINVAL);
> +		}
> +
>  		has_srq = 1;
>  		parms.ext_type = EQPT_SRQBASE;
>  		parms.srq_qpn = my_srq->real_qp_num;
> 
