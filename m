Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5990E1A015B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 11:18:45 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Thu, 1 Oct 2015 21:18:41 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DE8F4C90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 21:06:48 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t921IaKa61538334
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 01:18:36 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t921IYo5005104
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 21:18:36 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v5 18/34] cxlflash: Fix AFU version access/storage and add
 check
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <87h9maay0s.fsf@gamma.ozlabs.ibm.com>
Date: Thu, 1 Oct 2015 20:18:32 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Message-Id: <A8B191C3-D4C7-49ED-A058-95443BABDBDC@linux.vnet.ibm.com>
References: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443715012-18236-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <87h9maay0s.fsf@gamma.ozlabs.ibm.com>
To: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Oct 1, 2015, at 7:56 PM, Daniel Axtens <dja@axtens.net> wrote:
> 
> "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:
> 
>> The AFU version is stored as a non-terminated string of bytes within
>> a 64-bit little-endian register. Presently the value is read directly
>> (no MMIO accessor) and is stored in a buffer that is not big enough
>> to contain a NULL terminator. Additionally the version obtained is not
>> evaluated against a known value to prevent usage with unsupported AFUs.
>> All of these deficiencies can lead to a variety of problems.
>> 
>> +	if ((afu->interface_version + 1) == 0) {
>> +		pr_err("Back level AFU, please upgrade. AFU version %s "
>> +		       "interface version 0x%llx\n", afu->version,
>> +		       afu->interface_version);
>> +		rc = -EINVAL;
>> +		goto err1;
> 
> I'm confused by this if statement. If afu->interface_version + 1 == 0,
> and interface_version is a 64bit unsigned int, that would mean that
> afu->interface_version was 0xFFFF FFFF FFFF FFFF.
> 
> Are you trying to check against all Fs? Is that value significant in the
> hardware?

Correct, downlevel (unsupported) AFUs don't implement the interface_version
register and thus will return -1 at that offset.
