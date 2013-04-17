Return-Path: <michael@ellerman.id.au>
Date: Wed, 17 Apr 2013 17:08:53 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 5/5] powerpc, perf: Enable branch stack sampling
 framework support with BHRB
Message-ID: <20130417070852.GA29203@concordia>
References: <1366127650-1952-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1366127650-1952-6-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366127650-1952-6-git-send-email-khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 16, 2013 at 09:24:10PM +0530, Anshuman Khandual wrote:
> This patch provides basic enablement for perf branch stack sampling framework
> on POWER8 processor with a new PMU feature called BHRB (Branch History Rolling
> Buffer).
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/core-book3s.c     | 96 +++++++++++++++++++++++++++++++++++--
>  arch/powerpc/perf/perf_event_bhrb.c | 85 ++++++++++++++++++++++++++++++++
>  2 files changed, 178 insertions(+), 3 deletions(-)
>  create mode 100644 arch/powerpc/perf/perf_event_bhrb.c
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 4ac6e64..f4d1347 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -19,6 +19,8 @@
>  #include <asm/firmware.h>
>  #include <asm/ptrace.h>
>  
> +#define BHRB_MAX_ENTRIES	32
> +
>  struct cpu_hw_events {
>  	int n_events;
>  	int n_percpu;
> @@ -38,11 +40,21 @@ struct cpu_hw_events {
>  
>  	unsigned int group_flag;
>  	int n_txn_start;
> +
> +	/* BHRB bits */
> +	u64				bhrb_filter;	/* BHRB HW branch filter */
> +	int				bhrb_users;
> +	void				*bhrb_context;
> +	struct	perf_branch_stack	bhrb_stack;
> +	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
>  };
> +
>  DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
>  
>  struct power_pmu *ppmu;
>  
> +#include "perf_event_bhrb.c"
> +

Um, why are you doing that?

If it's code that should be in a header, put it in a header. If it's C
code, add it to the Makefile.

cheers
