Message-ID: <38E6B3F6.67F0D9A0@wibble.net>
Date: Sun, 02 Apr 2000 12:44:06 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: problems with the frame buffer (ATV 64) on a power mac 7220 in newer kernels
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

this is a yellow dog cs 1.1 install that came with 2.2.6somehting or
other (cd from the linuxcare.au offices) and I downloaded 2.2.10 tar
ball from samba.org, then rsynced 2.2.15pre14 from linuxcare.au

on the power mac 7220 the kernel that came with it works happily
and as soon as bootx loads it we see the text start apearing during boot
(along witht the little penguin) and with a 2.2.10 compiled kernel I
grabbed off samba it also works fine.

I also grabbed the 2.2.10 source from samba and I am cross compiling it
on my dual pII 350.

the 2.2.10 I compile with a configuration that is correct for the
machine works fine and we see the text console as I should as soon as
bootx loads.

however with 2.2.15pre14 from paulus' rsync there is nothing but a blank
screen (fortunately I am still able to ssh to the pmac)

the relevant parts of the bootup seem to be

on working 2.2.10

Mar 28 17:56:31 innuendo kernel: Linux version 2.2.10 (sjh@sjhmmj) (gcc
version egcs-2.91.60 19981201 (egcs-1.1.1 release)) #2 Tue Mar 28
16:44:45 EST 2000

Mar 28 17:56:31 innuendo kernel: MacOS display is /bandit/ATY,264V
Mar 28 17:56:31 innuendo kernel: atyfb: mach64VT (ATI264VT) [0x5654 rev
0x40] 2M EDO, 200 MHz PLL, 63 Mhz MCLK
Mar 28 17:56:31 innuendo kernel: Console: switching to colour frame
buffer device 100x37
Mar 28 17:56:31 innuendo kernel: fb0: ATY Mach64 frame buffer device on
/bandit/ATY,264V

and of a non working 2.2.15pre14 kernel

Mar 28 18:21:21 innuendo kernel: Linux version 2.2.15pre14 (sjh@sjhmmj)
(gcc version egcs-2.91.60 19981201 (egcs-1.1.1 release)) #9 Tue Mar 28
15:59:41 EST 2000

Mar 28 18:21:21 innuendo kernel: MacOS display is
/bandit/ATY,264VTc^G<BC><80>^A
Mar 28 18:21:21 innuendo kernel: atyfb: mach64VT (ATI264VT) [0x5654 rev
0x40] 2M EDO, 14.31818 MHz XTAL, 200 MHz PLL, 63 Mhz MCLK
Mar 28 18:21:21 innuendo kernel: BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL
CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
Mar 28 18:21:21 innuendo kernel: 680080f9 87010184 0a000022 00000000
03030200      00000000   00000000
Mar 28 18:21:21 innuendo kernel: PLL 00 b5 2d 14 c6 0b 02 be d6 ee cf 00
41 00 00 00
Mar 28 18:21:21 innuendo kernel: atyfb: monitor sense=73f, maps to mode
6
Mar 28 18:21:21 innuendo kernel: Console: switching to colour frame
buffer device 128x48
Mar 28 18:21:21 innuendo kernel: fb0: ATY Mach64 frame buffer device on
/bandit/ATY,264VTc^G<BC><80>^A

note it seems I always get the garbage in boot up from the 2.2.15pre14
kernels (garbage being the weird characters after /bandit/ATY,264

and the weird characters change all the time.

note also the line
Mar 28 18:21:21 innuendo kernel: atyfb: monitor sense=73f, maps to mode
6

now that is new, looking in the source (atyfb.c)

    /*
     * The default video mode is 1024x768 @ 75Hz, as that
     * works on iMacs as well as the G3 powerbooks. - paulus
     */
    if (default_vmode == VMODE_CHOOSE) {
        if (Gx == LG_CHIP_ID)
            /* G3 PowerBook with 1024x768 LCD */
                default_vmode = VMODE_1024_768_60;
        else
                default_vmode = VMODE_1024_768_75;
        /* 'twould be nice to get this going - paulus */
        sense = read_aty_sense(info);
        printk(KERN_INFO "atyfb: monitor sense=%x, maps to mode %d\n",
               sense, mac_map_monitor_sense(sense));
    }


which is new since 2.2.10

it seems it is auto choosing this mode

I tried a kernel command line of video=controlfb:vmode:5 (I assume for
the kernel headers mode 5 is what I want) and also tried just
video=vmode:5 incase that worked (I found these command lines in
the __initfunc(void control_setup(char *options, int *ints)) in
controlfb.c

and the thing still chose the vmode as if it wanted to use the code
paulus put there recently. (5 seems to be the vmode I want, although it
seems the vmode can be pulled out of nvram also)

anyway this may all be somewhat extraneous information, basically I want
to have console work on the mac and it doesnt in 2.2.15pre14 and it
does on 2.2.10

I really want to use the newer kernel, especially as my hard disk
performance is increased more than 3 fold in the 2.2.15pre14 over 2.2.10

anyone who can help (what kernel command line to try, or whatever) it
would be appreciated. I dont have time to dig into the code any deeper
really for a few weeks (although knowing me I will probably
misprioratise
my uni work and do this instead, oh well.

I am unsure whether this is a a -dev or -user request but for now shall
limit my post to -dev.

Thanks

        See You
            Steve

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
