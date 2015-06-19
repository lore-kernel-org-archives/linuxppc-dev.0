Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 128F31A0EF6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2015 02:27:24 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C512B140271
 for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2015 02:27:23 +1000 (AEST)
Date: Fri, 19 Jun 2015 18:27:13 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 dvaleev@suse.com
Subject: Re: [PATCH SLOF] disk-label: add support for booting from GPT FAT
 partition
Message-ID: <20150619182713.5981cabf@thh440s>
In-Reply-To: <87d20uee2q.fsf@linux.vnet.ibm.com>
References: <1434017929-1792-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150617122248.77211775@thh440s>
 <87fv5qeeax.fsf@linux.vnet.ibm.com>
 <87d20uee2q.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 Jun 2015 17:34:13 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:
>=20
> > Thomas Huth <thuth@redhat.com> writes:
> >>> +\ Check for GPT MSFT BASIC DATA GUID - vfat based
> >>> +EBD0A0A2     CONSTANT GPT-BASIC-DATA-PARTITION-1
> >>> +B9E5         CONSTANT GPT-BASIC-DATA-PARTITION-2
> >>> +4433         CONSTANT GPT-BASIC-DATA-PARTITION-3
> >>> +87C0         CONSTANT GPT-BASIC-DATA-PARTITION-4
> >>> +68B6B72699C7 CONSTANT GPT-BASIC-DATA-PARTITION-5
> >>> +
> >>> +: gpt-basic-data-partition? ( -- true|false )
> >>> +   block gpt-part-entry>part-type-guid l@-le GPT-BASIC-DATA-PARTITIO=
N-1 =3D IF
> >>> +      block gpt-part-entry>part-type-guid 4 + w@-le
> >>> +      GPT-BASIC-DATA-PARTITION-2 =3D IF
> >>> +         block gpt-part-entry>part-type-guid 6 + w@-le
> >>> +         GPT-BASIC-DATA-PARTITION-3 =3D IF
> >>> +            block gpt-part-entry>part-type-guid 8 + w@
> >>
> >> Don't you have to byte-swap (w@-le) here, too? Looks somehow strange
> >> that the other UID parts are read byte-swapped but this one is not?
> >
> > Interesting observation, I had used code from gpt-prep-partition? and
> > did not doubt the validity of it. But that is how I see it in the memory
> > though.
> >
> > 4 >  7e50d000 10 dump=20
> > 7e50d000: a2 a0 d0 eb e5 b9 33 44 87 c0 68 b6 b7 26 99 c7  ......3D..h.=
.&.. ok
> > 4 >
>=20
> And here the answer for that:
>=20
>     https://en.wikipedia.org/wiki/GUID_Partition_Table#cite_note-26
>    =20
>     The GUIDs in this table are written assuming a little-endian byte
>     order. For example, the GUID for an EFI System partition is written
>     as C12A7328-F81F-11D2-BA4B-00A0C93EC93B here, which corresponds to
>     the 16 byte sequence 28h 73h 2Ah C1h 1Fh F8h D2h 11h BAh 4Bh 00h A0h
>     C9h 3Eh C9h 3Bh =E2=80=93 only the first three blocks are byte-swappe=
d.
>=20
> "only the first three blocks are byte-swapped"

Ok, this seems to be a GUID specialty (as opposed to UUIDs), also see:

https://en.wikipedia.org/wiki/Globally_unique_identifier#Binary_encoding

... but that means that the last 8 bytes are always "big endian", so I
think you could simplify your code here and check the last 8 bytes at
once instead of checking 2 + 6 bytes separately, can't you?

 Thomas
