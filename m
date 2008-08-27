Return-Path: <vbendeb@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 6C2D2DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 09:13:54 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so63701pyi.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Aug 2008 16:13:52 -0700 (PDT)
Message-ID: <f608b67d0808271613g2092b287o44c3418fb7d33499@mail.gmail.com>
Date: Wed, 27 Aug 2008 16:13:52 -0700
From: vb <vb@vsbe.com>
Sender: vbendeb@gmail.com
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: mmap and ppc460gt
In-Reply-To: <200808271013.18659.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
	<ada3akri1i5.fsf@cisco.com> <200808271013.18659.arnd@arndb.de>
Cc: Roland Dreier <rdreier@cisco.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 27, 2008 at 1:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 27 August 2008, Roland Dreier wrote:
>>  > I don't seem to be able to port this to ppc460gt: on this architecture
>>  > the PCI register space can be mapped only to 36 bit address ranges
>>  > with nonzero top nibbles. But mmap()  (at least the one I have in
>>  > 2.6.25)  accepts only 32 bit values for addresses, hence there is no
>>  > way to map PCI space into user space.
>>
>> In the past I've been able to use mmap64() on ppc440 to get at 36-bit
>> addresses.  As far as I know this should still work.
>
> Right, this is supposed to work. If it doesn't, report it as a bug.
>
>> Also you should be able to get at the BAR of a PCI device by using
>> mmap() on a resource file under /sys/devices, eg something like
>> /sys/devices/pci0000:00/0000:00:04.0/0000:0b:00.0/resource0
>> (where the bus numbers obviously depend on your system and the resource
>> number depends on what BAR your device has registers in)
>
> This should work as well.
>
> The best way to do it however would be to implement a UIO device driver
> for your device, see e.g. http://lwn.net/Articles/232575/.
>
> That gives you proper control over the permissions and lets you handle
> interrupts and other things as well.
>
>        Arnd <><
>

Arnd, Roland, thank you for your replies, I did manage to get it
mapped using mmap64(), but as it often happens clearing one hurdle
just brings us to the next one :-)

The problem now is that that PCI register space gets mapped with
caching enabled (by looking at the TLB contents), so I still can't
control the device. I did some search and indeed UIO device driver
came up, I'll read the article. I was wondering  though if there is a
simpler way to modify cache attributes of a region. mmap() doesn't
seem to provide an interface for that, is there some other function to
call to configure 'cache inhibit' attribute for a region?

TIA,
Vadim
