Return-Path: <felix@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A310F1A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 23:54:26 +1000 (AEST)
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D065140F90
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Jun 2015 23:54:25 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Mon, 1 Jun 2015 14:54:22 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2A7502190069
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Jun 2015 14:54:00 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t51DsKAU23920808
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Jun 2015 13:54:20 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t51DsJYg007454
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Jun 2015 07:54:19 -0600
Message-ID: <556C64A6.2050905@linux.vnet.ibm.com>
Date: Mon, 01 Jun 2015 15:56:54 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: imunsie@au1.ibm.com, linuxppc-dev@ozlabs.org, vaibhav@linux.vnet.ibm.com
Subject: Re: [PATCH] cxl: Set up and enable PSL Timebase
References: <1432818778-27819-1-git-send-email-felix@linux.vnet.ibm.com>
 <1433140899.24546.14.camel@neuling.org>
In-Reply-To: <1433140899.24546.14.camel@neuling.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
 > Please use negative error codes here.  -EIO?
 > And check it here.

Mikey,

I am reluctant to fail the entire CAPI init after a PSL timebase sync failure.
If we ignore the error, the CAPI device stays available (without timebase sync).
If we honour the error, the CAPI device fails entirely.

I know three reasons why PSL timebase sync can fail:
1. h/w failure
2. OPAL did not initialize the CAPP timebase (wrong OPAL version)
3. the PCIe bus was not powered off/on between shutdown and reboot

I think that it is premature to choose to fail the entire CAPI init in all cases.
In particular, point 3. introduces a regression, as PCIe off/on was never a requirement for booting CAPI on P8.

I have tried one workaround do far: forcing the 0 to 1 transition of the tb bit of the PSL register TB_CTLSTAT.
In vain.

What do you think?

Philippe
