Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 50190140079
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 19:36:38 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 28 Mar 2014 08:36:34 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id AD7EE1B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 08:36:25 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2S8aKKU26149118
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 08:36:20 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2S8aUdM007200
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 02:36:31 -0600
Date: Fri, 28 Mar 2014 09:36:25 +0100
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Laurent Dufour <laurent.dufour@fr.ibm.com>
Subject: Re: [PATCH] powerpc/le: enable RTAS events support
Message-ID: <20140328093625.4d583774@bahia.local>
In-Reply-To: <533532E2.4020505@fr.ibm.com>
References: <20140328073344.26823.32931.stgit@bahia.local>
 <533532E2.4020505@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 28 Mar 2014 09:29:22 +0100
Laurent Dufour <laurent.dufour@fr.ibm.com> wrote:
> On 28/03/2014 08:33, Greg Kurz wrote:
> > The current kernel code assumes big endian and parses RTAS events all
> > wrong. The most visible effect is that we cannot honor EPOW events,
> > meaning, for example, we cannot shut down a guest properly from the
> > hypervisor.
> > 
> > This patch fixes that.
> > 
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> 
> Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> > ---
> >  arch/powerpc/include/asm/rtas.h      |   46 ++++++++++++++++++++++++++++++++++
> >  arch/powerpc/kernel/rtas.c           |   11 ++++----
> >  arch/powerpc/kernel/rtasd.c          |    8 ++++--
> >  arch/powerpc/platforms/pseries/ras.c |    3 +-
> >  4 files changed, 59 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> > index 9bd52c6..8bb99d0 100644
> > --- a/arch/powerpc/include/asm/rtas.h
> > +++ b/arch/powerpc/include/asm/rtas.h
> > @@ -150,15 +150,37 @@ struct rtas_suspend_me_data {
> >  #define RTAS_VECTOR_EXTERNAL_INTERRUPT	0x500
> >  
> >  struct rtas_error_log {
> > +#ifdef __BIG_ENDIAN__
> > +	/* Byte 0 */
> >  	unsigned long version:8;		/* Architectural version */
> > +	/* Byte 1 */
> >  	unsigned long severity:3;		/* Severity level of error */
> >  	unsigned long disposition:2;		/* Degree of recovery */
> >  	unsigned long extended:1;		/* extended log present? */
> >  	unsigned long /* reserved */ :2;	/* Reserved for future use */
> > +	/* Byte 2 */
> >  	unsigned long initiator:4;		/* Initiator of event */
> >  	unsigned long target:4;			/* Target of failed operation */
> > +	/* Byte 3 */
> >  	unsigned long type:8;			/* General event or error*/
> > +	/* Byte 4 */
> >  	unsigned long extended_log_length:32;	/* length in bytes */
> > +#else
> > +	/* Byte 0 */
> > +	unsigned long version:8;
> > +	/* Byte 1 */
> > +	unsigned long :2;
> > +	unsigned long extended:1;
> > +	unsigned long disposition:2;
> > +	unsigned long severity:3;
> > +	unsigned long target:4;
> 
> Hi Greg,
> 
> A cosmetic detail: 'target' is in the 'Byte 2'.
> 
> Laurent.
> 

Good catch ! Thanks.

> > +	/* Byte 2 */
> > +	unsigned long initiator:4;
> > +	/* Byte 3 */
> > +	unsigned long type:8;
> > +	/* Byte 4 */
> > +	unsigned long extended_log_length:32;
> > +#endif
> >  	unsigned char buffer[1];		/* Start of extended log */
> >  						/* Variable length.      */
> >  };
> > @@ -171,6 +193,7 @@ struct rtas_error_log {
> >   * from "buffer" field of struct rtas_error_log defined above.
> >   */
> >  struct rtas_ext_event_log_v6 {
> > +#ifdef __BIG_ENDIAN__
> >  	/* Byte 0 */
> >  	uint32_t log_valid:1;		/* 1:Log valid */
> >  	uint32_t unrecoverable_error:1;	/* 1:Unrecoverable error */
> > @@ -200,6 +223,29 @@ struct rtas_ext_event_log_v6 {
> >  	uint32_t company_id;		/* Company ID of the company	*/
> >  					/* that defines the format for	*/
> >  					/* the vendor specific log type	*/
> > +#else
> > +	/* Byte 0 */
> > +	uint32_t :1;
> > +	uint32_t big_endian:1;
> > +	uint32_t new_log:1;
> > +	uint32_t predictive_error:1;
> > +	uint32_t degraded_operation:1;
> > +	uint32_t recoverable_error:1;
> > +	uint32_t unrecoverable_error:1;
> > +	uint32_t log_valid:1;
> > +	/* Byte 1 */
> > +	uint32_t :8;
> > +	/* Byte 2 */
> > +	uint32_t log_format:4;
> > +	uint32_t :3;
> > +	uint32_t powerpc_format:1;
> > +	/* Byte 3 */
> > +	uint32_t :8;
> > +	/* Byte 4-11 */
> > +	uint8_t reserved[8];
> > +	/* Byte 12-15 */
> > +	uint32_t company_id;
> > +#endif
> >  	/* Byte 16-end of log */
> >  	uint8_t vendor_log[1];		/* Start of vendor specific log	*/
> >  					/* Variable length.		*/
> > diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> > index f386296..e18ab12 100644
> > --- a/arch/powerpc/kernel/rtas.c
> > +++ b/arch/powerpc/kernel/rtas.c
> > @@ -993,21 +993,22 @@ struct pseries_errorlog *get_pseries_errorlog(struct rtas_error_log *log,
> >  		(struct rtas_ext_event_log_v6 *)log->buffer;
> >  	struct pseries_errorlog *sect;
> >  	unsigned char *p, *log_end;
> > +	uint32_t extended_log_length = be32_to_cpu(log->extended_log_length);
> >  
> >  	/* Check that we understand the format */
> > -	if (log->extended_log_length < sizeof(struct rtas_ext_event_log_v6) ||
> > +	if (extended_log_length < sizeof(struct rtas_ext_event_log_v6) ||
> >  	    ext_log->log_format != RTAS_V6EXT_LOG_FORMAT_EVENT_LOG ||
> > -	    ext_log->company_id != RTAS_V6EXT_COMPANY_ID_IBM)
> > +	    be32_to_cpu(ext_log->company_id) != RTAS_V6EXT_COMPANY_ID_IBM)
> >  		return NULL;
> >  
> > -	log_end = log->buffer + log->extended_log_length;
> > +	log_end = log->buffer + extended_log_length;
> >  	p = ext_log->vendor_log;
> >  
> >  	while (p < log_end) {
> >  		sect = (struct pseries_errorlog *)p;
> > -		if (sect->id == section_id)
> > +		if (be16_to_cpu(sect->id) == section_id)
> >  			return sect;
> > -		p += sect->length;
> > +		p += be16_to_cpu(sect->length);
> >  	}
> >  
> >  	return NULL;
> > diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
> > index 1130c53..1987825 100644
> > --- a/arch/powerpc/kernel/rtasd.c
> > +++ b/arch/powerpc/kernel/rtasd.c
> > @@ -159,14 +159,16 @@ static int log_rtas_len(char * buf)
> >  {
> >  	int len;
> >  	struct rtas_error_log *err;
> > +	uint32_t extended_log_length;
> >  
> >  	/* rtas fixed header */
> >  	len = 8;
> >  	err = (struct rtas_error_log *)buf;
> > -	if (err->extended && err->extended_log_length) {
> > +	extended_log_length = be32_to_cpu(err->extended_log_length);
> > +	if (err->extended && extended_log_length) {
> >  
> >  		/* extended header */
> > -		len += err->extended_log_length;
> > +		len += extended_log_length;
> >  	}
> >  
> >  	if (rtas_error_log_max == 0)
> > @@ -298,7 +300,7 @@ static void handle_rtas_event(const struct rtas_error_log *log)
> >  		 * the scope for calling rtas update-nodes.
> >  		 */
> >  		if (prrn_is_enabled())
> > -			prrn_schedule_update(log->extended_log_length);
> > +			prrn_schedule_update(be32_to_cpu(log->extended_log_length));
> >  	}
> >  
> >  	return;
> > diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> > index 721c058..39e7557 100644
> > --- a/arch/powerpc/platforms/pseries/ras.c
> > +++ b/arch/powerpc/platforms/pseries/ras.c
> > @@ -306,7 +306,8 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
> >  	} else {
> >  		int len;
> >  
> > -		len = max_t(int, 8+h->extended_log_length, RTAS_ERROR_LOG_MAX);
> > +		len = max_t(int, 8+be32_to_cpu(h->extended_log_length),
> > +			    RTAS_ERROR_LOG_MAX);
> >  		memset(global_mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
> >  		memcpy(global_mce_data_buf, h, len);
> >  		errhdr = (struct rtas_error_log *)global_mce_data_buf;
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> 



-- 
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/Meiosys                  http://www.ibm.com
Tel +33 (0)562 165 496

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.
