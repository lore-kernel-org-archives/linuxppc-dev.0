Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6b.your-server.co.za [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA0FCDE011
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 02:03:13 +1100 (EST)
Message-ID: <48F7579B.6050803@vastech.co.za>
Date: Thu, 16 Oct 2008 17:02:51 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: networking fails to activate - even more info
References: <48F450CD.8060309@vastech.co.za>
	<2acbd3e40810141538w3781fa4r75cfbe2833a21f81@mail.gmail.com>
	<48F60633.3030805@vastech.co.za>
In-Reply-To: <48F60633.3030805@vastech.co.za>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms090808070100000604030507"
Cc: Andy Fleming <afleming@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a cryptographically signed message in MIME format.

--------------ms090808070100000604030507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


>>> Hi
>>>
>>> We have a powerpc (8548) based board. running eldk4.1. the board has
>>> three ethernet ports using Gainfair ethernet controller v1.2.
>>>
>>> If the board powers up with any network cable plugged in, that specific
>>> network is accessible.
>>> if the board powers up without network cables connected and a cable is
>>> plugged in, the network does not become active.
>>> The kernal makes a log entry stating that the phy is up when the cable
>>> is plugged in - but the interface is not pingable
>>> Running ifdown and ifup manually does not result in a pingable interface.
>>> Neither does running /etc/init.d/network restart
>>>
>>> can anyone help me pls.
>>>     
>>>       
>> Check the statistics counters to see if you are getting any bad
>> packets, or to see if you are getting interrupts.  Several people have
>> reported that their PHYs have powerdown issues, though I wouldn't
>> expect the PHY to report the link as up, then.  Make sure that your
>> dts specifies the correct PHY address for the connected PHY.
>>
>> What happens if you start up with the PHY connected, bring up the
>> interface, and *then* disconnect and reconnect the cable (after a
>> delay)?
>>     
> Hi
>
> I have checked the counters in both ifconfig and with ethtool. both show
> TX counts but no RX count and no errors
> ethtool reports that the link is detected.
> The phy addresses are correct (ethtool and kernel log shows the
> exspected addresses)
> I have found that the networking scripts are not called (ifup or down)
> when a cable is pluged or unplugged. 
> I also found that udev is not in my current linux platform - can this
> contribute to the problem?
>
> To rule out the phys. I powered on the system with all network cables
> plugged in. ping all three to confirm that they work. i then issue a
> reset signal (hardware routed) to the phys. when the phys reappear im
> still able to ping all three interfaces.
>
> The log file entries for unplugging and connecting the cable are :
> (logged by /driver/phy/phy.c )
> Oct 15 14:36:56 equus user.info kernel: PHY: 0:00 - Link is
> Down                                                       
> Oct 15 14:36:59 equus user.info kernel: PHY: 0:00 - Link is Up - 100/Full
> what is the sequence of events that should follow?
>
> Another test i tried, powered the system up with no cables plugged in
> and  "ONBOOT=no" in ifcgf-eth sctipts. I then manually run the ifup
> scripts one by one. then plug in the three network cables. when i ping
> the three interfaces and ping targets on the three networks i find that
> one interface is pingable, one is not and one returns "ping: sendto:
> Network is unreachable"  - these results were reproducible about 25% of
> attempts but varied according to order in with cables were plugged in.
>
> I would appreciate any help.
> thanks pieter
>   
hi

I did some more digging and testing today.  To recap the problem: When i
power on the system with network cables plugged in, the interface is
pingable. If the system powers up without network cables plugged in,
ifconfig reports tat all interfaces are up and running. but when
connecting the network cables none of the interfaces are pingable (even
after running ifdown and ifup scripts for the interfaces. )

I think the problem lies some ware in that both ifconfig and ethtool
reports the link as being up even though the system was powered up
without network cables plugged in.

Ifconfigs output:
SDH-25108>
ifconfig                                                                                                    

eth0      Link encap:Ethernet  HWaddr
00:50:C2:52:51:08                                                                

          inet addr:10.0.0.200  Bcast:10.0.0.255 
Mask:255.255.255.0                                                   
          UP BROADCAST RUNNING MULTICAST  MTU:1500 
Metric:1                                                           
          RX packets:0 errors:0 dropped:0 overruns:0
frame:0                                                           
          TX packets:394 errors:0 dropped:0 overruns:0
carrier:0                                                       
          collisions:0
txqueuelen:1000                                                                                 

          RX bytes:0 (0.0 b)  TX bytes:16548 (16.1
KiB)                                                                
          Base
address:0xe000                                                                                          

                                                                                                                       

eth1      Link encap:Ethernet  HWaddr
00:50:C2:52:51:09                                                                

          inet addr:172.16.63.237  Bcast:172.16.63.255 
Mask:255.255.255.0                                             
          UP BROADCAST RUNNING MULTICAST  MTU:1500 
Metric:1                                                           
          RX packets:8676 errors:0 dropped:0 overruns:0
frame:0                                                        
          TX packets:149 errors:0 dropped:0 overruns:0
carrier:0                                                       
          collisions:0
txqueuelen:1000                                                                                 

          RX bytes:942270 (920.1 KiB)  TX bytes:10268 (10.0
KiB)                                                       
                                                                                                                       

eth2      Link encap:Ethernet  HWaddr
00:50:C2:52:51:0A                                                                

          inet addr:20.0.0.200  Bcast:20.0.0.255 
Mask:255.255.255.0                                                   
          UP BROADCAST RUNNING MULTICAST  MTU:1500 
Metric:1                                                           
          RX packets:0 errors:0 dropped:0 overruns:0
frame:0                                                           
          TX packets:4 errors:0 dropped:0 overruns:0
carrier:0                                                         
          collisions:0
txqueuelen:1000                                                                                 

          RX bytes:0 (0.0 b)  TX bytes:168 (168.0
b)                                                                   
          Base
address:0x2000                                                                                          

                                                                                                                       

lo        Link encap:Local
Loopback                                                                                    

          inet addr:127.0.0.1 
Mask:255.0.0.0                                                                          

          UP LOOPBACK RUNNING  MTU:16436 
Metric:1                                                                     

          RX packets:3733 errors:0 dropped:0 overruns:0
frame:0                                                        
          TX packets:3733 errors:0 dropped:0 overruns:0
carrier:0                                                      
          collisions:0
txqueuelen:0                                                                                    

          RX bytes:674220 (658.4 KiB)  TX bytes:674220 (658.4 KiB)         

ethtools output:                                          
SDH-25108> ethtool
eth0                                                                                                

Settings for
eth0:                                                                                                     

        Supported ports: [ TP AUI BNC MII FIBRE
]                                                                      
        Supported link modes:   10baseT/Half
10baseT/Full                                                              
                                100baseT/Half
100baseT/Full                                                            
                                1000baseT/Half
1000baseT/Full                                                          
        Supports auto-negotiation:
Yes                                                                                 

        Advertised link modes:  10baseT/Half
10baseT/Full                                                              
                                100baseT/Half
100baseT/Full                                                            
                                1000baseT/Half
1000baseT/Full                                                          
        Advertised auto-negotiation:
Yes                                                                               

        Speed:
1000Mb/s                                                                                                

        Duplex:
Half                                                                                                   

        Port:
MII                                                                                                      

        PHYAD:
0                                                                                                       

        Transceiver:
external                                                                                          

        Auto-negotiation:
off                                                                                          

        Current message level: 0x0000003f
(63)                                                                         

        Link detected: yes       

If I then plug in the cables and unplug them again  the link status goes
down. When plugging in the cables again link status is detected again,
but none of teh interfaces are pingable - even after  trying ifdown and up.




--------------ms090808070100000604030507
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
I3e2LGT31Cvy0XnO69vOuQAAAAAAAA==
--------------ms090808070100000604030507--
