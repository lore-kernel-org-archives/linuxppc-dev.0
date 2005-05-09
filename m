Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id A798D67A06
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 16:36:39 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1146800wri
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 08 May 2005 23:36:38 -0700 (PDT)
Message-ID: <528646bc05050823366a4cf9e6@mail.gmail.com>
Date: Mon, 9 May 2005 00:36:38 -0600
From: Grant Likely <glikely@gmail.com>
To: Atit_Shah <Atit_Shah@satyam.com>
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED102779F@bsdmsg002.corp.satyam.ad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <D8595042F3765A4285B848A78A2C2ED102779F@bsdmsg002.corp.satyam.ad>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Network Setup - HOW TO
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/8/05, Atit_Shah <Atit_Shah@satyam.com> wrote:
> My company uses the 172.19.x.x IP addresses, I want a PC with
> 192.168.x.x IP address to access the company network via a router. I
> have a router running Linux and having 2 Ethernet ports. I configured
> the systems in the following 2 ways:
So, two subnets:
Eth0 on subnet 192.168.0.0/255.255.0.0
Eth1 on subnet 172.19.0.0/255.255.0.0

>=20
> 1. Eth0 (LAN port) - 172.19.56.218
>    Eth1 (WAN port) - 172.19.56.219
>    Single System   - 192.168.100.10 - IP Address
>                            172.19.56.218  - Gateway
>                            172.19.56.218  - DNS
This is wrong.  IP address for Eth0 must be on the 192.168.0.0/16 subnet

>=20
> 2. Eth0 (LAN port) - 192.168.100.20
>    Eth1 (WAN port) - 172.19.56.219
>    Single System   - 192.168.100.10 - IP Address
>                            192.168.100.20 - Gateway
>                            192.168.100.20 - DNS
This is correct, but the DNS server does not have to be your router.

>=20
> But I am not able to ping from the router to my single system in either
> way.
> How should I configure router to make this possible for the 2 networks
> to communicate?
Is you netmask set right?  Does /sbin/route show sane IP routes?  What
do you see on the wire? (Use Ethereal on a third computer).  If you
cannot ping then you've got a fundamental flaw in your configurations.
 Get this working before worrying about DHCP or routing.

>=20
> The second question is how to run DHCP on my router so it can receive a
> dynamic IP and assign dynamic IP when I power my router?
You need to run both dhcpd and dhcpcd.  dhcpd to assign IP to your
client.  dhcpcd to get an IP from the network.

It sounds like you need to brush up on your IP networking knowledge w/
linux.  Go look at the howtos on www.tldp.org.  Specifically on
networking and DHCP.  You should get this stuff working on a regular
PC w/ 2 network cards running linux first before trying to get it
going on your embedded board.

Also, as I asked before, please include relevant output logs with your
posts and I strongly recommend sniffing the Ethernet traffic with a
tool like Ethereal.

g.
