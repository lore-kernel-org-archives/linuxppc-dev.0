Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 905051A01F4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 09:27:41 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 65111140151
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 09:27:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 1 Dec 2014 08:27:40 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BC22C2CE8078
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 09:27:38 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAUMRUaM42533062
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Dec 2014 09:27:38 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAUMR5dv019943
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Dec 2014 09:27:06 +1100
Date: Mon, 1 Dec 2014 09:26:41 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/3] powerpc/eeh: Fix missed PE#0 on P7IOC
Message-ID: <20141130222641.GB5371@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416868020-4129-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <20141126040910.AE17D14017B@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141126040910.AE17D14017B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2014 at 03:09:10PM +1100, Michael Ellerman wrote:
>On Mon, 2014-24-11 at 22:27:00 UTC, Gavin Shan wrote:
>> PE#0 should be regarded as valid for P7IOC, while it's invalid for
>> PHB3. The patch adds flag EEH_VALID_PE_ZERO to differentiate those
>> two cases. Without the patch, we possibly see frozen PE#0 state is
>> cleared without EEH recovery taken on P7IOC as following kernel logs
>> indicate:
>
>This sounds like an urgent fix but I'm not sure.
>

You can pick it up for next release. Usually, we shouldn't see errors
from PE#0. Something I did to force that for testing purpose: disable
memory windows of the root complex and then access one of memory BARs
on one adapter behind the root complex.

Thanks,
Gavin

>cheers
>
