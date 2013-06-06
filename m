Return-Path: <knight@princeton.edu>
Received: from skuld.princeton.edu (skuld.Princeton.EDU [128.112.173.239])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E84AF2C01D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 22:40:17 +1000 (EST)
Message-ID: <51B08311.3080406@princeton.edu>
Date: Thu, 06 Jun 2013 08:39:45 -0400
From: Robert Knight <knight@princeton.edu>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: IBM OpenPower 720 ipr driver woes
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com> <51AD088C.8040803@princeton.edu>
 <20130604000130.GA25055@thor.bakeyournoodle.com>
 <51AD45A4.9080702@princeton.edu>
 <20130604031651.GA3373@thor.bakeyournoodle.com>
 <20130604035223.GA27964@shangw.(null)> <51AFAA2C.5060304@princeton.edu>
 <51B07336.7040609@linux.vnet.ibm.com>
In-Reply-To: <51B07336.7040609@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Wendy Xiong <wenxiong@linux.vnet.ibm.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2013 07:32 AM, Brian King wrote:
> On 06/05/2013 04:14 PM, Robert Knight wrote:
>> On 6/3/2013 11:52 PM, Gavin Shan wrote:
>>> On Tue, Jun 04, 2013 at 01:16:52PM +1000, Tony Breeds wrote:
>>>> On Mon, Jun 03, 2013 at 09:40:52PM -0400, Robert Knight wrote:
>>>>> On 6/3/2013 8:01 PM, Tony Breeds wrote:
>>>>>> On Mon, Jun 03, 2013 at 05:20:12PM -0400, Robert Knight wrote:
>>>>>>
>>>>>>>> Device tree struct  0x0000000004820000 -> 0x0000000004840000
>>>>>>>> Calling quiesce...
>>>>>>>> returning from prom_init
>>>>>>>> [    1.376359] ehci-pci 0000:c8:01.2: can't setup
>>>>>> Can you try adding "debug" to the kernel commandline.  We're missing a
>>>>>> great chunk of detail. If you're starting from scratch either try F18 or
>>>>>> the F19 Beta (if you're brave :))
>>>>>>
>>>>>> Yours Tony
>>>>> So, two points.  Since I have no live disks, I can't copy the dmesg
>>>>> output in dracut onto a disk and just sent it to you -- the only way
>>>>> that I know to get it is cut and paste from a HMC console window
>>>>> into a vi buffer.
>>>> Okay, when I've been in that situation, I run "script" locally and then
>>>> conenct to the HMC console.
>>>>
>>>> When you're done you can exit script adn then a file called typescript
>>>> will exist in the directory you ran script in.
>>>>
>>>> It's a less overhead way of doign what you're already doing.
>>>> [    0.087097] NET: Registered protocol family 16
>>>>
>>>>> [    0.087144] pseries_eeh_init: RTAS service <ibm,get-config-addr-info2> and <i
>>>>> bm,get-config-addr-info> invalid
>>>>> [    0.087155] eeh_init: Failed to call platform init function (-22)
>>>> Hmm this seems pretty strange to me.  Gavin are these RTAS tokens
>>>> supported on older power5 boxes?
>>>>
>>> Yes, Tony. "ibm,get-config-addr-info" should be supported on Power5 box.
>>> Newer PowerBox (e.g. P7) should support "ibm,get-config-addr-info2"
>>>
>>> Please have a try on the attached patch, which is based on mainline (3.10).
>>>
>>> Thanks,
>>> Gavin
>>>
>>>
>> The system boots with that patch.  I applied it to kernel-3.8.11-100.
> Does that patch resolve all your issues, or are there still issues with ipr remaining
> after applying the patch?
>
> Thanks,
>
> Brian
>
Yes.  I've started rebuilding the kernel and I'm up to the module 
building part, so I'd say it is solid.  Will this patch make it into 
some version of the kernel?

What was killing me was that it would not complete boot.  It now does.  
I see:

[   11.934481] scsi 0:0:15:0: Resetting device
[   11.934813] ipr 0001:d0:01.0: Adapter being reset as a result of 
error recovery.

on each boot.  It does not appear to affect operation.

Thank you and the rest of the team for your rapid and helpful responses.

Best regards,
Robert
