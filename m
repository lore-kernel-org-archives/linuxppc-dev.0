Mime-Version: 1.0 (Apple Message framework v612)
Message-Id: <935CBD11-6322-11D8-89E5-000A95B15278@aimsys.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-embedded@lists.linuxppc.org
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: usb hub problem on 8270
Date: Thu, 19 Feb 2004 22:28:35 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I found some time to adapt m8xxhci.c (for 823/850) to the 8270 with
limited success.
We use TOUT3 (from timer3) to DREQ0/1 to enable SOF transmitting which
works
more or less as one of my hubs is detected but after the host driver
received the hub's
device description, I get a time-out and, well that's it. Even after
resetting the 8270 and cpm
I'm unable to communicate to the hub:

m8xxhci: initializing controller
m8xxhci_setup()
usb.c: new USB bus registered, assigned bus number 1
m8xxhci_start_controller()
hp c0290000, immap f0000000, usbprmap f0008b00, usbregs f0011b60, cp
f00119c0
m8xxhci:MPC8270 mask 0
m8xxhci: USING CLK8 for USB clock!
m8xxhci: ring sizes: rx 32, tx 40
endpoint 0 0x140, epb f0000140
rstate f0008b08
set up tx ring @ c0290000
set up rx ring @ f0000170
tbptr 00000278
usep4190208 @ f0011b64
m8xxhci: assert reset
m8xxhci: enable USB controller
m8xxhci_timer_setup()
m8xxhci: timer, intfreq 266000000, busfreq 66660000, count 995
m8xxhci: timer bytes/count 1.28
m8xxhci: usb bus is idle
usb.c: kmalloc IF c026cb00, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB MPC8xx Root Hub
SerialNumber: f0011b60
hub.c: USB hub found
hub.c: 1 port detected
hub.c: standalone hub
hub.c: individual port power switching
hub.c: no over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: R
hub.c: local power source is good
hub.c: no over-current condition exists
rh_submit_urb() int pipe
hub.c: enabling power on all ports
rh_port_power(1)
usb.c: hub driver claimed interface c026cb00
m8xxhci: initializing done
idle_bus() 1; d+ one, d- zero, connect full-sp
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
rh_port_reset(1)
m8xxhci: assert reset
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device <NULL>-1, assigned address 2
usb.c: kmalloc IF c026cce0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Product: Standard USB Hub
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 100ms
hub.c: hub controller current requirement: 64mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c026cce0
complete_qe(qe=c02910fc,status=-110)
hub.c: nonzero status in irq -110


looking in /proc/driver/usb I see some timeouts:

USB host controller v1.2:
controller enabled
root hub port state connected, status CCS PES PPS
oe 1; bus 10 idle 1
ints: cpm 66, timer 367332, isrs 367385
       idle 66, rst 0, bsy 0, rxb 24, txb 46
errs: tx0 19, timeout 19, underrun 0
       rx  0, nak 0, stall 0, mismatch 0
comp: iso 0, intr 2, ctrl 14, bulk 0
root hub sends 1441
retransmits    19
tx restarts    19

frame lists: current c0294360, next c0294394
active_qe: 00000000
current: c0294360, total_bytes 0
next: c0294394, total_bytes 0
event message:
event logging: disabled

Nothing that is connected to the hub is detected (obviously)
Does somebody has had some similar problems with 8xx? Might it be
my SOF timing which is not accurate?

thanks for any advise,

Jaap-Jan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
