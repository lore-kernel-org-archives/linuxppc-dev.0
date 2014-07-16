Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DC6D1A023F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 04:30:29 +1000 (EST)
Received: from mail-qg0-x22c.google.com (mail-qg0-x22c.google.com
 [IPv6:2607:f8b0:400d:c04::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC0D91400FA
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 04:30:28 +1000 (EST)
Received: by mail-qg0-f44.google.com with SMTP id e89so1100406qgf.31
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2014 11:30:25 -0700 (PDT)
Message-ID: <53C6C4BE.6010301@gmail.com>
Date: Wed, 16 Jul 2014 11:30:22 -0700
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@linaro.org>,
 Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: OF_DYNAMIC node lifecycle
References: <CACxGe6tsXuLZT=h8S0yRPRPy6Hqz1xkX8G+ViY0cxEUuxZ1dsw@mail.gmail.com>
 <53A30117.3010100@austin.ibm.com>
 <20140623144806.1348EC40A60@trevor.secretlab.ca>
 <53A9DB4F.9060708@austin.ibm.com>
 <20140625202446.77687C40AE6@trevor.secretlab.ca>
 <53AC7C2D.3040604@austin.ibm.com>
 <20140627124101.367F7C40E5E@trevor.secretlab.ca>
 <53AD8296.6040702@austin.ibm.com>
 <CACxGe6u5bVwYZjux9F2xzZSxZOSe37DGemCgcYtmiTP-xenQfg@mail.gmail.com>
In-Reply-To: <CACxGe6u5bVwYZjux9F2xzZSxZOSe37DGemCgcYtmiTP-xenQfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2014 10:33 PM, Grant Likely wrote:
> I've got another question about powerpc reconfiguration. I was looking
> at the dlpar_configure_connector() function in dlpar.c. I see that the
> function has the ability to process multiple nodes with additional
> sibling and child nodes. It appears to link them into a detached tree
> structure, and the function returns a pointer to the first node.
> 
> All of the callers of that function then call dlpar_attach_node(),
> which calls of_attach_node(). However, of_attach_node() only handles a
> single node. It doesn't handle siblings or children. Is this a bug?
> Does the configure connector ever actually receive more than one node
> at once?

Yes, it is sometimes the case we will get a tree structure back of more
than one node. Under the proc interface implementation this just worked.
With the move to sysfs it appears we have a regression here. What makes
more sense here, for us to walk the tree calling of_attach_node, or to
move such tree walking logic into of_attach_node? From what I can tell
we are the only consumers of of_attach_node.

-Tyrel

> 
> g.
> 
> On Fri, Jun 27, 2014 at 8:41 AM, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>> On 06/27/2014 07:41 AM, Grant Likely wrote:
>>> On Thu, 26 Jun 2014 15:01:49 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>>>> On 06/25/2014 03:24 PM, Grant Likely wrote:
>>>>> On Tue, 24 Jun 2014 15:10:55 -0500, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>>>>>>>> heh! I have often thought about adding reference counting to device tree
>>>>>>>> properties.
>>>>>>>
>>>>>>> You horrible, horrible man.
>>>>>>
>>>>>> Yes. I are evil :)
>>>>>>
>>>>>> After looking again the work needed to add reference counts to properties
>>>>>> would be huge. The few properties I am concerned with are specific to powerpc
>>>>>> so perhaps just adding an arch specific lock around updating those
>>>>>> properties would work.
>>>>>
>>>>> Which code/properties? I'd like to have a look myself.
>>>>
>>>> /ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory
>>>>
>>>> The property is updated in
>>>> arch/powerpc/platforms/pseries/hotplug-memory.c:pseries_update_drconf_memory()
>>>
>>> Specifically, what do you need for the locking? Are you wanting to hold
>>> off additional changes while that function is executing? Pantelis is
>>> adding a mutex for device tree writers. Holding that mutex would prevent
>>> any changes from happening in the tree without affecting readers. Would
>>> that be sufficient?
>>
>> That would work.
>>
>> -Nathan
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
