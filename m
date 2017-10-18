Return-Path: <frowand.list@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHQcN2Vy5zDqXt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 08:46:28 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id b192so5351462pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 14:46:28 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] of/fdt: only store the device node basename in
 full_name
To: Rob Herring <robh@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-6-robh@kernel.org>
 <CANk1AXTLT9gB_f0GZLODpppjkxqDAp1x1RZmQ8O1i+UHckimxw@mail.gmail.com>
 <CABGGisxU2OPZz-rrWYZYgCQ0iGM9w5vL9Ob9BTHALFN8JyxeJQ@mail.gmail.com>
 <59E69786.2030406@gmail.com>
 <CANk1AXStoiNtJfU0iNug1wKASurqH6OrNoaN=UtSh6xxSB088Q@mail.gmail.com>
 <CAL_JsqKR3Jg+tgZr4xGPtcWnZW7ng741YjuyUFaS2SXKXbxGtg@mail.gmail.com>
 <1508341985.25643.12.camel@hp800z>
 <CAL_JsqKJ74y3qHVqbRph5C8=0Ggb+n=JT3TZybu2+mENyZ1VZA@mail.gmail.com>
Cc: Alan Tull <atull@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>,
 linux-fpga@vger.kernel.org
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <59E7CBAF.9080501@gmail.com>
Date: Wed, 18 Oct 2017 14:46:23 -0700
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKJ74y3qHVqbRph5C8=0Ggb+n=JT3TZybu2+mENyZ1VZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/18/17 11:30, Rob Herring wrote:
> On Wed, Oct 18, 2017 at 10:53 AM, Pantelis Antoniou
> <pantelis.antoniou@konsulko.com> wrote:
>> On Wed, 2017-10-18 at 10:44 -0500, Rob Herring wrote:
>>> On Wed, Oct 18, 2017 at 10:12 AM, Alan Tull <atull@kernel.org> wrote:
>>>> On Tue, Oct 17, 2017 at 6:51 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>>>>> On 10/17/17 14:46, Rob Herring wrote:
>>>>>> On Tue, Oct 17, 2017 at 4:32 PM, Alan Tull <atull@kernel.org> wrote:
>>>>>>> On Mon, Aug 21, 2017 at 10:16 AM, Rob Herring <robh@kernel.org> wrote:
>>>>>>>
>>>>>>> Hi Rob,
>>>>>>>
>>>>>>>> With dependencies on a statically allocated full path name converted to
>>>>>>>> use %pOF format specifier, we can store just the basename of node, and
>>>>>>>> the unflattening of the FDT can be simplified.
>>>>>>>>
>>>>>>>> This commit will affect the remaining users of full_name. After
>>>>>>>> analyzing these users, the remaining cases should only change some print
>>>>>>>> messages. The main users of full_name are providing a name for struct
>>>>>>>> resource. The resource names shouldn't be important other than providing
>>>>>>>> /proc/iomem names.
>>>>>>>>
>>>>>>>> We no longer distinguish between pre and post 0x10 dtb formats as either
>>>>>>>> a full path or basename will work. However, less than 0x10 formats have
>>>>>>>> been broken since the conversion to use libfdt (and no one has cared).
>>>>>>>> The conversion of the unflattening code to be non-recursive also broke
>>>>>>>> pre 0x10 formats as the populate_node function would return 0 in that
>>>>>>>> case.
>>>>>>>>
>>>>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>>>>>> ---
>>>>>>>> v2:
>>>>>>>> - rebase to linux-next
>>>>>>>>
>>>>>>>>  drivers/of/fdt.c | 69 +++++++++-----------------------------------------------
>>>>>>>>  1 file changed, 11 insertions(+), 58 deletions(-)
>>>>>>>
>>>>>>> I've just updated to the latest next branch and am finding problems
>>>>>>> applying overlays.   Reverting this commit alleviates things.  The
>>>>>>> errors I get are:
>>>>>>>
>>>>>>> [   88.498704] OF: overlay: Failed to apply prop @/__symbols__/clk_0
>>>>>>> [   88.513447] OF: overlay: apply failed '/__symbols__'
>>>>>>> [   88.518423] create_overlay: Failed to create overlay (err=-12)
>>>>>>
>>>>>> Frank's series with overlay updates should fix this.
>>>>>
>>>>> Yes, it does:
>>>>>
>>>>>   [PATCH v3 11/12] of: overlay: remove a dependency on device node full_name
>>>>
>>>> Thanks for the fast response.  I fetched the dt/next branch to test
>>>> this but there are sufficient changes that Pantelis' "OF: DT-Overlay
>>>> configfs interface (v7)" is broken now.  I've been adding that
>>>> downstream since 4.4.  We're using it as an interface for applying
>>>> overlays to program FPGAs.  If we fix it again, is there any chance
>>>> that can go upstream now?
>>>
>>> With a drive-by posting once every few years, no.
>>>
>>
>> I take offense to that. There's nothing changed in the patch for years.
>> Reposting the same patch without changes would achieve nothing.
> 
> Are you still expecting review comments on it or something?
> Furthermore, If something is posted infrequently, then I'm not
> inclined to comment or care if the next posting is going to be after I
> forget what I previously said (which is not very long).
> 
> I'm just saying, don't expect to forward port, post and it will be
> accepted. Below is minimally one of the issues that needs to be
> addressed.
> 


>>> The issue remains that the kernel is not really setup to deal with any
>>> random property or node to be changed at any point in run-time. I
>>> think there needs to be some restrictions around what the overlays can
>>> touch. We can't have it be wide open and then lock things down later
>>> and break users.

That paragraph is key to any discussion of accepting code to apply overlays.
Solving that issue has been stated to be a gating factor for such code from
the beginning of overlay development.


>>> One example of what you could do is you can only add
>>> sub-trees to whitelisted nodes. That's probably acceptable for your
>>> usecase.
>>>
>>
>> Defining what can and what cannot be changed is not as trivial as a
>> list of white-listed nodes.
> 
> No, but we have to start somewhere and we are not starting with any
> change allowed anywhere at anytime. If that is what people want, then
> they are going to get to maintain that out of tree.
> 
>> In some cases there is a whole node hierarchy being inserted (like in
>> a FPGA).
> 
> Yes, so you'd have a target fpga region. That sounds fine to me. Maybe
> its not a static whitelist, but drivers have to register target
> nodes/paths.
> 
>> In others, it's merely changing a status property to "okay" and
>> a few device parameters.
> 
> That seems fine too. Disabled nodes could be allowed. But what if you
> add/change properties on a node that is not disabled? Once a node is
> enabled, who is responsible for registering the device?
> 
> What about changing a node from enabled to disabled? The kernel would
> need to handle that or not allow it.
> 
>> The real issue is that the kernel has no way to verify that a given
>> device tree, either at boot time or at overlay application time, is
>> correct.
>>
>> When the tree is wrong at boot-time you'll hang (if you're lucky).
>> If the tree is wrong at run-time you'll get some into some unidentified
>> funky state.
> 
> Or have some security hole or a mechanism for userspace to crash the system.
> 
>> Finally what is, and what is not 'correct' is not for the kernel to
>> decide arbitrarily, it's a matter of policy, different for each
>> use-case.
> 
> It is if the kernel will break doing so.
> 
> Rob
> 
