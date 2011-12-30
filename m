Return-Path: <linuxppcemb@lkmail.de>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7BAC6B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Dec 2011 01:07:05 +1100 (EST)
Message-ID: <4EFDC3F2.7000607@lkmail.de>
Date: Fri, 30 Dec 2011 15:00:18 +0100
From: Lorenz Kolb <linuxppcemb@lkmail.de>
MIME-Version: 1.0
To: smitha.vanga@wipro.com
Subject: Re: Mac address in the DTS file
References: <40631E9A2581F14BA60888C87A76A1FE01C6BB@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE01C6BB@HYD-MKD-MBX4.wipro.com>
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

actually it should work as normal

On 12/30/2011 1:51 PM, smitha.vanga@wipro.com wrote:
> Its constant. Am not able to change this mac -address in linux once the target is up with LINUX.
> How do I change the MAC address.

actually it should work as normal:
ifconfig ethX down
ifconfig ethX hw ether 00:11:22:33:44:55
ifconfig ethX up

>   If different targets boards are connected on the network then every board will have the same MAC address as  the .dtb file is the same. How to go about this problem?

Depends on your setup: normally the real MAC is stored on some onboard 
configuration space (eeprom or flash).
Afterwards there are multiple ways you could work aroun the problem: 
most elegant: make your bootloader replace the fake MAC with the real 
one within the dtb.
Most simple one: have a startup script that reads the real MAC and does 
the ifconfig magic.

Regards,

Lorenz
