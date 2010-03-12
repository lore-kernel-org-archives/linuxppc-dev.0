Return-Path: <dgibson@ozlabs.org>
Date: Sat, 13 Mar 2010 09:36:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
Message-ID: <20100312223647.GM11655@yookeroo>
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
	<4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
	<fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org,
	=?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 12, 2010 at 05:14:56AM -0700, Grant Likely wrote:
> 2010/3/11 Németh Márton <nm127@freemail.hu>:
[snip]
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu@0 {
> > +                       device_type = "cpu";
> > +                       compatible = "PowerPC,5554";
> 
> I'd rather see the same convention used here as for all the other
> compatible values in this file.  ie:
> 
> compatible = "fsl,mpc5554-e200z6", "fsl,powerpc-e200z6";
> 
> Dave, what do you think?

Well, you could add those too, but "PowerPC,5554" should probably
remain.

The historical background here is that in the original OF spec, driver
matching was done on node name, and only then on compatible.
Essentially the node name was treated as an implicit first entry in
the compatible list.  The the generic names convention came along, and
instead name became a human readable generic type for the device
("ethernet", "i2c", etc..).

That convention has been widely used since long before flat trees
existed, but for some reason it was never really used for cpu nodes;
they remained as "PowerPC,XXXX" or whatever.  Because the varying
names of cpu nodes was sometimes awkward to deal with in bootloaders,
we decided it would be sensible to apply the generic names convention
here too, so "cpu@X".  But then, the previous node name, which was
treated as being prepended to compatible, should now explicitly be put
into compatible.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
