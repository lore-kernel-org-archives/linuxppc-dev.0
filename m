Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 78245DDE0A
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 04:45:36 +1000 (EST)
Message-ID: <47F91A4C.6030109@grandegger.com>
Date: Sun, 06 Apr 2008 20:45:32 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] tqm8560.dts: add local bus devices
References: <47F8C230.4090607@grandegger.com>	<0d57d42da9d29cc240be9d38de29ed96@kernel.crashing.org>
	<47F90B97.4080904@grandegger.com>
In-Reply-To: <47F90B97.4080904@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> Segher Boessenkool wrote:
>>> +                        partition@300000 {
>>> +                                label = "fs";
>>> +                                reg = <0x00300000 0x07c00000>;
>>> +                        };
>>> +                        partition@7700000 {
>>> +                                label = "firmware";
>>> +                                reg = <0x07700000 0x00100000>;
>> These two overlap; should the latter be @7f00000?
> 
> Yes, of course.
> 
>>> +        can@2,0 {
>>> +            device_type = "can";
>> No device_type please.
> 
> OK, but then I better use a more descriptive name for the compatible
> property, e.g.:
> 
> 	compatible = "can-i82527";	// Intel 82527 or Bosch CC770
> 
>>> +        nand@3,0 {
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +            compatible = "fsl,mpc8560-fcm-nand",
>>> +                         "fsl,elbc-fcm-nand";
>>> +            reg = <0x3 0x0 0x8000>;
>>> +
>>> +            kernel@0 {
>>> +                                label = "kernel";
>>> +                reg = <0x000000 0x0300000>;
>>> +            };
>>> +            fs@300000 {
>>> +                                label = "fs";
>>> +                reg = <0x300000 0x7d00000>;
>>> +            };
>>> +        };
>>> +    };
>> There should be a node that describes the nand chip between the nand
>> controller node and the partition nodes.
> 
> I took the mpc8378_*.dts files of 2.6.25-rc8 as example and there is no
> such node. Could you point me please to a more appropriate example.

In the meantime I realized, that the upcoming FSL UPM driver seems to be
appropriate for that board:

  http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052890.html

What is the status of this driver? Are there already some boards using
it (including DTS file)?

Wolfgang.
