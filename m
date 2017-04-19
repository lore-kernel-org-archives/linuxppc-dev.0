Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x22a.google.com (mail-qk0-x22a.google.com
 [IPv6:2607:f8b0:400d:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w75b11MFpzDqFb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:30:53 +1000 (AEST)
Received: by mail-qk0-x22a.google.com with SMTP id f133so9636253qke.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 19:30:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+GRkssqcn0wGzMgQRUtT-BO4zNDyYE7u1Cr5EhADK1SQ@mail.gmail.com>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <CAL_Jsq+GRkssqcn0wGzMgQRUtT-BO4zNDyYE7u1Cr5EhADK1SQ@mail.gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 19 Apr 2017 12:30:50 +1000
Message-ID: <CAOSf1CH8HgP0rKd0WCp87BADYcEGT5OCoq_yq+f3ZeoyTcXeng@mail.gmail.com>
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Rob Herring <robh+dt@kernel.org>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org,
 Ingo Molnar <mingo@redhat.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 2:46 AM, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, Apr 17, 2017 at 7:32 PM, Tyrel Datwyler
> <tyreld@linux.vnet.ibm.com> wrote:
>> This patch introduces event tracepoints for tracking a device_nodes
>> reference cycle as well as reconfig notifications generated in response
>> to node/property manipulations.
>>
>> With the recent upstreaming of the refcount API several device_node
>> underflows and leaks have come to my attention in the pseries (DLPAR) dynamic
>> logical partitioning code (ie. POWER speak for hotplugging virtual and physcial
>> resources at runtime such as cpus or IOAs). These tracepoints provide a
>> easy and quick mechanism for validating the reference counting of
>> device_nodes during their lifetime.
>
> Not really relevant for this patch, but since you are looking at
> pseries and refcounting, the refcounting largely exists for pseries.
> It's also hard to get right as this type of fix is fairly common. It's
> now used for overlays, but we really probably only need to refcount
> the overlays or changesets as a whole, not at a node level. If you
> have any thoughts on how a different model of refcounting could work
> for pseries, I'd like to discuss it.

One idea I've been kicking around is differentiating short and long
term references to a node. I figure most leaks are due to a missing
of_node_put() within a stack frame so it might be possible to use the
ftrace infrastructure to detect and emit warnings if a short term
reference is leaked. Long term references are slightly harder to deal
with, but they're less common so we can add more detailed reference
tracking there (devm_of_get_node?).

Oliver
