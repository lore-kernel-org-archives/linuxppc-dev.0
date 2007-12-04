Return-Path: <timur@freescale.com>
Message-ID: <4755E6AC.9020808@freescale.com>
Date: Tue, 04 Dec 2007 17:45:48 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Markus Rechberger <markus.rechberger@amd.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	PowerPC dev list <Linuxppc-dev@ozlabs.org>
Subject: Fix Firmware class name collision
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Markus and Greg,

I've found a problem with this patch that probably affects a number of embedded 
PowerPC systems:

http://marc.info/?l=linux-kernel&m=119222892713518&w=2

The problem is that the device name for many PowerPC SoC devices is based on the 
physical address.  So we have stuff like this:

# ls -l /sys/devices/
drwxr-xr-x    9 root     root            0 Nov  9 17:29 e0000000.soc8323
drwxr-xr-x   11 root     root            0 Nov  9 17:22 e0100000.qe
[snip]
# ls -l /sys/devices/e0000000.soc8323/
drwxr-xr-x    2 root     root            0 Nov  9 17:34 e0000200.wdt
drwxr-xr-x    2 root     root            0 Nov  9 17:34 e0000700.pic
drwxr-xr-x    2 root     root            0 Nov  9 17:34 e0001400.par_io
drwxr-xr-x    2 root     root            0 Nov  9 17:34 e0003000.i2c
drwxr-xr-x    2 root     root            0 Nov  9 17:34 e0004500.serial
drwxr-xr-x    2 root     root            0 Nov  9 17:34 e0004600.serial
drwxr-xr-x    2 root     root            0 Nov  9 17:34 e0030000.crypto
[snip]

With this patch, the device names in /sys/class/firmware look like this:

# ls -l /sys/class/firmware/
drwxr-xr-x    2 root     root            0 Nov  9 17:37 firmware-e0102400.u
-rw-r--r--    1 root     root         4096 Nov  9 17:22 timeout

In other words, the only thing you get is the first letter of the device name. 
You used to get the whole name.  The physical address obviously isn't very helpful.

The problem is the size of the string is only 20 characters:

static inline void fw_setup_device_id(struct device *f_dev, struct device *dev)
{
	snprintf(f_dev->bus_id, BUS_ID_SIZE, "firmware-%s", dev->bus_id);
}

Now, there are two solutions:

1) Change the PowerPC device names from physical_address.device_name to 
device_name.physical_address (so that e0102400.ucc becomes ucc.e0102400)

2) Change fw_setup_device_id() to something like this:

	snprintf(f_dev->bus_id, BUS_ID_SIZE, "fw-%s", dev->bus_id);

which do you think is a better idea?

-- 
Timur Tabi
Linux kernel developer at Freescale
