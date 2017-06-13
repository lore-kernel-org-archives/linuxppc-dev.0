Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn9z01cYDzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 23:46:19 +1000 (AEST)
Message-ID: <1497361558.2897.12.camel@kernel.crashing.org>
Subject: Re: [PATCH 13/14] powerpc/64: runlatch CTRL[RUN] set optimisation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, svaidy@linux.vnet.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "Shreyas B . Prabhu"
 <shreyas@linux.vnet.ibm.com>
Date: Tue, 13 Jun 2017 23:45:58 +1000
In-Reply-To: <87zidcgq50.fsf@concordia.ellerman.id.au>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-14-npiggin@gmail.com>
 <20170612171138.GB4340@drishya.in.ibm.com>
 <87zidcgq50.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-13 at 20:04 +1000, Michael Ellerman wrote:
> > Good idea.  Writing to CTRL register can change only the RUN field.
> > Was this any different in older generations?
> 
> No AFAICS back to 2.02.
> 
> > Anton and Ben kept the mfspr/mtspr part in earlier updates to this
> > routine.
> 
> Doing the read/modify write is forward compatible vs a new writable
> field, whereas writing the whole register with a known value is not.

At this stage I wouldn't worry too much about it. What we can do is
write a pre-cooked value (from reading it earlier once at boot) if we
are paranoid or just do what Nick does and put the onus on future
designs that might want to re-use it for other things to add a mode
bits to configure the new feature in.

Ben.
