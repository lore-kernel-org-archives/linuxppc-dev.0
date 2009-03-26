Return-Path: <wg@grandegger.com>
Message-ID: <49CBAED4.8030802@grandegger.com>
Date: Thu, 26 Mar 2009 17:35:32 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 3/4] powerpc: NAND: FSL UPM: document new bindings
References: <1237975701-23201-1-git-send-email-wg@grandegger.com>	
	<1237975701-23201-2-git-send-email-wg@grandegger.com>	
	<1237975701-23201-3-git-send-email-wg@grandegger.com>	
	<1237975701-23201-4-git-send-email-wg@grandegger.com>	
	<fa686aa40903251048g479d63f8i5a715defdbfc33d4@mail.gmail.com>	
	<49CA9899.30604@grandegger.com>	
	<fa686aa40903252209r52a1bc1cn995a7da16bc3527f@mail.gmail.com>	
	<49CB31CB.2010704@grandegger.com>	
	<fa686aa40903260727y3266e394g5e574680fe70bbbf@mail.gmail.com>	
	<49CBA062.5050000@grandegger.com>
	<fa686aa40903260904s67258fbbge3c87e06946c5f58@mail.gmail.com>
In-Reply-To: <fa686aa40903260904s67258fbbge3c87e06946c5f58@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Thu, Mar 26, 2009 at 9:33 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Grant Likely wrote:
>>> Does using the reg property give the driver enough information to
>>> reliably program the MAR for NAND connections that use the address
>>> line chip select scheme?  Related to that, should the binding include
>> In principle yes:
>>
>>  if (i > 0)
>>      offset[i] = resource[i].start - resource[0].start;
> 
> Ewww.  That's ugly.

Yep.

>>> a property that explicitly states that an address line chip select
>>> scheme is being used?
>> That's why I'm still in favor of:
>>
>>  fsl,upm-multi-chip-offsets = <0x200 0x400>
>>
>> That would state that the address line chip select scheme is used with
>> the specified offsets. It also allows for a more elegant solution
>> (code-wise).
> 
> Alright.  Then at the very least the property name should reflect that
> address lines CS is used to reduce the chance of confusion with
> another multi-chip scheme.  Something like
> fsl,upm-addr-line-cs-offsets maybe?


> 
> Here is another thought.  The binding is describing that address lines
> are used to activate CS lines.  Offset for chip access purposes is
> derived from the address line, but it doesn't directly describe the
> hardware.  The following may be a better description of the hardware.
> 
> fsl,upm-addr-line-cs = <9 10>;

The TQM8548 hardware has some logic connected to the two address lines
allowing to select up to 4 chips with two address lines:

 fsl,upm-addr-line-cs-offsets = <0x0 0x200 0x400 0x600>

That's the more general solution.

Wolfgang.
