Reply-To: <PaulFagerburg@RenaissanceNT.com>
From: "Paul Fagerburg" <PaulFagerburg@RenaissanceNT.com>
To: "'linuxppc'" <linuxppc-embedded@lists.linuxppc.org>
Subject: BOOTP problems on Embedded Planet CLLF with Monta Vista kernel
Date: Thu, 3 Aug 2000 16:43:18 -0700
Message-ID: <000c01bffda4$9a12f220$5301a8c0@RenaissanceNT.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm working with Embedded Planet's CLLF board (an 860T), and the Hard
Hat Linux Journeyman edition from Monta Vista.  My host system is an
intel celeron box running Mandrake 7.

I've been referring to the Hard Hat Linux docs (cdk.pdf) and the
getting_started.rpx file that is available on several of the linuxppc sites.

The mandrake host (named "penguin") is part of our NT network, and is a
properly-behaved DHCP client.  Minicom works fine talking to the CLLF
board.

Once I started dhcpd (the DHCP *server*), nothing went right from then
on; the TFTP client on the CLLF timed out with ARP failures.  Once I
stopped dhcpd, the CLLF was able to TFTP its kernel, uncompress it, and
boot.  However, after booting the kernel, it wants to use BOOTP to get
more info and then NFS mount the root filesystem.  This is where it all
goes downhill.

Thinking that there was some kind of issue with our NT box that is
serving up DHCP, I tried putting the CLLF and penguin on their own
network.  I put a second NIC in penguin and hooked up a dumb hub.  Since
we're using 192.168 addresses in our NT network, I decided to use a 10
network on the second NIC. I gave penguin the IP of 10.0.0.1, and told
the CLLF (in its EEPROM config) that it was 10.0.0.2.

I boot the RPX, tell it to load and execute from TFTP, and it does in
fact boot the kernel.  After the kernel boots, it tries to use BOOTP,
and gets no responses.  I used tcpdump to see the traffic on eth1, and
here's the amended version:

13:30:16.443429 arp who-has 10.0.0.1 tell rpx
13:30:16.443465 arp reply 10.0.0.1 is-at 0:c0:f0:5b:9e:23
13:30:16.557802 rpx.1 > 10.0.0.1.tftp: 22 RRQ "vmlinuz.srec"
13:30:16.576315 10.0.0.1.1030 > rpx.1: udp 516
13:30:16.577263 rpx.1 > 10.0.0.1.1030: udp 22
[ ... ]
13:30:22.830821 10.0.0.1.1030 > rpx.1: udp 516
13:30:22.833848 rpx.1 > 10.0.0.1.1030: udp 22
13:30:22.833915 10.0.0.1.1030 > rpx.1: udp 493
13:30:22.836905 rpx.1 > 10.0.0.1.1030: udp 22
13:30:23.569352 arp who-has rpx tell 10.0.0.1
13:30:24.569343 arp who-has rpx tell 10.0.0.1
13:30:25.569352 arp who-has rpx tell 10.0.0.1
13:30:26.569348 arp who-has rpx tell 10.0.0.1

When the four arp packets show up at the end, I see
    Linux/PPC load: root=/dev/nfs rw
I hit ENTER, it goes through the kernel load, and then gets stuck
waiting for BOOTP.


Here's what I hope will be useful data:

# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
10.0.0.1        *               255.255.255.255 UH    0      0        0 eth1
192.168.1.0     *               255.255.255.0   U     0      0        0 eth0
10.0.0.0        *               255.0.0.0       U     0      0        0 eth1
127.0.0.0       *               255.0.0.0       U     0      0        0 lo
default         venus           0.0.0.0         UG    0      0        0 eth0

# cat /etc/hosts
127.0.0.1   penguin localhost
192.168.1.2 venus
10.0.0.1    rpxhost
10.0.0.2    rpx

# cat /etc/exports
/opt/hardhat/devkit/ppc/8xx/target (rw,no_root_squash)

# cat /etc/dhcpd.conf
allow bootp;
subnet 192.168.1.0 netmask 255.255.255.0 {
}

subnet 10.0.0.0 netmask 255.0.0.0 {
    default-lease-time 1209600; # two weeks
    max-lease-time 31557600;    # one year
    group {
        host rpx {
            hardware ethernet 00:10:EC:00:19:F4;
            fixed-address 10.0.0.2;
            option root-path "/opt/hardhat/devkit/ppc/8xx/target";
        }
    }
}



I had to add that first subnet to dhcpd.conf, or else the daemon
wouldn't start, complaining about not knowing what to do with eth0.

So, that's where I'm stuck for now.

Surely I can't be the only person trying to hook up one of these boards
to a linux system that is sitting in an NT network.  Separate NIC and
hub 's is not an issue to me; show me the way to do it with either 1 or
2 NIC's and I'll be happy to do it that way.  I'll be quite grateful for
any help that anyone can provide.

-paul


--
Paul Fagerburg
Renaissance Network Technology
829 De La Vina St., Suite 200
Santa Barbara, CA 93101
805-899-4260 x 115
plf@RenaissanceNT.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
