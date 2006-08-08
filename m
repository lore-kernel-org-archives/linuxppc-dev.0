Return-Path: <pantelis@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id E91FD67A5E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 19:40:47 +1000 (EST)
In-Reply-To: <44D8230F.4020202@us.ibm.com>
References: <20060719230544.GD3887@mag.az.mvista.com>	
	<1154911082.27074.104.camel@diesel>
	<1154987921.24455.32.camel@basalt.austin.ibm.com>
	<44D8230F.4020202@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <1BB7BBC5-8348-4C4C-9390-064A06C1B370@embeddedalley.com>
From: Pantelis Antoniou <pantelis@embeddedalley.com>
Subject: Re: [RFC] consolidated libdt proposal
Date: Tue, 8 Aug 2006 12:34:01 +0300
To: Haren Myneni <haren@us.ibm.com>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
	"xen-ppc-devel@lists.xensource.com" <xen-ppc-devel@lists.xensource.com>,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	"Sachin P. Sant" <sachinp@in.ibm.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 08 =CE=91=CF=85=CE=B3 2006, at 8:37 =CE=A0=CE=9C, Haren Myneni wrote:

> Hollis Blanchard wrote:
>
>> On Sun, 2006-08-06 at 19:38 -0500, Hollis Blanchard wrote:
>>
>>> Hmm, so we'll have at least three copies of this code: uboot, =20
>>> kernel,
>>> and Xen. Would it make sense to put this stuff into a libdt.a?
>>> Technically, dtc has a "libdt" already, but it's absurdly incomplete
>>> (I don't even know why it's there), so we could just replace it.
>>
>> Mark, I had a look at the code Pantelis wrote for u-boot, and it was
>> pretty easy to adapt to meet Xen's (userspace-based) needs. I've
>> attached my version below (and see ft_setup() at the bottom of the
>> file). Does it meet your requirements for the kernel bootwrapper?
>>
>> One limitation of the attached code is that it doesn't support =20
>> changing
>> the *size* of properties, though I don't think that would be too
>> difficult to add if needed.
>>
>> Haren, what about using this in kexec-tools?
>>
>
> Hollis,
>    Good idea to have this lib. Based on brief look, some of these =20
> funcs are also useful for kexec-tools. Yes, as you mentioned, =20
> changing the size of properties is important for kexec/kdump.
>
> Present flattened device-tree process in kexec-tools:
>
> - Kexec-tool reads the /proc/device-tree and sort these entries =20
> since we get the different order than the first kernel uses.
> - creates linux,usable-memory property under /proc/device-tree/=20
> memory@* as appropriate.  (for kdump)
> - Modify the reserve map for RTAS, initrd, TCE and (0- crashkernel-=20
> start)
> - Create initrd properties if not exist in the first kernel as needed
> - Modify bootargs property
>
> Thanks
> Haren
>

Hi Haren,

Mind writing down what your requirements are? Just modifying the size =20=

of the properties?

Note that my functions work in a two phases.
In the first phase the tree is build with the string table being put =20
at the end
of the allocated memory area in a downward motion.
When the tree is finalized the string table is memmov'ed to be =20
adjacent to the structure
proper.

Could you use this two phased approach for you uses? I.e. first work =20
with maximum sized
properties and perform a move & fixup stage when finalizing?

Regards

Pantelis

>> If everybody can use this (I expect small modifications would be
>> needed), I think we should turn it into a library in the dtc source
>> tree. The various projects using it could then include snapshots (to
>> avoid dependencies). In general I'd like to avoid everybody =20
>> writing and
>> maintaining their own version of this stuff (myself included).
>>
>>
>> ---------------------------------------------------------------------=20=

>> ---
>>
>> /
>>
>
