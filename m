Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18473.33194.781010.826872@cargo.ozlabs.ibm.com>
Date: Tue, 13 May 2008 21:55:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: how to check for "optional" ppc chip features (MSR_BE)
In-Reply-To: <20080504231207.8377E26FA08@magilla.localdomain>
References: <20080502012118.96ED926FA07@magilla.localdomain>
	<DC173CDE-FBC4-4EA0-8022-3F993B6466BF@kernel.crashing.org>
	<1209937549.21644.2.camel@pasglop>
	<20080504231207.8377E26FA08@magilla.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath writes:

> Yeah, all that stuff I could figure out as needed.  What I really meant
> was, where is the big official table of which chips behave which ways that
> you base all code that on?  Actually, I don't really care as long as you
> all are happy to be responsible for figuring out what matters.  With the
> patch I posted to use MSR_BE, I took Kumar Gala's word as gospel that all
> the chips on which we use MSR_SE also have MSR_BE.  If that's not right,
> then I hope you'd like to pick a feature bit, populate the tables, etc.,
> and fix the definition of arch_has_block_step() as appropriate.

It turns out that the 601 doesn't support MSR_BE.  It looks like all
the "classic" 32-bit implementations after that (603, 604, 7xx, 7xxx)
implemented BE, as do POWER3 and RS64.  I'll check the later 64-bit
processors -- I think they all implement BE.  4xx and Book E have it
in a different form.  I'll let Kumar find out about 8xx and 82xx.

So it looks like we need to define a new feature bit to mean "supports
block-step".  Is this something that userspace will expect to be told
about via the AT_HWCAP entry in the aux vector?

Paul.
