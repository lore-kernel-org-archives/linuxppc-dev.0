Return-Path: <michael@ellerman.id.au>
Date: Tue, 8 Oct 2013 15:21:37 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc, perf: Configure BHRB filter before enabling PMU
 interrupts
Message-ID: <20131008042137.GE31666@concordia>
References: <1381120226-14838-1-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381120226-14838-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 07, 2013 at 10:00:26AM +0530, Anshuman Khandual wrote:
> Right now the `config_bhrb` PMU specific call happens after write_mmcr0
> which actually enables the PMU for event counting and interrupt. So
> there is a small window of time where the PMU and BHRB runs without the
> required HW branch filter (if any) enabled in BHRB. This can cause some
> of the branch samples to be collected through BHRB without any filter
> being applied and hence affecting the correctness of the results. This
> patch moves the BHRB config function call before enabling the interrupts.

Patch looks good.

But it reminds me I have an item in my TODO list:
 - "Why can't config_bhrb() be done in compute_mmcr()" ?

cheers
