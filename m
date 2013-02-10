Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 98D912C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 03:11:46 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 10 Feb 2013 21:39:15 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CA755E004C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 21:42:25 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AGBaCx12320986
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 21:41:36 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AGBb3G020748
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 03:11:37 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Phileas Fogg <phileas-fogg@mail.ru>, Geoff Levand <geoff@infradead.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Re[3]: PS3 platform is broken on Linux 3.7.0
In-Reply-To: <1360487778.293641922@f350.mail.ru>
References: <1355488506.55692113@f147.mail.ru> <1358206641.4489.8.camel@smoke>
 <1360486777.923599245@f85.mail.ru> <1360487778.293641922@f350.mail.ru>
Date: Sun, 10 Feb 2013 21:41:37 +0530
Message-ID: <87k3qg4092.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Phileas Fogg <phileas-fogg@mail.ru> writes:

>  And another note.
> I took a look at the MMU chapter in the Cell Architecture handbook and in=
deed the first 15 bits in VA are treated as 0 by the hardware.
>
> Quote:
>
> 1. High-order bits above 65 bits in the 80-bit virtual address (VA[0:14])=
 are not implemented. The hardware always
> =C2=A0=C2=A0 treats these bits as `0'. Software must not set these bits t=
o any other value than `0' or the results are undefined in
> =C2=A0=C2=A0 the PPE.
>
>

True, we missed the below part of ISA doc:

ISA doc says

"On implementations that support a virtual address size
of only n bits, n < 78, bits 0:77-n of the AVA field must be
zeros. "

The Cell document I found at=20

https://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/7A77CCDF14FE70D58=
52575CA0074E8ED/$file/CellBE_Handbook_v1.12_3Apr09_pub.pdf

gives=20

Virtual Address (VA) Size -> 65 bits

So as per ISA, bits 0:12 should be zero, which should make 0:14 of PTE
fields zero for Cell.

I will try to do a patch.=20

Thanks for debugging this.

-aneesh
