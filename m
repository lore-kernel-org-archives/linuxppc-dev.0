Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 837152C008E
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 05:40:44 +1000 (EST)
Message-ID: <500EFA34.1020801@freescale.com>
Date: Tue, 24 Jul 2012 14:40:36 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com>
In-Reply-To: <500EE1BB.6060104@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:

>> +/include/ "qoriq-mpic.dtsi"
>> +
>> +	guts: global-utilities@e0000 {
>> +		compatible = "fsl,qoriq-device-config-1.0";
>> +		reg = <0xe0000 0xe00>;
>> +		fsl,has-rstcr;
>> +		#sleep-cells = <1>;
>> +		fsl,liodn-bits = <12>;
>> +	};
>> +
>> +	pins: global-utilities@e0e00 {
>> +		compatible = "fsl,qoriq-pin-control-1.0";
>> +		reg = <0xe0e00 0x200>;
>> +		#sleep-cells = <2>;
>> +	};
> 
> Please add fsl,p5040-device-config and fsl,p5040-pin-control.  If you
> want to leave the "1.0" thing in (which was a mistake since this stuff
> doesn't seem to be versioned in any public way), double check that it's
> 100% backwards compatible with p4080.

For "fsl,qoriq-device-config-1.0", the only difference is in the LIODN
registers, since the P4080 and the P5040 have different devices.  For
those devices that are the same, the LIODN registers are the same.

Is that compatible enough?

The same can be said for "fsl,qoriq-pin-control-1.0".  The registers are
generally the same, except when they reference devices that are different
on the SOCs.  For example, the P4080 does  not have 000E_0E84 USB Polarity
Configuration Register (DCFG_USBPCR).

>> +	rcpm: global-utilities@e2000 {
>> +		compatible = "fsl,qoriq-rcpm-1.0";
>> +		reg = <0xe2000 0x1000>;
>> +		#sleep-cells = <1>;
>> +	};

Same thing here.  Except for a few bits for devices that don't exist on
the other SOC, they're the same.


-- 
Timur Tabi
Linux kernel developer at Freescale
