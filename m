Message-ID: <376A985C.9E499B15@alexa.com>
Date: Fri, 18 Jun 1999 12:05:01 -0700
From: joshua@alexa.com (Joshua Winsor)
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Open Firmware help
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I know this is off topic, but I think this is the best place to get a
possible solution


 I am trying to get Darwin installed on an UMAX S900,  I am having great
difficulties with the kernel loader.  I have concluded that  the open
firmware is not actually passing any of the boot variables to the the
kernel loader.

 I grabbed the nvramrc from the System Disk Application's OFsb resource
#128 (PowerSurge) that came with the Darwin installer.

Does anyone out there have experience with S900's firmware being
different from  9500's, or anyone with experience getting  Rhapsody DR2
booting on and S900 that could be explained by such problems?


 This is what the bootloader is outputing

                    Rhapsody Kernel Loader <02:12:14 990220>
                    sl-debug, unknown wordDebug Flag = 00000000

                    Installing bugfix replacement device drivers:
0x005370F8
                    Loading kernel and preparing it...
                    mach-o: __TEXT ovad=FFFFFFFF vad=00005000
sz=0021E000 ad=00005000 fsz=0021E000
                    mach-o: __DATA ovad=00005000 vad=00223000
sz=00317000 ad=00223000 fsz=00049000
                    mach-o: __OBJC ovad=00223000 vad=0031C000
sz=00338000 ad=0031C000 fsz=00021000
                    mach-o: __VECTORS ovad=0031C000 vad=00000000
sz=0033C000 ad=00000000 fsz=0000400
                    0
                    CLAIM failedmach-o: Loaded Server ovad=00000000
vad=0033D000
                    sz=0033D000 ad=0033
                    D000 fsz=00001000
                      fd=0, st=0, entry=14B900, base=33D000,
size=33D000, dataTop=33E000 loader: kernel: 0
                    mach-o: __TEXT ovad=FFFFFFFF vad=00700000
sz=00026000 ad=00700000 fsz=00026000
                    mach-o: __DATA ovad=00700000 vad=00726000
sz=00028000 ad=00726000 fsz=00002000
                    boot args = '    '
                    DeviceTree base=0x0033E1FC, length=62660 bytes
                    Call kernel!


        user-nvramrc?=true
        load-base=6000000

                    Here is my nvramrc


                    hex
                    : $C $call-method ;
                    : $D find-device ;
                    : $E device-end ;
                    : $x execute ;
                    : $F $D " open" $find drop ;
                    : $p 0 to my-self property ;
                    : $a " /chosen" $D $p $E ;
                    : R BRpatch ; : L BLpatch ;
                    : q over + ;
                    : g code! ;
                    : & get-token drop ;
                    6ED & $x
                    0 value mi
                    : mmr " map-range" mi if my-self $C else
$call-parent then ;
                    89B & ' mmr R
                    : mcm -1 to mi $C 0 to mi ;
                    8CB & 1E na+ ' mcm L
                    : maa -1 to mi 1D swap ;
                    8C9 & 5 na+ ' maa L
                    8C9 & 134 + ' 1 L
                    8CD & 184 + 14 q dup @ 6 << 6 >>a -4 and + R
                    8C6 & 7C + ' u< L
                    0 value yn
                    : y yn 0= if dup @ to yn then ;
                    8CB & ' y R
                    ' y 28 + 8CB & 8 + R
                    : z yn ?dup if over ! 0 to yn then ;
                    8CC & ' z R
                    ' z 2C + 8CC & 8 + R
                    @startvec BC + @ 40820014 over 88 + g 41820010 swap
E0 + g
                    0 @startvec 5C + @ 1D8 + g
                    dev /packages/mac-parts
                    400000 ' load 14 + g
                    : m1 400000 do-unmap ;
                    ' load 8 + ' m1 L
                    ' load 160 + ' 0 L
                    : &r1 4+ dup 8000 alloc-mem 7F00 + swap ! 4+ F8 ;
                    ' load 2AC - ' &r1 L
                    $E
                    4180FFF0 ' msr! 44 + g
                    dev /packages/xcoff-loader
                    : p&+ ['] open 600 - + ;
                    : p1 { _a _s } _a -1000 and _a _s + over - FFF ;
                    60000000 dup 8 p&+ g C p&+ g
                    18 p&+ ' p1 L
                    $E
                    " enet" $F dup
                    1D8 - 24 q ['] or L $x
                    248 - @ 6 encode-bytes 2dup
                    " local-mac-address" $p
                    $E
                    " mac-address" $a
                    10 buffer: km
                    dev kbd
                    get-key-map km swap move
                    $E
                    : ck 0 do swap dup 3 >> km + c@ 1 rot 7 and << and
or loop ;
                    : bootr 0d word count encode-string " machargs" $a
                    0 0 1 ck if 0 and else f 3d 0 2 ck if 40 or then
then
                    if bye else 1e 0 do ['] boot catch drop 1f4 ms loop
then bye ;
                    : &SI
                    " scsi-int" open-dev
                    " open" 2 pick 4+ @ find-method drop
                    2c q ['] 2 L 848 -
                    8 q 1C q R
                    88 q 4 q R
                    $x " close" rot $C ;
                    &SI
                    dev /packages/obp-tftp
                    : O ['] open + ;
                    : M dup 24 - -18E0 O $X 6 move 14 + ;
                    684 O ['] drop L
                    -63C O ' M L
                    $E
                    unselect-dev





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
