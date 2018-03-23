Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x244.google.com (mail-ot0-x244.google.com
 [IPv6:2607:f8b0:4003:c0f::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40792B4ZHSzF0W1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 04:07:14 +1100 (AEDT)
Received: by mail-ot0-x244.google.com with SMTP id r30-v6so13990575otr.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 10:07:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323081209.31387-3-oohall@gmail.com>
References: <20180323081209.31387-1-oohall@gmail.com>
 <20180323081209.31387-3-oohall@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 23 Mar 2018 10:07:11 -0700
Message-ID: <CAPcyv4h=b9fCN7mCU8Yge5804oxVfErXRa_3h7QVcKdEhBbVHg@mail.gmail.com>
Subject: Re: [PATCH 3/6] libnvdimm: Add device-tree based driver
To: "Oliver O'Halloran" <oohall@gmail.com>
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

On Fri, Mar 23, 2018 at 1:12 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
> This patch adds peliminary device-tree bindings for the NVDIMM driver.

*preliminary

> Currently this only supports one bus (created at probe time) which all
> regions are added to with individual regions being created by a platform
> device driver.
>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> I suspect the platform driver should be holding a reference to the
> created region. I left that out here since previously Dan has said
> he'd rather keep the struct device internal to libnvdimm and the only
> other way a region device can disappear is when the bus is unregistered.

Hmm, but this still seems broken if bus teardown races region
teardown. I think the more natural model, given the way libnvdimm is
structured, to have each of these of_nd_region instances create their
own nvdimm bus. Thoughts?
