Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 831791A01C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 08:36:44 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:36:42 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6588C3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:36:40 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LMZlup6816202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 15:35:47 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LMadoP025095
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:36:40 -0600
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 11/30] cxlflash: Make functions static
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <55FFF579.2020306@redhat.com>
Date: Mon, 21 Sep 2015 17:36:40 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <722EE14C-4D78-403A-9EB4-D8FD8C712006@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442438888-49583-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <55FFF579.2020306@redhat.com>
To: Tomas Henzl <thenzl@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 21, 2015, at 7:18 AM, Tomas Henzl <thenzl@redhat.com> wrote:
> On 16.9.2015 23:28, Matthew R. Ochs wrote:
>> 
>> +
>> +write_rrin:
>> +	nretry = 0;
>> +	writeq_be(rrin, &afu->host_map->ioarrin);
>> +	do {
>> +		rrin = readq_be(&afu->host_map->ioarrin);
>> +		if (rrin != 0x1)
>> +			break;
>> +		/* Double delay each time */
>> +		udelay(2 ^ nretry);
> 
> Double delay - isn't another operator needed?
> If so, pleas add a new patch for this.
> --tm

Good catch. This was an oversight. Will fix in a new patch in v3.


-matt
