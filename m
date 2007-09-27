Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 1B391DDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 01:44:38 +1000 (EST)
In-Reply-To: <20070927024535.GC14030@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-08.miltonm@bga.com>
	<20070924033612.GI8058@localhost.localdomain>
	<5e71423247aef068d82b84166102fd7d@bga.com>
	<20070925034616.GB2525@localhost.localdomain>
	<69f1ad37eec293a4c4616d04c8400ca4@bga.com>
	<20070927024535.GC14030@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <41180fced14196db80f261d2ac1909e0@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 8/15] bootwrapper: convert flatdevtree to version 16
Date: Thu, 27 Sep 2007 10:44:27 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 26, 2007, at 9:45 PM, David Gibson wrote:

> On Wed, Sep 26, 2007 at 11:19:47AM -0500, Milton Miller wrote:
>> On Sep 24, 2007, at 10:46 PM, David Gibson wrote:
>>> On Mon, Sep 24, 2007 at 01:54:32AM -0500, Milton Miller wrote:
>>>> On Sep 23, 2007, at 10:36 PM, David Gibson wrote:
>>>>> On Fri, Sep 21, 2007 at 06:05:06PM -0500, Milton Miller wrote:
>>> [snip]
>>>>>> +#define MIN_VERSION 2
>>>>>> +#define OUT_VERSION 16z


>>>> Actually the v1 trees has
>>>> some other differences such as initrd addresses were kernel linear  
>>>> not
>>>> real, cpus were assigned logical numbers  ... so while the structure
>>>> didn't change except for the header field, the contents did.
>>>
>>> !? what's your source for this.  v2 and v3 were absolutely supposed  
>>> to
>>> be backwards compatible with v1 which would not be the case with
>>> silent semantic changes such as this.
>>
>> What's your souce for saying the were supposed to be backwards
>> compatable?  That dtc fills out the struct header so?
>
> Sitting next to BenH and knowing he always intended them to be so.
>
>> My source is my involvment when v2 was defined (they were discovered
>> while writing my device tree generation code):
>>
>> The actual binary structure is compatable, just not the contents of  
>> the
>> properties nor how any slave cpus wait (for some trees it doesn't
>> matter).
>>
>> http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-
>> testing.git;a=blob;f=kexec/arch/ppc64/fs2dt.c;
>> hb=b84b87747a16f0afbef6f6802bb794a94f4961d9
>
> An old version of fs2dt is hardly definitive.  It could just be Plain
> Wrong, nothing to do with the dt version.

Sorry, copy and paste error.  I was tring to point out this changelog  
in 2.6.10:

http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git; 
a=commitdiff;h=e1b47549d1588ccea1fa5726eb430aae4e80f8ed


>
>> And some more changes just before that:
>>
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;
>> a=history;f=arch/ppc64/kernel/prom_init.c;
>> h=e570799a84cc5328e9f0fd44592cb0b828d8c13a;
>> hb=4ae24c4e8a8f68950a7774ca1cdfe69bfe4e2ffc
>
> I don't know what bit you're referring to in that batch of commits.

The following properties changed semantics and no heuristics are  
employed to check for the old vs new:
(1) tces changed from virtual to real
(2) cpus spin on physical (hw id) not logical (0-n)

Other changes in that series
(3) 0->klimit is not a memreserve in the tree (we now allow overlapping  
reserves, but not at the time)
(4) rtas properties are in a different location (but both could exist)

>
>> So its mostly when the kernel generated and required v1 trees, it was
>> ppc64 only and had these other content and handoff semantics.  If it
>> were to get a v1 tree, it only copes for the boot cpu determination
>> I'm not aware of any code other than the kernel that would actually
>> generate a v1 tree (other than dtc, which always supporteed v2, and
>> doesn't care about these differences).

So trying to boot 2.6.9 (2004-10-18 cutoff) kernel from a tree for  
2.6.10 would fail, and vice versa.  But a 2.6.10 kernel can boot a v1  
tree with properties, memreserves, and cpu ids that it expects, getting  
the boot-cpuid from the extra property in the tree.

Is that compatible?  If you only are talking about parsing the tree it  
is.

milton
