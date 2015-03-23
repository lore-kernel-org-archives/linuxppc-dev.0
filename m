Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D5881A2ADE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 08:57:29 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 15:57:27 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 663053E40044
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 15:57:25 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2NLvPlf33292442
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 14:57:25 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2NLuDlB011569
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 15:56:14 -0600
Date: Mon, 23 Mar 2015 14:55:19 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [8/9] powerpc/hv-24x7: Break up single_24x7_request
Message-ID: <20150323215519.GA6013@us.ibm.com>
References: <1424210434-28070-9-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150317022358.8DE1D14011D@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150317022358.8DE1D14011D@ozlabs.org>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
| > +static void start_24x7_get_data(struct hv_24x7_request_buffer *request_buffer,
| > +			struct hv_24x7_data_result_buffer *result_buffer)
| > +{
| 
| Just init_24x7_request() ?

Sure.

| 
| > +
| > +	memset(request_buffer, 0, 4096);
| > +	memset(result_buffer, 0, 4096);
| > +
| > +	request_buffer->interface_version = HV_24X7_IF_VERSION_CURRENT;
| > +	/* memset above set request_buffer->num_requests to 0 */
| > +}
| > +
| > +/*
| > + * Commit (i.e perform) the H_GET_24x7_DATA hcall using the data collected
| > + * by 'start_24x7_get_data()' and 'add_event_to_24x7_request()'.
| > + */
| > +static int commit_24x7_get_data(struct hv_24x7_request_buffer *request_buffer,
| > +			struct hv_24x7_data_result_buffer *result_buffer)
| > +{
| 
| It don't like "commit" that is a loaded term.
| 
| Just make_24x7_request() perhaps?

Sure.

Thanks

Sukadev
