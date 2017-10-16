Return-Path: <segher@gate.crashing.org>
Date: Mon, 16 Oct 2017 05:20:59 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] RFC: prom_init: Fetch flatten device tree from the
 system firmware
Message-ID: <20171016102058.GH4406@gate.crashing.org>
References: <20171016054917.21577-1-aik@ozlabs.ru>
 <20171016061125.GD2776@umbus.fritz.box>
 <00ec0e99-45dd-dbe0-d75f-4413253e8093@ozlabs.ru>
 <20171016064633.GE2776@umbus.fritz.box>
 <f849afda-4384-f72e-c8cf-15ba5d170f2c@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f849afda-4384-f72e-c8cf-15ba5d170f2c@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 16, 2017 at 06:07:06PM +1100, Alexey Kardashevskiy wrote:
> On 16/10/17 17:46, David Gibson wrote:

> >>>> +		/* Fixup the boot cpuid */
> >>>> +		hdr->boot_cpuid_phys = cpu_to_be32(prom.cpu);
> >>>
> >>> If SLOF is generating a tree it really should get this header field
> >>> right as well.
> >>
> >>
> >> Ah, I did not realize it is just a phandle from /chosen/cpu. Will
> >> fix.
> > 
> > It's not a phandle.  It's just the "address" (i.e. reg value) of the
> > boot cpu.
> 
> Well, it is "reg" of a CPU with phandle==/chosen/cpu so my fdt code needs
> to look there to pick the right "reg" rather than just plain 0. I'll fix
> this but in general can it possibly be not a zero in QEMU/SLOF?

/chosen/cpu is an ihandle, not a phandle.  Most (if not all) references
in /chosen are.


Segher
