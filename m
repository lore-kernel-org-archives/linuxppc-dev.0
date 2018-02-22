Return-Path: <srs0=xy4c=fq=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zn30R4vF2zF18V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 16:32:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zn30R469Pz8wPj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 16:32:55 +1100 (AEDT)
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zn30Q5wHKz9sVw
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 16:32:54 +1100 (AEDT)
Received: by mail-vk0-x243.google.com with SMTP id x125so2407217vkc.13
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 21:32:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519271512.2867.14.camel@au1.ibm.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com>
 <CAKTCnzkwwmbU4vzrmzW=eNnr2QW+rj=OUcAdOVxz+qKGC=9Q9A@mail.gmail.com>
 <1519271512.2867.14.camel@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 22 Feb 2018 16:32:51 +1100
Message-ID: <CAKTCnzkjbNVxBVTKmffbxsyqMb83y2tXN1Xv4Zm3VT+sxePdpg@mail.gmail.com>
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to
 userspace
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 frederic.barrat@fr.ibm.com, Greg KH <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 22, 2018 at 2:51 PM, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> On Thu, 2018-02-22 at 14:46 +1100, Balbir Singh wrote:
> <snip>
>> lpc_size could be added. It's currently useless to the library, but
>> > doesn't
>> > hurt. The one which was giving me troubles on a previous version of
>> > this
>> > patch was the lpc numa node ID, since that was experimental code
>> > and felt
>> > out of place considering what's been upstreamed in skiboot and
>> > linux so far.
>> >
>>
>> Yeah, I think metadata will evolve for a while till it settle's down.
>> Since ocxl_ioctl_get_metadata is exposed via uapi, a newer program
>> calling an older kernel will never work, since the size of that
>> struct
>> will always be larger than what the OS supports and our
>> copy_to_user()
>> will fail. The other option is for the user program to try all
>> possible versions till one succeeds, that is bad as well. I think
>> there are a few ways around it, if we care about this combination.
>>
>> Balbir Singh.
>>
>
> We have a number of reserved members at the end of the struct which can
> be re-purposed for future information (with a corresponding bump of the
> version number).

Good point, agreed

Balbir Singh.
