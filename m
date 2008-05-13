Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18473.29766.501740.124434@cargo.ozlabs.ibm.com>
Date: Tue, 13 May 2008 20:58:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] Fix irq_alloc_host() reference counting and callers
In-Reply-To: <dabdb53ffc73aa86b0432118bf07f2fc9ce72f6f.1210220561.git.michael@ellerman.id.au>
References: <3c91644d7ab701f99ec7f621fc5c16d23e75c71a.1210220561.git.michael@ellerman.id.au>
	<dabdb53ffc73aa86b0432118bf07f2fc9ce72f6f.1210220561.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> When I changed irq_alloc_host() to take an of_node
> (52964f87c64e6c6ea671b5bf3030fb1494090a48: "Add an
> optional device_node pointer to the irq_host"),
> I botched the reference counting semantics.
> 
> Stephen pointed out that it's irq_alloc_host()'s
> business if it needs to take an additional reference
> to the device_node, the caller shouldn't need to care.
> To make that clean we also need a free routine, so
> the caller doesn't have to deal with dropping the
> reference.
> 
> Luckily we now have an irq_free_host() where we can
> drop the reference - so we can make the reference
> counting internal to irq_alloc_host()/irq_free_host().

Is this needed for 2.6.26?  What's the worst possible effect of this
bug?

Paul.
