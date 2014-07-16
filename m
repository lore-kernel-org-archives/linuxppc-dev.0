Return-Path: <nfont@austin.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AD411A0245
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 09:12:25 +1000 (EST)
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A1E521400B6
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 09:12:24 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@austin.ibm.com>;
 Wed, 16 Jul 2014 19:12:22 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B52216E801A
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2014 19:12:10 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6GNCKqA5308786
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2014 23:12:20 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6GNCJQJ019280
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2014 19:12:20 -0400
Message-ID: <53C706D2.7080207@austin.ibm.com>
Date: Wed, 16 Jul 2014 18:12:18 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@linaro.org>,
 Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
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
 <53C6C4BE.6010301@gmail.com>
 <CACxGe6v8BgEcTRB-ftPVkR6Tqs3GPw_0fVuwFgff_VqawoocGA@mail.gmail.com>
 <CACxGe6scb291V9rjz2P48FxCEtXEEtOkgiQms=nZ_wdOf_cqHA@mail.gmail.com>
In-Reply-To: <CACxGe6scb291V9rjz2P48FxCEtXEEtOkgiQms=nZ_wdOf_cqHA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On 07/16/2014 05:26 PM, Grant Likely wrote:
> On Wed, Jul 16, 2014 at 2:57 PM, Grant Likely <grant.likely@linaro.org> wrote:
>> On Wed, Jul 16, 2014 at 12:30 PM, Tyrel Datwyler
>> <turtle.in.the.kernel@gmail.com> wrote:
>>> On 07/15/2014 10:33 PM, Grant Likely wrote:
>>>> I've got another question about powerpc reconfiguration. I was looking
>>>> at the dlpar_configure_connector() function in dlpar.c. I see that the
>>>> function has the ability to process multiple nodes with additional
>>>> sibling and child nodes. It appears to link them into a detached tree
>>>> structure, and the function returns a pointer to the first node.
>>>>
>>>> All of the callers of that function then call dlpar_attach_node(),
>>>> which calls of_attach_node(). However, of_attach_node() only handles a
>>>> single node. It doesn't handle siblings or children. Is this a bug?
>>>> Does the configure connector ever actually receive more than one node
>>>> at once?
>>>
>>> Yes, it is sometimes the case we will get a tree structure back of more
>>> than one node. Under the proc interface implementation this just worked.
>>> With the move to sysfs it appears we have a regression here. What makes
>>> more sense here, for us to walk the tree calling of_attach_node, or to
>>> move such tree walking logic into of_attach_node? From what I can tell
>>> we are the only consumers of of_attach_node.
>>
>> That is very shortly going to change. The overlay code also uses
>> of_attach_node(). I can make of_attach_node() recurse over
>> descendants, but I'm also considering moving the powerpc code over to
>> the of_changeset series that Panto and I are working on.
>>
>> Either way, the handling of multiple nodes should be common code. I
>> think the easiest is to put the recursion into of_attach_node(), at
>> least for fixing the bug. It can be reworked later.
> 
> On pseries, do notifiers ever fail? ie. Does the reconfig code ever
> object to a DT change and prevent it from being applied?
> 
I cannot think of a time that  I ever saw a notifier fail.

-Nathan
