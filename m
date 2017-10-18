Return-Path: <pantelis.antoniou@konsulko.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHGmx5yvGzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 02:53:20 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id u138so10871710wmu.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 08:53:20 -0700 (PDT)
Message-ID: <1508341985.25643.12.camel@hp800z>
Subject: Re: [PATCH v2 5/5] of/fdt: only store the device node basename in
 full_name
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Rob Herring <robh@kernel.org>
Cc: Alan Tull <atull@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>,  linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, David Laight
 <David.Laight@aculab.com>, linux-fpga@vger.kernel.org
Date: Wed, 18 Oct 2017 18:53:05 +0300
In-Reply-To: <CAL_JsqKR3Jg+tgZr4xGPtcWnZW7ng741YjuyUFaS2SXKXbxGtg@mail.gmail.com>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-6-robh@kernel.org>
 <CANk1AXTLT9gB_f0GZLODpppjkxqDAp1x1RZmQ8O1i+UHckimxw@mail.gmail.com>
 <CABGGisxU2OPZz-rrWYZYgCQ0iGM9w5vL9Ob9BTHALFN8JyxeJQ@mail.gmail.com>
 <59E69786.2030406@gmail.com>
 <CANk1AXStoiNtJfU0iNug1wKASurqH6OrNoaN=UtSh6xxSB088Q@mail.gmail.com>
 <CAL_JsqKR3Jg+tgZr4xGPtcWnZW7ng741YjuyUFaS2SXKXbxGtg@mail.gmail.com>
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

On Wed, 2017-10-18 at 10:44 -0500, Rob Herring wrote:
> On Wed, Oct 18, 2017 at 10:12 AM, Alan Tull <atull@kernel.org> wrote:
> > On Tue, Oct 17, 2017 at 6:51 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> >> On 10/17/17 14:46, Rob Herring wrote:
> >>> On Tue, Oct 17, 2017 at 4:32 PM, Alan Tull <atull@kernel.org> wrote:
> >>>> On Mon, Aug 21, 2017 at 10:16 AM, Rob Herring <robh@kernel.org> wrote:
> >>>>
> >>>> Hi Rob,
> >>>>
> >>>>> With dependencies on a statically allocated full path name converted to
> >>>>> use %pOF format specifier, we can store just the basename of node, and
> >>>>> the unflattening of the FDT can be simplified.
> >>>>>
> >>>>> This commit will affect the remaining users of full_name. After
> >>>>> analyzing these users, the remaining cases should only change some print
> >>>>> messages. The main users of full_name are providing a name for struct
> >>>>> resource. The resource names shouldn't be important other than providing
> >>>>> /proc/iomem names.
> >>>>>
> >>>>> We no longer distinguish between pre and post 0x10 dtb formats as either
> >>>>> a full path or basename will work. However, less than 0x10 formats have
> >>>>> been broken since the conversion to use libfdt (and no one has cared).
> >>>>> The conversion of the unflattening code to be non-recursive also broke
> >>>>> pre 0x10 formats as the populate_node function would return 0 in that
> >>>>> case.
> >>>>>
> >>>>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>>>> ---
> >>>>> v2:
> >>>>> - rebase to linux-next
> >>>>>
> >>>>>  drivers/of/fdt.c | 69 +++++++++-----------------------------------------------
> >>>>>  1 file changed, 11 insertions(+), 58 deletions(-)
> >>>>
> >>>> I've just updated to the latest next branch and am finding problems
> >>>> applying overlays.   Reverting this commit alleviates things.  The
> >>>> errors I get are:
> >>>>
> >>>> [   88.498704] OF: overlay: Failed to apply prop @/__symbols__/clk_0
> >>>> [   88.513447] OF: overlay: apply failed '/__symbols__'
> >>>> [   88.518423] create_overlay: Failed to create overlay (err=-12)
> >>>
> >>> Frank's series with overlay updates should fix this.
> >>
> >> Yes, it does:
> >>
> >>   [PATCH v3 11/12] of: overlay: remove a dependency on device node full_name
> >
> > Thanks for the fast response.  I fetched the dt/next branch to test
> > this but there are sufficient changes that Pantelis' "OF: DT-Overlay
> > configfs interface (v7)" is broken now.  I've been adding that
> > downstream since 4.4.  We're using it as an interface for applying
> > overlays to program FPGAs.  If we fix it again, is there any chance
> > that can go upstream now?
> 
> With a drive-by posting once every few years, no.
> 

I take offense to that. There's nothing changed in the patch for years.
Reposting the same patch without changes would achieve nothing.

> The issue remains that the kernel is not really setup to deal with any
> random property or node to be changed at any point in run-time. I
> think there needs to be some restrictions around what the overlays can
> touch. We can't have it be wide open and then lock things down later
> and break users. One example of what you could do is you can only add
> sub-trees to whitelisted nodes. That's probably acceptable for your
> usecase.
> 

Defining what can and what cannot be changed is not as trivial as a
list of white-listed nodes.

In some cases there is a whole node hierarchy being inserted (like in
a FPGA). In others, it's merely changing a status property to "okay" and
a few device parameters.

The real issue is that the kernel has no way to verify that a given
device tree, either at boot time or at overlay application time, is
correct.

When the tree is wrong at boot-time you'll hang (if you're lucky).
If the tree is wrong at run-time you'll get some into some unidentified
funky state.

Finally what is, and what is not 'correct' is not for the kernel to
decide arbitrarily, it's a matter of policy, different for each
use-case. 

> Rob

Regards

-- Pantelis
