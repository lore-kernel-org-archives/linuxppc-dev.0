Message-Id: <200311041129.FAA12245@lists.linuxppc.org>
Date: Tue, 4 Nov 2003 19:28:29 +0800
From: =?ISO-8859-1?Q?=CF=AF=D3=FD=D0=A2?= <xiyuxiao@harbournetworks.com>
Reply-To: xiyuxiao@harbournetworks.com
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: dhcp help!
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,all,
    Can anyone tell me where the mumber in_device *ip_ptr of the struct
net_device is initialized?
    I enable the DHCP and BOOTP kernel configurations,but I can not boot
my kernel successfully!
    The target sent dhcp discover message packet to the host server,and
the host server replied it with a dhcp offer message packet.The target's
ethernet card received the dhcp offer packet and sent it to the IP
protocol stack correctly.But the network layer dropped the packet!I
traced the packet receive process and found that when the function
ip_rcv_finish() was called,it called the function ip_route_input(),then
ip_route_input() called ip_route_input_slow(),then ip_route_input()
called in_device *in_dev = in_dev_get(dev) which returned NULL! the
source code of the function in_dev_get(dev) is shown below:

static __inline__ struct in_device *
in_dev_get(const struct net_device *dev)
{
	struct in_device *in_dev;

	read_lock(&inetdev_lock);
	in_dev = dev->ip_ptr;
	if (in_dev)
		atomic_inc(&in_dev->refcnt);
	read_unlock(&inetdev_lock);
	return in_dev;
}

    I checked the kernel startup code and I found that when the
target dynamicly went to obtain its IP address,and when function
in_dev_get(dev) was called,the mumber in_device *ip_ptr of the struct
net_device *dev had not been initialized. I am confused by this
trouble.Is DHCP really used as I described? Did I make any mistake?

BTW: I use montavista linux 2.1

            xiyuxiao@harbournetworks.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
