Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id F26E5DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 21:38:39 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH v5] MPC5121 TLB errata workaround
Date: Tue, 17 Mar 2009 11:38:42 +0100
References: <200903161652.09747.david.jander@protonic.nl>
	<FDDCB39D-E847-4627-B6F8-404A40D1C0C7@kernel.crashing.org>
In-Reply-To: <FDDCB39D-E847-4627-B6F8-404A40D1C0C7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903171138.42814.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Wolfgang Denk <wd@denx.de>, gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 16 March 2009 19:05:00 Kumar Gala wrote:
> On Mar 16, 2009, at 10:52 AM, David Jander wrote:
> > Complete workaround for DTLB errata in e300c2/c3/c4 processors.
> >
> > Due to the bug, the hardware-implemented LRU algorythm always goes
> > to way
> > 1 of the TLB. This fix implements the proposed software workaround in
> > form of a LRW table for chosing the TLB-way.
> >
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > Signed-off-by: David Jander <david@protonic.nl>
> >
> > ---
> > diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/
> > head_32.S
> > index 0f4fac5..3971ee4 100644
> > --- a/arch/powerpc/kernel/head_32.S
> > +++ b/arch/powerpc/kernel/head_32.S
> > @@ -578,9 +578,21 @@ DataLoadTLBMiss:
> > 	andc	r1,r3,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
> > 	mtspr	SPRN_RPA,r1
> > 	mfspr	r3,SPRN_DMISS
> > +	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
> > +	mtcrf	0x80,r2
> > +#ifdef CONFIG_PPC_MPC512x
> > +	li	r0,1
> > +	mfspr	r1,SPRN_SPRG6
> > +	rlwinm	r2,r3,17,27,31		/* Get Address bits 19:15 */
>
> Don't we want:
> 	rlwinm	r2,r3,20,27,31		/* Get address bits 15:19 */

Hmm, you are right, I must have accidentally counted LE bit-ordering ;-)
Only funny part is, that I don't measure any performance difference after 
fixing this.... *sigh*.

Regards,

-- 
David Jander
Protonic Holland.
