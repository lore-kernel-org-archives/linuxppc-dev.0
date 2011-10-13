Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A8B7DB6FA5
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 02:33:02 +1100 (EST)
Subject: Re: [PATCH][v2] uio: Support 36-bit physical addresses on 32-bit
 systems
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXWd_u_EWXNhh3-t258+Y8mx=JuJhU93CeZfaocPZvhOFA@mail.gmail.com>
Date: Thu, 13 Oct 2011 10:32:51 -0500
Message-Id: <9BD33578-CD8E-4784-AC6A-ADE4614E0FC1@kernel.crashing.org>
References: <1318453063-17349-1-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXWd_u_EWXNhh3-t258+Y8mx=JuJhU93CeZfaocPZvhOFA@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "hjk@hansjkoch.de" <hjk@hansjkoch.de>, "gregkh@suse.de" <gregkh@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiang Kai-B18973 <B18973@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2011, at 9:37 AM, Tabi Timur-B04825 wrote:

> On Wed, Oct 12, 2011 at 3:57 PM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>> From: Kai Jiang <Kai.Jiang@freescale.com>
>>=20
>> To support >32-bit physical addresses for UIO_MEM_PHYS type we need =
to
>> extend the width of 'addr' in struct uio_mem.  Numerous platforms =
like
>> embedded PPC, ARM, and X86 have support for systems with larger =
physical
>> address than logical.
>>=20
>> Since 'addr' may contain a physical, logical, or virtual address the
>> easiest solution is to just change the type to 'unsigned long long'
>> regardless of which type is utilized.
>=20
> You forgot to update this description.

will fix and update commit message

>=20
>>  struct uio_mem {
>>        const char              *name;
>> -       unsigned long           addr;
>> +       phys_addr_t             addr;
>=20
> Please add a comment here saying:
>=20
> 1) That 'addr' can be a virtual or physical address

The code and everything else makes that clear

> 2) That the kernel guarantees that sizeof(phys_addr_t) >=3D =
sizeof(void
> *), so it's safe to use phys_addr_t for a virtual pointer.

The commit message will cover that so I don't plan on add it.

- k=
