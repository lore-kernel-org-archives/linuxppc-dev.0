Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B34A1A0676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 06:26:20 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 29 Sep 2015 14:23:06 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 17E6719D8061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:13:36 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TKLmWL64553100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 13:21:48 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TKMe2S005062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 14:22:43 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v4 27/32] cxlflash: Fix to prevent stale AFU RRQ
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <8737xyuhun.fsf@gamma.ozlabs.ibm.com>
Date: Tue, 29 Sep 2015 15:22:39 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <FAA7C7C9-EFA4-4135-B39D-E0255980A5E8@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223144-9962-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <8737xyuhun.fsf@gamma.ozlabs.ibm.com>
To: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 28, 2015, at 8:36 PM, Daniel Axtens <dja@axtens.net> wrote:
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>=20
> "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:
>=20
>> Following an adapter reset, the AFU RRQ that resides in host memory
>> holds stale data. This can lead to a condition where the RRQ =
interrupt
>> handler tries to process stale entries and/or endlessly loops due to =
an
>> out of sync generation bit.
>>=20
>> To fix, the AFU RRQ in host memory needs to be cleared after each =
reset.
>=20
> This looks good. Do you need anything to bail out of cxlflash_rrq_irq =
if
> the data goes stale or to all Fs while that function is running?

We're not performing an MMIO here, so I'm not sure how the all Fs check
would apply. We're also protected fairly well by the generation bit. I =
suppose
we could look at adding some type of 'max iterations' count to protect =
against
a runaway handler but that would be in a future patch.
