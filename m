Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1BAF12C0081
 for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2012 17:47:26 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 6 Nov 2012 12:17:22 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA66lLHM4587900
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2012 12:17:21 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA6CFoLX032111
 for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2012 23:15:51 +1100
Message-ID: <5098B28B.2070703@linux.vnet.ibm.com>
Date: Tue, 06 Nov 2012 12:17:39 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc/perf: Fix finding overflowed PMC in interrupt
References: <20121106122559.38ea906f@kryten>
 <1352166835-27980-1-git-send-email-mikey@neuling.org>
In-Reply-To: <1352166835-27980-1-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/06/2012 07:23 AM, Michael Neuling wrote:

> +	if (!found && pvr_version_is(PVR_POWER7)) {
> +		/* check active counters for special buggy p7 overflow */
> +		for (i = 0; i < cpuhw->n_events; ++i) {
> +			event = cpuhw->event[i];
> +			if (!event->hw.idx || is_limited_pmc(event->hw.idx))
>  				continue;
> -			val = read_pmc(i + 1);
> -			if (pmc_overflow(val))
> -				write_pmc(i + 1, 0);
> +			if (pmc_overflow_power7(val[event->hw.idx - 1])) {


I have couple of questions. 

Can the buggy overflow happen on any of the available counters PMC1-PMC4 ?
Will this approach never reset an actual user defined event (with sample period < 256) ?
Is this related to the counter or the event which it is counting ? Just wondering if we
have to do something more than checking for the count < 256. Just a thought.

Regards
Anshuman
