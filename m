Return-Path: <robherring2@gmail.com>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com
 [IPv6:2a00:1450:400c:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A0501A0094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 02:49:55 +1000 (AEST)
Received: by wiax7 with SMTP id x7so69324548wia.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 09:49:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <552BC6E8.1040400@yandex-team.ru>
References: <20150408165920.25007.6869.stgit@buzz>
 <CAL_JsqKQPtNPfTAiqsKnFuU6e-qozzPgujM=8MHseG75R9cbSA@mail.gmail.com>
 <552BC6E8.1040400@yandex-team.ru>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 13 Apr 2015 11:49:31 -0500
Message-ID: <CAL_Jsq+vaufZJAchHC1OaV9g18zFfkXyRZ9j5wm0VWosh9i4kQ@mail.gmail.com>
Subject: Re: [PATCH] of: return NUMA_NO_NODE from fallback of_node_to_nid()
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 sparclinux@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 13, 2015 at 8:38 AM, Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
> On 13.04.2015 16:22, Rob Herring wrote:
>>
>> On Wed, Apr 8, 2015 at 11:59 AM, Konstantin Khlebnikov
>> <khlebnikov@yandex-team.ru> wrote:
>>>
>>> Node 0 might be offline as well as any other numa node,
>>> in this case kernel cannot handle memory allocation and crashes.
>>>
>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> Fixes: 0c3f061c195c ("of: implement of_node_to_nid as a weak function")
>>> ---
>>>   drivers/of/base.c  |    2 +-
>>>   include/linux/of.h |    5 ++++-
>>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index 8f165b112e03..51f4bd16e613 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -89,7 +89,7 @@ EXPORT_SYMBOL(of_n_size_cells);
>>>   #ifdef CONFIG_NUMA
>>>   int __weak of_node_to_nid(struct device_node *np)
>>>   {
>>> -       return numa_node_id();
>>> +       return NUMA_NO_NODE;
>>
>>
>> This is going to break any NUMA machine that enables OF and expects
>> the weak function to work.
>
>
> Why? NUMA_NO_NODE == -1 -- this's standard "no-affinity" signal.
> As I see powerpc/sparc versions of of_node_to_nid returns -1 if they
> cannot find out which node should be used.

Ah, I was thinking those platforms were relying on the default
implementation. I guess any real NUMA support is going to need to
override this function. The arm64 patch series does that as well. We
need to be sure this change is correct for metag which appears to be
the only other OF enabled platform with NUMA support.

In that case, then there is little reason to keep the inline and we
can just always enable the weak function (with your change). It is
slightly less optimal, but the few callers hardly appear to be hot
paths.

Rob
