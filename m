To: bh40@calva.net
Cc: linuxppc-dev@lists.linuxppc.org, paulus@cs.anu.edu.au
Subject: Re: Blue G3 and machine check
In-Reply-To: Your message of "Sun, 14 Mar 1999 14:35:58 +0100"
	<19990314143558.014768@mail.mipsys.com>
References: <19990314143558.014768@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990316014237Y.roikawa@rr.iij4u.or.jp>
Date: Tue, 16 Mar 1999 01:42:37 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> While reading of macbsd mailing list, I've seen that the Blue G3 causes a
> machine check exception while probing a non-existing PCI slot. I don't
> have time to look into this and I don't have one of those machines, but
> if anyone want to give a try at fixing this...
> 
> (With luck, the second PCI bridge will have been properly setup by OF or
> BootX and this fix could be enough to get the machine to boot further
> that It's doing now).
 As far as I tested(kernel source 2.2.1 from samba and BootX 1.0.2b),
the kernel freezes within head.S before jumping to start_kernel. It seems
to completely freeze after the following instructions:

/*
 * Go back to running unmapped so we can load up new values
 * for SDR1 (hash table pointer) and the segment registers
 * and change to using our exception vectors.
 * On the 8xx, all we have to do is invalidate the TLB to clear
 * the old 8M byte TLB mappings and load the page table base register.
 */
#ifndef CONFIG_8xx
	lis	r6,_SDR1@ha
	lwz	r6,_SDR1@l(r6)
#else
	/* The right way to do this would be to track it down through
	 * init's TSS like the context switch code does, but this is
	 * easier......until someone changes init's static structures.
	 */
	lis	r6, swapper_pg_dir@h
	tophys(r6,r6,0)
	ori	r6, r6, swapper_pg_dir@l
	mtspr	M_TWB, r6
#endif
	lis	r4,2f@h
	ori	r4,r4,2f@l
	tophys(r4,r4,r3)
	li	r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
	mtspr	SRR0,r4
	mtspr	SRR1,r3
	rfi


Next, I looked into MacOS ROM file if there's a hint or somthing
and found an OF boot script:

<CHRP-BOOT>
<COMPATIBLE>
iMac,1 PowerMac1,1 PowerBook1,1
</COMPATIBLE>
<DESCRIPTION>
MacROM for NewWorld.
</DESCRIPTION>
<BOOT-SCRIPT>
here &gt;r
dev /
" model" active-package get-package-property abort" can't find MODEL"
decode-string 2swap 2drop " iMac,1" $= ?dup 0= if
 " compatible" active-package get-package-property abort" can't find COMPATIBLE"
 false &gt;r
 begin
  dup while
  decode-string here over 2swap bounds ?do
   i c@ dup [char] A [char] Z between if h# 20 xor then c,
   loop
  2dup " powermac1,1" $= r&gt; or &gt;r
  2dup " powerbook1,1" $= r&gt; or &gt;r
  2drop
  repeat
 2drop r&gt;
  then
r&gt; here - allot
0= abort" this image is not for this platform"
dev /openprom
0 0 " supports-bootinfo" property
device-end
" /chosen" find-package 0= abort" can't find '/chosen'" constant /chosen
" memory" /chosen get-package-property abort" memory??" decode-int constant xmem 2drop
" mmu" /chosen get-package-property abort" mmu??" decode-int constant xmmu 2drop
" AAPL,debug" " /" find-package 0= abort" can't find '/'" get-package-property if
   false
  else
 2drop true
  then
( debug? ) constant debug?
debug? if cr ." checking for RELEASE-LOAD-AREA" then
" release-load-area" $find 0= if 2drop false then ( xt|0 ) constant 'release-load-area
debug? if 'release-load-area if ." , found it" else ." , not found" then then
: do-translate " translate" xmmu $call-method ;
: do-map  " map" xmmu $call-method ;
: do-unmap " unmap" xmmu $call-method ;
: claim-mem  " claim" xmem $call-method ;
: release-mem " release" xmem $call-method ;
: claim-virt " claim" xmmu $call-method ;
: release-virt " release" xmmu $call-method ;
1000 constant pagesz
pagesz 1- constant pagesz-1
-1000 constant pagemask
h# 004000 constant elf-offset
h# 00CCE8 constant elf-size
elf-size pagesz-1 + pagemask and constant elf-pages
h# 010CE8 constant lzss-offset
h# 1CB7A2 constant lzss-size
lzss-size pagesz-1 + pagemask and constant lzss-pages
h# 1DC48A constant info-size
info-size pagesz-1 + pagemask and constant info-pages
0 value load-base-claim
0 value info-base
'release-load-area if
    load-base to info-base
  else
    load-base info-pages 0 ['] claim-mem catch if 3drop 0 then to load-base-claim
    info-pages 1000 claim-virt to info-base
    load-base info-base info-pages 10 do-map
  then
lzss-pages 400000 claim-mem constant rom-phys
lzss-pages 1000 claim-virt constant rom-virt
rom-phys rom-virt lzss-pages 10 do-map
elf-pages 1000 claim-mem constant elf-phys
elf-pages 1000 claim-virt constant elf-virt
elf-phys elf-virt elf-pages 10 do-map
info-base elf-offset + elf-virt elf-size move
debug? if cr ." elf-phys,elf-virt,elf-pages: " elf-phys u. ." , " elf-virt u. ." , " elf-pages u. then
debug? if cr ." copying compressed ROM image" then
rom-virt lzss-pages 0 fill
info-base lzss-offset + rom-virt lzss-size move
'release-load-area 0= if
    info-base info-pages do-unmap
    load-base-claim ?dup if info-pages release-mem then
  then
debug? if cr ." MacOS-ROM phys,virt,size: " rom-phys u. ." , " rom-virt u. ." , " lzss-size u. then
debug? if cr ." finding/creating '/rom/macos' package" then
device-end 0 to my-self
" /rom" find-device
" macos" ['] find-device catch if 2drop new-device " macos" device-name finish-device then
" /rom/macos" find-device
debug? if cr ." creating 'AAPL,toolbox-image,lzss' property" then
rom-virt encode-int lzss-size encode-int encode+ " AAPL,toolbox-image,lzss" property
device-end
debug? if cr ." copying MacOS.elf to load-base" then
'release-load-area if
    load-base elf-pages + 'release-load-area execute
  else
    load-base elf-pages 0 claim-mem
    load-base dup elf-pages 0 do-map
  then
elf-virt load-base elf-size move
elf-virt elf-pages do-unmap
elf-virt elf-pages release-virt
elf-phys elf-pages release-mem
debug? if cr ." init-program" then
init-program
debug? if cr ." .registers" .registers then
debug? if cr ." go" cr then
go
cr ." end of BOOT-SCRIPT"
</BOOT-SCRIPT>
</CHRP-BOOT>...MacOS icon bitmap and ELF header follows...

BlueG3's OF contains ELF loader package and is this the loading script?
Though I don't understand OF/Forth very well, this may be useful for
prom_init or somewhere.
 
Still can't reach the entry point. What should I do next?


Thanks in advance,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp
http://www.rr.iij4u.or.jp/~roikawa

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
