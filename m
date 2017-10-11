Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yC0fQ0NXKzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 04:02:52 +1100 (AEDT)
Date: Wed, 11 Oct 2017 12:02:16 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Santosh Sivaraj <santosh@fossix.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v5] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Message-ID: <20171011170216.GR4406@gate.crashing.org>
References: <20171011083502.11648-1-santosh@fossix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171011083502.11648-1-santosh@fossix.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Oct 11, 2017 at 02:05:02PM +0530, Santosh Sivaraj wrote:
> +70:	ld      r8,CFG_TB_UPDATE_COUNT(r3)
> +	andi.   r0,r8,1                 /* pending update ? loop */
> +	bne-    70b
> +	xor     r0,r8,r8                /* create dependency */

r0 already is 0 here, and already depends on r8.  Or is this trying
to do something else?

> +	add     r3,r3,r0


Segher
