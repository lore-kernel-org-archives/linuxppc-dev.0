Message-ID: <3DD8A28C.E8EABFF@opensource.se>
Date: Mon, 18 Nov 2002 09:19:24 +0100
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: bi_record and initrd
References: <3DD3C747.8B7EE5CD@opensource.se> <20021114174807.GC605@opus.bloom.county> <3DD4E271.16FA374A@opensource.se> <20021115100857.H9673@duath.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> This would be a good opportunity to switch-over to allowing the bootloader
> stick the initrd where it wants and just pass the physical pointer in via
> bi_record in all cases.  It would certainly simplify these cases.

So, the following registers passed to the kernel could change from

 *   r3: ptr to board info data
 *   r4: initrd_start or if no initrd then 0
 *   r5: initrd_end - unused if r4 is 0
 *   r6: Start of command line string
 *   r7: End of command line string

to

 *   r3: ptr to bi_record

If the initrd is going to be passed with the bi_record, and the command line
already is there, then it's just the board info left. (for the 8xx anyhow)

Or maybe there are zillions of applications booting the kernel directly
without the bootloader..

/ magnus

Cort Dougan wrote:
>
> This would be a good opportunity to switch-over to allowing the bootloader
> stick the initrd where it wants and just pass the physical pointer in via
> bi_record in all cases.  It would certainly simplify these cases.
>
> } > Can you give more information about where everything is loaded up at?  I
> } > thought this was a non-issue, but it's been a while since I tested
> } > initrds.
> }
> } Sure.
> } The first example below does not trigger the bug.
> } The second one shows the bug.
> }
> } First example:
> }
> } loaded at:     00180000 0023C1D0
> } board data at: 00239124 00239140
> } relocated to:  001852FC 00185318
> } zimage at:     00185880 00214ADE
> } initrd at:     00215000 002388D9
> } avail ram:     0023D000 04000000
> }
> } gunzip() unzips the zimage to address 0 and sets zimage_size to 0x00148A6C.
> } I'm not sure about the _ALIGN() macro and how it's used, but in this case
> } rec gets calculated to 0x00300000.
> } I thought the idea was to get a address that is aligned to the nearest
> } 1-megabyte boundary.
> } (2 megabyte in this case - but that would overwrite the zimage...)
> }
> } anyhow, the rec at 3 megabytes is inside of the available ram - good.
> }
> } this mail says something about typos or misuse of _ALIGN().
> } http://www.geocrawler.com/archives/3/8358/2002/9/0/9715261/
> }
> } If _ALIGN() now is used correctly, then the align definition
> } maybe chould be changed from
> } #define _ALIGN(addr,size)        (((addr)+size-1)&(~(size-1)))
> } to
> } #define _ALIGN(addr,size)        (((addr)+(size)-1)&(~((size)-1)))
> } to make sure that size is treated correctly. Or maybe it's a feature. =)
> }
> } Second example:
> }
> } loaded at:     FE2226F0 FE3098C0
> } relocated to:  00180000 002671D0
> } board data at: 00264124 00264140
> } relocated to:  001852E8 00185304
> } zimage at:     00185840 001CCEAB
> } initrd at:     001CD000 00263A21
> } avail ram:     00268000 04000000
> }
> } I have not been able to output the value of zimage_size for this case, but I'm
> } sure that my initrd gets overwritten with the bi_record at 0x00200000.
> } We read out the initrd memory area with a BDM debugger and compared with the
> } original compressed filesystem image. So rec gets set to 2 megabytes.
> } This results in a initrd with bad crc. If it would help you I could get the value
> } of zimage_size, but it's on another machine and I don't have the time today.
> }
> } Another thing - why is the second argument (dstlen) to gunzip() always 4 megabytes?
> } Maybe it could be set to the address that the image is loaded at / relocated to?
> } (0x180000 above) That way the gunzip function wouldn't overwrite the running code,
> } if I understand the dstlen argument correctly that is.
> }
> } I'm using a 2.4.18 kernel patched up to 2.4.19-pre9 with more patches to match
> } linuxppc_2_4 (downloaded from ppckernel.org). So if you've made any changes
> } recently then I don't have them. But I compared my bi_record code with the
> } latest code available via rsync and they look identical.
> }
> } thanks /
> }
> } magnus
> }
> } Tom Rini wrote:
> } >
> } > On Thu, Nov 14, 2002 at 04:54:47PM +0100, Magnus Damm wrote:
> } >
> } > > The bi_record setup code in linux/arch/ppc/boot/simple/misc-embedded.c
> } > > doesn't care about the initrd size. So, if you are using a initrd that
> } > > crosses a megabyte-boundary you will have your initrd overwritten with
> } > > the bi_record. This results in crc error when unpacking the initrd.
> } > >
> } > > The quick fix is to add a offset to the boot-code and to
> } > > arch/ppc/kernel/setup.c.
> } > >
> } > > So, what's the long term solution?
> } > > Passing a pointer to the kernel?
> } >
> } > Can you give more information about where everything is loaded up at?  I
> } > thought this was a non-issue, but it's been a while since I tested
> } > initrds.
> } >
> } > --
> } > Tom Rini (TR1265)
> } > http://gate.crashing.org/~trini/
> }

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
