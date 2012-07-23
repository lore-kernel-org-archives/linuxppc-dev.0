Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 464412C0342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 20:22:33 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Jul 2012 20:22:01 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6NADrvC27787452
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 20:13:54 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6NAM885005703
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 20:22:08 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 11/11] arch/powerpc: Add 64TB support
In-Reply-To: <20120723093951.GB29264@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120723093951.GB29264@bloggs.ozlabs.ibm.com>
Date: Mon, 23 Jul 2012 15:52:05 +0530
Message-ID: <87txwyhj5e.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 09, 2012 at 06:43:41PM +0530, Aneesh Kumar K.V wrote:
>
>> -#define USER_ESID_BITS		16
>> -#define USER_ESID_BITS_1T	4
>> +#define USER_ESID_BITS		18
>> +#define USER_ESID_BITS_1T	6
>
> You also need to change the proto-VSID generation for kernel addresses
> when you do this.  If you don't you'll end up with some user processes
> using the same VSIDs as we use for the kernel addresses, meaning that
> those processes won't run very well...
>

Can you explain this more. right now we generate vsid as below

vsid_scramble(ea >> SID_SHIFT, 256M) for kernel

vsid_scramble((context << USER_ESID_BITS) | (ea >> SID_SHIFT), 256M);
for user

what changes are you suggesting ?

-aneesh
