Message-ID: <38AD50A9.B95BEA7F@execpc.com>
Date: Fri, 18 Feb 2000 08:01:13 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: bmac module broken
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With the recent mention of making dmasound a module to turn off sound when not
in use and save power, i wondered about the status of two other chips in the
pbg3.  Specifically, the bmac, and the mesh.  Bmac panics upon a second install,
so something is missing in the cleanup i guess.  also, it doesn't power it off.
borrowing from the sleep code, adding the following lines before freeing
bmac_devs does turn it off.  i dont know if i need the reset.

    feature_set(bp->node, FEATURE_BMac_reset);
    udelay(10000);
    feature_clear(bp->node, FEATURE_BMac_IO_enable);
    udelay(10000);

However, it still panics on a second install.  this is similar to the problem
with dmasound a few months ago.  I think i tried changing the free_irq's second
parameter to that of the last param in the corresponding request_irq, but it
didn't work for me.  Ideas/patches?

Also, mesh would be a nice one to modulize.  building the module, it complains
about kernel version.  modversions are not enabled in this.  i plan on a fix.
Also, there is no module_init or cleanup in it, but other scsi modules dont
either.  But like the others, I'd want to be able to rmmod this just so it turns
off the chip, and later i can reinstall it without a panic.  I'd think the
powerdown would have to go in the cleanup since the only calls to mesh_power are
in init(on only) and sleep.  Any tips?

Any other chips that can/should be turned off?  are media bays are off when not
in use?  Pcmcia?

Thank you for your time.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
