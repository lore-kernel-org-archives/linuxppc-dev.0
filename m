Return-Path: <dimov@ronetix.at>
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de
	[80.67.31.31]) by ozlabs.org (Postfix) with ESMTP id C297FB6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 20:18:33 +1100 (EST)
Message-ID: <4B308F14.7000800@ronetix.at>
Date: Tue, 22 Dec 2009 11:19:16 +0200
From: RONETIX - Asen Dimov <dimov@ronetix.at>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC8313e RDB rev A4 and rev C network throughput
References: <4B2FF66E.7000209@ronetix.at>
	<D7CCA83BB0796C49BC0BB53B6AB1208985F8CF@zch01exm21.fsl.freescale.net>
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208985F8CF@zch01exm21.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Liu Dave-R63238 <r63238@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
I checked the RCW(RCWLR and RCWHR) and they are the same(taken from 
NOR), S3 and S4 switches are the same too.
I will take a look at the priority levels on CSB.

Regards,
Asen

Liu Dave-R63238 wrote:
> One possible cause is the two board has different RCW.
> So that the freq of core/csb/.... Is different. 
>
>   
>> -----Original Message-----
>> From: 
>> linuxppc-dev-bounces+daveliu=freescale.com@lists.ozlabs.org 
>> [mailto:linuxppc-dev-bounces+daveliu=freescale.com@lists.ozlab
>> s.org] On Behalf Of RONETIX - Asen Dimov
>> Sent: Tuesday, December 22, 2009 6:28 AM
>> To: linuxppc-dev@lists.ozlabs.org
>> Subject: MPC8313e RDB rev A4 and rev C network throughput
>>
>> Hello all,
>> I have made some test on network throughput with MPC8313e RDB 
>> revA4 and revC.
>> Some have mentioned that CSB(Coherent System Bus) frequency 
>> or untuned TCP/IP stack, could cause decrease of network throughput.
>>
>> **Test results
>>
>> -on MPC8313e RDB revA4 with kernel 2.6.20 and u-boot 1.1.6 
>> created with
>> ltib-mpc8313erdb-20070824
>>         iperf -c 172.16.0.1 -l 2m -w 256k -throughput is 510Mbps
>>
>>
>> -on MPC8313e RDB revA4 with kernel 2.6.23 and u-boot 1.3.0 generated 
>> with ltib-mpc8313erdb-20081222
>>         iperf -c 172.16.0.1 -l 2m -w 256k
>> -throughput is 510Mbps
>>
>>
>> -on MPC8313e RDB revC with kernel 2.6.23 (the same u-boot, kernel and 
>> rootfs as in rev A4, only dtb file differs)
>>         iperf -c 172.16.0.1 -l 2m -w 256k
>> -throughput is 360Mbps.
>>
>>
>> Have someone made such measurements? Any ideas why MPC8313e RDB revC 
>> gives worser throughput than revA4?
>>
>> ** Notes
>> *The PC (CPU:Intel(R) Core(TM)2 Duo CPU, E8400 @ 3.00GHz;
>>          RAM:  2x2G DDR2 @ 800Mhz ;
>>          NIC: R8168B PCI Express Gigabit Ethernet controller, driver 
>> 8.014.00-NAPI;
>>          OS: Fedora release 10 (Cambridge) with kernel: 
>> 2.6.27.38-170.2.113.fc10.i686.PAE #1 SMP )
>> *Commnads to set PC
>>
>>         ethtool -s eth0 autoneg off speed 1000 duplex full
>>         ifconfig eth1 172.16.0.1/12 mtu 6000 txqueuelen 10000
>>         echo 131071 > /proc/sys/net/core/rmem_max
>>         echo 131071 > /proc/sys/net/core/wmem_max
>>         echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_rmem
>>         echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_wmem
>>         iperf -s -l 2m -w 70k
>>
>>
>> *The MPC8313e RDB(CPU: 333Mhz; CSB: 166Mhz) revA4 and 
>> revC(using PHY not 
>> switch)
>> *Commnads to set a board before using iperf
>>
>>         ifconfig eth1 172.16.0.1/12 mtu 6000 txqueuelen 10000
>>         #The PC  lan card is set to advertise 1000Mbps only, so the 
>> board switches to 1000Mbps too.
>>         echo 131071 > /proc/sys/net/core/rmem_max
>>         echo 131071 > /proc/sys/net/core/wmem_max
>>         echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_rmem
>>         echo "4096    1048576   8388608" > /proc/sys/net/ipv4/tcp_wmem
>>
>> Regards,
>> Asen
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>
>>     
