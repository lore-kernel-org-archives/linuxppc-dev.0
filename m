Return-Path: <paravpandit@yahoo.com>
Received: from web36604.mail.mud.yahoo.com (web36604.mail.mud.yahoo.com
	[209.191.85.21]) by ozlabs.org (Postfix) with SMTP id 5A01367B86
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 13:57:14 +1000 (EST)
Message-ID: <20060809035713.87265.qmail@web36604.mail.mud.yahoo.com>
Date: Tue, 8 Aug 2006 20:57:13 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: Lite5200B and ioctl(SETFLAGS) hangs in mpx5xxx_fec_open() call
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

Hi,

Please bare through the long mail to explain my
problem.

I am working on FEC driver on Lite5200B and facing
issue when I disable the printk()s in the fec_open()
inside arch/ppc/5xxx_io.

I have commented out function call
mii_display_status() inside fec_open().

Due to this, command #ifconfig eth0 192.168.4.48 hangs
in ioctl(SETFLAGS) command.

Basically Networking stack comes up during booting,
their it opens the fec device and device gets
initialized fine. (Because system boots and doesn't
hang)

After than bash shell comes up and when I run ifconfig
eth0 192.168.4.48, it again re-initializes the device
and hangs in the set_flag()->ioctl(SETFLAGS) function
inside driver.

In kernel space, it goes like this.

Counter part of ioctl(SETFLAGS) gets called and opens
the device. (IFF_UP flag is not set).

Now fec_open() issues mii_do_cmd() for phy_>config,
phy_cmd_config, and then waits for the sequence_done
flag to get set.

But sequence_done flag is not getting set by the
interrupt handler because mii_display_config() is not
called.

Above sequence happens first time during network stack
fec_open() call but not dufing ifconfig.

Its important to note above sequence works in the
first fec_open() but fails in next.

I put the explicit delay of 10ms between
mii_do_cmd(ack_int) and mpc5xxx_fec_restart().

Current configuration is in Half duplex mode on 100M.

I really appreciate your inputs and help in debugging
to me.

Here is code snippet for your quick reference.

        if (!priv->sequence_done) {

                if (!priv->phy) {

                        printk("mpc5xxx_fec_open: PHY
not configured\n");

                        return -ENODEV;         /* No
PHY we understand */

                }

                mii_do_cmd(dev, priv->phy->config);

 

                mii_do_cmd(dev, phy_cmd_config);  /*
display configuration */

 

                /* Driver hangs here is below
mii_display_status() call is commented. */

                while(!priv->sequence_done) {

                        schedule();

                }

 

                mii_do_cmd(dev, priv->phy->startup);

 

                /*

                 * Currently, MII link interrupts are
not supported,

                 * so start the 100 msec timer to
monitor the link up event.

                 */

                init_timer(&priv->phy_timer_list);

 

                priv->phy_timer_list.expires = jiffies
+ (100 * HZ / 1000);

                priv->phy_timer_list.data = (unsigned
long)dev;

                priv->phy_timer_list.function =
mdio_timer_callback;

                add_timer(&priv->phy_timer_list);

 

                if (dev->name!=NULL) {

                        printk("%s: Waiting for the
link to be up...\n", dev->name);

                }

 

                while (priv->link == 0) {

                        schedule();

                }

 

                mii_display_status(dev);

                /* IF I comment this call, my driver
hangs */

 

                if (priv->full_duplex == 0) { /* FD is
not negotiated, restart the fec in HD */

                        mpc5xxx_fec_restart(dev, 0);

                }

 
Regards,
Parav Pandit



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
