Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A49C1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 15:54:12 +1100 (AEDT)
Received: by mail-pa0-x236.google.com with SMTP id fy10so57001080pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 20:54:12 -0800 (PST)
Message-ID: <1455598439.3308.7.camel@gmail.com>
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
From: Balbir Singh <bsingharora@gmail.com>
To: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Petr
 Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Tue, 16 Feb 2016 15:53:59 +1100
In-Reply-To: <20160215222111.GA3321@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com> <20160211084230.GB29683@lst.de>
 <1455532035.26205.5.camel@ellerman.id.au> <20160215140408.GA22872@lst.de>
 <20160215222111.GA3321@lst.de>
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

On Mon, 2016-02-15 at 23:21 +0100, Torsten Duwe wrote:
> On Mon, Feb 15, 2016 at 03:04:08PM +0100, Torsten Duwe wrote:
> > If you use "-pg -mprofile-kernel", gcc seems to forget that, and omits the TOC
> > load, for a similar assembler calling sequence.
> > 
> > Looking at the code I can _understand_ why this is so, but my GCC knowledge
> > is not that deep that I could easily _fix_ this reliably.
> 
> Nonetheless, here's a proposal.
> 
> --- a/gcc/config/rs6000/rs6000.c
> +++ b/gcc/config/rs6000/rs6000.c
> @@ -25154,6 +25154,10 @@ rs6000_emit_prologue (void)
>      {
>        cfun->machine->r2_setup_needed = df_regs_ever_live_p (TOC_REGNUM);
>  
> +      /* Profiling _will_ generate a call to a global _mcount. */
> +      if (crtl->profile)
> +	cfun->machine->r2_setup_needed = true;
> +
>        /* With -mminimal-toc we may generate an extra use of r2 below.  */
>        if (TARGET_TOC && TARGET_MINIMAL_TOC && get_pool_size () != 0)
>  	cfun->machine->r2_setup_needed = true;

I was wondering if ftrace() works correctly, specifically dynamic ftrace.
We should be able to get livepatching to work as well. I can see r2 being
saved in the stub in ftrace_caller in patch 2/8

+       mr      r0,r2   /* save callee's TOC */
+       addis   r2,r12,(.TOC.-ftrace_caller-12)@ha
+       addi    r2,r2,(.TOC.-ftrace_caller-12)@l

The only limitation today is figuring out the correct offset to patch
(8 or 16) depending on whether the TOC stub is generated or not by the
compiler

If the sequence is well known, we could potentially scan instructions
or go to the hash that ftrace maintains and search in there with an offset
of 8 to 16.

Balbir Singh
