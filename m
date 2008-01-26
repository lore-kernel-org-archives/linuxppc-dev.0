Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8DA97DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Jan 2008 18:37:14 +1100 (EST)
Message-ID: <479AE41F.9040507@denx.de>
Date: Sat, 26 Jan 2008 08:41:19 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: Failed to mount rootfs
References: <mailman.1307.1201212280.6908.linuxppc-embedded@ozlabs.org>
	<47998D8B.8050100@denx.de>
	<F795765B112E7344AF36AA911279641502D1A9FA@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A9FA@xmb-sjc-212.amer.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Bizhan,

Bizhan Gholikhamseh (bgholikh) wrote:
>> "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com> wrote:
>>> Our custom board is leveraged from MPC8541cds from freescale.
>>> We have been running Linux 2.6.11 on it recently I have 
>> tried to boot 
>>> the system with the latest Linux 2.6.22-rc4 from PowerPC git tree.
>>>  
>>> I did ported the libfdt to our older version of the uboot and were 
>>> able to
>> Hmm... why you didnt use actual code?
>>
>> [...]
>>>     chosen {
>>>         linux,stdout-path = "/soc8541@e0000000/serial@4600";
>>>     };
>>>     chosen {
>>>         name = "chosen";
>>>         bootargs = "root=/dev/ram rw console=ttyS1,115200";
>>>         linux,platform = <600>;
>>>         linux,initrd-start = <1ef33000>;
>>>         linux,initrd-end = <1fe190aa>;
>>>         linux,stdout-path = "/soc8541@e0000000/serial@4600";
>>>     };
>>> };
>> Here is your problem, you have 2 choosen nodes:
>>
>> 64k data, 108k bss, 116k init) Mount-cache hash table entries: 512
>> device-tree: Duplicate name in /, renamed to "chosen#1"
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> -> Linux didnt find your commandline ...
>>
>> Hmm... do you have CONFIG_OF_FLAT_TREE and CONFIG_OF_LIBFDT defined?
>> If so, this would explain, why you have 2 choosen nodes.
> 
> Yes I do have both CONFIG_OF_FLAT_TREE and CONFIG_OF_LIBFDT defined. Is
> there a document to tell more about these options please?

Yes, read the README in the U-Boot root. CONFIG_OF_FLAT_TREE is deprecated,
you should use CONFIG_OF_LIBFDT.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
