Return-Path: <prvs=3898f00e9f=ast@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbZ9w20tHzDq71
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 06:21:08 +1100 (AEDT)
Subject: Re: [PATCH 3/4] samples/bpf: Simplify building BPF samples
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <0ce1c8bdff478db55490a90db6732c4db9de6f22.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
 <56FD632B.4040306@fb.com> <20160331185139.GD17907@naverao1-tp.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, "David S
 . Miller" <davem@davemloft.net>, Ananth N Mavinakayanahalli
 <ananth@in.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Borkmann
 <daniel@iogearbox.net>, <netdev@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <56FD7888.9080902@fb.com>
Date: Thu, 31 Mar 2016 12:20:40 -0700
MIME-Version: 1.0
In-Reply-To: <20160331185139.GD17907@naverao1-tp.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/31/16 11:51 AM, Naveen N. Rao wrote:
> On 2016/03/31 10:49AM, Alexei Starovoitov wrote:
>> On 3/31/16 4:25 AM, Naveen N. Rao wrote:
>>> Make BPF samples build depend on CONFIG_SAMPLE_BPF. We still don't add a
>>> Kconfig option since that will add a dependency on llvm for allyesconfig
>>> builds which may not be desirable.
>>>
>>> Those who need to build the BPF samples can now just do:
>>>
>>> make CONFIG_SAMPLE_BPF=y
>>>
>>> or:
>>>
>>> export CONFIG_SAMPLE_BPF=y
>>> make
>>
>> I don't like this 'simplification'.
>> make samples/bpf/
>> is much easier to type than capital letters.
>
> This started out as a patch to have the BPF samples built with a Kconfig
> option. As stated in the commit description, I realised that it won't
> work for allyesconfig builds. However, the reason I retained this patch
> is since it gets us one step closer to building the samples as part of
> the kernel build.
>
> The 'simplification' is since I can now have the export in my .bashrc
> and the kernel build will now build the BPF samples too without
> requiring an additional 'make samples/bpf/' step.
>
> I agree this is subjective, so I am ok if this isn't taken in.

If you can change it that 'make samples/bpf/' still works then it would
be fine. As it is it breaks our testing setup.
