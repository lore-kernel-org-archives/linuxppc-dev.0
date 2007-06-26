Return-Path: <ananth@in.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F94EDDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 13:48:01 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5Q3lwFN011268
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 23:47:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5Q3lwuK559836
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 23:47:58 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5Q3lvbY021366
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 23:47:58 -0400
Date: Tue, 26 Jun 2007 09:21:46 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] Make struct jprobe.entry a void *
Message-ID: <20070626035146.GA16713@in.ibm.com>
References: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	anil.s.keshavamurthy@intel.com, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2007 at 11:48:50AM +1000, Michael Ellerman wrote:
> Currently jprobe.entry is a kprobe_opcode_t *, but that's a lie. On some
> platforms it doesn't point to an opcode at all, it points to a function
> descriptor.
> 
> It's really a pointer to something that the arch code can turn into a
> function entry point. And that's what actually happens, none of the
> generic code ever looks at jprobe.entry, it's only ever dereferenced
> by arch code.
> 
> So just make it a void *.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Tested on powerpc. Ack to all three patches plus Andrew's declaration
fixup.

Thanks Michael for the patches.

Acked-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

> ---
> 
> It isn't obvious where kprobes patches should go, is anyone "the" maintainer?
> Instead I've just sent this to everyone who'd touched the code lately, or
> might be otherwise interested.
> 
> 
>  include/linux/kprobes.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 23adf60..f4e53b7 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -116,7 +116,7 @@ struct kprobe {
>   */
>  struct jprobe {
>  	struct kprobe kp;
> -	kprobe_opcode_t *entry;	/* probe handling code to jump to */
> +	void *entry;	/* probe handling code to jump to */
>  };
> 
>  DECLARE_PER_CPU(struct kprobe *, current_kprobe);
> -- 
> 1.5.1.3.g7a33b
