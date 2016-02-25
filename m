Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC3021A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 21:39:51 +1100 (AEDT)
Message-ID: <1456396790.15739.11.camel@ellerman.id.au>
Subject: Re: [PATCH 05/12] powerpc/ftrace: ftrace_graph_caller() needs to
 save/restore toc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz,  live-patching@vger.kernel.org, mbenes@suse.cz
Date: Thu, 25 Feb 2016 21:39:50 +1100
In-Reply-To: <56CE4B2E.7070505@gmail.com>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-5-git-send-email-mpe@ellerman.id.au>
 <56CE4B2E.7070505@gmail.com>
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

On Thu, 2016-02-25 at 11:30 +1100, Balbir Singh wrote:
> 
> On 25/02/16 01:28, Michael Ellerman wrote:
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > 
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index 2a7313cfbc7d..9e77a2c8f218 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -1237,6 +1237,11 @@ _GLOBAL(ftrace_graph_caller)
> >  	std	r5, 64(r1)
> >  	std	r4, 56(r1)
> >  	std	r3, 48(r1)
> > +
> > +	/* Save callee's TOC in the ABI compliant location */
> > +	std	r2, 24(r1)

> R2_STACK_OFFSET for readability?

Hmm, maybe. Personally when I see "24(r1)" what my brain reads is "stack TOC
save slot", but maybe I've been spending too much time with powerpc assembly.

R2_STACK_OFFSET is actually new, pulled out from the module code by Torsten.
Other code uses STK_GOT to mean the same thing. I don't really like either
name, so I'll probably leave do a clean up once this is in.

cheers
