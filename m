Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1259096815.16367.133.camel@pasglop>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081957.6216.74456.stgit@angua>
	<20091124.093732.203692950.davem@davemloft.net>
	<1259096815.16367.133.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 14:39:16 -0700
Message-ID: <fa686aa40911241339h5b48e6a2i28efec0cfaa1faab@mail.gmail.com>
Subject: Re: [PATCH 11/11] of: unify phandle name in struct device_node
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 24, 2009 at 2:06 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 09:37 -0800, David Miller wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>> Date: Tue, 24 Nov 2009 01:20:05 -0700
>>
>> > In struct device_node, the phandle is named 'linux_phandle' for PowerP=
C
>> > and MicroBlaze, and 'node' for SPARC. =A0There is no good reason for t=
he
>> > difference, it is just an artifact of the code diverging over a couple
>> > of years. =A0This patch renames .node to .linux_phandle for SPARC.
>>
>> I know it's just a name, but there is no reason to put "linux" in the
>> member name. =A0It's the real device phandle value from OpenFirmware not
>> something invented by Linux's OF layer.
>>
>> PowerPC uses this for something different, it records the information
>> here using the special "linux,phandle" and "ibm,phandle" properties.
>>
>> See unflatten_dt_node() in arch/powerpc/kernel/prom.c before your
>> changes.
>
> Right, this comes from a subtle problem with our firmwares on pSeries.
>
> We have a phandle from OF. But some devices, especially virtual devices,
> also have an "ibm,phandle" which may or may not be the same afaik.
>
> In addition, when the hypervisor hotplugs some devices, it sends us some
> new device-tree bits to add. Those don't have a phandle in the formal
> sense afaik, but -do- have an ibm,phandle property.
>
> I think we can always just use ibm,phandle instead of the OF one when
> the former is present, they should be non overlapping, but of course,
> any chance in that area will require plenty of testing on some of those
> machines.

If pseries is the troublesome platform, not powermac, then I'm pretty
confident this change is okay.  I cannot find any other users of .node
other than arch/powerpc/platforms/powermac/pfunc_core.c, but I'll
double check with an allmodconfig and an allyesconfig.  This patch
shouldn't change the behaviour of linux_phandle at all.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
