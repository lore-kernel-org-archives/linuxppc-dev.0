Return-Path: <jiehanca@yahoo.com.cn>
Received: from web15102.mail.cnb.yahoo.com (web15102.mail.cnb.yahoo.com
	[202.165.103.71]) by ozlabs.org (Postfix) with SMTP id 1826B67CE6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 18:00:35 +1000 (EST)
Message-ID: <20060823080034.78275.qmail@web15102.mail.cnb.yahoo.com>
Date: Wed, 23 Aug 2006 01:00:34 -0700 (PDT)
From: jie han <jiehanca@yahoo.com.cn>
Subject: help about configuring and initializing serial console under kernel
	2.6.18-rc2
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 am trying to take a working embedded linux system
from kernel 2.4.24 to 
2.6.18. The hardware is a custom board using a MPC8270
processor.
The working system uses u-boot 1.1.4 with linux kernel
2.4.24.

I am using the same u-boot and I am trying to port
linux kernel 2.6.18 
to our platform. Tthe kernel seems to hang after being
uncompressed. Here is what I see after running bootm
from u-boot:

## Booting image at 00400000 ...
   Image Name:   Linux-2.6.18/Ocean BoradBand Ltd
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    995213 Bytes = 971.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x0FB73C38 => set upper limit
to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF3D
bd address  = 0x0FB73FB4
memstart    = 0x00000000
memsize     = 0x10000000
flashstart  = 0xFE000000
flashsize   = 0x02000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xF0000000
bootflags   = 0x00000001
vco         =    264 MHz
sccfreq     =     66 MHz
brgfreq     = 16.500 MHz
intfreq     =    198 MHz
cpmfreq     =    132 MHz
busfreq     =     66 MHz
ethaddr     = 00:13:09:00:01:04
IP addr     = 192.168.2.46
baudrate    =  19200 bps
No initrd
## Transferring control to Linux (at address 00000000)
...

I check the __log_buf buffer and found message as
follow
020c634: 20736368 6564756c 65722063 66712072    
scheduler cfq r
0020c644: 65676973 74657265 64202864 65666175   
egistered (defau
0020c654: 6c74290a 3c363e53 65726961 6c3a2043   
lt).<6>Serial: C
0020c664: 504d2064 72697665 72202452 65766973    PM
driver $Revis
0020c674: 696f6e3a 20302e30 3220240a 3c363e63    ion:
0.02 $.<6>c
0020c684: 706d5f75 6172743a 20574152 4e494e47   
pm_uart: WARNING
0020c694: 3a206e6f 20554152 54206465 76696365    : no
UART device
0020c6a4: 7320666f 756e6420 6f6e2070 6c617466    s
found on platf
0020c6b4: 6f726d20 62757321 0a3c363e 63706d5f    orm
bus!.<6>cpm_
0020c6c4: 75617274 3a207468 65206472 69766572    uart:
the driver
0020c6d4: 2077696c 6c206775 65737320 636f6e66     will
guess conf
0020c6e4: 69677572 6174696f 6e2c2062 75742074   
iguration, but t
0020c6f4: 68697320 6d6f6465 20697320 6e6f206c    his
mode is no l
0020c704: 6f6e6765 72207375 70706f72 7465642e    onger
supported.

I got a  result,I failed to initialize smc1 port,the
function is 
static int cpm_uart_init(void) --->dev =
bus_find_device(&platform_bus_type, NULL, 0,
match_is_uart),I always got dev == NULL,
how can I define struct platform_bus_type????????

My kernel config file about serial drivers as follow
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
# CONFIG_SERIAL_CPM_SCC1 is not set
# CONFIG_SERIAL_CPM_SCC2 is not set
# CONFIG_SERIAL_CPM_SCC3 is not set
# CONFIG_SERIAL_CPM_SCC4 is not set
CONFIG_SERIAL_CPM_SMC1=y
# CONFIG_SERIAL_CPM_SMC2 is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

define cpm parallel port D as follow
    _/* PD9  */ {   0,   1,   0,   1,   0,   0   },
_/* SMC1 TXD */
    _/* PD8  */ {   0,   1,   0,   0,   0,   0   },
_/* SMC1 RXD */

Any ideas would be appreciated.

Regards,

Jie


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
