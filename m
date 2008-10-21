Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc1-s17.bay0.hotmail.com (bay0-omc1-s17.bay0.hotmail.com
	[65.54.246.89]) by ozlabs.org (Postfix) with ESMTP id 30AD3DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Oct 2008 12:23:17 +1100 (EST)
Message-ID: <BLU119-DAV14074C54D3632A6E1DCE3BB2E0@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.3776.1224533270.3127.linuxppc-embedded@ozlabs.org>
Subject: Re: How can I make flash writeable?
Date: Mon, 20 Oct 2008 18:23:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Below is what I did to burn JFFS2 into NOR flash

1) Partition
Due to small size 8 MB of NOR flash, I have to re-partition to fit the 
minimum 4MB of JFFS2 with erase blk of 64 KB

Start of DTS:
 nor@fe000000 {
  device_type = "rom";
  compatible = "direct-mapped";
  reg = <fe000000 00800000>; /*8MB*/
  probe-type = "CFI";
  bank-width = <2>;
  partitions = <
   00000000 00050001   /* U-BOOT  1M RO */
   00050000 00010001   /*  DTB 512K RO */
   00060000 001A0001   /* kernel 2M RO  */
   00200000 00600000>; /* JFFS2 512K RW */
  partition-names = "U-Boot", "Kernel", "DTB", "JFFS2" ;
 };
End of DTS

2) u-boot env

setenv bootargs root=/dev/mtdblock3 rootfstype=jffs2 rw console=ttyS0,115200

bootm fe06000 - fe050000

3) Compile DTS to get DTB and Use u-boot to burn DTB at 0xFE05_0000

4) Use u-boot to burn kernel at 0xFE06_0000

5) I use u-boot to burn JFFS2 at 0xFE20_0000

Good luck

----- Original Message ----- 
From: <linuxppc-embedded-request@ozlabs.org>
To: <linuxppc-embedded@ozlabs.org>
Sent: Monday, October 20, 2008 1:07 PM
Subject: Linuxppc-embedded Digest, Vol 50, Issue 33


> Send Linuxppc-embedded mailing list submissions to
> linuxppc-embedded@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> linuxppc-embedded-request@ozlabs.org
>
> You can reach the person managing the list at
> linuxppc-embedded-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
>
>
> Today's Topics:
>
>   1. Re: How can I make flash writeable? (Mark Bishop)
>   2. [PATCH] [MPC52XX] gpio: remove dead code (Wolfram Sang)
>   3. Re: [PATCH] [MPC52XX] gpio: remove dead code (Grant Likely)
>   4. Xilininx GPIO (Peter Scott)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 20 Oct 2008 11:36:39 -0400
> From: Mark Bishop <mark@bish.net>
> Subject: Re: How can I make flash writeable?
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <20081020113639.8h5cv70ciswwo4sc@www.bish.net>
> Content-Type: text/plain; charset=ISO-8859-1; DelSp="Yes";
> format="flowed"
>
> I am still trying to get JFFS2 onto the 8313E-RDB.  The procedure in
> the manual isn't working.  What did you use to put JFFS2 on there?
>
>
> Quoting Duy-Ky Nguyen <duykynguyen@hotmail.com>:
>
>> Dear Wolfgang Denk,
>>
>> I totally agree ramdisk filesystem is writable. However, for this
>> particular MPC8313E-RDB with FreeScale BSP Linux via LTIB (Linux
>> Traget Image Builder), based on the BSP document, I did try ramdisk
>> and unable to save change after power recycle. That's why I had to
>> try JFFS2 and it did save my change after power recycle .
>>
>> It's even more confusing when I tried to recreate ramdisk image
>> using LTIB and found ramdisk is of type EXT2, which is writable
>> filesystem !?!?
>>
>> Best Regards,
>>
>> Duy-Ky
>>
>> ----- Original Message ----- From: <linuxppc-embedded-request@ozlabs.org>
>> To: <linuxppc-embedded@ozlabs.org>
>> Sent: Saturday, October 18, 2008 6:00 PM
>> Subject: Linuxppc-embedded Digest, Vol 50, Issue 31
>>
>>
>>> Send Linuxppc-embedded mailing list submissions to
>>> linuxppc-embedded@ozlabs.org
>>>
>>> To subscribe or unsubscribe via the World Wide Web, visit
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>> or, via email, send a message with subject or body 'help' to
>>> linuxppc-embedded-request@ozlabs.org
>>>
>>> You can reach the person managing the list at
>>> linuxppc-embedded-owner@ozlabs.org
>>>
>>> When replying, please edit your Subject line so it is more specific
>>> than "Re: Contents of Linuxppc-embedded digest..."
>>>
>>>
>>> Today's Topics:
>>>
>>>  1. Re: How can I make flash writeable? (Duy-Ky Nguyen)
>>>  2. Re: Cache control (Grant Likely)
>>>  3. Re: How can I make flash writeable? (Wolfgang Denk)
>>>  4. Related to Keypad Driver .... (Misbah khan)
>>>
>>>
>>> ----------------------------------------------------------------------
>>>
>>> Message: 1
>>> Date: Fri, 17 Oct 2008 18:19:38 -0700
>>> From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
>>> Subject: Re: How can I make flash writeable?
>>> To: <linuxppc-embedded@ozlabs.org>
>>> Message-ID: <BLU119-DAV13B797B2CC811E90F87406BB2D0@phx.gbl>
>>> Content-Type: text/plain; format=flowed; charset="iso-8859-1";
>>> reply-type=original
>>>
>>> Hi Mark,
>>>
>>> I guess you want to have RW filesystem for your Linux target.
>>> If that's the case you need to have root filesystem as JFFS2.
>>>
>>> There's a document MPC8313E-RDB BSP User's Guide comes with the 
>>> MPC8313E-RDB
>>> package.
>>> It has all info for several filesystems like NFS (network), Ramdisk
>>> (Read-Only), and JFFS2 (Read/Write)
>>>
>>> Regards,
>>>
>>> Duy-Ky
>>>
>>> ----- Original Message ----- From: 
>>> <linuxppc-embedded-request@ozlabs.org>
>>> To: <linuxppc-embedded@ozlabs.org>
>>> Sent: Friday, October 17, 2008 6:00 PM
>>> Subject: Linuxppc-embedded Digest, Vol 50, Issue 30
>>>
>>>
>>>> Send Linuxppc-embedded mailing list submissions to
>>>> linuxppc-embedded@ozlabs.org
>>>>
>>>> To subscribe or unsubscribe via the World Wide Web, visit
>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>> or, via email, send a message with subject or body 'help' to
>>>> linuxppc-embedded-request@ozlabs.org
>>>>
>>>> You can reach the person managing the list at
>>>> linuxppc-embedded-owner@ozlabs.org
>>>>
>>>> When replying, please edit your Subject line so it is more specific
>>>> than "Re: Contents of Linuxppc-embedded digest..."
>>>>
>>>>
>>>> Today's Topics:
>>>>
>>>>  1. Re: How can I make flash writeable? (Mark Bishop)
>>>>  2. Re: How can I make flash writeable? (Marco Stornelli)
>>>>  3. Re: Loadable module crashes at kernel stack overflow or
>>>>     machine check (Ben Gardiner)
>>>>  4. Re: Oops in during system run (Scott Wood)
>>>>
>>>>
>>>> ----------------------------------------------------------------------
>>>>
>>>> Message: 1
>>>> Date: Fri, 17 Oct 2008 08:33:52 -0400
>>>> From: Mark Bishop <mark@bish.net>
>>>> Subject: Re: How can I make flash writeable?
>>>> To: linuxppc-embedded@ozlabs.org
>>>> Message-ID: <20081017083352.hvn0g2q1es8skcwg@www.bish.net>
>>>> Content-Type: text/plain; charset=ISO-8859-1; DelSp="Yes";
>>>> format="flowed"
>>>>
>>>>
>>>>
>>>> Ok, so bear with me.  I've read booting-without-of.txt in the
>>>> Documentation/powerpc directory and I modified a .dts file but now 
>>>> what?
>>>>
>>>> I use ltib or u-boot to load that into the device or do I roll a
>>>> kernel with that file and flash the device with it?
>>>>
>>>> Apologies for the less than technical questions.
>>>>
>>>> Quoting Marco Stornelli <marco.stornelli@coritel.it>:
>>>>
>>>>> Hi Mark,
>>>>>
>>>>>> How can I tell which devices are mapped to /proc/mtd devices?
>>>>>
>>>>> If I well understand the question, you'd like to change the partitions
>>>>> layout (?), so you should check out the dts file to see the flash
>>>>> layout, then you can specify there the partitions and change the
>>>>> dimensions, if they are read-only...and so on.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Mark Bishop ha scritto:
>>>>>> I am using the MPC8313E-RDB and I am having some problems using the
>>>>>> flash that comes on the board.  Let me preface this by saying that I
>>>>>> haven't worked in the embedded linux arena in about 10 years so I am
>>>>>> trying to catch up with all the new toys.
>>>>>>
>>>>>> This board uses uBoot and it currently has 128M of DDR2, 8M flash and
>>>>>> 32M NAND Flash.  I have a few questions:
>>>>>>
>>>>>> How can I tell which memory device it uses to boot out of?
>>>>>> How can I tell which devices are mapped to /proc/mtd devices?
>>>>>>
>>>>>>
>>>>>> I want to create a writeable flash partition, is there a FAQ out 
>>>>>> there I
>>>>>> could look at.
>>>>>>
>>>>>> All of this is after a few days of using Google to try and glean some
>>>>>> data from the internet.  And the books don't get here from Amazon 
>>>>>> until
>>>>>> Monday.
>>>>>>
>>>>>> I would appreciate any help.  Even a RTFM - if you could point me to
>>>>>> TFM, it would greatly help.
>>>>>> _______________________________________________
>>>>>> Linuxppc-embedded mailing list
>>>>>> Linuxppc-embedded@ozlabs.org
>>>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>>>
>>>>>
>>>>> --
>>>>> Marco Stornelli
>>>>> Embedded Software Engineer
>>>>> CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
>>>>> http://www.coritel.it
>>>>>
>>>>> marco.stornelli@coritel.it
>>>>> +39 06 72582838
>>>>>
>>>>>
>>>>
>>>>
>>>>
>>>> ------------------------------
>>>>
>>>> Message: 2
>>>> Date: Fri, 17 Oct 2008 15:13:58 +0200
>>>> From: Marco Stornelli <marco.stornelli@coritel.it>
>>>> Subject: Re: How can I make flash writeable?
>>>> To: Mark Bishop <mark@bish.net>
>>>> Cc: linuxppc-embedded@ozlabs.org
>>>> Message-ID: <48F88F96.3000804@coritel.it>
>>>> Content-Type: text/plain; charset=us-ascii
>>>>
>>>> You have to compile it with the dtc compiler and load it with the uboot
>>>> bootm command, indeed, (at least with a recent uboot version) it has
>>>> three parameters: kernel, dtb (the name of dts compiled) and initrd. If
>>>> you want you can store the dtb in flash.
>>>>
>>>> Regards,
>>>>
>>>> Mark Bishop ha scritto:
>>>>>
>>>>>
>>>>> Ok, so bear with me.  I've read booting-without-of.txt in the
>>>>> Documentation/powerpc directory and I modified a .dts file but now 
>>>>> what?
>>>>>
>>>>> I use ltib or u-boot to load that into the device or do I roll a 
>>>>> kernel
>>>>> with that file and flash the device with it?
>>>>>
>>>>> Apologies for the less than technical questions.
>>>>>
>>>>> Quoting Marco Stornelli <marco.stornelli@coritel.it>:
>>>>>
>>>>>> Hi Mark,
>>>>>>
>>>>>>> How can I tell which devices are mapped to /proc/mtd devices?
>>>>>>
>>>>>> If I well understand the question, you'd like to change the 
>>>>>> partitions
>>>>>> layout (?), so you should check out the dts file to see the flash
>>>>>> layout, then you can specify there the partitions and change the
>>>>>> dimensions, if they are read-only...and so on.
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Mark Bishop ha scritto:
>>>>>>> I am using the MPC8313E-RDB and I am having some problems using the
>>>>>>> flash that comes on the board.  Let me preface this by saying that I
>>>>>>> haven't worked in the embedded linux arena in about 10 years so I am
>>>>>>> trying to catch up with all the new toys.
>>>>>>>
>>>>>>> This board uses uBoot and it currently has 128M of DDR2, 8M flash 
>>>>>>> and
>>>>>>> 32M NAND Flash.  I have a few questions:
>>>>>>>
>>>>>>> How can I tell which memory device it uses to boot out of?
>>>>>>> How can I tell which devices are mapped to /proc/mtd devices?
>>>>>>>
>>>>>>>
>>>>>>> I want to create a writeable flash partition, is there a FAQ out 
>>>>>>> there
>>>>>>> I
>>>>>>> could look at.
>>>>>>>
>>>>>>> All of this is after a few days of using Google to try and glean 
>>>>>>> some
>>>>>>> data from the internet.  And the books don't get here from Amazon 
>>>>>>> until
>>>>>>> Monday.
>>>>>>>
>>>>>>> I would appreciate any help.  Even a RTFM - if you could point me to
>>>>>>> TFM, it would greatly help.
>>>>>>> _______________________________________________
>>>>>>> Linuxppc-embedded mailing list
>>>>>>> Linuxppc-embedded@ozlabs.org
>>>>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>>>>
>>>>>>
>>>>>> -- 
>>>>>> Marco Stornelli
>>>>>> Embedded Software Engineer
>>>>>> CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
>>>>>> http://www.coritel.it
>>>>>>
>>>>>> marco.stornelli@coritel.it
>>>>>> +39 06 72582838
>>>>>>
>>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Linuxppc-embedded mailing list
>>>>> Linuxppc-embedded@ozlabs.org
>>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>>
>>>>
>>>> -- 
>>>> Marco Stornelli
>>>> Embedded Software Engineer
>>>> CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
>>>> http://www.coritel.it
>>>>
>>>> marco.stornelli@coritel.it
>>>> +39 06 72582838
>>>>
>>>>
>>>> ------------------------------
>>>>
>>>> Message: 3
>>>> Date: Fri, 17 Oct 2008 09:12:07 -0400
>>>> From: Ben Gardiner <BenGardiner@nanometrics.ca>
>>>> Subject: Re: Loadable module crashes at kernel stack overflow or
>>>> machine check
>>>> To: Ganesh Kumar N M <ganeshkumar@signal-networks.com>
>>>> Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
>>>> Message-ID: <48F88F27.4040107@nanometrics.ca>
>>>> Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
>>>>
>>>> Ganesh Kumar N M wrote:
>>>>> *Hi All,*
>>>>> **
>>>>> *    I'm working on MPC860 with Montavista linux 2.4.18*
>>>>> *We have a Linux kernel loadable module which on loading*
>>>>> *panicks after some random time say 8 hours, 4 hours or so*
>>>>> *the oops outputs say either machine check exception or *
>>>>> *kernel stack overflow (randomly both show up) a**re as below:*
>>>> I don't know for sure what could be causing your problem. I can only
>>>> suggest some patches that have helped us in the past.
>>>>
>>>> I'm not familiar with Montavista's kernel versions; but I know our
>>>> 2.4.24 kernel did not have the 'separate I-TLB error and miss handling'
>>>> patch (
>>>> http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html  
>>>> )
>>>> which caused our applications to segfault for not apparent reason.
>>>>
>>>> I also suggest applying the CPU15 fix (
>>>> http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commit;h=baf9a6caca75b1f338ae370669e5882809000164
>>>> and
>>>> http://git.denx.de/?p=linuxppc_2_4_devel.git;a=commit;h=3ad403717f1d9c6a09ec41a5b016ac5245591122
>>>> ) and enabling it temporarily to see if the problem could be the 
>>>> unlucky
>>>> placement of a branch instruction at the end of a page; but evaluate 
>>>> the
>>>> performance of your application carefully if you are considering 
>>>> running
>>>> production code with the patch enabled as it introduces significant
>>>> overhead.
>>>>
>>>> Regards,
>>>>
>>>> Ben Gardiner
>>>> Nanometrics Seismological Instruments
>>>> 250 Herzberg Rd., Kanata, ON, CA, K2K 2A1
>>>> -------------- next part --------------
>>>> An HTML attachment was scrubbed...
>>>> URL:
>>>> <http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20081017/ba2e605f/attachment.html>
>>>>
>>>> ------------------------------
>>>>
>>>> Message: 4
>>>> Date: Fri, 17 Oct 2008 10:21:32 -0500
>>>> From: Scott Wood <scottwood@freescale.com>
>>>> Subject: Re: Oops in during system run
>>>> To: Sreejith <sreejithmm@tataelxsi.co.in>
>>>> Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
>>>> Message-ID: <20081017152129.GA19584@ld0162-tx32.am.freescale.net>
>>>> Content-Type: text/plain; charset=us-ascii
>>>>
>>>> On Fri, Oct 17, 2008 at 03:49:12PM +0530, Sreejith wrote:
>>>>> This is a peculiar Oops we are encountering during the running of our
>>>>> board
>>>>> (sh4) architecture
>>>>
>>>> So why are you posting to powerpc lists?
>>>>
>>>>> PC  : 844240f8 SP  : 88d1ff44 SR  : 400080f0 TEA : c0169d64 
>>>>> Tainted: P
>>>>
>>>> With proprietary modules, too.
>>>>
>>>>> Give you valuable suggestions!!
>>>>
>>>> Debug the code?
>>>> Switch to powerpc? :-)
>>>>
>>>> -Scott
>>>>
>>>>
>>>> ------------------------------
>>>>
>>>> _______________________________________________
>>>> Linuxppc-embedded mailing list
>>>> Linuxppc-embedded@ozlabs.org
>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>
>>>> End of Linuxppc-embedded Digest, Vol 50, Issue 30
>>>> *************************************************
>>>>
>>>
>>>
>>>
>>> ------------------------------
>>>
>>> Message: 2
>>> Date: Sat, 18 Oct 2008 00:32:47 -0600
>>> From: Grant Likely <grant.likely@secretlab.ca>
>>> Subject: Re: Cache control
>>> To: Robert Woodworth <rwoodworth@securics.com>
>>> Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
>>> Message-ID: <20081018063246.GA5594@secretlab.ca>
>>> Content-Type: text/plain; charset=us-ascii
>>>
>>> On Thu, Oct 16, 2008 at 09:57:27AM -0600, Robert Woodworth wrote:
>>>> I have a Virtex4 VF60 device with 256MB DDR2.
>>>>
>>>> I have told the Linux kernel that the device has only 128MB and its
>>>> working fine.  There is an HDL module that is populating the next 16MB
>>>> with sensor data (0x08000000 - 0x09000000)  I mapped the area into my
>>>> driver via `ioremap()` and also via `mmap / remap_pfn_range()`  It 
>>>> works
>>>> fine.
>>>>
>>>> I know that PPC cache regions work in 128MB blocks.  I assume that the
>>>> kernel bootup is turning on cache in the first 128, because it thinks
>>>> that its the full RAM range, and not cached in the next 128MB.
>>>
>>> That's only true when the MMU is off.  Linux runs with the MMU on and
>>> the TLB entries specify the caching per mapping.
>>>
>>>> I know that if I declare the area cached, and invalidate the region
>>>> before I read it,  the reads should be much faster than if it's not
>>>> cached.
>>>
>>> Correct.
>>>
>>>> How can I control if the area is cached? and then invalidate it when 
>>>> new
>>>> data arrives?
>>>>
>>>> Is there a PPC/Linux API call to declare the region cached and
>>>> invalidate regions before read?
>>>
>>> Take a look at dma_alloc_coherent() and related functions.
>>>
>>> Cheers,
>>> g.
>>>
>>>
>>>
>>> ------------------------------
>>>
>>> Message: 3
>>> Date: Sat, 18 Oct 2008 09:53:16 +0200
>>> From: Wolfgang Denk <wd@denx.de>
>>> Subject: Re: How can I make flash writeable?
>>> To: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
>>> Cc: linuxppc-embedded@ozlabs.org
>>> Message-ID: <20081018075316.11AB0835697A@gemini.denx.de>
>>> Content-Type: text/plain; charset=ISO-8859-1
>>>
>>> Dear "Duy-Ky Nguyen",
>>>
>>> In message <BLU119-DAV13B797B2CC811E90F87406BB2D0@phx.gbl> you wrote:
>>>>
>>>> I guess you want to have RW filesystem for your Linux target.
>>>> If that's the case you need to have root filesystem as JFFS2.
>>>
>>> This is not correct. You can use a read-only root file system combined
>>> with additionala ,writable file systems.
>>>
>>>> There's a document MPC8313E-RDB BSP User's Guide comes with the
>>>> MPC8313E-RDB
>>>> package.
>>>> It has all info for several filesystems like NFS (network), Ramdisk
>>>> (Read-Only), and JFFS2 (Read/Write)
>>>
>>> That's incorrect, either. A ramdisk is usually writable (unless you
>>> mount it read-only, which would be very unusuak).
>>>
>>> See also
>>> http://www.denx.de/wiki/view/DULG/RootFileSystemDesignAndBuilding
>>>
>>> Best regards,
>>>
>>> Wolfgang Denk
>>>
>>> -- 
>>> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
>>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>>> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
>>> To get something done, a committee should consist  of  no  more  than
>>> three men, two of them absent.
>>>
>>>
>>> ------------------------------
>>>
>>> Message: 4
>>> Date: Sat, 18 Oct 2008 08:26:07 -0700 (PDT)
>>> From: Misbah khan <misbah_khan@engineer.com>
>>> Subject: Related to Keypad Driver ....
>>> To: linuxppc-embedded@ozlabs.org
>>> Message-ID: <20047836.post@talk.nabble.com>
>>> Content-Type: text/plain; charset=us-ascii
>>>
>>>
>>> Hi all ...
>>>
>>> If any of you have worked on key pad driver could you please guide me 
>>> how to
>>> write the same as in the most standard form ...
>>>
>>> I have a CPLD from Whre i have to read the key physical status 
>>> (debouncing
>>> logic in CPLD itself) on interrupt this i have to pass to the 
>>> application
>>> which ever is using keys for its operation and control ....
>>>
>>> The concern is this ...
>>>
>>>
>>> What could the best way of passing the virtual key status to the 
>>> application
>>> and how it is done in linux drivers ???? How should i make the API 
>>> waiting
>>> for Key event and Getting Unblocked ???? Can i make the API as a thread
>>> waiting for signal ??? The same API application could use ... How is it 
>>> done
>>> in Standard Keyboard Drivers ???
>>>
>>> A code snipped or Documentation would really help me ...
>>>
>>>
>>> I am not sure what way i should proceed ...If any one implemented a 
>>> Keypad
>>> driver or can suggest your experience
>>>
>>>
>>> Thanks in Advance ...
>>>
>>> Misbah <><
>>> -- 
>>> View this message in context:
>>> http://www.nabble.com/Related-to-Keypad-Driver-....-tp20047836p20047836.html
>>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>>>
>>>
>>>
>>> ------------------------------
>>>
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
>>> End of Linuxppc-embedded Digest, Vol 50, Issue 31
>>> *************************************************
>>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
>
>
>
> ------------------------------
>
> Message: 2
> Date: Mon, 20 Oct 2008 19:12:57 +0200
> From: Wolfram Sang <w.sang@pengutronix.de>
> Subject: [PATCH] [MPC52XX] gpio: remove dead code
> To: linuxppc-embedded@ozlabs.org
> Message-ID: <20081020171257.GC4362@pengutronix.de>
> Content-Type: text/plain; charset="us-ascii"
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> arch/powerpc/platforms/52xx/mpc52xx_gpio.c |    3 ---
> 1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c 
> b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> index 8a455eb..07f89ae 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> @@ -363,11 +363,8 @@ static int mpc52xx_gpt_gpio_get(struct gpio_chip *gc, 
> unsigned int gpio)
> {
>  struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
> - unsigned int ret;
>
>  return (in_be32(&regs->status) & (1 << (31 - 23))) ? 1 : 0;
> -
> - return ret;
> }
>
> static void
> -- 
> 1.5.6.5
>
> -- 
>  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
> Pengutronix - Linux Solutions for Science and Industry
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: not available
> Type: application/pgp-signature
> Size: 197 bytes
> Desc: Digital signature
> URL: 
> <http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20081020/449aa59d/attachment-0001.pgp>
>
> ------------------------------
>
> Message: 3
> Date: Mon, 20 Oct 2008 12:01:35 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> Subject: Re: [PATCH] [MPC52XX] gpio: remove dead code
> To: Wolfram Sang <w.sang@pengutronix.de>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <20081020180135.GA13667@secretlab.ca>
> Content-Type: text/plain; charset=us-ascii
>
> On Mon, Oct 20, 2008 at 07:12:57PM +0200, Wolfram Sang wrote:
>> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>
> Thanks, I'll pick this up.
>
>> ---
>>  arch/powerpc/platforms/52xx/mpc52xx_gpio.c |    3 ---
>>  1 files changed, 0 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c 
>> b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
>> index 8a455eb..07f89ae 100644
>> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
>> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
>> @@ -363,11 +363,8 @@ static int mpc52xx_gpt_gpio_get(struct gpio_chip 
>> *gc, unsigned int gpio)
>>  {
>>  struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>>  struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
>> - unsigned int ret;
>>
>>  return (in_be32(&regs->status) & (1 << (31 - 23))) ? 1 : 0;
>> -
>> - return ret;
>>  }
>>
>>  static void
>> -- 
>> 1.5.6.5
>>
>> -- 
>>   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
>>  Pengutronix - Linux Solutions for Science and Industry
>
>
>
>
> ------------------------------
>
> Message: 4
> Date: Mon, 20 Oct 2008 21:42:41 +0200
> From: "Peter Scott" <peter.scott@ericsson.com>
> Subject: Xilininx GPIO
> To: <linuxppc-embedded@ozlabs.org>
> Message-ID:
> <425A3BC99494A4409BEF99524478ED52092E7F36@esealmw103.eemea.ericsson.se>
>
> Content-Type: text/plain; charset="us-ascii"
>
> Hello there,
>
> I am having difficulties with some xilinx gpios and the xilinx-2.6-xlnx
> kernel. As far as I can tell the kernel is configured correctly for
> gpio.
>
> I can see that the module_init function "xgpio_init" is called, and that
> bus_add_driver and driver_add_groups returns without error. But I cannot
> see that the probe function is called.  /proc/misc doesnt list a driver
> for the gpios. I am not sure where to go next as there is no error
> printouts.
>
> I have seen other peoples consoles stating that the gpio is mapped to xx
> but this doesn't happen for me.
>
> I am using the default bit file for the ml507 board, and have created
> device files
> /dev/xgpio0
> /dev/xgpio1 etc with major 10 and minor 185
>
> However if I try to open these devices the open fails.
>
> I would rally appreciate it if someone could give me some pointers as to
> what to look for, or how a to go about debugging this.
>
> Many thanks
> Peter Scott
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: 
> <http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20081020/4f4d2dac/attachment.htm>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> End of Linuxppc-embedded Digest, Vol 50, Issue 33
> *************************************************
> 
