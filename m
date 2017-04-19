Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Hrz4L76zDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 20:13:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, Ingo Molnar <mingo@redhat.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
In-Reply-To: <CAOSf1CH8HgP0rKd0WCp87BADYcEGT5OCoq_yq+f3ZeoyTcXeng@mail.gmail.com>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <CAL_Jsq+GRkssqcn0wGzMgQRUtT-BO4zNDyYE7u1Cr5EhADK1SQ@mail.gmail.com>
 <CAOSf1CH8HgP0rKd0WCp87BADYcEGT5OCoq_yq+f3ZeoyTcXeng@mail.gmail.com>
Date: Wed, 19 Apr 2017 20:13:38 +1000
Message-ID: <87y3uw66y5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:

> On Wed, Apr 19, 2017 at 2:46 AM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Mon, Apr 17, 2017 at 7:32 PM, Tyrel Datwyler
>> <tyreld@linux.vnet.ibm.com> wrote:
>>> This patch introduces event tracepoints for tracking a device_nodes
>>> reference cycle as well as reconfig notifications generated in response
>>> to node/property manipulations.
>>>
>>> With the recent upstreaming of the refcount API several device_node
>>> underflows and leaks have come to my attention in the pseries (DLPAR) dynamic
>>> logical partitioning code (ie. POWER speak for hotplugging virtual and physcial
>>> resources at runtime such as cpus or IOAs). These tracepoints provide a
>>> easy and quick mechanism for validating the reference counting of
>>> device_nodes during their lifetime.
>>
>> Not really relevant for this patch, but since you are looking at
>> pseries and refcounting, the refcounting largely exists for pseries.
>> It's also hard to get right as this type of fix is fairly common. It's
>> now used for overlays, but we really probably only need to refcount
>> the overlays or changesets as a whole, not at a node level. If you
>> have any thoughts on how a different model of refcounting could work
>> for pseries, I'd like to discuss it.
>
> One idea I've been kicking around is differentiating short and long
> term references to a node.

I actually did this a long time ago, but balked at the size of the patch
to do the conversion. Let me see if I can find it lying around ...

cheers
