Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4A2E67B9C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Sep 2006 01:49:48 +1000 (EST)
Message-ID: <45019041.2070409@gmail.com>
Date: Fri, 08 Sep 2006 16:46:09 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: SystemAce Driver.
References: <20060724121452.55760.qmail@web53608.mail.yahoo.com>	<44C4BE5B.3000002@gmail.com>	<44D9F9DF.5020100@gmail.com>
	<44DC4F34.1070308@gmail.com> <44FFE0EC.6010603@gmail.com>
In-Reply-To: <44FFE0EC.6010603@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sudheer,
    Ah! I never did the test for polled mode. There might be issue with 
that. Will have a look....

-Ameet

sudheer wrote:
> Hi Ameet Patil
> 
> Ameet Patil wrote:
>> Hi Sudheer,
>>    Frank has already answered your questions. If you have any problems 
>> with the SysAce patch... do let me know. I have written a small 
>> tutorial here if it helps...
> I have used your SystemAce patch with linux-2.6.16-2. The kernel gets 
> loaded with the ace module and is fine.
> I want the driver in polling mode. So i have commented few lines related 
> to interrupt in the adapter.c file- xsysace_init function.
> 
> When i give the fdisk command, it gives few errors and then enters to  
> the  fdisk commad promt. It prints the partitions, etc.
> 
> But when  i try to quit from the fdisk, it hangs. I am not able to 
> complete the request properly (i guess in xsa_thread function in 
> adapter.c file)
> 
> The dump is as follows:
> SystemACE: Error 1 when reading sector 60.
> end_request: I/O error, dev xsa, sector 56
> SystemACE: Error 1351 when reading sector 62.
> end_request: I/O error, dev xsa, sector 56
> 
> Command (m for help): p
> 
> Disk /dev/xsysace: 512 MB, 512483328 bytes
> 16 heads, 62 sectors/track, 1009 cylinders
> Units = cylinders of 992 * 512 = 507904 bytes
> Device Boot Start End Blocks Id System
> /dev/xsysace1 1 1009 500433 6 FAT16
> 
> Command (m for help): q
> -------
> The fdisk enters into xsysace_ioctl function but no commands are 
> implemented in the ioctl function and returns an error.
> 
> Please help me in this issue and let me know if any other details required.
> 
> Thanks
> Sudheer
> 
>>
>> http://linux.get2knowmore.com
>>
>>
>> -Ameet
>>
>> sudheer wrote:
>>> Hello Ameet Patil
>>>
>>> I am looking for linux kernel source 2.6.16 with system ace 
>>> controller support. I downloaded the linux-2.6.16 and linux-2.6.17-1 
>>> source from kernel.org but could not find any files related to system 
>>> ace controller  ( No xilinx_sysace directory in  drivers/block/) .  I 
>>> have checked penguinppc.org also but could not get it.
>>>
>>> Can you please send to me the link where i could download the 
>>> linuxppc-2.6.16 source with system ace support.
>>>
>>> Thanks & Regards
>>> Sudheer
>>>
>>> Ameet Patil wrote:
>>>> Hi Raja,
>>>>     I have ported the Xilinx System ACE driver to 2.6 kernel. Find 
>>>> the latest one here:
>>>> http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch 
>>>>
>>>>
>>>> NOTE: this patch wouldn't work if you are using the TEMAC driver. In 
>>>> which case use the -after-TEMAC patch found in the patches folder 
>>>> above.
>>>>
>>>> Check the following discussions (threads) for more details:
>>>> 1. "Xilinx SystemACE driver for 2.6"
>>>> 2. "Xilinx BSP for linux 2.6"
>>>> 3. "Kernel hangs after "Now booting the kernel"."
>>>>
>>>> cheers,
>>>> -Ameet
>>>>
>>>> Raja Chidambaram wrote:
>>>>  
>>>>>  Hi all,
>>>>>  We are working on customized board with amcc 440SPe
>>>>> processor & xilinx System Ace controller. The System
>>>>> Ace controller is connected to compact flash driver.
>>>>>
>>>>> We use u-boot 1.2 as bootloader & linux kernel
>>>>> 2.6.16-2.
>>>>>
>>>>> On the process the u-boot is able to detect compact
>>>>> flash through Xilinx SystemAce controller & able to
>>>>> load the kernel image into compact flash.But when the
>>>>> linux boot's up it not able to detect the System Ace
>>>>> controller or compact flash.
>>>>>
>>>>> Note:we need to have the root file system in compact
>>>>> flash.
>>>>>
>>>>> Is their any drivers available for SystemAce
>>>>> controller on linux 2.6,if their how to get it.please
>>>>> help me in this
>>>>>                                     with regards
>>>>>                                      raja
>>>>>
>>>>>
>>>>>
>>>>> __________________________________________________
>>>>> Do You Yahoo!?
>>>>> Tired of spam?  Yahoo! Mail has the best spam protection around 
>>>>> http://mail.yahoo.com _______________________________________________
>>>>> Linuxppc-embedded mailing list
>>>>> Linuxppc-embedded@ozlabs.org
>>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>>
>>>>>     
>>>> _______________________________________________
>>>> Linuxppc-embedded mailing list
>>>> Linuxppc-embedded@ozlabs.org
>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>
>>>>   
>>>
>>
> 
