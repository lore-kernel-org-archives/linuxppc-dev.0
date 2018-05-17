Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40n1SY5nqJzF25v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 05:23:57 +1000 (AEST)
Date: Thu, 17 May 2018 14:23:31 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Ensure gcc doesn't move around cache flushing in
 __patch_instruction
Message-ID: <20180517192331.GZ17342@gate.crashing.org>
References: <48284701fe497bb4f5bede5c55bbce9d70309562.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48284701fe497bb4f5bede5c55bbce9d70309562.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Thu, May 17, 2018 at 01:06:10PM +1000, Benjamin Herrenschmidt wrote:
> The current asm statement in __patch_instruction() for the cache flushes
> doesn't have a "volatile" statement and no memory clobber. That means
> gcc can potentially move it around (or move the store done by put_user
> past the flush).

volatile is completely superfluous here, except maybe as documentation:
any asm without outputs is always volatile.

(And the memory clobber does not prevent the compiler from moving the
asm around, or duplicating it, etc., and neither does the volatile).


Segher
