Message-ID: <39661556.D86AA2DA@mvista.com>
Date: Fri, 07 Jul 2000 10:37:26 -0700
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: RFC: Changing default partition type for linux/ppc
References: <20000707105915.30418@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That sounds like a great idea.  Looking at:
http://developer.apple.com/techpubs/mac/Devices/Devices-126.html

You'll see:
pmParType
              A string that identifies the partition type. Names that
begin with Apple_ are reserved for use by Apple Computer, Inc....

It looks to me that this allows us to use any name we wish, as long as
it doesn't start with "Apple_"

My vote: let the kernel still look for Apple_UNIX_SVR2 the way it does
now.  Then I would like it to be able to use anything that starts with
"Linux".  That way people can name there parts types whatever they want,
but Linux_ext2 and Linux_swap should be defaults.

Anyway, thats my suggestions, do what you wish!

Thanks!
--Mark


Benjamin Herrenschmidt wrote:
>
> Hi all !
>
> Currently, the default partition type used by Linux/PPC on mac partition
> maps is Apple_UNIX_SVR2. This is historically the type used by Apple's A/
> UX for its own partitions. However, I don't like it since it gives no
> indication on the type of filesystem on the partition, and I see no
> reason to keep it.
>
> So I suggest moving to Linux_ext2, Linux_swap, or maybe simply Linux and
> Linux_swap (since ext2 is not the only filesystem Linux may put on
> these). Using a different type for swap would help avoiding confusion.
>
> If everyone is ok, we can then update pdisk, and on my side, I'll update
> the kernel's root-auto-detect mecanism to take this into account. (The
> kernel will currently find by itself a root partition if it has the above
> type and the name "root" and no root= option was specified by the bootloader).
>
> Any comments ?
>
> Ben.
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
