Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70DA21A0B22
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 09:05:55 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 17:05:53 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4460C1FF0042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:56:59 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LN4vqW61735140
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:04:57 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LN5mS3014280
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 17:05:49 -0600
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 14/30] cxlflash: Fix to avoid stall while waiting on TMF
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <56004B57.6080409@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2015 18:05:48 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <B58FE47B-9CFB-427D-9D64-3F8A983AD29A@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442439022-49742-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <56004B57.6080409@linux.vnet.ibm.com>
To: Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 21, 2015, at 1:24 PM, Brian King <brking@linux.vnet.ibm.com> wrote:
> On 09/16/2015 04:30 PM, Matthew R. Ochs wrote:
>> Borrowing the TMF waitq's spinlock causes a stall condition when
>> waiting for the TMF to complete. To remedy, introduce our own spin
>> lock to serialize TMF and use the appropriate wait services.
> 
> Can you clarify what stall condition you were seeing. Its not obvious
> to me what this fixes. Do you have soft lockup logs from the failure?

I believe we saw cascading RCU stalls.

I couldn't find any more details in my notes or development commits.
Unfortunately the logs are long gone as this was fixed in June.
