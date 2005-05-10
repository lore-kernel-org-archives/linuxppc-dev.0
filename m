Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id D0082679E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 20:39:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C5554C.6B799700"
Date: Tue, 10 May 2005 16:08:26 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED10277A9@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: "Grant Likely" <glikely@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Network Setup - HOW TO
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5554C.6B799700
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I had my router with IP address 172.19.56.218 and linux machine
172.19.60.11 connected with a normal cable. I had the system ping the
router with ethereal running.
Ethereal captured only the ARP packets, there were no ARP reply and on
the console of the system I would get "Destination Host unreachable".=20
Have enclosed the ethereal capture...
Atit

-----Original Message-----
From: Grant Likely [mailto:glikely@gmail.com]=20
Sent: Monday, May 09, 2005 12:07 PM
To: Atit_Shah
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Network Setup - HOW TO

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
> But I am not able to ping from the router to my single system in
either
> way.
> How should I configure router to make this possible for the 2 networks
> to communicate?
Is you netmask set right?  Does /sbin/route show sane IP routes?  What
do you see on the wire? (Use Ethereal on a third computer).  If you
cannot ping then you've got a fundamental flaw in your configurations.
 Get this working before worrying about DHCP or routing.

>=20
> The second question is how to run DHCP on my router so it can receive
a
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



DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.

------_=_NextPart_001_01C5554C.6B799700
Content-Type: application/octet-stream;
	name="ethereal"
Content-Transfer-Encoding: base64
Content-Description: ethereal
Content-Disposition: attachment;
	filename="ethereal"

1MOyoQIABAAAAAAAAAAAAP//AAABAAAA0oiAQufKBAAqAAAAKgAAAP///////wAREZAdAAgGAAEI
AAYEAAEAERGQHQCsEzwLAAAAAAAArBM42tKIgELa8QQAKgAAACoAAAD///////8AERGQHQAIBgAB
CAAGBAABABERkB0ArBM8CwAAAAAAAKwTONrTiIBCMfoAACoAAAAqAAAA////////ABERkB0ACAYA
AQgABgQAAQAREZAdAKwTPAsAAAAAAACsEzja

------_=_NextPart_001_01C5554C.6B799700--
