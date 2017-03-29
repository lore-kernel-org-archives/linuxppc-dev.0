Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtN3R5myGzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 20:37:55 +1100 (AEDT)
Date: Wed, 29 Mar 2017 20:37:47 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH] kvm: powerpc: book3s: Disable preemption while accessing
 paca xics_phys filed
Message-ID: <20170329093747.GC13844@fergus.ozlabs.ibm.com>
References: <1490603214-30116-1-git-send-email-kda@linux-powerpc.org>
 <87a884evrc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a884evrc.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 29, 2017 at 12:07:03PM +1100, Michael Ellerman wrote:
> Denis Kirjanov <kda@linux-powerpc.org> writes:
>
[...]
> > @@ -3930,7 +3934,11 @@ static int kvmppc_book3s_init_hv(void)
> >  	 * indirectly, via OPAL.
> >  	 */
> >  #ifdef CONFIG_SMP
> > -	if (!get_paca()->kvm_hstate.xics_phys) {
> > +	preempt_disable();
> > +	xics_phys = get_paca()->kvm_hstate.xics_phys;
> > +	preempt_enable();
> > +
> > +	if (!xics_phys) {
> >  		struct device_node *np;
>   
> Can you tell me what actual problem (other than the warning) this is
> fixing?

If paca->kvm_hstate.xics_phys is non-zero on one cpu, it will be
non-zero on them all.  Therefore this is not fixing any actual
problem, just the warning.

By the way, the #ifdefs are ugly, and could be removed.  (Yes I know
it was me that put the first #ifdef in that function.)

Paul.
