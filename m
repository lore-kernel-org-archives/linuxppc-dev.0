Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.3.70]) by ozlabs.org (Postfix) with ESMTP id 8155B2BF1F
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jan 2005 09:18:52 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j01MIdqT023233
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Jan 2005 23:18:41 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41D721E1.8000007@246tNt.com>
Date: Sat, 01 Jan 2005 23:19:13 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Benny Liu <benny@cellvision.com.cn>
References: <008c01c4f005$bc1e94c0$1100a8c0@BENNY>
In-Reply-To: <008c01c4f005$bc1e94c0$1100a8c0@BENNY>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-dev@ozlabs.org
Subject: Re: isochronous mode of USB audio device on MPC5200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Benny


What version of the kernel ?


In the last 2.4 I built ( quite a while ago ... ) there was a flaw
in the handling of the hwPSW field in the OHCI driver when on big-endian
platform. Since this field is only used fot Isochronous the problem
didn't show up before.

The fields were assume by the kernel to be in this order

hwPSW[0]
hwPSW[1]
hwPSW[2]
hwPSW[3]
...

But in fact since the figure in ohci spec shows this array not as an
array of 16bits fields but as an array of 32bits integer, each containing
two hwPSW[] in little endian order, they ended up implemented in the order

hwPSW[1]
hwPSW[0]
hwPSW[3]
hwPSW[2]
...

(fscked up isn't it ? ;)


And that was not taken into account ...


I notified W.Denk about the problem a while ago, don't know if any
action has been taken.




Sylvain Munaut


Benny Liu wrote:

> Hi, everyone, happy new year!
> Did anyone try usb audio device or other isochronous mode usb devices
> on Icecube board(Motorola MPC5200)?
> I tried, but it reports the following message:
> /"host/usb-ohci.c: OHCI Unrecoverable Error, controller usb-0 disabled"/
> After this message, the host controller is disabled.
> Thanks a lot.
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
