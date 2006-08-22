Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 5AEB867C71
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 01:08:12 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id D232887806E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 08:08:07 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r68m080807D-03-2
	for linuxppc-embedded@ozlabs.org; Tue, 22 Aug 2006 08:08:07 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 6181B8780A7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 08:08:07 -0700 (PDT)
Message-ID: <44EB1DC2.5070307@gmail.com>
Date: Tue, 22 Aug 2006 20:37:46 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: SystemAce Driver.
References: <20060724121452.55760.qmail@web53608.mail.yahoo.com>	<44C4BE5B.3000002@gmail.com>	<44D9F9DF.5020100@gmail.com>
	<44DC4F34.1070308@gmail.com> <44DC5F21.8000906@gmail.com>
In-Reply-To: <44DC5F21.8000906@gmail.com>
Content-Type: multipart/alternative;
	boundary="------------020501010800050700090308"
Cc: raja_chidambaram82@yahoo.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020501010800050700090308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Raja,

We too are working on customized board with amcc 440SPe processor & 
xilinx System Ace controller. The System Ace controller is connected to 
compact flash driver.
We use u-boot 1.1.2 as bootloader & linux kernel - 2.6.16-2.

System ace is connected to amcc440SPE processor via GPIO and External 
Peripheral Bus Controller(EBC).

While booting the linux, it crashes when i am trying to 
access(read/write) a system ace register.
In the u-boot though i have support, as of now  i am not doing anything 
with system ace as it not required now.
In u-boot/include/configs/custom_board.h, i could see
#define CFG_ACE_BASE        0xe0000000          /* Xilinx ACE controller 
- Compact Flash */
 So i have used this address in Linux driver to to ioremap to access 
the  ace registers. Though i could do ioremap,  it crashes while booting 
exactly when it is trying the access any ace register.

I doubt with the address i have used . But could not get any clue from 
the docs given.

I want to know how to access the system ace registers and how to  get 
the address to ioremap. Please let me know if any details required and 
also if i am missing any fundamentals.


Thanks & Regards
Sudheer




sudheer wrote:
> Hi Ameet,
>
> Firstly, thanks for the mail.
>
> I am able to compile the linux-2.6.16 and got the ace support files with 
> the patch.
> While compiling got some errors with  xparameters, but am rectify  them.
>
> I need to wait for the hardware to test the source.
>
> Thanks & Regards
> Sudheer
>
>
> Ameet Patil wrote:
>   
>> Hi Sudheer,
>>    Frank has already answered your questions. If you have any problems 
>> with the SysAce patch... do let me know. I have written a small 
>> tutorial here if it helps...
>>
>> http://linux.get2knowmore.com
>>
>>
>> -Ameet
>>
>> sudheer wrote:
>>     
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
>>>       
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
>>>>>           
>>>> _______________________________________________
>>>> Linuxppc-embedded mailing list
>>>> Linuxppc-embedded@ozlabs.org
>>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>
>>>>   
>>>>         
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   


--------------020501010800050700090308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hello Raja,<br>
<br>
We too are working on customized board with amcc 440SPe processor &amp;
xilinx System Ace controller. The System Ace controller is connected to
compact flash driver. <br>
We use u-boot 1.1.2 as bootloader &amp; linux kernel - 2.6.16-2.<br>
<br>
System ace is connected to amcc440SPE processor via GPIO and External
Peripheral Bus Controller(EBC).<br>
<br>
While booting the linux, it crashes when i am trying to
access(read/write) a system ace register.<br>
In the u-boot though i have support, as of now&nbsp; i am not doing anything
with system ace as it not required now.<br>
In u-boot/include/configs/custom_board.h, i could see <br>
#define CFG_ACE_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xe0000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Xilinx ACE
controller - Compact Flash */<br>
&nbsp;So i have used this address in Linux driver to to ioremap to access
the&nbsp; ace registers. Though i could do ioremap,&nbsp; it crashes while
booting exactly when it is trying the access any ace register. <br>
<br>
I doubt with the address i have used . But could not get any clue from
the docs given.<br>
<br>
I want to know how to access the system ace registers and how to&nbsp; get
the address to ioremap. Please let me know if any details required and
also if i am missing any fundamentals.<br>
<br>
<br>
Thanks &amp; Regards<br>
Sudheer<br>
<br>
<br>
<br>
<br>
sudheer wrote:
<blockquote cite="mid44DC5F21.8000906@gmail.com" type="cite">
  <pre wrap="">Hi Ameet,

Firstly, thanks for the mail.

I am able to compile the linux-2.6.16 and got the ace support files with 
the patch.
While compiling got some errors with  xparameters, but am rectify  them.

I need to wait for the hardware to test the source.

Thanks &amp; Regards
Sudheer


Ameet Patil wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi Sudheer,
   Frank has already answered your questions. If you have any problems 
with the SysAce patch... do let me know. I have written a small 
tutorial here if it helps...

<a class="moz-txt-link-freetext" href="http://linux.get2knowmore.com">http://linux.get2knowmore.com</a>


-Ameet

sudheer wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Hello Ameet Patil

I am looking for linux kernel source 2.6.16 with system ace 
controller support. I downloaded the linux-2.6.16 and linux-2.6.17-1 
source from kernel.org but could not find any files related to system 
ace controller  ( No xilinx_sysace directory in  drivers/block/) .  I 
have checked penguinppc.org also but could not get it.

Can you please send to me the link where i could download the 
linuxppc-2.6.16 source with system ace support.

Thanks &amp; Regards
Sudheer

Ameet Patil wrote:
      </pre>
      <blockquote type="cite">
        <pre wrap="">Hi Raja,
    I have ported the Xilinx System ACE driver to 2.6 kernel. Find 
the latest one here:
<a class="moz-txt-link-freetext" href="http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch">http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.2.patch</a> 


NOTE: this patch wouldn't work if you are using the TEMAC driver. In 
which case use the -after-TEMAC patch found in the patches folder 
above.

Check the following discussions (threads) for more details:
1. "Xilinx SystemACE driver for 2.6"
2. "Xilinx BSP for linux 2.6"
3. "Kernel hangs after "Now booting the kernel"."

cheers,
-Ameet

Raja Chidambaram wrote:
 
        </pre>
        <blockquote type="cite">
          <pre wrap=""> Hi all,
 We are working on customized board with amcc 440SPe
processor &amp; xilinx System Ace controller. The System
Ace controller is connected to compact flash driver.

We use u-boot 1.2 as bootloader &amp; linux kernel
2.6.16-2.

On the process the u-boot is able to detect compact
flash through Xilinx SystemAce controller &amp; able to
load the kernel image into compact flash.But when the
linux boot's up it not able to detect the System Ace
controller or compact flash.

Note:we need to have the root file system in compact
flash.

Is their any drivers available for SystemAce
controller on linux 2.6,if their how to get it.please
help me in this
                                    with regards
                                     raja



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
<a class="moz-txt-link-freetext" href="http://mail.yahoo.com">http://mail.yahoo.com</a> _______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

    
          </pre>
        </blockquote>
        <pre wrap="">_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

  
        </pre>
      </blockquote>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

  </pre>
</blockquote>
<br>
</body>
</html>

--------------020501010800050700090308--
