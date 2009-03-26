Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <49CBA062.5050000@grandegger.com>
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
Date: Thu, 26 Mar 2009 10:04:37 -0600
Message-ID: <fa686aa40903260904s67258fbbge3c87e06946c5f58@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] powerpc: NAND: FSL UPM: document new bindings
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
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

On Thu, Mar 26, 2009 at 9:33 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Grant Likely wrote:
>> Does using the reg property give the driver enough information to
>> reliably program the MAR for NAND connections that use the address
>> line chip select scheme? =A0Related to that, should the binding include
>
> In principle yes:
>
> =A0if (i > 0)
> =A0 =A0 =A0offset[i] =3D resource[i].start - resource[0].start;

Ewww.  That's ugly.

>> a property that explicitly states that an address line chip select
>> scheme is being used?
>
> That's why I'm still in favor of:
>
> =A0fsl,upm-multi-chip-offsets =3D <0x200 0x400>
>
> That would state that the address line chip select scheme is used with
> the specified offsets. It also allows for a more elegant solution
> (code-wise).

Alright.  Then at the very least the property name should reflect that
address lines CS is used to reduce the chance of confusion with
another multi-chip scheme.  Something like
fsl,upm-addr-line-cs-offsets maybe?

Here is another thought.  The binding is describing that address lines
are used to activate CS lines.  Offset for chip access purposes is
derived from the address line, but it doesn't directly describe the
hardware.  The following may be a better description of the hardware.

fsl,upm-addr-line-cs =3D <9 10>;

g.



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
