Return-Path: <sam@ravnborg.org>
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by ozlabs.org (Postfix) with ESMTP id A1EE5B6FB8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Apr 2011 05:54:48 +1000 (EST)
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id 459B2803C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 21:31:53 +0200 (CEST)
Date: Wed, 20 Apr 2011 21:31:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: stop exporting irq_map
Message-ID: <20110420193145.GA15439@merkur.ravnborg.org>
References: <20110420084449.23741.45580.stgit@ponder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110420084449.23741.45580.stgit@ponder>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +
>  irq_hw_number_t virq_to_hw(unsigned int virq)
>  {
>  	return irq_map[virq].hwirq;
>  }
>  EXPORT_SYMBOL_GPL(virq_to_hw);

General comment...
kernel/irq/* denote the virtual irq numbers "irq".
powerpc uses "virq" for the same.

Sometimes it is confusing that two different names is used
for the same thing.

The intent of this patch is to centralize access to a common data structure,
but this could also be a good candidate for a terminology shift if
this is considered.

"git grep virq" shows a lot of hits - especially in arm, powerpc.
So what I suggest is obviously only a small step in the direction
of using "irq" all over.

	Sam
