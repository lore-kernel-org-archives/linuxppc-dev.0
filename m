Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 95AF7DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 07:16:56 +1100 (EST)
Message-ID: <49C3F9B5.5000909@grandegger.com>
Date: Fri, 20 Mar 2009 21:16:53 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
References: <49C26434.30302@grandegger.com>
	<734DA8C3-EADB-4426-BD18-AC190918CD7E@kernel.crashing.org>
In-Reply-To: <734DA8C3-EADB-4426-BD18-AC190918CD7E@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Kumar Gala wrote:
> 
> On Mar 19, 2009, at 10:26 AM, Wolfgang Grandegger wrote:
> 
>> +        mdio@24520 {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            compatible = "fsl,gianfar-mdio";
>> +            reg = <0x24520 0x20>;
>> +
>> +            phy0: ethernet-phy@0 {
>> +                interrupt-parent = <&mpic>;
>> +                interrupts = <0 1>;
>> +                reg = <0>;
>> +                device_type = "ethernet-phy";
>> +            };
>> +            phy1: ethernet-phy@1 {
>> +                interrupt-parent = <&mpic>;
>> +                interrupts = <0 1>;
>> +                reg = <1>;
>> +                device_type = "ethernet-phy";
>> +            };
>> +            tbi0: tbi-phy@11 {
>> +                reg = <0x11>;
>> +                device_type = "tbi-phy";
>> +            };
>> +        };
>> +
>> +        mdio@26520 {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            compatible = "fsl,gianfar-tbi";
>> +            reg = <0x26520 0x20>;
>> +
>> +            tbi1: tbi-phy@11 {
>> +                reg = <0x11>;
>> +                device_type = "tbi-phy";
>> +            };
>> +        };
>> +
>> +        enet0: ethernet@24000 {
>> +            cell-index = <0>;
>> +            device_type = "network";
>> +            model = "eTSEC";
>> +            compatible = "gianfar";
>> +            reg = <0x24000 0x1000>;
>> +            local-mac-address = [ 00 00 00 00 00 00 ];
>> +            interrupts = <29 2 30 2 34 2>;
>> +            interrupt-parent = <&mpic>;
>> +            phy-handle = <&phy0>;
>> +            tbi-handle = <&tbi0>;
>> +            phy-connection-type = "rgmii-id";
>> +        };
>> +
> 
> See Anton's recent post in moving the mdio node under the ethernet. 
> Please match.

I have fixed it for the socrates board. Is there a GIT tree with that
modifications which I can base my patches on, also for the one for the
TQM8548 posted recently:

  http://ozlabs.org/pipermail/linuxppc-dev/2009-March/069364.html

Wolfgang.
