Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0244DE006
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 15:32:43 +1000 (EST)
In-Reply-To: <18012.61822.197988.279764@cargo.ozlabs.ibm.com>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
	<18012.61822.197988.279764@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ADB2DAF4-B25F-462D-B552-531D706F57BE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Wed, 30 May 2007 00:32:31 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>, Anton Blanchard <anton@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 10:37 PM, Paul Mackerras wrote:

> Steve Munroe writes:
>
>> But unless you take the time to write it up like a full ABI change  
>> you are
>> never sure that it IS compatible. And any change to the size/shape of
>> ucontext_t is an ABI change.
>
> There is no change to the size or shape of the ucontext_t.  There is
> no change to the ABI at all, in the sense that everything that is
> currently guaranteed by the ABI is still guaranteed.  An extra
> guarantee is added: the top 32 bits of the GPRs will not change
> unpredictably as long as you don't call a function and don't use
> setcontext or swapcontext to return from a signal handler.
>
> I think actually it would be useful to have the saving/restoring of
> the high 32 bits controlled by a prctl, so that programs have to ask
> explicitly for the new behaviour (and programs that don't want to use
> the high 32 bits don't incur the extra overhead).

I like this, it means we can error if HW doesn't support it and  
requires applications to do something specific to enable the feature.

- k
