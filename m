Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AAC71A2354
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 16:30:17 +1000 (AEST)
Message-ID: <1441607415.1285.1.camel@ellerman.id.au>
Subject: Re: [PATCH v6 2/3] perf,kvm/powerpc: Port perf kvm stat to powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 scottwood@freescale.com, acme@kernel.org, mingo@kernel.org,
 sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 warrier@linux.vnet.ibm.com,  srikar@linux.vnet.ibm.com, paulus@samba.org
Date: Mon, 07 Sep 2015 16:30:15 +1000
In-Reply-To: <1441004068-11306-2-git-send-email-hemant@linux.vnet.ibm.com>
References: <1441004068-11306-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1441004068-11306-2-git-send-email-hemant@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-31 at 12:24 +0530, Hemant Kumar wrote:
> perf kvm can be used to analyze guest exit reasons. This support already
> exists in x86. Hence, porting it to powerpc.
> 
>  - To trace KVM events :
>   perf kvm stat record
>   If many guests are running, we can track for a specific guest by using
>   --pid as in : perf kvm stat record --pid <pid>
> 
>  - To see the results :
>   perf kvm stat report
> 
> The result shows the number of exits (from the guest context to
> host/hypervisor context) grouped by their respective exit reasons with
> their frequency.
> 
> Since, different powerpc machines have different KVM tracepoints, this
> patch discovers the machine type dynamically from /proc/cpuinfo's
> "machine" tag  and accordingly sets kvm tracepoints. Right now, it only
> supports Book3S_HV tracepoints.

I'm not a big fan of parsing /proc/cpuinfo. I know you're not the first person
to do it, but can't we do something better?

Perf already knows how to find out what tracepoint events exist. You should be
able to just probe for the required events. eg. if 'kvm_hv:kvm_guest_enter'
exists then you use it. Otherwise there's no support.

When book3e wants to support 'perf kvm', you'd just add another event to probe
for, ie. something like 'kvm_book3e:kvm_guest_enter'.

And, if we ever want to change the name of any of the tracepoints you could
just add the new and the old names to the list of events to look for, and
depending on which you find, that is what you use.

cheers
