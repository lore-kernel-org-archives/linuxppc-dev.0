Return-Path: <michael@ellerman.id.au>
Date: Thu, 3 Oct 2013 14:04:31 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/9][v5] powerpc/perf: Export Power8 generic events in
 sysfs
Message-ID: <20131003040431.GB17237@concordia>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1380672911-12812-3-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380672911-12812-3-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Tue, Oct 01, 2013 at 05:15:03PM -0700, Sukadev Bhattiprolu wrote:
> Export generic perf events for Power8 in sysfs.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/power8-pmu.c |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
> index 976c203..b991b2e 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -510,6 +510,28 @@ static void power8_disable_pmc(unsigned int pmc, unsigned long mmcr[])
>  		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
>  }
>  
> +GENERIC_EVENT_ATTR(cpu-cyles,			PM_CYC);
> +GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_GCT_NOSLOT_CYC);
> +GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
> +GENERIC_EVENT_ATTR(instructions,		PM_INST_CMPL);
> +GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_FIN);
> +GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);

And here you use PM_ not PME_ - I'm confused.

cheers
