From: xuwentao@cn.ibm.com
To: ben bodley <benb@m2tech.co.nz>
cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <4825691F.002DF1CC.00@d73mta06.au.ibm.com>
Date: Mon, 17 Jul 2000 14:21:24 +0800
Subject: Re: Why eth0 does not work
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I found that the client can not receive packet correctly.  I put some
printk()
in fucntion ei_receive() in file driver/net/8390.c as the following:

                if (rx_frame.next != next_frame
                        && rx_frame.next != next_frame + 1
                        && rx_frame.next != next_frame - num_rx_pages
                        && rx_frame.next != next_frame + 1 - num_rx_pages)
{()

                        /* the following lines are added by Wentao */
                        printk("----------rx
error---------------------\n");
                        printk("rx_frame.next =
%d,next_frame=%d\n",rx_frame.nex
t,next_frame); /* Wentao adds */

printk("num_rx_pages=%d,ei_local->current_page=%d\n\n",n
um_rx_pages, ei_local->current_page);
                  /* end of addtion by Wentao */
               .....

BTW, the related receive buffer registers are initialized with value(my
board has
a 32k sram for packet buffer);
page start reg: 44
current page reg: 44
page stop reg: 64
boundary poiter: 63

The output in the client is :
.......
eth0: National DP83902AV at 12:34:56:78:90:ab, found at 0xf1400000, using
IRQ 26.
Looking up port of RPC 100003/2 on 7.1.1.21
----------rx error---------------------
rx_frame.next = 45,next_frame=109
num_rx_pages=20,ei_local->current_page=44

----------rx error---------------------
rx_frame.next = 46,next_frame=110
num_rx_pages=20,ei_local->current_page=45

----------rx error---------------------
rx_frame.next = 47,next_frame=111
num_rx_pages=20,ei_local->current_page=46

Device lo is down.
----------rx error---------------------
rx_frame.next = 48,next_frame=112
num_rx_pages=20,ei_local->current_page=47

----------rx error---------------------
rx_frame.next = 49,next_frame=113
num_rx_pages=20,ei_local->current_page=48

----------rx error---------------------
rx_frame.next = 50,next_frame=114
num_rx_pages=20,ei_local->current_page=49

Device lo is down.
----------rx error---------------------
rx_frame.next = 51,next_frame=115
num_rx_pages=20,ei_local->current_page=50

----------rx error---------------------
rx_frame.next = 52,next_frame=116
num_rx_pages=20,ei_local->current_page=51

----------rx error---------------------
rx_frame.next = 53,next_frame=117
num_rx_pages=20,ei_local->current_page=52

Device lo is down.
----------rx error---------------------
rx_frame.next = 54,next_frame=172
num_rx_pages=20,ei_local->current_page=53

----------rx error---------------------
rx_frame.next = 55,next_frame=119
num_rx_pages=20,ei_local->current_page=54

----------rx error---------------------
rx_frame.next = 56,next_frame=120
num_rx_pages=20,ei_local->current_page=55

----------rx error---------------------
rx_frame.next = 57,next_frame=121
num_rx_pages=20,ei_local->current_page=56

Device lo is down.
portmap: server 7.1.1.21 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 7.1.1.21
----------rx error---------------------
rx_frame.next = 58,next_frame=122
num_rx_pages=20,ei_local->current_page=57
........


the output of the tcpdump -i eth0 host 7.1.1.5 in the NFS server is:
13:47:08.224173 B arp who-has 7.1.1.21 tell 7.1.1.5
13:47:08.224207 > arp reply 7.1.1.21 (0:20:35:b1:fc:d8) is-at
0:20:35:b1:fc:d8 (
12:34:56:78:90:ab)
13:47:09.335805 B arp who-has 7.1.1.21 tell 7.1.1.5
13:47:09.335826 > arp reply 7.1.1.21 (0:20:35:b1:fc:d8) is-at
0:20:35:b1:fc:d8 (
12:34:56:78:90:ab)
13:47:10.447399 B arp who-has 7.1.1.21 tell 7.1.1.5
13:47:10.447413 > arp reply 7.1.1.21 (0:20:35:b1:fc:d8) is-at
0:20:35:b1:fc:d8 (
12:34:56:78:90:ab)
13:47:13.604779 B arp who-has 7.1.1.21 tell 7.1.1.5
13:47:13.604794 > arp reply 7.1.1.21 (0:20:35:b1:fc:d8) is-at
0:20:35:b1:fc:d8 (
12:34:56:78:90:ab)
.......
I also tried other vlaues for the buffer registers such as
page start reg: 0
current page reg: 1
page stop reg: 32
boundary poiter: 0
and also got rx errors. I dont know what to do next.

Wentao


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
