Return-Path: <gabriel@krisman.be>
Received: from layla.krisman.be (layla.krisman.be [176.31.208.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfGSz725RzDvM6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 12:44:19 +1100 (AEDT)
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, gabriel@krisman.be,
 hch@lst.de, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] genirq/affinity: fix node generation from cpumask
In-Reply-To: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 (Guilherme G. Piccoli's message of "Wed, 14 Dec 2016 16:01:12 -0200")
References: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 23:05:51 -0200
Message-ID: <87oa0erogg.fsf@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> Commit 34c3d9819fda ("genirq/affinity: Provide smarter irq spreading
> infrastructure") introduced a better IRQ spreading mechanism, taking
> account of the available NUMA nodes in the machine.
>
> Problem is that the algorithm of retrieving the nodemask iterates
> "linearly" based on the number of online nodes - some architectures
> present non-linear node distribution among the nodemask, like PowerPC.
> If this is the case, the algorithm lead to a wrong node count number
> and therefore to a bad/incomplete IRQ affinity distribution.
>
> For example, this problem were found in a machine with 128 CPUs and two
> nodes, namely nodes 0 and 8 (instead of 0 and 1, if it was linearly
> distributed). This led to a wrong affinity distribution which then led to
> a bad mq allocation for nvme driver.
>
> Finally, we take the opportunity to fix a comment regarding the affinity
> distribution when we have _more_ nodes than vectors.

Thanks for taking care of this so quickly, Guilherme.

Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>

-- 
Gabriel Krisman Bertazi
