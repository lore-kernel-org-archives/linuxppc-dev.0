Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdXP42cFSzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 04:09:12 +1000 (AEST)
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com
 [209.85.216.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E70B321A2C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 18:09:09 +0000 (UTC)
Received: by mail-qt0-f170.google.com with SMTP id n13so1061903qtc.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 11:09:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87fuckb2z2.fsf@concordia.ellerman.id.au>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-3-robh@kernel.org>
 <87fuckb2z2.fsf@concordia.ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 Aug 2017 13:08:48 -0500
Message-ID: <CAL_Jsq+sUgVcfNkpAHG7TmkO03+-0_GuZVW2tpxq6Xm2qDzUog@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] powerpc: pseries: vio: match parent nodes with
 of_find_node_by_path
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 22, 2017 at 12:12 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> In preparation to remove the full path from device_node.full_name, use
>> of_find_node_by_path instead of open coding with strcmp.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>> v2:
>> - rebased to linux-next and removed spurious change fro patch 1.
>>
>>  arch/powerpc/platforms/pseries/vio.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
>> index aa5ca74316fa..5754572deb23 100644
>> --- a/arch/powerpc/platforms/pseries/vio.c
>> +++ b/arch/powerpc/platforms/pseries/vio.c
>> @@ -1357,9 +1357,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
>>        */
>>       parent_node = of_get_parent(of_node);
>>       if (parent_node) {
>> -             if (!strcmp(parent_node->full_name, "/ibm,platform-facilities"))
>> +             if (parent_node == of_find_node_by_path("/ibm,platform-facilities"))
>>                       family = PFO;
>> -             else if (!strcmp(parent_node->full_name, "/vdevice"))
>> +             else if (parent_node == of_find_node_by_path("/vdevice"))
>>                       family = VDEVICE;
>
> This leaks references to the looked up nodes.
>
> Both these nodes are defined in PAPR (our hypervisor spec), and both of
> them must have a device_type, either "ibm,platform-facilities" or
> "vdevice".
>
> Looking at the commit that added the code I don't see any particular
> reason it used the comparison against full_name, rather than using the
> device_type.
>
> So I'm inclined to do this instead:
>
> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> index 8a47f168476b..f26f906e6021 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -1357,9 +1357,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
>          */
>         parent_node = of_get_parent(of_node);
>         if (parent_node) {
> -               if (!strcmp(parent_node->full_name, "/ibm,platform-facilities"))
> +               if (!strcmp(parent_node->type, "ibm,platform-facilities"))
>                         family = PFO;
> -               else if (!strcmp(parent_node->full_name, "/vdevice"))
> +               else if (!strcmp(parent_node->type, "vdevice"))
>                         family = VDEVICE;
>                 else {
>                         pr_warn("%s: parent(%s) of %s not recognized.\n",
>
>
> I've checked both Qemu and kvmtool add the device_type, and I'm fairly
> confident that PowerVM does too. Anyway I'll test it on all the machines
> I can find.

Okay, do you want me to respin the patch or will you update it with
the above change?

Rob
