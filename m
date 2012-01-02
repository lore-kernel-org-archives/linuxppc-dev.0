Return-Path: <linuxppcemb@lkmail.de>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EB445B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2012 02:42:54 +1100 (EST)
Message-ID: <4F01D06E.1010306@lkmail.de>
Date: Mon, 02 Jan 2012 16:42:38 +0100
From: Lorenz Kolb <linuxppcemb@lkmail.de>
MIME-Version: 1.0
To: smitha.vanga@wipro.com
Subject: Re: Mac address change in linux
References: <40631E9A2581F14BA60888C87A76A1FE01C96A@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE01C96A@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Smitha,

first of: please try changing the MAC of the adapter, not of the virtual 
interface (btw: are you sure, that you really intend to have  a physical 
and a virtual interface that have the same configurations and the same 
metric?).
second: guess your copy+pasted log shows: that you concatenated 
"ifconfig eth0.246 up" to the actual MAC address change command by 
accident. Please try again, without these additional (surely non 
working) parameters.

Regards,

lorenz

On 1/2/2012 12:24 PM, smitha.vanga@wipro.com wrote:
> Hi Scott,
>
> When I execute below statements in linux to change the mac address I get the error Host name look up error.
> Below are the commands I execute to change the mac address and the console output.
>
>
> 1. ifconfig eth0.246 down
> 2. ifconfig eth0.246 hw ether 00:11:22:33:44:55
>     ifconfig: hw: Host name lookup failure
>
> sh-3.1# ifconfig
> eth0      Link encap:Ethernet  HWaddr 00:E0:EE:00:05:2E
>            inet addr:172.16.52.20  Bcast:172.16.53.255  Mask:255.255.254.0
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:999 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:93661 (91.4 KiB)  TX bytes:0 (0.0 B)
>
> eth0.246  Link encap:Ethernet  HWaddr 00:E0:EE:00:05:2E
>            inet addr:172.16.52.20  Bcast:172.16.53.255  Mask:255.255.254.0
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:0
>            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>
> lo        Link encap:Local Loopback
>            inet addr:127.0.0.1  Mask:255.0.0.0
>            UP LOOPBACK RUNNING  MTU:16436  Metric:1
>            RX packets:4 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:0
>            RX bytes:248 (248.0 B)  TX bytes:248 (248.0 B)
>
> sh-3.1# ifconfig eth0.246 down
> sh-3.1# ifconfig
> eth0      Link encap:Ethernet  HWaddr 00:E0:EE:00:05:2E
>            inet addr:172.16.52.20  Bcast:172.16.53.255  Mask:255.255.254.0
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:1005 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:94205 (91.9 KiB)  TX bytes:0 (0.0 B)
>
> lo        Link encap:Local Loopback
>            inet addr:127.0.0.1  Mask:255.0.0.0
>            UP LOOPBACK RUNNING  MTU:16436  Metric:1
>            RX packets:4 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:0
>            RX bytes:248 (248.0 B)  TX bytes:248 (248.0 B)
>
> sh-3.1# ifconfig eth0.246 hw ether 00:11:22:33:44:55 ifconfig eth0.246 up
> ifconfig: hw: Host name lookup failure
> sh-3.1#
>
>
> Regards,
> Smitha
> Please do not print this email unless it is absolutely necessary.
>
> The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments.
>
> WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email.
>
> www.wipro.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
