Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr14.xs4all.nl (smtp-vbr14.xs4all.nl [194.109.24.34])
	by ozlabs.org (Postfix) with ESMTP id A1564DDE32
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Oct 2007 01:35:21 +1000 (EST)
Message-ID: <4706577C.8030806@aimvalley.nl>
Date: Fri, 05 Oct 2007 17:25:48 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, linux-mtd@lists.infradead.org
Subject: jedec probe for AMD/Spansion flash (16 bit) device in 8 bit mode fails
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My board has a regular AMD/Spansion compatible flash device. It's a
Spansion S29AL016D (2MB) which supports 8/16 bit access.
We use it in 8 bit and top boot block mode.

I thought the linux kernel would have no problem recognizing/supporting this
(regular) flash device. I was wrong.

The S29AL016D/AM29LV160DT datasheet says the following:

                                   first     second    third     fourth (read)
                                   addr/data addr/data addr/data addr/data
Manufacturer ID, word             555/AA    2AA/55    555/90    X00/01
                  byte             AAA/AA    555/55    AAA/90    X00/01
Device ID (top boot block), word  555/AA    2AA/55    555/90    X01/22C4
                             byte  AAA/AA    555/55    AAA/90    X02/C4

Unfortunately the linux kernel does not recognize the chip.
The jedec_probe_chip function fails to recognize the chip, even though it's
present in the jedec_table[], the is the entry that represents the S29AL016D
(the S29AL016D is comptabile with AM29LV160DT):

                 .mfr_id         = MANUFACTURER_AMD,
                 .dev_id         = AM29LV160DT,
                 .name           = "AMD AM29LV160DT",
                 .uaddr          = {
                         [0] = MTD_UADDR_0x0AAA_0x0555,  /* x8 */
                         [1] = MTD_UADDR_0x0555_0x02AA   /* x16 */
                 },
                 .DevSize        = SIZE_2MiB,
                 .CmdSet         = P_ID_AMD_STD,
                 .NumEraseRegions= 4,
                 .regions        = {
                         ERASEINFO(0x10000,31),
                         ERASEINFO(0x08000,1),
                         ERASEINFO(0x02000,2),
                         ERASEINFO(0x04000,1)
                 }

The above jedec_table entry seems to be correct and it should be the one to
find/match.

The problem when probing if "cfi->interleave=1 and cfi->device_type=2 (x16)" is
that the device is not put into autoselect mode properly.
This is because the unlock addresses are multiplied with the cfi->device_type
(this is done by cfi_build_cmd_addr) and thus the autoselect mode
(for MTD_UADDR_0x0AAA_0x0555,  /* x8 */) is entered by writing:
address=0x1554, data=0xaa
address=0x0aaa, data=0x55
address=0x1554, data=0x90

This fails to put the chip into autoselect mode.
Here's the kernel corresponding kernel console output:
reset unlock called aaa 555
Search for id:(0a 00) interleave(1) type(2)
Note that 0a 00 is ordinary data.

Other unlock addresses (2aa 555 and 555 aaa) do get the device in autoselect mode,
but now there are two other problems which make jedec_match fail:
-1- the following code from jedec_match makes matching always fail for any x16
     device in x8 mode ?
         if ( cfi->mfr != mfr) || cfi->id != id ) {
                 goto match_done;
         }
id is 16 bit (0x22c4), so it won't match 0xc4.

-2- the unlock address is wrong. Here's the corresponding kernel console output:
reset unlock called 555 2aa
Search for id:(01 c4) interleave(1) type(2)
MTD jedec_match(): Check fit 0x00000000 + 0x00200000 = 0x00200000
MTD jedec_match(): check unlock addrs 0x0555 0x02aa
MTD jedec_match(): 0x0aaa 0x0555 did not match 0x0555 0x02aa
reset unlock called 555 aaa
Search for id:(01 c4) interleave(1) type(2)
MTD jedec_match(): Check fit 0x00000000 + 0x00200000 = 0x00200000
MTD jedec_match(): check unlock addrs 0x0555 0x0aaa
MTD jedec_match(): 0x0aaa 0x0555 did not match 0x0555 0x0aaa

It wants to match with unlock address 0x0aaa 0x0555 (because this is the one
listed in the jedec_table[] entry for cfi->device_type=2=x16) and both pair
of unlock addresses (which do get the chip in autoselect mode) do not match.


I'm not sure whether the kernel should recognize the chip as 8 or 16 bit, I
guess 16 bit. Let me anyway discuss the 8 bit case also.

The problem when probing if "cfi->interleave=1 and cfi->device_type=1 (x8)" is
twofold:
-1- device id is not read correctly. After putting the device in "Autoselect Mode"
     the device id is read from address 1 (it should be 2). This makes the device id
     equal to the manufacture id. Here's the corresponding kernel console output:
reset unlock called aaa 555
Search for id:(01 01) interleave(1) type(1)

-2- even if the device id and manufacturer id would be read correctly the
     chip won't be recognized anyway since jedec_match has the following code:
                 /* bjd: it seems that if we do this, we can end up
                  * detecting 16bit flashes as an 8bit device, even though
                  * there aren't.
                  */
                 if (finfo->dev_id > 0xff) {
                         DEBUG( MTD_DEBUG_LEVEL3, "%s(): ID is not 8bit\n",
                                __func__);
                         goto match_done;

Because finfo->devid=AM29LV160DT=0x22C4 -> the ID is not 8 bit.


I'm sure I miss something. Our linux kernel is ancient (2.4.25) but more recent
linux kernel seem to have the same mtd/jedec code in this repect.

I anyone could help me pointing out what is wrong it would be great.

BR,
N. van Bolhuis.


Btw. is the linux mtd mailing list (linux-mtd@lists.infradead.org) still alive ?
      I couldn't reach the archives at http://lists.infradead.org/pipermail/linux-mtd/

-- 
This message has been scanned for viruses and is believed to be clean
