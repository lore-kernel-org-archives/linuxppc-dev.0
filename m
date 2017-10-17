Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGsRH27q7zDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 10:51:39 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 17so2522287pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 16:51:39 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] of/fdt: only store the device node basename in
 full_name
To: Rob Herring <robh@kernel.org>, Alan Tull <atull@kernel.org>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-6-robh@kernel.org>
 <CANk1AXTLT9gB_f0GZLODpppjkxqDAp1x1RZmQ8O1i+UHckimxw@mail.gmail.com>
 <CABGGisxU2OPZz-rrWYZYgCQ0iGM9w5vL9Ob9BTHALFN8JyxeJQ@mail.gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <59E69786.2030406@gmail.com>
Date: Tue, 17 Oct 2017 16:51:34 -0700
MIME-Version: 1.0
In-Reply-To: <CABGGisxU2OPZz-rrWYZYgCQ0iGM9w5vL9Ob9BTHALFN8JyxeJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/17 14:46, Rob Herring wrote:
> On Tue, Oct 17, 2017 at 4:32 PM, Alan Tull <atull@kernel.org> wrote:
>> On Mon, Aug 21, 2017 at 10:16 AM, Rob Herring <robh@kernel.org> wrote:
>>
>> Hi Rob,
>>
>>> With dependencies on a statically allocated full path name converted to
>>> use %pOF format specifier, we can store just the basename of node, and
>>> the unflattening of the FDT can be simplified.
>>>
>>> This commit will affect the remaining users of full_name. After
>>> analyzing these users, the remaining cases should only change some print
>>> messages. The main users of full_name are providing a name for struct
>>> resource. The resource names shouldn't be important other than providing
>>> /proc/iomem names.
>>>
>>> We no longer distinguish between pre and post 0x10 dtb formats as either
>>> a full path or basename will work. However, less than 0x10 formats have
>>> been broken since the conversion to use libfdt (and no one has cared).
>>> The conversion of the unflattening code to be non-recursive also broke
>>> pre 0x10 formats as the populate_node function would return 0 in that
>>> case.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>> v2:
>>> - rebase to linux-next
>>>
>>>  drivers/of/fdt.c | 69 +++++++++-----------------------------------------------
>>>  1 file changed, 11 insertions(+), 58 deletions(-)
>>
>> I've just updated to the latest next branch and am finding problems
>> applying overlays.   Reverting this commit alleviates things.  The
>> errors I get are:
>>
>> [   88.498704] OF: overlay: Failed to apply prop @/__symbols__/clk_0
>> [   88.513447] OF: overlay: apply failed '/__symbols__'
>> [   88.518423] create_overlay: Failed to create overlay (err=-12)
> 
> Frank's series with overlay updates should fix this.

Yes, it does:

  [PATCH v3 11/12] of: overlay: remove a dependency on device node full_name

-Frank
