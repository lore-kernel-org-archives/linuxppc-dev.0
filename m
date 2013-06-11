Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 272B92C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 08:50:39 +1000 (EST)
Date: Tue, 11 Jun 2013 17:50:27 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH -V7 09/18] powerpc: Switch 16GB and 16MB explicit
 hugepages to a different page table format
To: Scott Wood <scottwood@freescale.com>
References: <87obbgpmk3.fsf@linux.vnet.ibm.com> <1370984023.18413.30@snotra>
In-Reply-To: <1370984023.18413.30@snotra> (from scottwood@freescale.com on
 Tue Jun 11 15:53:43 2013)
Message-ID: <1370991027.18413.33@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2013 03:53:43 PM, Scott Wood wrote:
> On 06/08/2013 11:57:48 AM, Aneesh Kumar K.V wrote:
>> With the config shared I am not finding anything wrong, but I can't =20
>> test
>> these configs. Also can you confirm what you bisect this to
>>=20
>> e2b3d202d1dba8f3546ed28224ce485bc50010be
>> powerpc: Switch 16GB and 16MB explicit hugepages to a different page =20
>> table format
>=20
>>=20
>> or
>>=20
>> cf9427b85e90bb1ff90e2397ff419691d983c68b "powerpc: New hugepage =20
>> directory format"
>=20
> It's e2b3d202d1dba8f3546ed28224ce485bc50010be.
>=20
> It turned out to be the change from "pmd_none" to =20
> "pmd_none_or_clear_bad".  Making that change triggers the "bad pmd" =20
> messages even when applied to v3.9 -- so we had bad pmds all along, =20
> undetected.  Now I get to figure out why. :-(

So, for both pud and pgd we only call "or_clear_bad" when is_hugepd =20
returns false.  Why is it OK to do it unconditionally for pmd?

-Scott=
