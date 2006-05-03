Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CE5C467A63
	for <linuxppc-dev@ozlabs.org>; Wed,  3 May 2006 23:55:29 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.6/8.13.6) with ESMTP id k43DtN1N050112
	for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2006 13:55:23 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k43DuZH6112514
	for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2006 15:56:35 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k43DtNJr018344
	for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2006 15:55:23 +0200
In-Reply-To: <17489.18630.75412.66803@cargo.ozlabs.ibm.com>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
To: Paul Mackerras <paulus@samba.org>
Message-ID: <OF10E7ED21.CCC1AFCE-ONC1257163.00478AC0-C1257163.004BF94F@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Wed, 3 May 2006 15:56:34 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>,
	=?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> wrote on 28.04.2006 00:42:14:

> Mind you, since a lot of the parameters are used to return individual
> bytes or half-words, which are then put into structures, it might be
> better to pass the pointers to the structures and let the wrapper put
> the values straight into the structures.
>
> Paul.

As Paul already mentioned we can't change the firmware interface.

...so we would propose the following solution:
For the two h_call wrappers with more than 8 parameters we'll change to the
following signature:

hipz_h_alloc_resource_cq(const struct ipz_adapter_handle adapter_handle,
                         struct ehca_cq *cq, /* used for input and output
parameters */
                         const struct ipz_eq_handle eq_handle);

hipz_h_alloc_resource_qp(const struct ipz_adapter_handle adapter_handle,
                         struct ehca_qp * qp, /* used for input and output
parameters */
                         struct ehca_alloc_qp_params * param); /*input
params not in ehca_qp*/


hipz_h_alloc_resource_mr(const struct ipz_adapter_handle adapter_handle,
                         struct ehca_mr *mr,
                         const u64 vaddr,
                         const u64 length,
                         const u32 access_ctrl,
                         const struct ipz_pd pd);


u64 hipz_h_query_mr(const struct ipz_adapter_handle adapter_handle,
                    struct ehca_mr *mr);

u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle adapter_handle,
                          struct ehca_mr *mr,
                          const u64 vaddr_in,
                          const u64 length,
                          const u32 access_ctrl,
                          const struct ipz_pd pd,
                          const u64 mr_addr_cb);

u64 hipz_h_register_smr(const struct ipz_adapter_handle adapter_handle,
                        struct ehca_mr *mr,
                        struct ehca_mr *orig_mr,
                        const u64 vaddr_in,
                        const u32 access_ctrl,
                        const struct ipz_pd pd);


What do you think about this solution?


Gruss / Regards . . . Christoph Raisch
