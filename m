Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B78CD2C00C3
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Oct 2013 03:58:18 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 3 Oct 2013 13:58:16 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4C20F38C8047
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Oct 2013 13:58:13 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r93HwDrE3277168
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Oct 2013 17:58:13 GMT
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r93HwCKR013161
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Oct 2013 14:58:13 -0300
Date: Thu, 3 Oct 2013 10:57:57 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/9][v5] powerpc/perf: Export Power8 generic events in
 sysfs
Message-ID: <20131003175757.GA21561@us.ibm.com>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1380672911-12812-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20131003040431.GB17237@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131003040431.GB17237@concordia>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [michael@ellerman.id.au] wrote:
| On Tue, Oct 01, 2013 at 05:15:03PM -0700, Sukadev Bhattiprolu wrote:
| > Export generic perf events for Power8 in sysfs.
| > 
| > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| > Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
| > ---
| >  arch/powerpc/perf/power8-pmu.c |   23 +++++++++++++++++++++++
| >  1 file changed, 23 insertions(+)
| > 
| > diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
| > index 976c203..b991b2e 100644
| > --- a/arch/powerpc/perf/power8-pmu.c
| > +++ b/arch/powerpc/perf/power8-pmu.c
| > @@ -510,6 +510,28 @@ static void power8_disable_pmc(unsigned int pmc, unsigned long mmcr[])
| >  		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
| >  }
| >  
| > +GENERIC_EVENT_ATTR(cpu-cyles,			PM_CYC);
| > +GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_GCT_NOSLOT_CYC);
| > +GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
| > +GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
| > +GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_FIN);
| > +GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
| 
| And here you use PM_ not PME_ - I'm confused.

It is a bit confusing. The GENERIC_EVENT_ATTR() adds the PME_ prefix. I
kept this change minimal for now, since we will have to revisit this once
the Power8 events are finalized.

Sukadev
