Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 59B3EDDF7D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jun 2008 21:21:57 +1000 (EST)
Message-ID: <485B9360.2070702@coritel.it>
Date: Fri, 20 Jun 2008 13:24:16 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Nidhi Dua <dua.nidhi2007@gmail.com>
Subject: Re: mpc8313erdb
References: <d8b992c20806200342q4e040a44y459a736fbd061592@mail.gmail.com>
In-Reply-To: <d8b992c20806200342q4e040a44y459a736fbd061592@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Nidhi Dua ha scritto:
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
> question2: After we have set ethact to TSEC1 and saved it(=>saveenv) and
> tried to ping the Host from u-boot prompt it is working (displaying: 'host
> alive').
> But when we are trying to ping Target board from the host it is showing:
> 
> PING 192.168.1.101 (192.168.1.101) 56(84) bytes of data.
>>From 192.168.1.57 icmp_seq=2 Destination Host Unreachable
>>From 192.168.1.57 icmp_seq=3 Destination Host Unreachable
> ....
> ....
> --- 192.168.1.101 ping statistics ---
> 12 packets transmitted, 0 received, +9 errors, 100% packet loss, time
> 11002ms
> , pipe 3
> 
> Why is it happening so?
> 
> question 3: After we have set 'ethact' to TSEC1, the kernel is loaded, and
> we have logged -in, when we try to ping the Host from target it says '100%
> packet lost'. also we are unable to ping target from the host. Why is it
> happening so?
> 
> Awaiting a prompt reply
> Regards
> Nidhi Dua
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

You have to set ethprime=TSEC1 because ethact isn't saved, but surely 
you can find more information in the U-Boot mailing list.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
