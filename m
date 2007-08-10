Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070809212420.GD13921@localdomain>
References: <20070809005044.GD10114@localdomain>
	<20070809030555.GA8261@localhost.localdomain>
	<20070809041632.GA13921@localdomain>
	<40561246eaa06210a2a607aa7ed67b02@kernel.crashing.org>
	<20070809212420.GD13921@localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6681fdad128303fc62c86c2345aa33a4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] remove gratuitous reads from maple pci config space
	methods
Date: Fri, 10 Aug 2007 19:58:43 +0200
To: Nathan Lynch <ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Well, I had already checked with Ben, who wrote the code, and my
>>> understanding is that the reads are intended to work around some
>>> misbehaving Apple bridges,
>>
>> None of the PCI interfaces on the U3 or U4 bridges have that
>> problem as far as I know.  I think the workaround was copied
>> from code for older Apple bridges?
>
> Okay, then the change should be fine for maple.

Yes.  Of course, as usual, testing is needed, yada yada.

>>> but that a sync after the write (implied by
>>> releasing pci_lock in the generic pci code) should suffice for those.
>>
>> I don't see how a sync could help here at all, not more than
>> an eieio anyway?
>
> Alright, well, maybe take it up with Ben when I post the patch for
> powermac, since that's where it could actually matter.

It should be fine on PowerMac as well -- all G5s use U3/U4,
the workaround is for certain older Apple bridge chips.


Segher
