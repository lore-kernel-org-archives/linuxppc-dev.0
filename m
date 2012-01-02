Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DBE07B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2012 04:53:54 +1100 (EST)
Received: from mail146-tx2 (localhost [127.0.0.1])	by
 mail146-tx2-R.bigfish.com (Postfix) with ESMTP id CD82C5402FC	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jan 2012 17:53:50 +0000 (UTC)
Message-ID: <4F01EEFE.9040305@freescale.com>
Date: Mon, 2 Jan 2012 11:53:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <smitha.vanga@wipro.com>
Subject: Re: Mac address in the DTS file
References: <40631E9A2581F14BA60888C87A76A1FE01C6BB@HYD-MKD-MBX4.wipro.com>
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE01C6BB@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/30/2011 06:51 AM, smitha.vanga@wipro.com wrote:
>  
> Hi Scott,
> 
> In my DTS file for mpc8247 I have defined the ether MAC in the node as below.
> 
> ethernet@24000 {
>                        #address-cells = <1>;
>                        #size-cells = <0>;
>                        device_type = "network";
>                        device-id = <1>;
>                        compatible = "fs_enet";
>                        model = "FCC";
>                        reg = <11300 20 8400 100 11380 30>;
>                        mac-address = [ 00 e0 ee 00 05 2e ];
>                        interrupts = <20 2>;
>                        interrupt-parent = <10c00>;
>                        phy-handle = <2452000>;
>                        rx-clock = <13>;
>                        tx-clock = <12>;
>                };

Others have answered your question (the mac address should not be in the
.dts file -- it should be patched in by boot software), but I'd like to
point out that this is a deprecated device tree binding that was very
short-lived in a very old kernel, from an early attempt at 82xx support
in arch/powerpc.  Why are you still using it?  It will not work with
current kernels (which suggests you're also using a very old kernel).

-Scott
