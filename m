Message-ID: <3E8B28B6.2090009@esteem.com>
Date: Wed, 02 Apr 2003 10:15:18 -0800
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux support for MPC859T processor
References: <3E8A4B70.7090607@tait.co.nz> <3E8A4EE1.8090205@mvista.com> <3E8A536A.8070506@tait.co.nz> <3E8A554A.2040700@mvista.com> <3E8A5B69.1030601@tait.co.nz>
In-Reply-To: <3E8A5B69.1030601@tait.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	From what you describe of the MPC859T I would say that porting the
kernel may not be too difficult. The motorola web page claims that the
MPC859T has a RTC. It sound like it is just a stripped down MPC866 with
just one SCC and one FEC. Without a data book its hard to say what may
need to change in the kernel to make it work, but I doubt it will be much.

	Unless the MPC859T has introduced new instructions assembly should be
identical to the MPC860.I also doubt that you would need to write a
single line of assembly. Perhaps you should look into 'PPCBoot' (
http://ppcboot.sourceforge.net ) or 'Das U Boot' (
http://sourceforge.net/projects/u-boot/ ) for starters. PPCBoot was a
godsend and abstracted a lot of the porting head aches for us.

	 In designing a propretary design I would suggest you look at the
kernel code and try and map your io pins in a similar manner as some
supported board. It eases the amount of work needed to port the kernel.
An In Circuit Emulator or BDM/JTAG debugger can be worth its weight in
gold in bringing up a propretary design. Just beware that quite a few
will not work once you get Linux up and going on your board. You also
may want the initial prototype design to accept socketed flash as well
as the rom/flash you intend on using in production. Sometimes getting a
BDM/JTAG debugger or ICE to do it is a major pain. A bootstrap header
that allows you to power and program the flash in the circuit might be
better because it can aid in production. Its just alot harder to design.

Good Luck and have fun ripping your hair out.

Conn

Dmytro Bablinyuk wrote:
>
> Yes, we are ready to have a big pain with porting, and we know that
> there is a risk which we are trying to reduce.
> Would the MontaVista give some hands on, for example, how to an internal
> RTC function on '860 represent in the kernel ('859 doesn't have RTC
> func) and how it's affect the kernel and how it could be "removed" etc?
> So, we at least would know what shall we look for.
> Also could you please tell me how assembler on '860 different from '859?
> Would this affect booting?
>
>> Honestly, I don't know my guess is close to non to a small handful...
>> But I am truely a novice when it comes to CPU/board bringup.. (I've
>> assisted in it, but my expertise and history is in userspace
>> development.)  The things that can take massive amounts of time on
>> these new processors/boards are hardware bugs (cpu and board) as well
>> as device drivers for new on chip devices.  I have seen more then one
>> engineer going bald due to hardware bugs, especially a board that the
>> customer said "But it runs VxWorks, why doesn't it run Linux?"...
>>
>>> Not a lot of our people experienced in PPC assembler (including myself).
>>> Actually not a lot experienced with PPC at all.
>>> Roughly, from your point of you, how major changes in the kernel
>>> could be? Just your subjective opinion.
>>>
>>>> On userspace basis.. the 860 and the 859 are fully compatable.. The
>>>> need for
>>>> 859T changes may be in the kernel.  So anyone who sells/supports an
>>>> 860 based
>>>> system can support your needs for application level.  (That includes
>>>> MontaVista.)
>>>>
>>>> The linux kernel of course is a different level of complexity.
>>>>
>>>>> We are trying to find a linux supplier who supports Motorola MPC859T
>>>>> processor (actually it will be processor from Motorola but our custom
>>>>> board).
>>>>
>>>>
>
>
>
>
>


--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
