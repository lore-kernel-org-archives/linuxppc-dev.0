Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D339D1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 21:03:38 +1000 (EST)
Message-ID: <1402052599.3247.225.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/powernv: include asm/smp.h to handle UP config
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 06 Jun 2014 21:03:19 +1000
In-Reply-To: <539152B3.5070702@linux.vnet.ibm.com>
References: <1401981695-3682-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <539152B3.5070702@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-06-06 at 11:03 +0530, Anshuman Khandual wrote:
> On 06/05/2014 08:51 PM, Shreyas B. Prabhu wrote:
> > Build throws following errors when CONFIG_SMP=n
> > arch/powerpc/platforms/powernv/setup.c: In function ‘pnv_kexec_wait_secondaries_down’:
> > arch/powerpc/platforms/powernv/setup.c:179:4: error: implicit declaration of function ‘get_hard_smp_processor_id’
> >     rc = opal_query_cpu_status(get_hard_smp_processor_id(i),
> > 
> > The usage of get_hard_smp_processor_id() needs the declaration from
> > <asm/smp.h>. The file setup.c includes <linux/sched.h>, which in-turn
> > includes <linux/smp.h>. However, <linux/smp.h> includes <asm/smp.h>
> > only on SMP configs and hence UP builds fail.
> > 
> > Fix this by directly including <asm/smp.h> in setup.c unconditionally.
> 
> Can you please clean up the description in the commit message ? and also
> the first line in the commit message should mention that the patch is
> trying to fix a UP specific build failure.

I don't understand your comment ... the description and subject line
are perfectly fine...

Ben.
