Return-Path: <mrmacman_g4@mac.com>
Received: from smtpout.mac.com (smtpout.mac.com [17.250.248.184])
	by ozlabs.org (Postfix) with ESMTP id D57DF67A6B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 03:19:53 +1000 (EST)
In-Reply-To: <20060427123701.GG32127@wohnheim.fh-wedel.de>
References: <4450A1C0.3080209@de.ibm.com>
	<20060427123701.GG32127@wohnheim.fh-wedel.de>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <28E154B8-B491-4C5D-9976-5082718FEF26@mac.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
Date: Thu, 27 Apr 2006 13:13:54 -0400
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 27, 2006, at 08:37:01, J=F6rn Engel wrote:
> On Thu, 27 April 2006 12:49:36 +0200, Heiko J Schick wrote:
>> +u64 hipz_h_alloc_resource_qp(const struct ipz_adapter_handle
>> adapter_handle,
>> +			     struct ehca_pfqp *pfqp,
>> +			     const u8 servicetype,
>> +			     const u8 daqp_ctrl,
>> +			     const u8 signalingtype,
>> +			     const u8 ud_av_l_key_ctl,
>> +			     const struct ipz_cq_handle send_cq_handle,
>> +			     const struct ipz_cq_handle =
receive_cq_handle,
>> +			     const struct ipz_eq_handle async_eq_handle,
>> +			     const u32 qp_token,
>> +			     const struct ipz_pd pd,
>> +			     const u16 max_nr_send_wqes,
>> +			     const u16 max_nr_receive_wqes,
>> +			     const u8 max_nr_send_sges,
>> +			     const u8 max_nr_receive_sges,
>> +			     const u32 ud_av_l_key,
>> +			     struct ipz_qp_handle *qp_handle,
>> +			     u32 * qp_nr,
>> +			     u16 * act_nr_send_wqes,
>> +			     u16 * act_nr_receive_wqes,
>> +			     u8 * act_nr_send_sges,
>> +			     u8 * act_nr_receive_sges,
>> +			     u32 * nr_sq_pages,
>> +			     u32 * nr_rq_pages,
>> +			     struct h_galpas *h_galpas);
>
> 25 parameters?  If you tell me which drugs were involved in this =20
> code, I know what to stay away from.  Might be the current record =20
> for any code ever proposed for inclusion.
>
> The whole patch is full of parameter-happy functions with this one =20
> being the ugly top of the iceberg.  I sincerely hope this is not a =20
> defined ABI and can still be changed.

What's worse; look at the stack usage on that sucker alone:

10 pointers, 6 u8, 2 u16, 2 u32, and topped off with 3 unknown-sized =20
"struct ipz_cq_handle", an unknown-sized "struct ipz_pd".  The =20
alignment alone probably chews up at least another couple bytes in =20
there somewhere too.  That's at _least_ 98 + 3*sizeof(struct =20
ipz_cq_handle) + sizeof(struct ipz_pd) on a 64-bit platform (58 + =20
3*sizeof(struct ipz_cq_handle) + sizeof(struct ipz_pd) on 32-bit).  =20
Not to mention the fact that you totally screwed the compiler's =20
chances of ever passing the important stuff in registers.  And you =20
haven't even gotten into local variables yet.

Cheers,
Kyle Moffett
