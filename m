Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 10456DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 05:51:05 +1100 (EST)
Message-ID: <49D50910.4020909@grandegger.com>
Date: Thu, 02 Apr 2009 20:50:56 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
References: <49C26434.30302@grandegger.com>	
	<fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>	
	<49D1E3E5.3080607@grandegger.com>	
	<fa686aa40903310623r2b2db0adjb912cfefd3a321e2@mail.gmail.com>	
	<49D21C75.7060307@grandegger.com>	
	<fa686aa40903310805k794b9df0s4d21a8080907a767@mail.gmail.com>	
	<20090331155443.GA28242@oksana.dev.rtsoft.ru>	
	<49D3197C.7000806@grandegger.com>
	<fa686aa40904010540h53c8975ao196657f6fdd66583@mail.gmail.com>
	<49D367C7.5010802@grandegger.com>
	<D7365D0C-57B0-479C-9335-265620B8E5AE@kernel.crashing.org>
	<49D45D4F.3010103@grandegger.com>
	<3247527D-1FD0-420F-99C6-9DADBB79B020@kernel.crashing.org>
In-Reply-To: <3247527D-1FD0-420F-99C6-9DADBB79B020@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Apr 2, 2009, at 1:38 AM, Wolfgang Grandegger wrote:
> 
>>
>> Socrates is a new board and it has no problem using an up-to-date
>> version of U-Boot. The socrates.dts file in your "next" tree already has
>> the "device_type = "soc" removed. We need to add "fsl,soc" to the
>> "compatible" property and update fsl_get_sys_freq(), etc. to search for
>> it as well. And U-Boot should use the same name to fixup the
>> frequencies. Are you already working on that issue? Should I provide
>> patches?
>>
> 
> I'm not working on it at all.  I'm also guessing at this point the
> Socrates support is in Linus tree :)

Yes, I know, but it does not work properly because the "device_type =
"soc" is missing :-(. I did not realize that immediately, sorry. Could
you please apply the fix below re-adding the 'device_type = "soc";' line
for the time being.

Thanks.

Wolfgang.


[PATCH] powerpc/85xx: Re-add the device_type soc to socrates.dts

The device_type "soc" is still required for MPC85xx boards.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/socrates.dts |    1 +
 1 file changed, 1 insertion(+)

Index: powerpc/arch/powerpc/boot/dts/socrates.dts
===================================================================
--- powerpc.orig/arch/powerpc/boot/dts/socrates.dts	2009-04-01
15:26:09.000000000 +0200
+++ powerpc/arch/powerpc/boot/dts/socrates.dts	2009-04-02
16:37:09.838719521 +0200
@@ -52,6 +52,7 @@
 	soc8544@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
+		device_type = "soc";

 		ranges = <0x00000000 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00001000>;	// CCSRBAR 1M
