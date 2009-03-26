Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <49CBFE52.6090706@grandegger.com>
References: <1237975701-23201-4-git-send-email-wg@grandegger.com>
	<fa686aa40903252209r52a1bc1cn995a7da16bc3527f@mail.gmail.com>
	<49CB31CB.2010704@grandegger.com>
	<fa686aa40903260727y3266e394g5e574680fe70bbbf@mail.gmail.com>
	<49CBA062.5050000@grandegger.com>
	<fa686aa40903260904s67258fbbge3c87e06946c5f58@mail.gmail.com>
	<49CBAED4.8030802@grandegger.com>
	<fa686aa40903261002l2c8e0d41s6e5ad4bc049058bf@mail.gmail.com>
	<20090326173302.GA23187@oksana.dev.rtsoft.ru>
	<49CBFE52.6090706@grandegger.com>
Date: Thu, 26 Mar 2009 17:22:36 -0600
Message-ID: <fa686aa40903261622wa2a93f9i98435080c7ab6cea@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] powerpc: NAND: FSL UPM: document new bindings
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 26, 2009 at 4:14 PM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Anton Vorontsov wrote:
>> On Thu, Mar 26, 2009 at 11:02:06AM -0600, Grant Likely wrote:
>>> In other words, this device is not register-level compatible with the
>>> fsl,upm-nand device. =A0Give the node a new compatible value
>>> (tqc,tqm8548-upm-nand) and add another entry to the of_fun_match table
>>> for the new device. =A0Use the .data element in the match table to
>>> supply an alternate fun_cmd_ctrl() function for this board (instead of
>>> using a property value do decide which fun_cmd_ctrl() behaviour to
>>> use). =A0New boards that *do* use the same addressing scheme can claim
>>> compatibility with tqc,tqm8548-upm-nand.
>>
>> I don't like this. :-/
>>
>> UPM is an universal thing, so there are thousands of ways we can
>> connect NAND to the UPM. Of which only ~10 would be sane (others are
>> insane, and nobody would do this. If they do, _then_ we'll fall back
>> to <board>-upm-nand scheme for a particular board).
>
> Yep.
>
>> I don't see any problem with fsl,upm-addr-line-cs-offsets. It can
>> describe any scheme in "addr lines are cs" connection, it's a common
>> setup for multi-chip memory, we shouldn't treat it is as something
>> extraordinary.
>
> I fully agree. I'm going to provide a patch on monday.

Well, I still don't think it is the wisest choice.  My position is
that it is better to be conservative and pedantic now because it is
easy to relax the rules from that point.  If it turns out after some
experience with "fsl,upm-addr-line-cs-offset" that the scheme has a
serious flaw, then the impact is contained.  On the other side, if it
is confirmed and useful and correct, it is a trivial change to make it
available to everything that claims compatibility with fsl,upm-nand.

That said, I won't oppose it if you go this route.  However at the
very least, please change the nand node's compatible list to be:

compatible =3D "tqc,tqm8548-upm-nand", "fsl,upm-nand";

The custom glue logic makes it something unique, so "tqc,..." should
be at the start of the list to describe it as such, even if the driver
only ever uses "fsl,upm-nand".

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
