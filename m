Return-Path: <fkan@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7294ADDFB7
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 02:30:56 +1000 (EST)
Message-ID: <49E4BA36.2080102@amcc.com>
Date: Tue, 14 Apr 2009 09:30:46 -0700
From: Feng Kan <fkan@amcc.com>
MIME-Version: 1.0
To: SunNeo <sunwx2001@hotmail.com>
Subject: Re: Help!Some memory doesn't work on PPC405Ex based board!
References: <BAY114-W121B40A28E203154BC9209AB7F0@phx.gbl><200904141123.02495.sr@denx.de>
	<BAY114-W4176A96E45AE37FB5FBE02AB7C0@phx.gbl>
In-Reply-To: <BAY114-W4176A96E45AE37FB5FBE02AB7C0@phx.gbl>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-dev@ozlabs.org, support@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi SunNeo:

The fact that it is hanging at the same place in kernel seems strange.
Usually when dram initialization is incorrect,
the kernel would not run at all. Uboot just hangs at relocate code. I
suggest you turn on early kernel printf to see
if you get some other outputs.

P.S when you have discrete memory on board. you have to be sure that
your calibration values are correct. The RDCC
RQDC value should be best possible. You can run the fix initialization
and then lift the autocalibration routine
to the end of the fix dram init to determine the best RFDC RQDC windows.
After that recode the fix values for those
registers.

Feng Kan
AMCC Software

SunNeo wrote:
> Hi, Stefan,
>  
> Thanks for your help.
>  
> My platform uses the MICRON MT47H256M8THN DDRII SDRAM and the DDRII SDRAM is soldered on the board.
>
> As I said, my board was similar with "Kilauea" evb, so I created my configuration header file from Kilauea's at U-Boot. In the configuration file, register value for the DDR SDRAM controller is defined. But I have removed DDR autocalibraton related configuration from the configuration file, do you think this will cause any issues?
>  
> I'm not sure what you mean about "intensive memory test". I use "mm" cmd under U-Boot command prompt to modify value of high 512M memory, and this command works well.
>  
> About booting Linux, the kernel hangs at the same location. Always after this print info "<4>Mount-cache hash table entries: 512".
>
> Best Regards,
> Sun
>  
>   
>> From: sr@denx.de
>> To: linuxppc-dev@ozlabs.org
>> Subject: Re: Help!Some memory doesn't work on PPC405Ex based board!
>> Date: Tue, 14 Apr 2009 11:23:02 +0200
>> CC: sunwx2001@hotmail.com
>>
>> On Monday 13 April 2009, SunNeo wrote:
>>     
>>> I'm porting Linux-2.6.29 on PPC405Ex based board, it's very similar to AMCC
>>> "Kilauea" evb.
>>>
>>> In my board, two 512MB DDRII memory is connected to 2 ranks of the 405Ex
>>> CPU. This 1GB memory works well at U-Boot-2009.01, but when I boot
>>> Linux-2.6.29, the kernel hangs somewhere.
>>>       
>> Does it just hang "somewhere", or always at the same location? A random hangup 
>> could mean that you are having a memory problem (hardware, or wrong 
>> initialization).
>>
>>     
>>> What interesting is, if I 
>>> configured the system to use only 512MB memory at U-Boot, the Linux can
>>> boot normally .
>>>       
>> Are you using DIMM's on your platform? Or soldered chips? Which memory 
>> initialization code are you using in U-Boot? And which autocalibration code?
>>
>> Did you do some intensive memory test?
>>
>> Best regards,
>> Stefan
>>     
>
>
>   _____  
>
> 把MSN装进手机，更多聊天乐趣等你挖掘！ 立刻下载！ <http://mobile.msn.com.cn/> 
>
>   
