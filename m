Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F121A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 09:21:16 +1100 (AEDT)
Date: Mon, 15 Feb 2016 23:21:11 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Jessica Yu <jeyu@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160215222111.GA3321@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com> <20160211084230.GB29683@lst.de>
 <1455532035.26205.5.camel@ellerman.id.au> <20160215140408.GA22872@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160215140408.GA22872@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 15, 2016 at 03:04:08PM +0100, Torsten Duwe wrote:
> If you use "-pg -mprofile-kernel", gcc seems to forget that, and omits the TOC
> load, for a similar assembler calling sequence.
> 
> Looking at the code I can _understand_ why this is so, but my GCC knowledge
> is not that deep that I could easily _fix_ this reliably.

Nonetheless, here's a proposal.

--- a/gcc/config/rs6000/rs6000.c
+++ b/gcc/config/rs6000/rs6000.c
@@ -25154,6 +25154,10 @@ rs6000_emit_prologue (void)
     {
       cfun->machine->r2_setup_needed = df_regs_ever_live_p (TOC_REGNUM);
 
+      /* Profiling _will_ generate a call to a global _mcount. */
+      if (crtl->profile)
+	cfun->machine->r2_setup_needed = true;
+
       /* With -mminimal-toc we may generate an extra use of r2 below.  */
       if (TARGET_TOC && TARGET_MINIMAL_TOC && get_pool_size () != 0)
 	cfun->machine->r2_setup_needed = true;
