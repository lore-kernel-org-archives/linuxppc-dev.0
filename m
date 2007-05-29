Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49F7CDDFF9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 21:32:39 +1000 (EST)
Date: Tue, 29 May 2007 13:32:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/5] powerpc: Make syscall restart code more common
Message-ID: <20070529113232.GA6071@lst.de>
References: <20070529064533.CA8C4DDFF8@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070529064533.CA8C4DDFF8@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ulrich.weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 04:45:23PM +1000, Benjamin Herrenschmidt wrote:
> +static inline void check_syscall_restart(struct pt_regs *regs,
> +					 struct k_sigaction *ka,
> +					 int has_handler)
> +{

I don't think this should be inlined.  Just create a new signal.c file,
which can grow a lot more common signal code later on aswell.
