Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 9C5F36884E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Dec 2005 22:36:18 +1100 (EST)
Message-ID: <43A0021E.7030406@ru.mvista.com>
Date: Wed, 14 Dec 2005 14:29:34 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Alex BASTOS <alebas@televes.com>
References: <1134555662.439ff20e6e812@webmail.televes.com:443>
In-Reply-To: <1134555662.439ff20e6e812@webmail.televes.com:443>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pq2_find_bridges hangs system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex BASTOS wrote:
> Vitaly,
> 
> So, I have arrived to some conclusions.
> 
> 1) With my previous kernel version (2.6.11) I had no problems
> because it had CONFIG_PCI_8260 and CONFIG_PPC_INDIRECT_PCI unset.
> So I think no effective read/write operation was executed, and so
> that, no Machine Check.
> 
> In fact, this is the configuration I would prefer for my board. I have
> to set CONFIG_PCI for enabling USB, but I don't want all the HW stuff
> of the PCI. I can get these also with 2.6.15 if I modify Kconfig, to
> allow me to unset PCI_8260 (and then PPC_INDIRECT_PCI) for my board.
> With that, the problem dissapears and I can boot 2.6.15.
> 
> Shouldn't this (PCI_8260) be visible from xconfig for those like me
> who wants USB (=> CONFIG_PCI) but don't really have any PCI device?
> 
Maybe, but I guess more correct is to deal with USB->PCI dependency.. 
Is it really needed(I am not USB expert)?
> 2) Although I am using Uboot 1.1.4, it is not top of git. I have
> found your changes to support PCI on 8272ADS for u-boot are not
> still applied on the version i am using. So, could this be causing
> the problem? Is there any configuration done in u-boot required by
> the PCI on the linux kernel to boot (BR3,OR3, EMR, ...)?
> 
> I should say that, on ADS, I have an older version of u-boot, 1.1.2,
> and it boots OK.
> 
My changes do not required for kernel to deal with PCI, that patch just allows access to PCI in 
U-Boot. Hence I might be useful if you'll head for resolving this issue which I guess unlikely to happen
> 3) I have seen that from u-boot, a reset occurs when I read Internal
> Memory at offset 0x10904 (PCI CFG_DATA). From BDI, when I do the same
> all PCI section on IM becomes zero. Is this a known behaviour? May this
> reflect a hardware problem?
> 
Sounds weird 
> In conclusion, 1) solves my "must", a working board (without PCI).
> But I still would like to know what am I doing so wrong with this.
> 
IMHO ability to disable PCI_8260 while PCI is on might be confusing, at least for upstream.



> Best regards,
> 
> Alex
> 
> Citando Alex BASTOS <alebas@televes.com>:
> 
>> Vitaly,
>>
>> It didn't work. So I will check pq2ads_setup_pci to check if
>> some board specific issue is affected.
>>
>> I will say you if I find anything
>>
>> Thanks
>>
>> Alex.
>>
> 
> 


-- 
Sincerely, 
Vitaly
