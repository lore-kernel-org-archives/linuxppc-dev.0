From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>, <msokolov@ivan.Harhan.ORG>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Date: Sun, 7 Apr 2002 10:04:21 +0100
Message-Id: <20020407090421.11429@smtp.wanadoo.fr>
In-Reply-To: <Pine.GSO.4.21.0204071026160.2567-100000@lisianthus.sonytel.be>
References: <Pine.GSO.4.21.0204071026160.2567-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On Sat, 6 Apr 2002, Benjamin Herrenschmidt wrote:
>> I've looked at the patch in the meantime and it makes much sense. I want
>> to do something around those lines:
>>
>>  - Completely rip off CONFIG_ALL_PPC in favor of CONFIG_GENERIC_PPC32
>>  - Each board model has it's own CONFIG_xxx entry (like Michael patch),
>>    which means adding "back" CONFIG_PMAC, CONFIG_CHRP, CONFIG_PREP, but
>>    those will only control which set of .c file will get in the makefile
>>    and the toplevel switch/case on platform_init. That is you will be able
>>    to select an arbitrary set of boards.
>
>Good, starts to look like m68k again, where you always were able to compile a
>generic kernel (except for Sun-3 (not 3x) due to the different MMU)!
>Now start moving platform specific files to arch/ppc/$platform/ again. Dan is
>right, we're running in circles :-)

No, we aren't ;)

In some way, all those new board brought us back to the pre-CONFIG_ALL_PPC
days since they all have their own config option and can't live in a
generic kernel. Mostly for no reason except maybe detecting the board
at boot time (which can be done in the wrapper now if there is no other
way).

The other way, iirc, making the generic (CONFIG_ALL_PPC) kernel from
split pmac/chrp/prep was necessary to get the non-platform specific code
really non-platform specific (at that time, we had the "common" irq, pci
etc... code diff'ing between platforms or #ifdef'ed in places).

So we aren't circling here. We are slowly moving toward an arch where the
common code is really common and no crippled with platform ifdefs, and
a platform is just a set of functions behind ppc_md along with appropriate
drivers beeing in the Makefile. It's a logical step to do the (few) Makefile
and Config.in work to make those individual platforms be selectable
in arbitrary sets.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
