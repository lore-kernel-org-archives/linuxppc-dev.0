Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17145.12993.672427.466466@cargo.ozlabs.ibm.com>
Date: Wed, 10 Aug 2005 08:48:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
	<42F79D89.3040709@austin.ibm.com>
	<bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
Cc: Joel Schopp <jschopp@austin.ibm.com>, linuxppc-dev@ozlabs.org,
	linuxppc64-dev@ozlabs.org
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> _Please_ don't throw the real device tree away; I'm happy with
> the flattened device tree if and only if it is a _minimum_
> requirement, and having a _real_ device tree (or even real
> Open Firmware support) is still an option.

Aarrgh! <sound of paulus tearing hair out>

There seems to be a lot of misunderstanding about the flattened device
tree concept.  The flattened device tree is simply a representation of
a device tree (i.e., the full, or "real" (whatever that means) device
tree) that does not contain any pointers and is in a single contiguous
block of memory.

On systems with open firmware, the boot is separated into two phases.
In the first phase, OF is still active.  The kernel is not based at
physical address 0, and can do OF client calls.  In the second phase,
the kernel is based at physical address 0 and OF's memory has been
reclaimed by the kernel.  The flattened device tree is the main data
structure that is passed from the first phase to the second.  One of
the first things that the second phase does is to expand the flattened
device tree into the normal in-kernel device tree representation (a
tree of struct device_node).

Having the flattened device tree doesn't mean that we will be using
the device tree less, it means we will be using it _more_.

Paul.
