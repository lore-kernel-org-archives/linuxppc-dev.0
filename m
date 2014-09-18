Return-Path: <gpkulkarni@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DF9E1A0077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 00:30:21 +1000 (EST)
Received: by mail-pa0-f41.google.com with SMTP id et14so1634926pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 07:30:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFpQJXUs+6Qvj0SqgajA8_D8UdEh_EQVgTQDz0bPSn-VpEty9g@mail.gmail.com>
References: <1410944189-3608-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <541A01B7.8030601@mentor.com>
 <CAMDttNfSr5BrnEwLXqgy676jOZbFHhXcMtC0n7gBSniwhWCDRQ@mail.gmail.com>
 <CAFpQJXUs+6Qvj0SqgajA8_D8UdEh_EQVgTQDz0bPSn-VpEty9g@mail.gmail.com>
Date: Thu, 18 Sep 2014 20:00:19 +0530
Message-ID: <CAFpQJXWjZc8mPFUrG0ec=c7-5bBMnwTjrfFmvopSTjVqO_o5Vw@mail.gmail.com>
Subject: Re: [RFC PATCH] dt:numa: adding numa node mapping for memory nodes.
From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
To: Zi Shen Lim <zlim.lnx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Nathan Lynch <Nathan_Lynch@mentor.com>, Rob Herring <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Kumar Gala <galak@codeaurora.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

looks like previous email not had the email ids added by kumar gala.
adding the missing ids and sending again.

On Thu, Sep 18, 2014 at 9:32 AM, Ganapatrao Kulkarni
<gpkulkarni@gmail.com> wrote:
> On Thu, Sep 18, 2014 at 4:42 AM, Zi Shen Lim <zlim.lnx@gmail.com> wrote:
>> On Wed, Sep 17, 2014 at 2:48 PM, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
>>> On 09/17/2014 03:56 AM, Ganapatrao Kulkarni wrote:
>>>> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>>
>>>> This patch adds property "nid" to memory node to provide the memory range to
>>>> numa node id mapping.
>>>>
>>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>>
>>>> ---
>>>>  Documentation/devicetree/bindings/numa.txt | 58 ++++++++++++++++++++++++++++++
>>>>  1 file changed, 58 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/numa.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>>> new file mode 100644
>>>> index 0000000..c4a94f2
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>>> @@ -0,0 +1,58 @@
>>>> +======================================================
>>>> +numa id binding description
>>>> +======================================================
>>>> +
>>>> +======================================================
>>>> +1 - Introduction
>>>> +======================================================
>>>> +The device node  property "nid(numa node id)" can be added to memory
>>>> +device node to map the range of memory addresses as defined in property "reg".
>>>> +The property "nid" maps the memory range to the numa node id, which is used to
>>>> +find the local and remory pages on numa aware systems.
>>>
>>> "Local" and "remote" memory are notions that relate to some other
>>> resource -- typically a CPU, but also I/O resources on some systems.  It
>>> seems to me that a useful NUMA binding would at least specify a "nid"
>>> property, or something like it, for both cpu and memory nodes.  But this
>>> document speaks only of memory nodes.
> IMO, nid can be extended to cpu node also if the arch dont have any
> other way to do mapping, in fact this can be scaled to any node.
> for ARM arch, cpu mapping can be fetched from topology parsing and
> more over cpu mapping is required much later when secondary cpus comes
> online.
> i have added for memory, since this is parsed very early in the boot
> sequence and there is no support for dt based map at this moment(at
> least i am not aware off).
> numa distance matrix can also be defined, if the architecture has
> variable node distance other than just local/remote.
>>>
>>> As Kumar said, the device tree on powerpc server systems already has
>>> properties that express NUMA information.  If you can get hold of a copy
>>> of the PAPR (not ePAPR) from power.org, refer to the description of
>>> "ibm,associativity" and related properties.  I recall that it's a bit
>>> more complex than this proposal, though.
>>
>> I'm not able to find a link to the actual PAPR (not ePAPR)
>> specification. Anyone has a linky?
>>
>> I did find some code in tree, but couldn't find the bindings in
>> Documentation/devicetree/.
> yes, there is nothing in Documentation, if PPC are using since several
> years, then i humbly request to publish the documentation for numa
> bindings.
> No point in reinventing the wheel. Also i did not find any spec named
> PAPR, is it open spec, available to all like ePAPR?
>
>>
>> Seems like we'd care about form1?
>> -----8<-----
>> commit 41eab6f88f24124df89e38067b3766b7bef06ddb
>> Author: Anton Blanchard <anton@samba.org>
>> Date:   Sun May 16 20:22:31 2010 +0000
>>
>>     powerpc/numa: Use form 1 affinity to setup node distance
>>
>>     Form 1 affinity allows multiple entries in
>> ibm,associativity-reference-points
>>     which represent affinity domains in decreasing order of importance. The
>>     Linux concept of a node is always the first entry, but using the other
>>     values as an input to node_distance() allows the memory allocator to make
>>     better decisions on which node to go first when local memory has been
>>     exhausted.
>>
>>     We keep things simple and create an array indexed by NUMA node, capped at
>>     4 entries. Each time we lookup an associativity property we initialise
>>     the array which is overkill, but since we should only hit this path during
>>     boot it didn't seem worth adding a per node valid bit.
>>
>>     Signed-off-by: Anton Blanchard <anton@samba.org>
>>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ----->8-----
>>
>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
