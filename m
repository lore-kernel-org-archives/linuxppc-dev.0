Return-Path: <tnt@246tNt.com>
Message-ID: <4550C31E.4080805@246tNt.com>
Date: Tue, 07 Nov 2006 18:32:14 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_platform support for OHCI/Bigendian HC
References: <200611061035.kA6AZtGZ018329@post.webmailer.de>
	<9580D2CE-BD68-440F-A1FD-09E882D93231@kernel.crashing.org>
	<454FC539.2050900@246tNt.com>
	<754FECA8-A7B4-44FE-A08D-89019F9005A8@kernel.crashing.org>
In-Reply-To: <754FECA8-A7B4-44FE-A08D-89019F9005A8@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>>>> This patch use of_platform device to probe and install OHCI big
>>>> endian HC.
>>>>
>>>> PS: I did not success to properly inline the file using thrunderbird.
>>>>
>>>
>>> You really copy the USB maintainers on this.  Also, why bother with
>>> the Kconfig for USB_OHCI_HCD_PPC_OF_BE/USB_OHCI_HCD_PPC_OF_LE?
>>>
>> I think it's a good idea to use those :
>>  - Just including both when PPC_OF is used is overkill because it makes
>> all USB
>> perform useless tests if you never intend to use the LE version for
>> example.
>>  - Using the already defined symbol USB_OHCI_BIG_ENDIAN would force
>> other ohci user to select BE/LE and they may not want to expose this.
>
> Maybe I'm missing something, but it looks like the _OF_LE & _OF_BE are
> just configuring what matches may occur.  This seems like a one time
> event.

+
+config USB_OHCI_HCD_PPC_OF_BE
+	bool "Support big endian HC"
+	depends on USB_OHCI_HCD_PPC_OF
+	default y
+	select USB_OHCI_BIG_ENDIAN
+
+config USB_OHCI_HCD_PPC_OF_LE
+	bool "Support little endian HC"
+	depends on USB_OHCI_HCD_PPC_OF
+	default n
+	select USB_OHCI_LITTLE_ENDIAN

What's important is the USB_OHCI_BIG_ENDIAN and USB_OHCI_LITTLE_ENDIAN symbols that are selected when you choose these options.
When both are active, each usb mmio access will test either to access in BE mode or LE mode. If only one is active, the test is hardcoded.



    Sylvain
