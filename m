Return-Path: <segher@gate.crashing.org>
Date: Sat, 3 Feb 2018 09:36:20 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH (skiboot)] dt: add /cpus/ibm,
 powerpc-cpu-features device tree bindings
Message-ID: <20180203153620.GP21977@gate.crashing.org>
References: <20180203042732.27980-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180203042732.27980-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!  Some remarks:

On Sat, Feb 03, 2018 at 02:27:32PM +1000, Nicholas Piggin wrote:
> +	/*
> +	 * ISAv3.0B deliver a random number instruction (darn)
> +	 */
> +	{ "random-number-generator",

That's not such a great name...  "darn-instruction" maybe?  Just "wait"
as a name is a bit too short too I guess (and there is "wait-v3", so
that could be "wait-v2" or so?  Or "wait-instruction").

> +	/*
> +	 * ISAv3.0B branch instruction and register additions
> +	 * CA32, OV32, mcrxrx, setb
> +	 */
> +	{ "branch-v3",

Those aren't branch instructions, they are integer instructions.  Some
of which use the XER, some of which use CR fields.

> +- isa
> +  Usage: required
> +  Value type: <u32>
> +  Definition:
> +
> +  isa that the CPU is currently running in. This provides instruction set
> +  compatibility, less the individual feature nodes. For example, an ISA v3.0
> +  implementation that lacks the "transactional-memory" cpufeature node
> +  should not use transactional memory facilities.
> +
> +  Value corresponds to the "Power ISA Version" multiplied by 1000.
> +  For example, <3000> corresponds to Version 3.0, <2070> to Version 2.07.
> +  The minor digit is available for revisions.

So the 2.07B, 3.0B (in the code above) should really be 2071 and 3001
(instead of 2070 and 3000)?  Or you could make it hex and have 0x207B :-)

> +The policy for seleting and configuring which features to advertise and use

Typo ("selecting").


Segher
