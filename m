Date: Fri, 25 Jun 1999 11:30:53 +0100
From: Andrew Chadwick <andyc@durge.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Possible ne2k-pci bug on ppc
Message-ID: <19990625113053.A5487@fof2.durge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


First up, apologies for posting to linuxppc-dev. I'm by no means a kernel
hacker, but this is developer-level stuff. If any ethernet gurus could
help me I'd be eternally grateful *g*.

Does anyone know the status of the ne2k-pci drivers on linux/ppc? I ask
because my ne2000 card seems to be sending very oddly-shaped etherpackets
over the network.

	Thanks in advance,
	Andrew.


*The actors:

duodecimo: a Fujitsu 110 Lifebook, Processor: Pentium II @233MHz,
ethercard is a PCMCIA Xircom CreditCard IIps (known working and
configured OK via pcmcia-cs). Linux kernel 2.2.7 (unpatched).

piffle: an Apple PowerMac 4400/160, Processor: PowerPC 603e @160MHz,
ethercard is a cheapo 'software-configurable' 8390-based PCI NE2000 clone
made by Genius (drivers are right, card config is OK, but it just doesn't
seem to work). Kernel 2.2.7 (unpatched).

the string: properly teed and terminated 10base2.


*Symptoms

piffle does not send any TCP packets that are even recognised by the other
machine, although they're seen at ethernet level by the ethercard and the
kernel at the other end. Packets sent by duodecimo are at least seen at
the TCP level by piffle, but they're all errors.

These ifconfigs are after a few "ping -v"s either way, and are by no
means synchronized:


**duodecimo ifconfig:

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:14447 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14447 errors:0 dropped:0 overruns:0 carrier:0
          Collisions:0 

eth0      Link encap:Ethernet  HWaddr 00:80:C7:26:FD:91  
          inet addr:192.168.101.2  Bcast:192.168.101.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:343 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          Collisions:0 
          Interrupt:3 Base address:0x300 


**piffle ifconfig:

eth0      Link encap:Ethernet  HWaddr 00:C0:DF:EE:15:4F  
          inet addr:192.168.101.1  Bcast:192.168.101.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:395 dropped:0 overruns:0 frame:0
          TX packets:2979 errors:8 dropped:0 overruns:0 carrier:8
          collisions:136 txqueuelen:100 
          Interrupt:25 Base address:0x400 
                                    ^^^^^
*** Possible problem #1: this clashes on the PCI bus with the on-board ATI
*** mach64 graphics chips. But the gfx chips' IO ports are disabled.

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:3019 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3019 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 


Just to see what was happening and why the lifebook wasn't recognising
the powerpc's ethernet packets, I did a couple of TCPdumps:


**duodecimo tcpdump (piffle pinging duodecimo):

22:15:52.131492 ff:ff:4f:15:ee:df sap 08 > ff:ff:ff:ff:c0:0 ip-sap I
(s=2,r=3,C) len=46
			 0008 c000 0100 4f15 eedf 0165 a8c0 0000
			 0000 a8c0 0000 0265 6d6b 3fe7 ebee ef3e
			 6ffd a9fe 7fef dfd6 f9be ca71 2ab0
22:15:53.131437 ff:ff:4f:15:ee:df sap 08 > ff:ff:ff:ff:c0:0 ip-sap I
(s=2,r=3,C) len=46
			 0008 c000 0100 4f15 eedf 0165 a8c0 0000
			 0000 a8c0 0000 0265 6d6b 3fe7 ebee ef3e
			 6ffd a9fe 7fef dfd6 f9be ca71 2ab0
22:15:54.131883 ff:ff:4f:15:ee:df sap 08 > ff:ff:ff:ff:c0:0 ip-sap I
(s=2,r=3,C) len=46    ^^^^^^^^^^^                      ^^^^
                      ^^^^^^^^^^^                      ^^^^
*** Almost certainly the real problem: an endianness probblem here?
*** Besides, that should be "card-addr > ff:ff:ff:ff:ff", no?

			 0008 c000 0100 4f15 eedf 0165 a8c0 0000
			 0000 a8c0 0000 0265 6d6b 3fe7 ebee ef3e
			 6ffd a9fe 7fef dfd6 f9be ca71 2ab0
22:15:55.131364 ff:ff:4f:15:ee:df sap 08 > ff:ff:ff:ff:c0:0 ip-sap I
(s=2,r=3,C) len=46
			 0008 c000 0100 4f15 eedf 0165 a8c0 0000
			 0000 a8c0 0000 0265 6d6b 3fe7 ebee ef3e
			 6ffd a9fe 7fef dfd6 f9be ca71 2ab0


**piffle tcpdump -x (piffle pinging duodecimo):

21:26:39.170000 arp who-has duodecimo tell piffle
			 0001 0800 0604 0001 00c0 dfee 154f c0a8
			 6501 0000 0000 0000 c0a8 6502
21:26:40.170000 arp who-has duodecimo tell piffle
			 0001 0800 0604 0001 00c0 dfee 154f c0a8
			 6501 0000 0000 0000 c0a8 6502
21:26:41.170000 arp who-has duodecimo tell piffle
			 0001 0800 0604 0001 00c0 dfee 154f c0a8
			 6501 0000 0000 0000 c0a8 6502
21:26:42.170000 arp who-has duodecimo tell piffle
			 0001 0800 0604 0001 00c0 dfee 154f c0a8
			 6501 0000 0000 0000 c0a8 6502

-- 
sub p{s/^\s*((\"(\\.|.)*?\")|\w+)//&&return$1;s/^\s*\(//||die$_;my @r;until
(s/^\s*\)//){push(@r,&p)}\@r}sub r{ref($c=$_[0])?shift(@{$c}).'('.join(',',
map{r($_)}@{$c}).')':$c}$_= #Andrew Chadwick <http://www.durge.org/~andyc/>
'(print (join " " (reverse "hacker.\n""Perl""another""Just")))';eval &r(&p)

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
