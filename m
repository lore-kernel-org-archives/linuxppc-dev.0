Return-Path: <kernelfans@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41jlgq6NBBzF1Tw
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Aug 2018 12:52:39 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id 27-v6so6705634qkv.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Aug 2018 19:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <1533217359-11420-1-git-send-email-kernelfans@gmail.com>
 <1533217359-11420-2-git-send-email-kernelfans@gmail.com>
 <87tvoag835.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvoag835.fsf@concordia.ellerman.id.au>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Sun, 5 Aug 2018 10:52:24 +0800
Message-ID: <CAFgQCTu-UWr9iwG1qFEQ_Ur3TMUKwfWnamoybRyOhVOnSZjFug@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/cpu: post the event cpux add/remove instead
 of online/offline during hotplug
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 4, 2018 at 10:48 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi Pingfan,
>
> Pingfan Liu <kernelfans@gmail.com> writes:
> > Technically speaking, echo 1/0 > cpuX/online is only a subset of cpu
> > hotplug/unplug, i.e. add/remove. The latter one includes the physical
> > adding/removing of a cpu device. Some user space tools such as kexec-tools
> > resort to the event add/remove to automatically rebuild dtb.
> > If the dtb is not rebuilt correctly, we may hang on 2nd kernel due to
> > lack the info of boot-cpu-hwid in dtb.
>
> I notice you also sent a patch for ppc64_cpu to deal with CPUs being
> removed rather than just offlined.
>
> If I apply this patch then existing ppc64_cpu (without your other patch)
> will break. Is that right?
>
Yes. Since removing cpu will make a hole in cpu map, but ppc64_cpu
code takes the assumption that the cpu map is contiguous.

Thanks,
Pingfan
