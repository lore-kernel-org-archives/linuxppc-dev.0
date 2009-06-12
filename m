Return-Path: <kyle@infradead.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CD07BB7117
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 03:40:19 +1000 (EST)
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D689DDDA0
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 03:40:19 +1000 (EST)
Date: Fri, 12 Jun 2009 13:40:13 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH RFC] powerpc: Implement atomic64_t for 32-bit processors
Message-ID: <20090612174013.GA13153@bombadil.infradead.org>
References: <18994.17381.129339.162342@cargo.ozlabs.ibm.com>
	<55D4E406-B6C5-471F-B7FF-86106CCC0ABF@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55D4E406-B6C5-471F-B7FF-86106CCC0ABF@kernel.crashing.org>
Sender: Kyle McMartin <kyle@infradead.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 12, 2009 at 09:04:52AM -0500, Kumar Gala wrote:
>> On UP, all the spinlock manipulation goes away and we simply disable
>> interrupts around each operation.  In fact gcc eliminates the whole
>> atomic64_lock variable as well.
>>
>> Signed-off-by: Paul Mackerras <paulus@samba.org>
>> ---
>> Compile-tested only at this stage, which is why it's [RFC].
>
> any reason not to make this lib/asm generic?  Seems like it isn't ppc  
> specific.
>

Indeed... PA-RISC uses these for all atomics, since we have no useful
atomic insns to implement them... I'd be happy to submit a cleanup after
you merge this, if you don't have time to ahead of time.

regards, Kyle
