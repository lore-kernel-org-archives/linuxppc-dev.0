Return-Path: <fenkes@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1B02DE42F
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 18:45:32 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m3L8jR5K101730
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 08:45:27 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3L8jRI41941658
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 09:45:27 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3L8jQ6t022595
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 08:45:27 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 1/5] IB/ehca: Prevent posting of SQ WQEs if QP not in RTS
Date: Mon, 21 Apr 2008 09:45:25 +0100
References: <200804211003.10695.fenkes@de.ibm.com>
	<200804211004.44666.fenkes@de.ibm.com>
In-Reply-To: <200804211004.44666.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804211045.26183.fenkes@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 April 2008 10:04, Joachim Fenkes wrote:

> +	if (unlikely(my_qp->state != IB_QPS_RTS)) {
> +		ehca_err(qp->device, "QP not in RTS state  qpn=%x", qp->qp_num);
> +		return -EINVAL;
> +	}

Myself, I'm not very happy with using EINVAL, but I can't think of a more
fitting return code. Also, this is what nes, amso and cxgb3 return in such a
case; ipath posts an error CQE and mthca/mlx4 don't do this check at all
(AFAICS).

Better suggestions, anyone?

Regards,
  Joachim
