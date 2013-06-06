Return-Path: <brking@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3396F2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 21:32:17 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 6 Jun 2013 07:32:12 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DCE2B38C8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 07:32:09 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r56BWADG296328
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 07:32:10 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r56BW9F0012851
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 07:32:09 -0400
Message-ID: <51B07336.7040609@linux.vnet.ibm.com>
Date: Thu, 06 Jun 2013 06:32:06 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Robert Knight <knight@princeton.edu>
Subject: Re: IBM OpenPower 720 ipr driver woes
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com> <51AD088C.8040803@princeton.edu>
 <20130604000130.GA25055@thor.bakeyournoodle.com>
 <51AD45A4.9080702@princeton.edu>
 <20130604031651.GA3373@thor.bakeyournoodle.com>
 <20130604035223.GA27964@shangw.(null)> <51AFAA2C.5060304@princeton.edu>
In-Reply-To: <51AFAA2C.5060304@princeton.edu>
Content-Type: text/plain; charset=ISO-8859-1
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

On 06/05/2013 04:14 PM, Robert Knight wrote:
> On 6/3/2013 11:52 PM, Gavin Shan wrote:
>> On Tue, Jun 04, 2013 at 01:16:52PM +1000, Tony Breeds wrote:
>>> On Mon, Jun 03, 2013 at 09:40:52PM -0400, Robert Knight wrote:
>>>> On 6/3/2013 8:01 PM, Tony Breeds wrote:
>>>>> On Mon, Jun 03, 2013 at 05:20:12PM -0400, Robert Knight wrote:
>>>>>
>>>>>>> Device tree struct  0x0000000004820000 -> 0x0000000004840000
>>>>>>> Calling quiesce...
>>>>>>> returning from prom_init
>>>>>>> [    1.376359] ehci-pci 0000:c8:01.2: can't setup
>>>>> Can you try adding "debug" to the kernel commandline.  We're missing a
>>>>> great chunk of detail. If you're starting from scratch either try F18 or
>>>>> the F19 Beta (if you're brave :))
>>>>>
>>>>> Yours Tony
>>>> So, two points.  Since I have no live disks, I can't copy the dmesg
>>>> output in dracut onto a disk and just sent it to you -- the only way
>>>> that I know to get it is cut and paste from a HMC console window
>>>> into a vi buffer.
>>> Okay, when I've been in that situation, I run "script" locally and then
>>> conenct to the HMC console.
>>>
>>> When you're done you can exit script adn then a file called typescript
>>> will exist in the directory you ran script in.
>>>
>>> It's a less overhead way of doign what you're already doing.
>>> [    0.087097] NET: Registered protocol family 16
>>>
>>>> [    0.087144] pseries_eeh_init: RTAS service <ibm,get-config-addr-info2> and <i
>>>> bm,get-config-addr-info> invalid
>>>> [    0.087155] eeh_init: Failed to call platform init function (-22)
>>> Hmm this seems pretty strange to me.  Gavin are these RTAS tokens
>>> supported on older power5 boxes?
>>>
>> Yes, Tony. "ibm,get-config-addr-info" should be supported on Power5 box.
>> Newer PowerBox (e.g. P7) should support "ibm,get-config-addr-info2"
>>
>> Please have a try on the attached patch, which is based on mainline (3.10).
>>
>> Thanks,
>> Gavin
>>
>>
> The system boots with that patch.  I applied it to kernel-3.8.11-100.

Does that patch resolve all your issues, or are there still issues with ipr remaining
after applying the patch?

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
