Message-ID: <40EC2876.7090303@ru.mvista.com>
Date: Wed, 07 Jul 2004 20:44:38 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: roberto.farina@cefriel.it
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PRoblem with VirtexII Pro: maybe the toolchain?
References: <40EBB6FA.9080009@cefriel.it>
In-Reply-To: <40EBB6FA.9080009@cefriel.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Roberto,

The definitely wrong thing I can see in your log is the wrong
RAM size. I can't give you more help without knowing what
kernel tree you are working with, how you configured the
kernel, and how you load the kernel (do you use System ACE,
BDI2000; has your board a bootloader like uboot etc.).

To my knowledge, there is no Memec 2VP7 board support in
the linuxppc-2.4 and linuxppc-2.5 trees.
If you were using ML300 platform as the base for your development,
I would expect the console output to look similar to:

   loaded at: 00400000 004931D0
   <snip>
   avail ram: 00494000 02000000

"loaded at:     00800000" in your log instead of "loaded at: 00400000"
could indicate wrong kernel configuration. But, again, the main point is
that the last line should look like "avail ram: ???????? 02000000" reflecting
that 2VP7 board has 32MB (0x2000000 bytes) of SDRAM.

Best regards,
Andrei


Roberto Farina wrote:
>
>
> Hi list,
> I'm currently trying to make Linux booting on my Memec XC2VP7 board that
> holds a Xilinx V2Pro device.
>
> I'm using gcc version 3.3.2 for ppc405 compiled with crosstool (thx D.
> Kegel) ;)
>
> This toolchain makes me succeded in compiling the kernel; downloading it
> with xilinx tools brings this output to the serial console
>
> loaded at:     00800000 008561C8
> board data at: 00085EB4 00085EEC
> relocated to:  00805308 00805340
> zimage at:     00805833 00852A7C
> avail ram:     00857000 4D046405
>
> Linux/PPC load:
> Uncompressing Linux...done.
> Now booting the kernel
>
> At this point the system hangs...
>
> I'm still trying to figure out where the system stops or what's
> happening: I'll give more detail when I'll find them :(
> I'm sorry for the poor info I can give you at this point.
>
> I tried to compile the same kernel with the Xilinx toolchain (gcc
> 2.95.3) but many linking steps require some file that must be copied
> from the Xilinx EDK prj: after copying them I face lots of multiple
> definition problems... I stopped this investigation for now.
>
> Did anyone experienced the same problems (or knows about a possible
> reason for this kind of hangs?)
>
> Thanks in advance for any help
> Best regards
>
> - ---------------------------------------------------------
> Roberto Farina
> CEFRIEL - Digital Technologies and Operating Systems Unit
> Via Fucini, 2 - 20133 MILANO (ITALY)
> Phone:  +39 02 23954 236
> Fax:    +39 02 23954 254
> ~        178 606 5693
> - ---------------------------------------------------------
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
