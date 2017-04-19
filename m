Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7ZVt5LXjzDq9P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 07:13:58 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JL8b5Z123290
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 17:13:56 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x74n8nd1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 17:13:56 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 17:13:55 -0400
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Oliver O'Halloran" <oohall@gmail.com>, Rob Herring <robh+dt@kernel.org>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <CAL_Jsq+GRkssqcn0wGzMgQRUtT-BO4zNDyYE7u1Cr5EhADK1SQ@mail.gmail.com>
 <CAOSf1CH8HgP0rKd0WCp87BADYcEGT5OCoq_yq+f3ZeoyTcXeng@mail.gmail.com>
 <87y3uw66y5.fsf@concordia.ellerman.id.au>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, Ingo Molnar <mingo@redhat.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Frank Rowand <frowand.list@gmail.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 19 Apr 2017 14:13:50 -0700
MIME-Version: 1.0
In-Reply-To: <87y3uw66y5.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5aa699db-255a-773b-7d60-3c6f05e88050@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2017 03:13 AM, Michael Ellerman wrote:
> Oliver O'Halloran <oohall@gmail.com> writes:
> 
>> On Wed, Apr 19, 2017 at 2:46 AM, Rob Herring <robh+dt@kernel.org> wrote:
>>> On Mon, Apr 17, 2017 at 7:32 PM, Tyrel Datwyler
>>> <tyreld@linux.vnet.ibm.com> wrote:
>>>> This patch introduces event tracepoints for tracking a device_nodes
>>>> reference cycle as well as reconfig notifications generated in response
>>>> to node/property manipulations.
>>>>
>>>> With the recent upstreaming of the refcount API several device_node
>>>> underflows and leaks have come to my attention in the pseries (DLPAR) dynamic
>>>> logical partitioning code (ie. POWER speak for hotplugging virtual and physcial
>>>> resources at runtime such as cpus or IOAs). These tracepoints provide a
>>>> easy and quick mechanism for validating the reference counting of
>>>> device_nodes during their lifetime.
>>>
>>> Not really relevant for this patch, but since you are looking at
>>> pseries and refcounting, the refcounting largely exists for pseries.
>>> It's also hard to get right as this type of fix is fairly common. It's
>>> now used for overlays, but we really probably only need to refcount
>>> the overlays or changesets as a whole, not at a node level. If you
>>> have any thoughts on how a different model of refcounting could work
>>> for pseries, I'd like to discuss it.
>>
>> One idea I've been kicking around is differentiating short and long
>> term references to a node.
> 
> I actually did this a long time ago, but balked at the size of the patch
> to do the conversion. Let me see if I can find it lying around ...

It would be interesting to revisit this, and toss around any other ideas
anyone may have.

-Tyrel

> 
> cheers
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
