Date: Fri, 31 Oct 2003 12:28:55 -0500
Subject: Re: Max RAM for Linux only 1GB?
From: John Whitney <john.whitney@timesys.com>
To: Prakash Kanthi <pkanthi@yahoo.com>,
	"Mailing List: linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <BBC80607.2081%john.whitney@timesys.com>
In-Reply-To: <20031031165821.17006.qmail@web41215.mail.yahoo.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Prakash,

The easiest route it to turn on highmem support (CONFIG_HIGHMEM).  As far as
I know, this does work for the PowerPC.  My understanding is that the kernel
doesn't directly use this memory, but will allow user-space programs to use
it (mapped into their memory space), which should in turn free up the memory
the kernel DOES use.

I think you'll need to start playing with the kernel start address if you
want the kernel to benefit directly from the additional memory.  I know this
has been done successfully to 0xA0000000, not sure about all the way down to
0x80000000 (but I can't think of why it wouldn't off the top of my head).

John

On 10/31/03 11:58 AM, "Prakash Kanthi" <pkanthi@yahoo.com> wrote:

>
> Folks,
>
> I have over 1GB DIMM RAM on my board running PPC 405.
> How can i ioremap that to my OS? As Linux virtual
> space starts at 0xC0000000, we have only 1GB more for
> all virtual space mappings.
>
> Even if i move 0xC0000000 to 0x80000000, what will
> happen to TLB settings? Any problem there to map 1GB
> additional RAM?
>
> Any idea as to how i can do this?
>
> Thanks,
> Prakash
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
