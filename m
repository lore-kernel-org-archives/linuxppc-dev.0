Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 83BA3DDF27
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 08:04:08 +1100 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.21-rc2] ehca: fix mismatched sync between completion
	handler and destroy cq
References: <200702281801.02747.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 01 Mar 2007 13:04:05 -0800
In-Reply-To: <200702281801.02747.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Wed, 28 Feb 2007 18:01:02 +0100")
Message-ID: <ada8xegr7zu.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks OK to me, queued for 2.6.21, except:

 > +#include <linux/completion.h>

This can just be <linux/wait.h>, because you're only using
wait_queue_head_t and not struct completion, right?

I fixed this up before merging.
