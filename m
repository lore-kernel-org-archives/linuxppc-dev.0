Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D3B01A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 16:19:59 +1000 (AEST)
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 684FE1402EE
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2015 16:19:58 +1000 (AEST)
Received: by pdjn11 with SMTP id n11so46584464pdj.0
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 23:19:55 -0700 (PDT)
Message-ID: <1435213119.4286.51.camel@axtens.net>
Subject: Re: [PATCH V9 00/13] powerpc, perf: Enable SW branch filters
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org
Date: Thu, 25 Jun 2015 16:18:39 +1000
In-Reply-To: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1434370268-19056-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-XTzxiw5VJHfG8f/bK2Un"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-XTzxiw5VJHfG8f/bK2Un
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anshuman,

Thanks for your continued work on this.

Given that the series is now at version 9 and is 13 patches long, I
wonder if it might be worth splitting it up.

I'd suggest:

 - Patch 1 could be sent individually as it's a bug fix.

 - Separating out a series of simple cleanups would make the actual
changes in your patch set easier to understand. Patches 2, 3 and 5 are
obvious candidates.

 - It looks like the changes in patch 6 aren't used by any of the
following patches. It might be worth separating that out or just
dropping it entirely.


That would give you a series with just:
4   powerpc, perf: Restore privilege level filter support for BHRB
7   powerpc, perf: Re organize PMU branch filter processing on POWER8
8   powerpc, perf: Change the name of HW PMU branch filter tracking variabl=
e
9   powerpc, lib: Add new branch analysis support functions
10   powerpc, perf: Enable SW filtering in branch stack sampling framework
11   powerpc, perf: Change POWER8 PMU configuration to work with SW filters
12   powerpc, perf: Enable privilege mode SW branch filters
13   selftests, powerpc: Add test for BHRB branch filters (HW & SW)

That might make it easier for you to start getting the ground work in,
and make it easier for others to understand what you're trying to do.

Regards,
Daniel=20

On Mon, 2015-06-15 at 17:40 +0530, Anshuman Khandual wrote:
> 	This is the continuation (rebased and reworked) of the series
> posted at https://lkml.org/lkml/2014/5/5/153 (which is V6). I remember
> to have incremented the version count for the re-send of the first four
> patches of the series to Peter Z for generic review which got pulled in
> last year. These patches here are the remaining powerpc part of the
> original series.
>=20
> Changes in V9
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (1) Changed some of the commit messages and fixed some typos
> (2) Variable 'bhrb_users' type changed from int to unsigned int
> (3) Replaced the last usage of 'get_cpu_var' with 'this_cpu_ptr'
> (4) Conditional checks for 'cpuhw->bhrb_users' changed to test against ze=
ro
> (5) Updated in-code documentation inside 'check_excludes' function
> (6) Changed the name & type of 'pred' variable in 'power_pmu_bhrb_read'
> (7) Changed the name of 'tmp' to 'to_addr' inside 'power_pmu_bhrb_read'
> (8) Changed return values for branch instruction analysis functions
> (9) Changed the name of 'flag' variable to 'select_branch' inside 'keep_b=
ranch'
> (10) Fixed one nested conditional statement inside 'keep_branch' function
> (11) Changed function name from 'update_branch_entry' to 'insert_branch'
> (12) Fixed copyright and license statements for new selftest related file=
s
> (13) Improved helper assembly functions with some macro definitions
> (14) Improved the core test program at various places
> (15) Added .gitignore file for the new test case
>=20
> Changes in V8 (http://patchwork.ozlabs.org/patch/481848/)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (1) Fixed BHRB privilege mode branch filter request processing
> (2) Dropped branch records where 'from' cannot be fetched
> (3) Added in-code documenation at various places in the patch series
> (4) Added one comprehensive seltest case to verify all the filters
>=20
> Changes in V7
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (1) Incremented the version count while requesting pull for generic chang=
es
>=20
> Changes in V6 (https://lkml.org/lkml/2014/5/5/153)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (1) Rebased the patchset against the master
> (2) Added "Reviewed-by: Andi Kleen" in the first four patches in the seri=
es which changes the
>     generic or X86 perf code. [https://lkml.org/lkml/2014/4/7/130]
>=20
> Changes in V5 (https://lkml.org/lkml/2014/3/7/101)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (1) Added a precursor patch to cleanup the indentation problem in power_p=
mu_bhrb_read
> (2) Added a precursor patch to re-arrange P8 PMU BHRB filter config which=
 improved the clarity
> (3) Merged the previous 10th patch into the 8th patch
> (4) Moved SW based branch analysis code from core perf into code-patching=
 library as suggested by Michael
> (5) Simplified the logic in branch analysis library
> (6) Fixed some ambiguities in documentation at various places
> (7) Added some more in-code documentation blocks at various places
> (8) Renamed some local variable and function names
> (9) Fixed some indentation and white space errors in the code
> (10) Implemented almost all the review comments and suggestions made by M=
ichael Ellerman on V4 patchset
> (11) Enabled privilege mode SW branch filter
> (12) Simplified and generalized the SW implemented conditional branch fil=
ter
> (13) PERF_SAMPLE_BRANCH_COND filter is now supported only through SW impl=
ementation
> (14) Adjusted other patches to deal with the above changes
>=20
> Changes in V4 (https://lkml.org/lkml/2013/12/4/168)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (1) Changed the commit message for patch (01/10)
> (2) Changed the patch (02/10) to accommodate review comments from Michael=
 Ellerman
> (3) Rebased the patchset against latest Linus's tree
>=20
> Changes in V3 (https://lkml.org/lkml/2013/10/16/59)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (1) Split the SW branch filter enablement into multiple patches
> (2) Added PMU neutral SW branch filtering code, PMU specific HW branch fi=
ltering code
> (3) Added new instruction analysis functionality into powerpc code-patchi=
ng library
> (4) Changed name for some of the functions
> (5) Fixed couple of spelling mistakes
> (6) Changed code documentation in multiple places
>=20
> Changes in V2 (https://lkml.org/lkml/2013/8/30/10)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (1) Enabled PPC64 SW branch filtering support
> (2) Incorporated changes required for all previous comments
>=20
> Anshuman Khandual (13):
>   powerpc, perf: Drop the branch sample when 'from' cannot be fetched
>   powerpc, perf: Change type of the bhrb_users variable
>   powerpc, perf: Replace last usage of get_cpu_var with this_cpu_ptr
>   powerpc, perf: Restore privilege level filter support for BHRB
>   powerpc, perf: Change name & type of 'pred' in power_pmu_bhrb_read
>   powerpc, perf: Re organize BHRB processing
>   powerpc, perf: Re organize PMU branch filter processing on POWER8
>   powerpc, perf: Change the name of HW PMU branch filter tracking variabl=
e
>   powerpc, lib: Add new branch analysis support functions
>   powerpc, perf: Enable SW filtering in branch stack sampling framework
>   powerpc, perf: Change POWER8 PMU configuration to work with SW filters
>   powerpc, perf: Enable privilege mode SW branch filters
>   selftests, powerpc: Add test for BHRB branch filters (HW & SW)
>=20
>  arch/powerpc/include/asm/code-patching.h           |  15 +
>  arch/powerpc/include/asm/perf_event_server.h       |  10 +-
>  arch/powerpc/lib/code-patching.c                   |  60 +++
>  arch/powerpc/perf/core-book3s.c                    | 361 +++++++++++---
>  arch/powerpc/perf/power8-pmu.c                     |  70 ++-
>  tools/testing/selftests/powerpc/pmu/Makefile       |  11 +-
>  .../testing/selftests/powerpc/pmu/bhrb/.gitignore  |   1 +
>  tools/testing/selftests/powerpc/pmu/bhrb/Makefile  |  13 +
>  .../selftests/powerpc/pmu/bhrb/bhrb_filters.c      | 535 +++++++++++++++=
++++++
>  .../selftests/powerpc/pmu/bhrb/bhrb_filters.h      |  15 +
>  .../selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S  | 263 ++++++++++
>  tools/testing/selftests/powerpc/pmu/event.h        |   5 +
>  12 files changed, 1267 insertions(+), 92 deletions(-)
>  create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters=
.c
>  create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters=
.h
>  create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters=
_asm.S
>=20

--=20
Regards,
Daniel

--=-XTzxiw5VJHfG8f/bK2Un
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVi50/AAoJEPC3R3P2I92FV3kQAL4k5kZm6+nIaTMLGzX/P3lP
A1xsPYPl2gZxOUe9xo01FMG5CZdbR0Xtha1hgP1mIuk2DjXsfcrddTz6gaMc0Bfb
3PBC0VGTI4OWaDQD2Hz3GajCmNh7FmoRCyi6RF+OhnAy8Ox2dF/Es8goOEqy05ji
rPtqqR28UpyonJCQSbbXrm9lspp0kRVhz2oVo+x/iYdWDCEAP10N+rY5jBY8eIBC
cWYMTOpxMxRiThKaeT3HJoTFQqxdVbR4QWzgYKg4g+g7yjEn+N9Y95VYQhi5npL+
uXnzvlZ0lXnYF2pAembe7yVH9rwi9axFliAT9NiabXhrlumwku0HI27y1SYTZl8p
FotYwWXF586k7Sl4mZQ//igBKCIMVQf01pqUd8gm7W0NcO9xxOeARWE1DSNe+9+c
5dqO/yB30shyHJSO2Kn4D4RMekltNfwunAnod3WnHSN4RNtiExuYmJIyPBNHi1H+
IT58HVoVWOIvy+HQTrFkkPh/xzjWuZULv9ZL1Clb1Iyb56eX3zbbr6nr0kq0RoaW
UoBFW2tEhcEEWQQMtSCyI1XLRsbtp0UBLk3zj/3uf3IfeWpe/9NQBna+RUJ1Uczp
ps6eZ8fDNjWEWUaqefIVK7OPis1g6AR9aGrydviQ7fIcGIrYG6kKtQeDv7m7BDpX
PPv5PO5jMq5ZKYKTVVgO
=TOQV
-----END PGP SIGNATURE-----

--=-XTzxiw5VJHfG8f/bK2Un--
