Message-ID: <3F17BCE4.7070603@dgt-lab.com.pl>
Date: Fri, 18 Jul 2003 11:24:52 +0200
From: Adam Kaczynski <kaczor@dgt-lab.com.pl>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: HDLC driver for MPC8260
References: <20030718071048.82F6EC6D82@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


How to buid a "net" driver? Please have a look at
http://www.dgt-lab.com.pl/Serwis/mpc860hdlc.tar.gz

This is a per-channel structure:

typedef struct m_port_t {
         hdlc_device hdlc;    /* HDLC device struct - must be first */
<a lot of private variables comes here...>
}

initialization:
static int __init mpc860hdlc_init(void)
calls
result = register_hdlc_device(&m_dev[i].hdlc);
for each channel  - does registration in the HDLC stack.


de-initialization:
static void __exit mpc860hdlc_cleanup(void)
does the opposite thing:
unregister_hdlc_device(&m_dev[i].hdlc);

open method:
static int m_open(hdlc_device *hdlc)
starts the transmitter queue:
netif_start_queue(hdlc_to_dev(hdlc));


the close method does the opposite thing:
static void m_close(hdlc_device *hdlc)
stops the queue
netif_stop_queue(hdlc_to_dev(hdlc));

the ioctl will probably need re-design work together with sethdlc
utility if you want to pass down more parameters:
static int m_ioctl(hdlc_device *hdlc, struct ifreq *ifr, int cmd)

Now the xmit method:
static int m_xmit(hdlc_device *hdlc, struct sk_buff *skb)
should queue the skb and initiate sending it
(I simplified my task by using an intermediate transmitter queue but you
may wish to directly connect the skbuff to a buffer descriptor- you'll
skip one memcpy then)
or stop if the queue is full (netif_stop_queue(hdlc_to_dev(hdlc));
return 1;)
The skb needs to be freed either after copying it or sending it (in this
case in the interrupt)
dev_kfree_skb_any(skb);
In the transmitter interrupt one should unlock the queue if it was
locked due to being full
netif_wake_queue(hdlc_to_dev(&_m_dev->hdlc));

Reception:
in the interrupt (or in a bottom half if you like)
do some sanity checks... if OK
skb = dev_alloc_skb(len);
copy the data from the low-level buffer
and push it upwards the stack
hdlc_netif_rx(&_m_dev->hdlc, skb);
That's it.
If you like you may also pre-allocate some skbuffs and connect them to
buffer descriptors (this way you will avoid copying)

This is almost all you need to know. Don't hesitate to ask if something
is unclear.

The doble-copying appears not to spoil the performance too much. For
8260 it is even less significant (I checked it for ATM driver) but if
you want to make your boss more happy you may design the driver in a
more mature way than I did.

Regards,
Adam


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
