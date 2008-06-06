Return-Path: <wg@grandegger.com>
Message-ID: <4848E90F.5090101@grandegger.com>
Date: Fri, 06 Jun 2008 09:36:47 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 2/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
References: <48481E86.1060302@grandegger.com>
	<4188A8A4-BDF9-4D23-A874-19C6A9A18E71@kernel.crashing.org>
	<48484EFE.5050101@grandegger.com>
	<389E58E0-C885-4E8E-B311-C655F52FE23D@kernel.crashing.org>
In-Reply-To: <389E58E0-C885-4E8E-B311-C655F52FE23D@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
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
> On Jun 5, 2008, at 3:39 PM, Wolfgang Grandegger wrote:
> 
>> Kumar Gala wrote:
>>>
>>>> ===================================================================
>>>> --- /dev/null
>>>> +++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8548.dts
>>>>
>>>
>>>> +    memory {
>>>> +        device_type = "memory";
>>>> +        reg = <0x00000000 0x20000000>;
>>>> +    };
>>>
>>> is memory fixed on this board to 256M?
>>
>> Ah, no, actually I have a module with 512 MB but it can be ordered with
>> less or more memory like the other TQM85xx modules as well. Does U-Boot
>> fixup this value? Is it used by Linux?
> 
> if u-boot determines the memory it will update this properly.  Linux
> expects this to be set to know how much mem is in the system.
> 
> if you can try setting the 2nd value to 0x0 and see if it boots that
> will let me know if its safe for me to change.

It works with

	memory {
		device_type = "memory";
		reg = <0x00000000 0x00000000>;	// size filled by U-Boot
	};

as well. With my previous definition Linux came up with 512 MB of memory
as well and it was already obvious, that U-Boot fills in the right size
value.

Wolfgang.
