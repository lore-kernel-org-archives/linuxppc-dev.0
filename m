Date: Sun, 16 Jul 2000 11:26:39 -0400
From: Dan Foster <dsf@gblx.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: dsf@gblx.net
Subject: G4/500 cannot finish booting kernel - IDE and USB (strange)
Message-ID: <20000716112639.A2970@frontiernet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy!
	I have a G4/500 with two Maxtor EIDE drives, one DVD-RAM drive, an
ATI Rage 128, built in GMAC(?) Ethernet, an Adaptec 2940UW SCSI controller
for the external HP CD-RW (9210e), the Apple USB Keyboard and a Microsoft
IntelliExplorer USB mouse hooked up to it.

	I can not get the kernel to fully boot; it seems to die when it
tries to detect the DVD-RAM drive and somehow triggers an USB device
registration callback(!). It does not appear the kernel crashes; rather, it
seems to be hanging - waiting for something that will never happen. I say
this, because if I hit the power button on the machine, it brings up a
kernel crash trace on the screen quickly before it reboots. So the kernel is
indeed alive and doing...*something*.

	I've tried the latest of BenH's rsync sources - only a few hours old.
2.2.17pre10-ben2, from the looks of the Makefile.

	Sound seems to be broken right now, so I had to disable it to get
it to proceed further in the boot. Will investigate later. My config options
are almost identical to the .config in BenH's sources - only two or three
things turned on/off, such as the powerbook power management stuff. So,
it has everything essential enabled such as the new input layer, etc...
(and RAMdisk image is updated in /dev, too. Too bad it doesn't get that far.)

	I can stick in printk in the sources - I have an idea of how things
are being called by tracing the call chain in the source tree (block devices,
then character devices, and then following an #ifdef chain, etc...).

	At line 2236 of drivers/block/ide-cd.c is where it goes nutso:

        do { /* we seem to get stat=0x01,err=0x00 the first time (??) */
2236->          stat = cdrom_mode_sense(cdi, &cgc, GPMODE_CAPABILITIES_PAGE, 0);
                if (!stat)
                        break;
        } while (--attempts);
        return stat;

By nutso - I mean, it calls that function, and never hits the printk in
the next line (that I added).

and this is the function from drivers/cdrom/cdrom.c:

int cdrom_mode_sense(struct cdrom_device_info *cdi,
                     struct cdrom_generic_command *cgc,
                     int page_code, int page_control)
{
        struct cdrom_device_ops *cdo = cdi->ops;

        memset(cgc->cmd, 0, sizeof(cgc->cmd));

        cgc->cmd[0] = GPCMD_MODE_SENSE_10;
        cgc->cmd[2] = page_code | (page_control << 6);
        cgc->cmd[7] = cgc->buflen >> 8;
        cgc->cmd[8] = cgc->buflen & 0xff;
        return cdo->generic_packet(cdi, cgc);
}

Clearly it's building a command then executing it. Perhaps it's some kind
of drive-specific quirk in responding to it? But, I still can't quite explain
how this triggers USB device registration.

Here is the last 15 lines of boot messages, up to point where it hangs:

pmac_ide: enabling IDE bus ID 2
pmac_ide: enabling IDE bus ID 0
pmac_ide: enabling IDE bus ID 1
hda: Maxtor 51024U2, ATA DISK drive
hdb: Maxtor 54098U8, ATA DISK drive
hdc: MATSHITAPD-2 LF-D110, ATAPI CDROM drive
ide0 at 0x8e01f000-0x8e01f007,0x8e01f160 on irq 19
ide0 at 0x8e020000-0x8e020007,0x8e020160 on irq 20
hda: Enabling Ultra DMA 4
hda: Maxtor 51024U2, 9770MB w/2048kB Cache, CHS=19852/16/63, (U)DMA
hdb: Enabling Ultra DMA 4
hdb: Maxtor 54098U8, 39082MB w/2048kB Cache, CHS=4982/255/63, (U)DMA
hdc: Enabling MultiWord DMA 2
usb.c: USB new device connect, assigned device number 2
<and here it hangs>

	Any suggestions? I can insert printk at strategic places or to
print out values of anything in a key data structure like cdi, cgc, or
anything else that will help. Also, what is the sysrq key combo for an
Apple keyboard? I'd like to see what tasks it's executing at the time of
the hang.

	I'm afraid I don't know how to debug the low level CDROM/DVD drive
interactions, and know *nothing* about USB code or the protocol. Hoping
that someone here does :)

-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
