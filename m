Subject: Re: Problem in booting PPC with kernel 2.5.44
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Atm account <linux2@cdotd.ernet.in>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.OSF.4.10.10211131428120.9066-100000@moon.cdotd.ernet.in>
References: <Pine.OSF.4.10.10211131428120.9066-100000@moon.cdotd.ernet.in>
Content-Type: text/plain
Date: 14 Nov 2002 14:36:21 +0100
Message-Id: <1037280982.877.14.camel@zion>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2002-11-13 at 10:52, Atm account wrote:
>
> Hello All,
>   We are porting Linux 2.5.44 for our custom board which has
>  603e processor..
>     We are using the arch/ppc/boot/simple bootloader with minor
> modifications. At the end of boot-code relocation to 8 Mb, the code jumps
> to the relocated code and thereafter
> does the decompression (decompress_kernel)of the vmlinux image to physical
> address 0 and jumps to the 0th location (3 nops followed by code). It is
> from here that early_init is called.
>     Now the problem is ... the kernel has been linked at 3GB and a call in
> kernel/head.S which says ---
>        bl early_init
> translates to sth like =>    bl 0Xc000xxxx
>    I dont have the MMU on at this point nor any dual mapping being done
> thru the BATs. So how is the above code supposed to execute ?????
> Our board precisely hangs after this jump.

Those are relative branches, not absolute.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
