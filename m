Message-ID: <3A6CA10B.9040801@valinux.com>
Date: Mon, 22 Jan 2001 14:07:23 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: Dan Malek <dan@mvista.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101222110460.23057-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> Hi,
>
> On Mon, 22 Jan 2001, Dan Malek wrote:
>
>> ...I don't know who wrote:
>
>
> (That was I too :). )
>
>>>>> There is no pte table and so there is nothing mapped at that address,
>>>>
>> No, there is a pte table there, you just didn't get to printing
>> anything from it......
>
>
> Nope, there is no pte table, otherwise pte had been a valid pointer into
> that table, so it's just the offset for that table.
>
>> Err...ahhhh...I don't know if I would go looking in that file for
>> examples.  I would prefer to understand the problem we are trying to
>> solve, and perhaps write some functions to call if necessary.  Scattering
>> code from functions in this file into other places may not be a good
>> thing.
>
>
> Sure, one missing information is, how he got that address.

We take the value returned from vmalloc_32 and walk the kernel page
tables from that address.

>
> Anyway, looking up virtual kernel memory that way is possible, with
> ioremapped memory it already is dangerous, but for that you also don't get
> any page struct.
>
> bye, Roman
>
Doing this for ioremapped memory would be EVIL.  If your using an
ioremapped area of memory, you should know the addresses it refers too.
I suppose you could get them by walking the page tables, but that's just
icky.  The only reason we are walking the page tables is there is no
kernel call which gives us a list of pages and a virtually contiguous
address.

-Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
