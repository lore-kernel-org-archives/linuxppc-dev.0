Return-Path: <dwalker@fifo99.com>
Received: from fifo99.com (fifo99.com [67.223.236.141])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 30D05B7B80
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 00:51:23 +1000 (EST)
Subject: Re: [PATCH v3 1/3] pSeries: cede latency specifier helper function.
From: Daniel Walker <dwalker@fifo99.com>
To: Gautham R Shenoy <ego@in.ibm.com>
In-Reply-To: <20090915120701.20523.94109.stgit@sofia.in.ibm.com>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<20090915120701.20523.94109.stgit@sofia.in.ibm.com>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 07:45:05 -0700
Message-Id: <1253025905.11643.335.camel@desktop>
Mime-Version: 1.0
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	"Darrick J. Wong" <djwong@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-15 at 17:37 +0530, Gautham R Shenoy wrote:
>         // Used to pass parms from the OS to PLIC for SetAsrAndRfid
>         u64     saved_gpr3;             // Saved GPR3                   x20-x27
>         u64     saved_gpr4;             // Saved GPR4                   x28-x2F
> -       u64     saved_gpr5;             // Saved GPR5                   x30-x37
> +       union {
> +               u64     saved_gpr5;     // Saved GPR5                   x30-x37
> +               struct {
> +                       u8      cede_latency_hint;  //                  x30
> +                       u8      reserved[7];        //                  x31-x36
> +               } fields;
> +       } gpr5_dword;
> +
>  
>         u8      dtl_enable_mask;        // Dispatch Trace Log mask      x38-x38
>         u8      donate_dedicated_cpu;   // Donate dedicated CPU cycles  x39-x39

Could you drop the C99 style comments (use /* */ instead)? If you run
checkpatch on this it will error on these lines..

Daniel
