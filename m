Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E04C31A037B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 09:18:31 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 18 Sep 2015 17:18:29 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EA4763E40041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 17:18:25 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t8INIPYu4718964
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:18:25 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8INIOn3024431
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 17:18:25 -0600
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 04/30] cxlflash: Fix potential oops following LUN
 removal
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <55FB683A.5000201@linux.vnet.ibm.com>
Date: Fri, 18 Sep 2015 18:18:24 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <D9F09DDE-0CAE-4086-960A-761C9CEAC324@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442438860-49316-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <55FB683A.5000201@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 17, 2015, at 8:26 PM, Brian King <brking@linux.vnet.ibm.com> =
wrote:
>=20
> On 09/16/2015 04:27 PM, Matthew R. Ochs wrote:
>>=20
>> 	lun_access =3D kzalloc(sizeof(*lun_access), GFP_KERNEL);
>> 	if (unlikely(!lun_access)) {
>> 		dev_err(dev, "%s: Unable to allocate lun_access!\n", =
__func__);
>> +		scsi_device_put(sdev);
>=20
> Looks like you've got a double scsi_device_put in this path, since =
there is another put
> in the the err0 path.

Good catch! I'll fix in v3.
