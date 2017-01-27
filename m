Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8x9J2SbLzDqDC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 22:18:12 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: =?Windows-1252?Q?=27Michal_Such=E1nek=27?= <msuchanek@suse.de>, Ashley Lai
 <ashleydlai@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Peter Huewe <peterhuewe@gmx.de>, Marcel Selhorst <tpmdd@selhorst.net>,
 "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>, "tpmdd-devel@lists.sourceforge.net"
 <tpmdd-devel@lists.sourceforge.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: ibmvtpm byteswapping inconsistency
Date: Fri, 27 Jan 2017 11:18:01 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0270A32@AcuExch.aculab.com>
References: <20170126212248.3f3e9103@kitsune.suse.cz>
In-Reply-To: <20170126212248.3f3e9103@kitsune.suse.cz>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Such=E1nek
> building ibmvtpm I noticed gcc warning complaining that second word of
> struct ibmvtpm_crq in tpm_ibmvtpm_suspend is uninitialized.
>=20
> The structure is defined as
>=20
> struct ibmvtpm_crq {
>         u8 valid;
>         u8 msg;
>         __be16 len;
>         __be32 data;
>         __be64 reserved;
> } __attribute__((packed, aligned(8)));
>=20
> initialized as
>=20
>         struct ibmvtpm_crq crq;
>         u64 *buf =3D (u64 *) &crq;
...

Hrummfff....
What is that attribute for, seems pretty confusing and pointless to me.

I also suspect that if you want to access it as two 64bit words it
ought to be a union.

	David
