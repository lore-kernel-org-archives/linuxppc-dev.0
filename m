Return-Path: <seiji.aguchi@hds.com>
Received: from usindpps04.hds.com (usindpps04.hds.com [207.126.252.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BD18C2C00B3
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Sep 2013 11:45:10 +1000 (EST)
From: Seiji Aguchi <seiji.aguchi@hds.com>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>, "Luck, Tony"
 <tony.luck@intel.com>
Subject: RE: [RFC PATCH v2 04/11] pstore: Add compression support to pstore
Date: Wed, 4 Sep 2013 01:44:57 +0000
Message-ID: <A5ED84D3BB3A384992CBB9C77DEDA4D443E9E24D@USINDEM103.corp.hds.com>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <20130816131805.3338.68767.stgit@aruna-ThinkPad-T420>
 <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0D7@USINDEM103.corp.hds.com>
 <3908561D78D1C84285E8C5FCA982C28F31CC7AC0@ORSMSX106.amr.corp.intel.com>
 <521C36F4.8030607@linux.vnet.ibm.com>
In-Reply-To: <521C36F4.8030607@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "ccross@android.com" <ccross@android.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aruna,

Sorry for the late response.

> Seiji,
>=20
> Could you let us know the efivars buffer size with which the pstore is
> registered when
> the failure occurred.

I looked into the issue today.

I added some debug message just before pstore_compress().
As you can see below, the buffer size is a fixed value(1024).
Therefore, the size doesn't seem to be related to the failure directly.

Also, in the failure case, zlib_deflate() returns Z_OK and stream.avail_out=
 is zero.
So, I thought big_oops_buf_sz is too big in my environment.
And then, I tuned  big_oops_buf_sz to (psinfo->bufsize * 100) / 53.

At the same time, while looking into this issue, I had two concerns about c=
urrent cording.

1) In pstore_decompress(), why not use zlib_inflateInit2() instead of zlib_=
inflateInit()?
     If you use zlib_deflateInit2()  for specifying window_bit at compressi=
ng time,=20
     zlib_inflateInit2() seems to be appropriate for decompressing.
     (Please see a comment about inflateInit2() in include/linux/zlib.h and=
 source code of crypto/deflate.c)

2) As looking at crypto/deflate.c, stream->workspace is kzalloced at the be=
ginning of=20
   compressing/decompressing time.
    So, in pstore case,  stream.workspace must be initialized to 0 with mem=
set() in pstore_compress()/decompress().

I did three things above, tuning big_oops_buf_sz, using zlib_inflateInit2()=
 and initializing stream.workspace , in my environment.
As a result, compressions/decmpressions of all entries succeeded with efiva=
rs driver.

<snip>
Panic#2 Part1
<4>[   75.665020]  [<ffffffff811af59c>] SyS_write+0x4c/0xa0
<4>[   75.665020]  [<ffffffff8168be82>] system_call_fastpath+0x16/0x1b
<4>[   75.665020] Code: ef e8 ff f7 ff ff eb d8 66 2e 0f 1f 84 00 00 00 00 =
00 0f 1f 00 0f 1f 44 00 00 55 c7 05 cc f3 c9 00 01 00 00 00 48 89 e5 0f ae =
f8 <c6> 04 25 00 00 00 00 01 5d c3 0f 1f 44 00 00 55 31 c0 c7 05 5e=20
<1>[   75.665020] RIP  [<ffffffff813d3946>] sysrq_handle_crash+0x16/0x20
<4>[   75.665020]  RSP <ffff88007852de80>
<4>[   75.665020] CR2: 0000000000000000
<4>[   75.665020] ---[ end trace 97bb4a1f8d3fe7b2 ]---
<3>[   75.665020] pstore_dump hsize=3D13 len=3D2155 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore_dump hsize=3D13 len=3D2246 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore: compression failed for Part 2 returned -5
<3>[   75.665020] pstore: Capture uncompressed oops/panic report of Part 2
<3>[   75.665020] pstore_dump hsize=3D13 len=3D2239 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore_dump hsize=3D13 len=3D2231 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore_dump hsize=3D13 len=3D2185 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore: compression failed for Part 5 returned -5
<3>[   75.665020] pstore: Capture uncompressed oops/panic report of Part 5
<3>[   75.665020] pstore_dump hsize=3D13 len=3D2234 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore_dump hsize=3D13 len=3D2208 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore_dump hsize=3D13 len=3D2218 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore_dump hsize=3D13 len=3D2222 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore: compression failed for Part 9 returned -5
<3>[   75.665020] pstore: Capture uncompressed oops/panic report of Part 9
<3>[   75.665020] pstore_dump hsize=3D14 len=3D2256 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore_dump hsize=3D14 len=3D2219 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<3>[   75.665020] pstore_dump hsize=3D14 len=3D2226 big_oops_buf_sz=3D2275 =
psinfo->bufsize=3D1024
<0>[   75.665020] Kernel panic - not syncing: Fatal exception
<3>[   75.665020] drm_kms_helper: panic occurred, switching back to text co=
nsole
<snip>

Seiji
