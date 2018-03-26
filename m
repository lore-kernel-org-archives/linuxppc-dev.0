Return-Path: <oohall@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408bbS4HM1zF1wq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:07:32 +1100 (AEDT)
Received: by mail-it0-x244.google.com with SMTP id k135-v6so8622240ite.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 18:07:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h=b9fCN7mCU8Yge5804oxVfErXRa_3h7QVcKdEhBbVHg@mail.gmail.com>
References: <20180323081209.31387-1-oohall@gmail.com>
 <20180323081209.31387-3-oohall@gmail.com>
 <CAPcyv4h=b9fCN7mCU8Yge5804oxVfErXRa_3h7QVcKdEhBbVHg@mail.gmail.com>
From: Oliver <oohall@gmail.com>
Date: Mon, 26 Mar 2018 12:07:29 +1100
Message-ID: <CAOSf1CFbdRhEbnCdrg5fGMLhMVz8Jpf=POs-opd6LqPe3nOEjQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] libnvdimm: Add device-tree based driver
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Device Tree <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 24, 2018 at 4:07 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Fri, Mar 23, 2018 at 1:12 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
>> This patch adds peliminary device-tree bindings for the NVDIMM driver.
>
> *preliminary
>
>> Currently this only supports one bus (created at probe time) which all
>> regions are added to with individual regions being created by a platform
>> device driver.
>>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> ---
>> I suspect the platform driver should be holding a reference to the
>> created region. I left that out here since previously Dan has said
>> he'd rather keep the struct device internal to libnvdimm and the only
>> other way a region device can disappear is when the bus is unregistered.

> Hmm, but this still seems broken if bus teardown races region
> teardown.

Yeah looks like it.

>I think the more natural model, given the way libnvdimm is
> structured, to have each of these of_nd_region instances create their
> own nvdimm bus. Thoughts?

I'd prefer this too tbh. The main reason I'm looking at this approach
is that we plan on doing all interleave set configuration, etc from
Linux. So we'd like to have "similar" region/dimm devices end up in
the same bus to simplify validating managment ops, etc. That said, the
real enablement work for that is blocked on teams so I'm ok with
ignoring all of that for now.

Oliver
