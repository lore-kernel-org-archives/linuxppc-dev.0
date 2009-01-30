Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id DE021DDF0F
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 11:38:37 +1100 (EST)
Date: Thu, 29 Jan 2009 18:38:29 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Fix partition migration hang under load
Message-ID: <20090130003829.GC6913@localdomain>
References: <200901292324.n0TNOktd000814@d03av02.boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901292324.n0TNOktd000814@d03av02.boulder.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian King wrote:
> 
> While testing partition migration with heavy CPU load using
> shared processors, it was observed that sometimes the migration
> would never complete and would appear to hang. Currently, the
> migration code assumes that if H_SUCCESS is returned from the H_JOIN
> then the migration is complete and the processor is waking up on
> the target system. If there was an outstanding PROD to the processor
> when the H_JOIN is called, however, it will return H_SUCCESS on the source
> system

Hmm, did you determine where that outstanding H_PROD is coming from?
AFAICT this is the only code which uses that hcall, and all processors
should have "consumed" their prods from one migration before another
migration can commence.

Regardless, ACK -- if we were to add another H_PROD call site (or if
there's one I missed) this would be necessary anyway.
