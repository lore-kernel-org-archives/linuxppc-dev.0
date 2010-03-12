Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 83344B802F
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 10:04:49 +1100 (EST)
Received: by pwi10 with SMTP id 10so1080904pwi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 15:04:47 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100312223647.GM11655@yookeroo>
References: <4B934CCA.8030608@freemail.hu> <4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
	<fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
	<20100312223647.GM11655@yookeroo>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 12 Mar 2010 16:04:27 -0700
Message-ID: <fa686aa41003121504u7d346cf7yf1e1433019b5fd22@mail.gmail.com>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
To: Grant Likely <grant.likely@secretlab.ca>,
	=?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>,
	linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 12, 2010 at 3:36 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Fri, Mar 12, 2010 at 05:14:56AM -0700, Grant Likely wrote:
>> 2010/3/11 N=E9meth M=E1rton <nm127@freemail.hu>:
> [snip]
>> > +
>> > + =A0 =A0 =A0 cpus {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu@0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "cpu";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "PowerPC,=
5554";
>>
>> I'd rather see the same convention used here as for all the other
>> compatible values in this file. =A0ie:
>>
>> compatible =3D "fsl,mpc5554-e200z6", "fsl,powerpc-e200z6";
>>
>> Dave, what do you think?
>
> Well, you could add those too, but "PowerPC,5554" should probably
> remain.
>
> The historical background here is that in the original OF spec, driver
> matching was done on node name, and only then on compatible.
> Essentially the node name was treated as an implicit first entry in
> the compatible list. =A0The the generic names convention came along, and
> instead name became a human readable generic type for the device
> ("ethernet", "i2c", etc..).
>
> That convention has been widely used since long before flat trees
> existed, but for some reason it was never really used for cpu nodes;
> they remained as "PowerPC,XXXX" or whatever. =A0Because the varying
> names of cpu nodes was sometimes awkward to deal with in bootloaders,
> we decided it would be sensible to apply the generic names convention
> here too, so "cpu@X". =A0But then, the previous node name, which was
> treated as being prepended to compatible, should now explicitly be put
> into compatible.

In this particular case, we're talking about a part that has never
previously been described in a device tree.  So, since this is
something entirely new, what is the value in preserving the
PowerPC,XXXX style when there isn't any code that will be relying on
it?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
