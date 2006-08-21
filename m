Return-Path: <osstklei@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6988D67B6A
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 22:03:38 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7LC3Wlp013264
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 12:03:32 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7LC7V8v154704
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 14:07:31 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7LC3WiS005812
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 14:03:32 +0200
Message-ID: <44E9A114.6040605@de.ibm.com>
Date: Mon, 21 Aug 2006 14:03:32 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [2.6.19 PATCH 5/7] ehea: main header files
References: <200608181334.57701.ossthema@de.ibm.com>
	<20060818180345.9660E67B64@ozlabs.org>
In-Reply-To: <20060818180345.9660E67B64@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
 >> +static inline void ehea_update_sqa(struct ehea_qp *qp, u16 nr_wqes)
 >> +{
 >> +    struct h_epa epa = qp->epas.kernel;
 >> +    epa_store_acc(epa, QPTEMM_OFFSET(qpx_sqa),
 >> +                  EHEA_BMASK_SET(QPX_SQA_VALUE, nr_wqes));
 >> +}
 >> +
 >> +static inline void ehea_update_rq3a(struct ehea_qp *qp, u16 nr_wqes)
 >> +{
 >> +    struct h_epa epa = qp->epas.kernel;
 >> +    epa_store_acc(epa, QPTEMM_OFFSET(qpx_rq3a),
 >> +                  EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));
 >> +}
 >> +
 >> +static inline void ehea_update_rq2a(struct ehea_qp *qp, u16 nr_wqes)
 >> +{
 >> +    struct h_epa epa = qp->epas.kernel;
 >> +    epa_store_acc(epa, QPTEMM_OFFSET(qpx_rq2a),
 >> +                  EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));
 >> +}
 >> +
 >> +static inline void ehea_update_rq1a(struct ehea_qp *qp, u16 nr_wqes)
 >> +{
 >> +    struct h_epa epa = qp->epas.kernel;
 >> +    epa_store_acc(epa, QPTEMM_OFFSET(qpx_rq1a),
 >> +                  EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));
 >> +}
 >> +
 >> +static inline void ehea_update_feca(struct ehea_cq *cq, u32 nr_cqes)
 >> +{
 >> +    struct h_epa epa = cq->epas.kernel;
 >> +    epa_store_acc(epa, CQTEMM_OFFSET(cqx_feca),
 >> +                  EHEA_BMASK_SET(CQX_FECADDER, nr_cqes));
 >> +}
 >> +
 >> +static inline void ehea_reset_cq_n1(struct ehea_cq *cq)
 >> +{
 >> +    struct h_epa epa = cq->epas.kernel;
 >> +    epa_store_cq(epa, cqx_n1,
 >> +                 EHEA_BMASK_SET(CQX_N1_GENERATE_COMP_EVENT, 1));
 >> +}
 >> +
 >> +static inline void ehea_reset_cq_ep(struct ehea_cq *my_cq)
 >> +{
 >> +    struct h_epa epa = my_cq->epas.kernel;
 >> +    epa_store_acc(epa, CQTEMM_OFFSET(cqx_ep),
 >> +                  EHEA_BMASK_SET(CQX_EP_EVENT_PENDING, 0));
 >> +}
 >
 > These are almost identical... I'm sure most (if not all) could be merged
 > into a single function or #define.
 >
 > Mikey

Hi Mikey,

I gave it a try: ehea_reset_cq_n1() drops out because it calls epa_store_cq(),
not epa_store_acc(). ehea_update_feca() and ehea_reset_cq_ep() require a
different input parm as the others and replacing two inline functions by
one inline function and two macros doesn't help neither the code nor does
it improve readability.
Finally we have ehea_update_sqa() and the 3 ehea_update_rqXa() functions which
I replaced by an inline function and four macros. See the result below. It
think understanding what this does is way more difficult than looking at the
four inline functions we had before. Therefore I'd prefer leaving those inline
functions as is.

Regards
Thomas


#define ehea_update_sqa(qp, nr_wqes) \
         ehea_update_qa(qp, nr_wqes, \
                        QPTEMM_OFFSET(qpx_sqa), \
                        EHEA_BMASK_SET(QPX_SQA_VALUE, nr_wqes));

#define ehea_update_rq1a(qp, nr_wqes) \
         ehea_update_qa(qp, nr_wqes, \
                        QPTEMM_OFFSET(qpx_rq1a), \
                        EHEA_BMASK_SET(QPX_RQ1A_VALUE, nr_wqes));

#define ehea_update_rq2a(qp, nr_wqes) \
         ehea_update_qa(qp, nr_wqes, \
                        QPTEMM_OFFSET(qpx_rq2a), \
                        EHEA_BMASK_SET(QPX_RQ2A_VALUE, nr_wqes));

#define ehea_update_rq3a(qp, nr_wqes) \
         ehea_update_qa(qp, nr_wqes, \
                        QPTEMM_OFFSET(qpx_rq3a), \
                        EHEA_BMASK_SET(QPX_RQ3A_VALUE, nr_wqes));

static inline void ehea_update_qa(struct ehea_qp *qp, u16 nr_wqes,
                                   u32 offset, u64 value)
{
         struct h_epa epa = qp->epas.kernel;
         epa_store_acc(epa, offset, value);
}
