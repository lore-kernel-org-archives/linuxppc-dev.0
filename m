Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id EA93A67C7F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 09:26:36 +1000 (EST)
In-Reply-To: <42DBCE60.8090300@anagramm.de>
References: <42DBCE60.8090300@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <550C0481-4DD8-4AFC-AFA2-13AAEBD055E5@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 18 Jul 2005 11:17:21 -0500
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8540 DMA routines (channel 0 broken?)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Glad to see that the issue was software.  If there is something going  
on in u-boot during init that isn't leaving the DMA channel in a  
clean state let me know.

Also, it looks like there maybe some proposal for a general DMA  
engine API.  If your interested take a look at the Linux Sympoisum  
2005 papers (Accelerating Network Receive Processing).  I'm hoping to  
talk to the guys doing this to see what their thoughts are.  If you  
have some feedback on what they are proposing let me know.

- kumar

On Jul 18, 2005, at 10:44 AM, Clemens Koller wrote:

> Hello, Stephane!
>
>
>>> In the meanwhile, I got channel 0 working. It seems
>>> that the DMA#0 machine got stuck in some configuration from any
>>> previous (u-boot?) operation which didn't clean up things
>>> properly. I had to explicitly abort a (continously running?)
>>> transfer to be able to re-program it in the way I need.
>>>
>>
>> Are you using a BDI2000?
>>
>
> Nope.
>
>
>> Some init mode uses the DMA#0 for memory zeroing (see your .cfg  
>> file).
>> Also the DDR ECC U-boot code may use the DMA#0.
>> Isn't it possible to reset the DMA#0 from Linux?
>>
>
> Thank you! Yes, that's true! <ACK>
>
> I've checked the U-Boot code, today. The problem comes up when
> U-Boot is built with CONFIG_DDR_ECC.
> The DMA #0 is used to initialize the DDR prior enabling ECC.
> Maybe the DMA doesn't get cleaned up properly.
> (I'll have to re-check the registers).
>
> But I can get my mpc85xx_dma "driver" working now.
> However I cannot disable ECC when I am in Linux for testing
> yet. :-]
> I'll need to customize U-Boot without ECC because I don't want
> to use it due to performance issues anyway.
> But that's getting OT here.
>
> Greets,
>
> Clemens Koller
> _______________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Str. 45/1
> 81379 Muenchen
> Germany
>
> http://www.anagramm.de
> Phone: +49-89-741518-50
> Fax: +49-89-741518-19
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
