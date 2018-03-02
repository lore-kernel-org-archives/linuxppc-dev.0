Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-vk0-x22d.google.com (mail-vk0-x22d.google.com
 [IPv6:2607:f8b0:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ztKlH1TKmzF1tm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2018 06:54:50 +1100 (AEDT)
Received: by mail-vk0-x22d.google.com with SMTP id a63so6424675vkg.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Mar 2018 11:54:50 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180226084602.GR21977@gate.crashing.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-6-malat@debian.org>
 <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
 <20180226084602.GR21977@gate.crashing.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 2 Mar 2018 20:54:27 +0100
Message-ID: <CA+7wUsz7srOXwehLjuSn_SEgCUkGxu9bq6aOw5AeOaiiipBNtg@mail.gmail.com>
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in
 pfn_valid
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 26, 2018 at 9:46 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Mon, Feb 26, 2018 at 07:32:03AM +0100, Christophe LEROY wrote:
>> Le 25/02/2018 =C3=A0 18:22, Mathieu Malaterre a =C3=A9crit :
>> >-#define pfn_valid(pfn)              ((pfn) >=3D ARCH_PFN_OFFSET && (pf=
n) <
>> >max_mapnr)
>> >+#define pfn_valid(pfn) \
>> >+            (((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET)=
)
>>
>> What will happen when ARCH_PFN_OFFSET is not nul and pfn is lower than
>> ARCH_PFN_OFFSET ?
>
> It will work fine.
>
> Say you are asking for  a <=3D x < b  so (in actual integers, no overflow=
)
> that is  0 <=3D x-a < b-a  and you also assume x-a overflows, so that we
> are actually comparing  x-a+M < b-a  with M =3D 2**32 or such (the maximu=
m
> value in the unsigned integer type plus one).  This comparison is
> obviously always false.
>
> (It also works if b < a btw).
>
>
Thanks Segher !

Christophe does that clarify things or do you want me to update the
commit message ?
