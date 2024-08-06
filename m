Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466B4C3DA64
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2024 10:37:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WdV9s03n7z3dH4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2024 20:37:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=joey.gouly@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WdV9P4zTjz3bhD
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2024 20:36:56 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE013FEC;
	Tue,  6 Aug 2024 03:36:51 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7792B3F6A8;
	Tue,  6 Aug 2024 03:36:22 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:35:32 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <20240806103532.GA1986436@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <ZqJ2knGETfS4nfEA@e133380.arm.com>
 <20240801155441.GB841837@e124191.cambridge.arm.com>
 <Zqu2VYELikM5LFY/@e133380.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqu2VYELikM5LFY/@e133380.arm.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: szabolcs.nagy@arm.com, catalin.marinas@arm.com, dave.hansen@linux.intel.com, linux-mm@kvack.org, hpa@zytor.com, shuah@kernel.org, maz@kernel.org, x86@kernel.org, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, mingo@redhat.com, naveen.n.rao@linux.ibm.com, will@kernel.org, npiggin@gmail.com, broonie@kernel.org, bp@alien8.de, kvmarm@lists.linux.dev, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, oliver.upton@linux.dev, aneesh.kumar@linux.ibm.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 01, 2024 at 05:22:45PM +0100, Dave Martin wrote:
> On Thu, Aug 01, 2024 at 04:54:41PM +0100, Joey Gouly wrote:
> > On Thu, Jul 25, 2024 at 05:00:18PM +0100, Dave Martin wrote:
> > > Hi,
> > > 
> > > On Fri, May 03, 2024 at 02:01:36PM +0100, Joey Gouly wrote:
> > > > Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.
> > > > 
> > > > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Reviewed-by: Mark Brown <broonie@kernel.org>
> > > > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > > > ---
> > > >  arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
> > > >  arch/arm64/kernel/signal.c               | 52 ++++++++++++++++++++++++
> > > >  2 files changed, 59 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
> > > > index 8a45b7a411e0..e4cba8a6c9a2 100644
> > > > --- a/arch/arm64/include/uapi/asm/sigcontext.h
> > > > +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> > > 
> > > [...]
> > > 
> > > > @@ -980,6 +1013,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
> > > >  			return err;
> > > >  	}
> > > >  
> > > > +	if (system_supports_poe()) {
> > > > +		err = sigframe_alloc(user, &user->poe_offset,
> > > > +				     sizeof(struct poe_context));
> > > > +		if (err)
> > > > +			return err;
> > > > +	}
> > > > +
> > > >  	return sigframe_alloc_end(user);
> > > >  }
> > > >  
> > > > @@ -1020,6 +1060,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
> > > >  		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
> > > >  	}
> > > >  
> > > > +	if (system_supports_poe() && err == 0 && user->poe_offset) {
> > > > +		struct poe_context __user *poe_ctx =
> > > > +			apply_user_offset(user, user->poe_offset);
> > > > +
> > > > +		__put_user_error(POE_MAGIC, &poe_ctx->head.magic, err);
> > > > +		__put_user_error(sizeof(*poe_ctx), &poe_ctx->head.size, err);
> > > > +		__put_user_error(read_sysreg_s(SYS_POR_EL0), &poe_ctx->por_el0, err);
> > > > +	}
> > > > +
> > > 
> > > Does the AArch64 procedure call standard say anything about whether
> > > POR_EL0 is caller-saved?
> > 
> > I asked about this, and it doesn't say anything and they don't plan on it,
> > since it's very application specific.
> 
> Right.  I think that confirms that we don't absolutely need to preserve
> POR_EL0, because if compiler-generated code was allowed to fiddle with
> this and not clean up after itself, the PCS would have to document this.
> 
> > > 
> > > <bikeshed>
> > > 
> > > In theory we could skip saving this register if it is already
> > > POR_EL0_INIT (which it often will be), and if the signal handler is not
> > > supposed to modify and leave the modified value in the register when
> > > returning.
> > > 
> > > The complexity of the additional check my be a bit pointless though,
> > > and the the handler might theoretically want to change the interrupted
> > > code's POR_EL0 explicitly, which would be complicated if POE_MAGIC is
> > > sometimes there and sometimes not.
> > > 
> > > </bikeshed>
> > > 
> > I think trying to skip/optimise something here would be more effort than any
> > possible benefits!
> 
> Actually, having thought about this some more I think that only dumping
> this register if != POR_EL0_INIT may be right right thing to do.
> 
> This would mean that old binary would stacks never see poe_context in
> the signal frame, and so will never experience unexpected stack
> overruns (at least, not due solely to the presence of this feature).

They can already see things they don't expect, like FPMR that was added
recently.

> 
> POE-aware signal handlers have to do something fiddly and nonportable
> to obtain the original value of POR_EL0 regardless, so requiring them
> do handle both cases (present in sigframe and absent) doesn't seem too
> onerous to me.

If the signal handler wanted to modify the value, from the default, wouldn't it
need to mess around with the sig context stuff, to allocate some space for
POR_EL0, such that the kernel would restore it properly? (If that's even
possible).

> 
> 
> Do you think this approach would break any known use cases?

Not sure.

> 
> Cheers
> ---Dave
> 
