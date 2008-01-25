Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DABB6DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Jan 2008 00:04:33 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JIOEP-0007OH-EY
	for linuxppc-embedded@ozlabs.org; Fri, 25 Jan 2008 05:04:29 -0800
Message-ID: <15087192.post@talk.nabble.com>
Date: Fri, 25 Jan 2008 05:04:29 -0800 (PST)
From: greenlean <jmgomez@atc.ugr.es>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ml310 kernel2.6 booting problems
In-Reply-To: <fa686aa40801160650u6c5f35d9m325a87bc8482475f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <537566320@web.de>
	<fa686aa40801160650u6c5f35d9m325a87bc8482475f@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'm also having some problem with my systemace file system. I'm working with
secretlab git, and I try to mount the CF card with xsysace and with xsa, but
in both cases it can't mount the rootfs:

Linux/PPC load: console=ttyS0,9600 root=/dev/xsa3 rw  
:
:
:
[    2.777706] xsysace xsysace.0: Xilinx SystemACE revision 1.0.12              
[    2.849967] xsysace xsysace.0: capacity: 986320 sectors                      
[    2.913383]  xsa: unknown partition table       
:
:
[    3.398810] Please append a correct "root=" boot option; here are the
availa:
[    3.499476] fe00     493160 xsa (driver?)                                    
[    3.547926] Kernel panic - not syncing: VFS: Unable to mount root fs on
unkn)

Does this mean that I have configured incorrectly the file system options in
the kernel??
I have read that the solution to this is to change the DOS/FAT/NT Filesystem
option to the below configuration:

      <*> Second extended fs support 
DOS/FAT/NT Filesystems
       < > MSDOS fs support                                            
       < > VFAT (Windows-95) fs support                                
       < > NTFS file system support 
  [*] Advanced partition selection                                
         [*]   PC BIOS (MSDOS partition tables) support 
I've already tested this configuration:

      <*> Second extended fs support 
DOS/FAT/NT Filesystems
       <*> MSDOS fs support                                            
       <*> VFAT (Windows-95) fs support                                
       < > NTFS file system support 
  [] Advanced partition selection                                
     

My CF card has the following structure:

Disco /dev/sdc: 521 MB, 521773056 bytes
16 cabezas, 63 sectores/pistas, 1011 cilindros
Unidades = cilindros de 1008 * 512 = 516096 bytes
Disk identifier: 0x00000000

Disposit. Inicio    Comienzo      Fin      Bloques  Id  Sistema
/dev/sdc1               1         400      201568+   6  FAT16
/dev/sdc2             401         500       50400   82  Linux swap / Solaris
/dev/sdc3             501        1011      257544   83  Linux

I'm also wondering if I should use xsysace or xsa, because I have search in
the file xsysace.c for the name of the device and It is named as xsysace. Am
I right, and should I use xsysace? Or this name isn't related with the /dev
file??
$ grep xsysace xsysace.c

        .name = "xsysace",
        ace_major = register_blkdev(ace_major, "xsysace");
                printk(KERN_WARNING "xsysace: register_blkdev() failed\n");
        unregister_blkdev(ace_major, "xsysace");

I'm going to reformat my CF card and test it,maybe the partition table is
corrupted, but fdisk is not saying anything at all.

Thanks


Grant Likely-2 wrote:
> 
> On 1/16/08, Joachim Meyer <Jogi95@web.de> wrote:
>> Hi
>>
>> I made an Ace file with my Kernel and load it with the Flash Card.
>> I made the Initial release CF image on the card and copied my ace file in
>> an folder, from which I boot with the DIP-Switch.
>> If I used
>> "console=ttyUL0 ,9600 root=/dev/xsysace/disc0/part2 rw "
> 
> try root=/dev/xsa2
> Also, the ',9600' is unnecessary with the uartlite.
> 
>>
>> I tried to use this:
>> "console=ttyUL0 ,9600 root=fe02 rw"
>> and with this, after making ace-file etc. I get:
>> [   12.862678] EXT3 FS on xsa2, internal journal
>> [   12.899229] EXT3-fs: recovery complete.
>> [   12.982635] EXT3-fs: mounted filesystem with ordered data mode.
>> [   13.038505] VFS: Mounted root (ext3 filesystem).
>> [   13.094113] Freeing unused kernel memory: 96k init
>> [   13.159079] Warning: unable to open an initial console.
> 
> You're probably missing the /dev/console device file
> 
> g.
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/ml310-kernel2.6-booting-problems-tp14881983p15087192.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
