Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67EEE1A08DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 19:20:44 +1100 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 10 Oct 2014 09:20:39 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0B06C1B08049
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 09:21:54 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9A8KbQF9371966
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 08:20:37 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9A8Kboo023175
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 02:20:37 -0600
Date: Fri, 10 Oct 2014 10:20:33 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] powerpc/vphn: fix endian issue in NUMA device node code
Message-ID: <20141010102033.49af46f4@bahia.local>
In-Reply-To: <20141007092823.7994A1400BE@ozlabs.org>
References: <20141003091250.28354.13766.stgit@bahia.local>
 <20141007092823.7994A1400BE@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  7 Oct 2014 20:28:23 +1100 (EST)
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Fri, 2014-03-10 at 09:13:17 UTC, Greg Kurz wrote:
> > The associativity domain numbers are obtained from the hypervisor through
> > registers and written into memory by the guest: the packed array passed to
> > vphn_unpack_associativity() is then native-endian, unlike what was assumed
> > in the following commit:
> > 
> > This patch does two things:
> > - extract values from the packed array with shifts, in order to be endian
> >   neutral
> > - convert the resulting values to be32 as expected
> > 
> > Suggested-by: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > Reviewed-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > Tested-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 
> 
> Hi Greg,
> 
> I'm a bit dense, it's after 8pm, but this seems like it's more complicated than
> it needs to be?
> 
> We get six 64-bit registers back from the hypervisor, they're cpu endian
> obviously, and each is defined to consist of four 2 byte fields.
> 
> So to unpack them, can't we just iterate over those six 64-bit values, which if
> we load them as 64-bit values will be back in cpu endian?
> 
> cheers
> 

First, I was sure I had Cc'd Benjamin... sorry for this omission :)

Hi Michael,

Do you mean something like the following ?

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b835bf0..fbe5a8b 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1421,8 +1421,11 @@ static long hcall_vphn(unsigned long cpu, __be32 *associativity)
        long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
        u64 flags = 1;
        int hwcpu = get_hard_smp_processor_id(cpu);
+       int i;
 
        rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
+       for (i = 0; i < 6; i++)
+               retbuf[i] = cpu_to_be64(retbuf[i]);
        vphn_unpack_associativity(retbuf, associativity);
 
        return rc;

Sure it also works and is a lot simplier... but it adds an extra loop. Also,
if the 3 first elements of the array contain 12 VPHN_FIELD_MSB fields, then
we don't even need to swap the remaining elements: only the parsing code
knows.

On the other hand, I understand this is not a hot path... so what should we
do ?

Cheers.

--
Greg
