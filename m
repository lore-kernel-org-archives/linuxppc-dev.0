Message-Id: <200206171535.g5HFYw508095@p2.parker.boston.ma.us>
To: Marko Virkki <marko.virkki@mitron.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: USB naks and timeouts 
In-Reply-To: Your message of "Thu, 13 Jun 2002 16:54:05 +0200."
             <F03BD58073F0D311BF6F00105AB408D16B0EE3@MITRON>
Date: Mon, 17 Jun 2002 11:34:58 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Some devices are very sensitive to missing SOF frames; printk() will
shut of interrupts for longer than 1ms, sad to say, and can cause missing
SOF's which can cause devices to suspend.

Try hacking printk to not shut of interrupts and instead add some
code at the begining of printk which says "if (in_interrupt()) return;"

It's a hack, but it may fix your problem.  personally I'd like to see
a printk which managed two buffers and didn't shut of interrupts for
the entire call to vsprintf...

-brad


Marko Virkki wrote:
>
>Hello
>
>Has anyone seen a lot of get_port_status timeouts and tx errors using USB in
>mpc823e? Can anyone explain what could be a reason for getting huge amount
>of nak and timeout errors? See /proc/driver/usb below. Bitlength and SOF
>frames seems to be OK. The RXD signal from PDIUSB11A follows exactly the
>state of the USB bus and there seems not to be delay more than 5-6 ns
>between rxp/rxn and rxd.
>
>I've got the USB working a little bit on our custom board with a slightly
>modified MVL2.1 embeddedplanet_rpxlite 2.4.17 kernel. I can get data for
>example by cat:ing  mouse0 in /dev/input. The mouse is connected through the
>hub in Cherry 3000 USB keyboard. The keyboard seems to work also (expect
>those get_port_status timeouts).
>
>I can also connect 32M IBM Memory Key to USB but I'm not able to mount the
>disk. See console capture below. I will not get errors at all when
>connecting this device directly to the bus but the system hangs. If I
>connect this device through the hub in keyboard the system will reset the
>port of hub as soon as I press key on console keyboard or do something else
>time consuming operation.
>
>TIA
>br. Marko
>
>
>
>-- booting --
>
>usb.c: registered new driver usbdevfs
>usb.c: registered new driver hub
>m8xxhci: initializing controller
>m8xxhci_setup()
>usb.c: new USB bus registered, assigned bus number 1
>m8xxhci_start_controller()
>m8xxhci: MPC823e (mask 1)
>m8xxhci: USING BRG3 (sysclk) for USB clock!
>m8xxhci: ring sizes: rx 32, tx 40
>m8xxhci: assert reset
>m8xxhci: enable USB controller
>m8xxhci_timer_setup()
>m8xxhci: timer, intfreq 48005120, busfreq 48005120, count 3000
>m8xxhci: USING TIMER1 FOR SOF!
>m8xxhci: timer1 started
>m8xxhci: usb bus is NOT idle
>Product: USB MPC8xx Root Hub
>SerialNumber: ff000a00
>hub.c: USB hub found
>hub.c: 1 port detected
>rh_submit_urb() int pipe
>rh_port_power(1)
>m8xxhci: initializing done
>usb.c: registered new driver hiddev
>usb.c: registered new driver hid
>hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
>hid-core.c: USB HID support drivers
>Initializing USB Mass Storage driver...
>usb.c: registered new driver usb-storage
>USB Mass Storage support registered.
>mice: PS/2 mouse device common for all mice
>
>-- Cherry 3000 connected --
>
>rh_port_reset(1)
>m8xxhci: assert reset
>hub.c: USB new device connect on bus1/1, assigned device number 12
>hub.c: USB hub found
>hub.c: 5 ports detected
>hub.c: get_port_status failed (err = -110)
>hub.c: USB new device connect on bus1/1/4, assigned device number 13
>input0: USB HID v0.01 Keyboard [046a:0001] on usb1:13.0
>handle_scancode(scancode=0x23, down=1)
>handle_scancode(scancode=0x22, down=0)
>hub.c: get_port_status failed (err = -110)              <<<<<<<<
>handle_scancode(scancode=0x21, down=0)
>
>-- IBM Memory key connected directly to USB bus
>
>rh_port_reset(1)
>m8xxhci: assert reset
hub.c: USB new device connect on bus1/1, assigned device number 2
>Manufacturer: IBM
>Product: IBM USB Memory Key
>scsi0 : SCSI emulation for USB Mass Storage devices
>  Vendor: IBM       Model: IBM USB Memory K  Rev: 0100
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
>
>[/]#
>[/]# mount -t vfat /dev/sda1 /mnt/memkey/
>-ENOENT
>-ENOENT
>-ENOENT
>
>I've added these ENOENT printks in transport.c line 1124.
>
>-- IBM Memory key connected to USB bus via Cherrys hub
>
>hub.c: USB new device connect on bus1/1/5, assigned device number 4
>Manufacturer: IBM
>Product: IBM USB Memory Key
>scsi0 : SCSI emulation for USB Mass Storage devices
>  Vendor: IBM       Model: IBM USB Memory K  Rev: 0100
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
>sda : READ CAPACITY failed.
>sda : status = 0, message = 00, host = 7, driver = 00
>sda : sense not available.
>sda : block size assumed to be 512 bytes, disk size 1GB.
>Partition check:
> sda:<7>usb-storage: queuecommand() called
>SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
> I/O error: dev 08:00, sector 0
>SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
> I/O error: dev 08:00, sector 2
>SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
> I/O error: dev 08:00, sector 4
>SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
> I/O error: dev 08:00, sector 6
>SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
> I/O error: dev 08:00, sector 0
>SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
> I/O error: dev 08:00, sector 2
>SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
> I/O error: dev 08:00, sector 4
>SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 70000
> I/O error: dev 08:00, sector 6
> unable to read partition table
>hub.c: already running port 5 disabled by hub (EMI?), re-enabling...
>usb.c: USB disconnect on device 4
>hub.c: USB new device connect on bus1/1/5, assigned device number 5
>Manufacturer: IBM
>Product: IBM USB Memory Key
>[/]#
>--- After a while
>[/]#
>hub.c: already running port 5 disabled by hub (EMI?), re-enabling...
>usb.c: USB disconnect on device 5
>hub.c: USB new device connect on bus1/1/5, assigned device number 6
>usb.c: USB device not accepting new address=6 (error=-110)
>[/]# hub.c: USB new device connect on bus1/1/5, assigned device number 7
>Manufacturer: IBM
>Product: IBM USB Memory Key
>-------------------------------------------------------
>
>
>
>cat /proc/driver/usb
>
>SB host controller v1.2:
>controller enabled
>root hub port state connected, status CCS PES PPS
>ints: cpm 118083, timer 665788, isrs 783871
>      idle 118083, rst 12, bsy 0, rxb 15459, txb 45831
>errs: tx0 72213, timeout 581, underrun 0
>      rx  0, nak 71632, stall 0, mismatch 0
>comp: iso 0, intr 2612, ctrl 15297, bulk 60
>root hub sends 2669
>retransmits    581
>tx restarts    72213
>
>frame lists: current c01ec594, next c01ec560
>active_qe: 00000000
>current: c01ec594, total_bytes 0
>next: c01ec560, total_bytes 0
>
>###########################################
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
