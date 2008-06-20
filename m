Return-Path: <carlos.moratelli@digitel.com.br>
Received: from ares.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id E7B37DDF45
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jun 2008 02:53:39 +1000 (EST)
Received: from [192.168.20.171] (unknown [192.168.20.171])
	by ares.digitel.com.br (Postfix) with ESMTP id 98F1F7160DE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jun 2008 13:46:16 -0300 (BRT)
Subject: Re: mpc8313erdb
From: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <mailman.2509.1213973560.4744.linuxppc-embedded@ozlabs.org>
References: <mailman.2509.1213973560.4744.linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Fri, 20 Jun 2008 13:43:15 -0300
Message-Id: <1213980195.6911.15.camel@parana>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Date: Fri, 20 Jun 2008 16:12:20 +0530
> From: "Nidhi Dua" <dua.nidhi2007@gmail.com>
> Subject: mpc8313erdb
> To: linuxppc-embedded@ozlabs.org
> Message-ID:
> 	<d8b992c20806200342q4e040a44y459a736fbd061592@mail.gmail.com>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> We are using the board MPC8313ERDB and we are facing problems regarding
> u-boot environment variables(the environment variables displayed after
> giving 'printenv' command at u-boot prompt).
> 
> We are following the steps stated as below:
> 
> 1. =>printenv
> 
> output is:
> ....
> ....
> bootargs=root=/dev/mtdblock2 rootfstype=jffs2 rw console=ttyS0,115200
> bootcmd=bootm fe100000 - fe700000
> filesize=1a4a05
> fileaddr=200000
> ipaddr=192.168.1.101
> serverip=192.168.1.57
> stdin=serial
> stdout=serial
> stderr=serial
> ethact=TSEC0
> 
> 
> Here ethact is TSEC0 by default.
> 
> 2. =>setenv ethact TSEC1
> 3. =>saveenv
> output:
> Saving Environment to Flash...
> Un-Protected 1 sectors
> Erasing Flash...
> . done
> Erased 1 sectors
> Writing to Flash... done
> Protected 1 sectors
> 
> Here we have set the ethact variable to TSEC1 and saved it. Now it is
> showing that this value of ethact is burnt in flash. But after the board is
> reset,
> 
> 4. =>printenv
> 
> ileaddr=200000
> ipaddr=192.168.1.101
> serverip=192.168.1.57
> stdin=serial
> stdout=serial
> stderr=serial
> ethact=TSEC0
> 
> Here again the value of ethact is changed to TSEC0.
> 
> we have following questions:
> 
> question 1: We want to know the reason why it(ethact variable) changes to
> TSEC0 everytime with a reset.
> 

This variable (ethact) isn't save with the enviroment variables. 

> question2: After we have set ethact to TSEC1 and saved it(=>saveenv) and
> tried to ping the Host from u-boot prompt it is working (displaying: 'host
> alive').
> But when we are trying to ping Target board from the host it is showing:
> 
> PING 192.168.1.101 (192.168.1.101) 56(84) bytes of data.
> >From 192.168.1.57 icmp_seq=2 Destination Host Unreachable
> >From 192.168.1.57 icmp_seq=3 Destination Host Unreachable
> ....
> ....
> --- 192.168.1.101 ping statistics ---
> 12 packets transmitted, 0 received, +9 errors, 100% packet loss, time
> 11002ms
> , pipe 3
> 
> Why is it happening so?

Ping from a host to U-Boot should't work. U-Boot isn't able to respond a
ping protocol. Maybe this link can be usefull:

http://docs.blackfin.uclinux.org/doku.php?id=bootloaders:u-boot:faq

> 
> question 3: After we have set 'ethact' to TSEC1, the kernel is loaded, and
> we have logged -in, when we try to ping the Host from target it says '100%
> packet lost'. also we are unable to ping target from the host. Why is it
> happening so?
> 

After the kernel boot, did you try using ifconfig command to configure
the ethernet interface?

> Awaiting a prompt reply
> Regards
> Nidhi Dua

I hope this can help you.

Regards

Carlos R. Moratelli
