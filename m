Date: Mon, 15 Jan 2001 21:28:43 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: setting the frequency on an airport card?
Message-ID: <20010115212843.A10256@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

does anyone know how to go about setting the frequency on the airport card?
The only way I can think of that seems to want to work is using iwconfig
(see http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/) but all it keeps
saying is
[20:48:11] 17 shiva root ~>iwconfig airport freq 2.442GHz
SIOCSIWFREQ: Operation not supported

it says that (same response, different ioctl) for all the ioctl's except the
one to set the essid.

I dont understand why it is not setting the frequency or not able to. (I
need to do this so I can actually speak to another 802.11b card, one which I
also cant set the frequency on with iwconfig and have not the faintest as to
why it is failing either).

The airport.c (benh's I had to pull out some code and change one line so it
would actually compile unfortunately, mostly it seemed to be things messing
up with version differences (running this with 2.4.0), see diff -u below)
contains the ioctl sections for setting the frequency and all the others as
far as I can tell.

The aiport.c contains
if ((port_type != 3) || (wrq->u.freq.m > 1000) || (wrq->u.freq.e > 0))
   rc = -EOPNOTSUPP;

which is I guess where it is failing, anyone know why the airport card
doesnt seem to want to have it's frequency changed? (or for that matter the
majority of the ioctls the wireless extensions allow use of?

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

this diff was the quick changes I needed to get the module ben has on his
website to compile and insert successfully

on insertion I get the message

[20:47:10] 11 shiva root ~>insmod airport.o
airport.o parameter enc has unknown format modifier '*'

however all seems fine
Jan 15 20:18:46 shiva kernel: airport: Airport WaveLAN/IEEE driver v1.0.4
Jan 15 20:18:46 shiva kernel: airport: (c) Benjamin Herrenschmidt
<bh40@calva.net>
Jan 15 20:18:46 shiva kernel: airport: (c) Andreas Neuhaus
<andy@fasta.fh-dortmund.de>
Jan 15 20:18:47 shiva kernel: airport: Registered netdevice airport
Jan 15 20:18:47 shiva kernel: airport: MAC address on airport is 00 30 65 12
22 99

so hey

--- ben/airport.c       Mon Jan 15 21:22:13 2001
+++ airport_0.9.3/airport.c     Mon Jan 15 20:46:24 2001
@@ -2170,24 +2170,7 @@

        DEBUG(DEBUG_CALLTRACE, "-> airport_tx(%s)\n", dev->name);

-#if (KERNEL_VERSION_CODE < KERNEL_VERSION(2,3,42))
-       // We normally shouldn't be called if queue is stopped (transmitter
busy)
-       // but older kernel code does anyway. So we'll check if the last
-       // transmission has timed out and reset the device in case
-       if (test_and_set_bit(0, (void *) &dev->tbusy) != 0) {
-               DEBUG(DEBUG_TXRX, "%s: airport_tx(%s) called while busy!\n",
dev_info, dev->name);
-               if ((jiffies - dev->trans_start) < TX_TIMEOUT)
-                       return 1;
-               if (!netif_running(dev))
-               {
-                       printk(KERN_WARNING "%s: %s Tx on stopped
device!\n", dev_info, dev->name);
-                       return 1;
-               }
-               airport_watchdog(dev);
-       }
-#else
        netif_stop_queue(dev);
-#endif

        skb_tx_check(dev, skb);

@@ -2657,7 +2640,7 @@

        // Other netdevice data
        if (!eth)
-               dev->name = "airport";
+               strncpy (dev->name, "airport", 8);
        dev->mtu = mtu;
 //     netif_stop_queue(dev);

--- ben/k_compat.h      Mon Jan 15 21:22:56 2001
+++ airport_0.9.3/k_compat.h    Mon Jan 15 20:40:50 2001
@@ -119,11 +119,13 @@
 #define signal_pending(cur)    ((cur)->signal & ~(cur)->blocked)
 #endif

+/*
 #if (LINUX_VERSION_CODE < VERSION(2,1,86))
 #define DEV_KFREE_SKB(skb)     dev_kfree_skb(skb, FREE_WRITE)
 #else
 #define DEV_KFREE_SKB(skb)     dev_kfree_skb(skb)
 #endif
+*/

 #if (LINUX_VERSION_CODE < VERSION(2,1,89))
 #define POLL_WAIT(f, q, w)     poll_wait(q, w)
@@ -285,6 +287,7 @@
        resetup_one_dev(dev, drive); } while (0);
 #endif

+/*
 #if (LINUX_VERSION_CODE < VERSION(2,1,25))
 #define net_device_stats       enet_statistics
 #define skb_tx_check(dev, skb) \
@@ -297,6 +300,7 @@
 #define add_rx_bytes(stats, n) do { (stats)->rx_bytes += n; } while (0)
 #define add_tx_bytes(stats, n) do { (stats)->tx_bytes += n; } while (0)
 #endif
+*/

 #if (LINUX_VERSION_CODE < VERSION(2,3,43))
 #define netif_stop_queue(dev)  set_bit(0, (void *)&(dev)->tbusy)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
