Subject: Re: CLLF with Hard Hat Lunix "Sending BOOTP requests" problem
To: rshaw@graftononline.net
Date: Tue, 19 Sep 2000 12:05:25 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <001401c01eb2$48a92330$0100a8c0@nonewr2gx24hxi> from "rshaw@graftononline.net" at Sep 14, 2000 09:14:18 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000919010525.0A734231@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


rshaw@graftononline.net writes:
> While loading the kernel via tftp I found that in order for the boot process
> to work I have to use both the 10 Mbps and 100 Mbps ports.

Which version of the ROM monitor are you using?  The old one couldn't download
over the 100 Mbps port, so we had to connect both.  We used the 10 Mbps port
to download the kernel, and the 100 Mbps port once the kernel comes up.  Of
course, you need a 10/100 switch to do this.  I believe that Embedded
Planet are working on a new ROM monitor, which hopefully will correct this
problem; I don't know if they're shipping it with production boards yet
though.

Note that there is a hack in the fec driver which munges the ethernet MAC
address for the FEC port by adding 80:00:00 to the number that the monitor
reports on the CPM port.  You'll need to configure your dhcp & nfs server to
recognise the board via the munged address.  Your tftp server on the other
hand needs to recognise the unmunged address.

> OK, This gets us to a Linux shell prompt even though I had to execute the
> script files using both the 10 Mbps and 100 Mbps ports, which I shouldn't
> have to do. I'm hoping someone might be able to help me with why I need to
> use both ports and execute these arp commands.  Is something wrong with my
> DHCP configuration?
>
> Here are some of my configuration files.
>
> Here is /etc/dhcpd.conf file contents
>
> allow bootp;
> subnet 192.168.0.0 netmask 255.255.0.0 {
>   default-lease-time 1209600;   #two weeks
>   max-lease-time 31557600;   #one year
>   group {
>     host CLLFBOARD {
>       hardware ethernet 00:10:EC:00:00:00;
>       fixed-address 192.168.0.3;
>       option root-path "/opt/hardhat/devkit/ppc/8xx/target";
>     }
>   }
> }

You're using the unmunged address here, where it should be 00:10:EC:80:00:00.
This is probably why your bootp server doesn't respond.  By the way, they
didn't _really_ sell you a board with a MAC address ending in all-zero, did
they?

Once you've got it set up, your arp scripts will be unnecessary.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
