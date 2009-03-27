Return-Path: <wg@grandegger.com>
Message-ID: <49CC8943.9060006@grandegger.com>
Date: Fri, 27 Mar 2009 09:07:31 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 3/4] powerpc: NAND: FSL UPM: document new bindings
References: <1237975701-23201-4-git-send-email-wg@grandegger.com>	<fa686aa40903252209r52a1bc1cn995a7da16bc3527f@mail.gmail.com>	<49CB31CB.2010704@grandegger.com>	<fa686aa40903260727y3266e394g5e574680fe70bbbf@mail.gmail.com>	<49CBA062.5050000@grandegger.com>	<fa686aa40903260904s67258fbbge3c87e06946c5f58@mail.gmail.com>	<49CBAED4.8030802@grandegger.com>	<fa686aa40903261002l2c8e0d41s6e5ad4bc049058bf@mail.gmail.com>	<20090326173302.GA23187@oksana.dev.rtsoft.ru>	<49CBFE52.6090706@grandegger.com>
	<fa686aa40903261622wa2a93f9i98435080c7ab6cea@mail.gmail.com>
In-Reply-To: <fa686aa40903261622wa2a93f9i98435080c7ab6cea@mail.gmail.com>
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

Grant Likely wrote:
> On Thu, Mar 26, 2009 at 4:14 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Anton Vorontsov wrote:
>>> On Thu, Mar 26, 2009 at 11:02:06AM -0600, Grant Likely wrote:
>>>> In other words, this device is not register-level compatible with the
>>>> fsl,upm-nand device.  Give the node a new compatible value
>>>> (tqc,tqm8548-upm-nand) and add another entry to the of_fun_match table
>>>> for the new device.  Use the .data element in the match table to
>>>> supply an alternate fun_cmd_ctrl() function for this board (instead of
>>>> using a property value do decide which fun_cmd_ctrl() behaviour to
>>>> use).  New boards that *do* use the same addressing scheme can claim
>>>> compatibility with tqc,tqm8548-upm-nand.
>>> I don't like this. :-/
>>>
>>> UPM is an universal thing, so there are thousands of ways we can
>>> connect NAND to the UPM. Of which only ~10 would be sane (others are
>>> insane, and nobody would do this. If they do, _then_ we'll fall back
>>> to <board>-upm-nand scheme for a particular board).
>> Yep.
>>
>>> I don't see any problem with fsl,upm-addr-line-cs-offsets. It can
>>> describe any scheme in "addr lines are cs" connection, it's a common
>>> setup for multi-chip memory, we shouldn't treat it is as something
>>> extraordinary.
>> I fully agree. I'm going to provide a patch on monday.
> 
> Well, I still don't think it is the wisest choice.  My position is
> that it is better to be conservative and pedantic now because it is
> easy to relax the rules from that point.  If it turns out after some
> experience with "fsl,upm-addr-line-cs-offset" that the scheme has a
> serious flaw, then the impact is contained.  On the other side, if it
> is confirmed and useful and correct, it is a trivial change to make it
> available to everything that claims compatibility with fsl,upm-nand.
> 
> That said, I won't oppose it if you go this route.  However at the
> very least, please change the nand node's compatible list to be:
> 
> compatible = "tqc,tqm8548-upm-nand", "fsl,upm-nand";
> 
> The custom glue logic makes it something unique, so "tqc,..." should
> be at the start of the list to describe it as such, even if the driver
> only ever uses "fsl,upm-nand".

That's a good idea in case we need it lateron. For the time being, I
prefer to make the driver as generic as possible. Currently there are
only two boards using the driver, the MPC8360RTDK and the TQM8548. and
it's unlikely that there will be much more in the future.

Wolfgang.
