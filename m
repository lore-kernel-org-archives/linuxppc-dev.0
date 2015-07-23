Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E57D81A02B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:11:13 +1000 (AEST)
Message-ID: <1437642672.29271.2.camel@ellerman.id.au>
Subject: Re: [PATCH v5 4/7] powerpc/powernv: detect supported nest pmus and
 its events
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Anton
 Blanchard <anton@samba.org>,  Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 19:11:12 +1000
In-Reply-To: <55B083A2.4030404@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-5-git-send-email-maddy@linux.vnet.ibm.com>
 <1437538064.30906.20.camel@axtens.net>
 <55B083A2.4030404@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-23 at 11:33 +0530, Madhavan Srinivasan wrote:
> 
> On Wednesday 22 July 2015 09:37 AM, Daniel Axtens wrote:
> >  
> >>  static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
> >> +static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
> >> +
> >> +static int nest_event_info(struct property *pp, char *name,
> >> +			struct nest_ima_events *p8_events, int string, u32 val)
> > 'int string' is a bit confusing. 'bool is_string' might be clearer, but
> > I think it would be even better still to have different functions for
> > string and non-string cases, especially because you only need val in the
> > non-string case.
> 
> I would perfer to be a single function, since most of the code is same
> just of the sting or val part. yes. We can make is as is_string and will
> add comment explaining what is done here? 

I think Daniel's right, it would be better as two functions.

The only part that is common after the if (string) check is the
p8_events->ev_value = buf assignment.

So you should be able to keep all the code up to the if (string) check in a
shared function and just have two wrappers that use it.

cheers
