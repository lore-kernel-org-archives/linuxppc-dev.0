From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B2363A@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Trying to program u-boot into flash using BDI2000
Date: Fri, 31 Jan 2003 13:18:32 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


J39 is confirmed open (i.e. write enabled).

-----Original Message-----
From: Chris Zimman [mailto:chris@cryptoapps.com]
Sent: Friday, January 31, 2003 3:05 PM
To: brian.auld@adic.com
Subject: Re: Trying to program u-boot into flash using BDI2000

On Fri, Jan 31, 2003 at 11:40:36AM -0800, brian.auld@adic.com wrote:

Just as a first -- did you check the flash write protect jumper (J39)?
Should be open.

--Chris

>
> The embedded linux on ebony(440GP) saga continues:
>
> - ELDK in place (check)
> - kernel compiled (check)
> - u-boot compiled (check)
> - ebony in place (check ... dip switch settings confirmed)
> - BDI2000 in hand (arrived this morning)
>
> OK, I'm trying to program flash with u-boot (I'm using u-boot.bin). I am
> using the 440GP config file provided by abatron, plus the [FLASH]
parameters
> from the example in the bdiGDB users manual for programming flash on the
> 405. It looks like the memory map as it pertains to flash as well as the
> part (AMD29F040) was consistent from the 405 --> 440, so it seemed logical
> to use these FLASH values. The 440GP config file provided does not have
any
> FLASH parameters set, which is why I made this change.
>
> Well, I successfully erased the flash from 0xfff8000 - 0xffffffff and
> checked the locations after the erase ... they were all 'F's. I then tried
> to program the flash with my u-boot.bin and got the following:
>
> ===== start of bdi clip =====
> BDI>prog 0xfff80000 u-boot.bin bin=
> Programming u-boot.bin , please wait ....
> # Programming flash memory failed at 0xfff80000
> BDI>prog 0xfff80000 u-boot.bin bin
> Programming u-boot.bin , please wait ....
> # Programming flash memory failed at 0xfff80000
> BDI>
> ===== end of bdi clip =====
>
> Any ideas why this failed. Attached is my config file. I'll just attach
the
> [HOST] and [FLASH] sections to make it a little easier on the eyes. For
> anyone familiar with BDI sample 440GP confile file, you will see that it
is
> this file with the [FLASH] additions I mentioned above. Actually, after
> looking at the file, I remembered that I also trimmed information in the
> [HOST] section ... specifically stuff that was presuming path to Windows
> information. My host is Linux.
>
> ===== start of config file ([HOST] and [FLASH] sections) =====
> ;bdiGDB configuration file for IBM 440GP Reference Board
>
> -- cut --
>
> [HOST]
> IP          172.16.77.151        ;Linux host
> ;FILE        u-boot.bin
> ;FORMAT      BIN
> ;START      0x200000
> LOAD        MANUAL              ;load code MANUAL or AUTO after reset
> DEBUGPORT   2001
> DUMP        dump.bin            ;Linux: dump.bin must already exist and
> public writable
>
> [FLASH]
> CHIPTYPE    AM29F            ; flash part = AMD29F040B
> CHIPSIZE    0x80000          ;The size of one flash chip in bytes (0.5MB)
> BUSWIDTH    8                ;The width of the flash memory bus in bits (8
|
> 16 | 32)
> WORKSPACE   0x000040000      ; RAM buffer for fast flash programming
> FILE        u-boot.bin       ;The file to program
> FORMAT      BIN  0x00000000
> ERASE       0xFFF80000
> ERASE       0xFFF90000
> ERASE       0xFFFA0000
> ERASE       0xFFFB0000
> ERASE       0xFFFC0000
> ERASE       0xFFFD0000
> ERASE       0xFFFE0000
> ERASE       0xFFFF0000
>
> -- cut --
>
> ===== end of config file ( with cuts) =====
>
> -- Brian
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
