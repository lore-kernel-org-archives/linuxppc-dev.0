Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrx542QsKzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:18:16 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 22 Apr 2016 23:18:14 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7CBE93578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:18:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3MDI25462128216
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:18:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3MDHbYT023480
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:17:38 +1000
Date: Fri, 22 Apr 2016 23:17:19 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 alistair@popple.id.au, david@gibson.dropbear.id.au, mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] powerpc/eeh: Restore config from edev in
 eeh_pe_reset_and_recover()
Message-ID: <20160422131719.GA31375@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1461239595-5627-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1461239595-5627-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <1461307072.2646.4.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461307072.2646.4.camel@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 22, 2016 at 04:37:52PM +1000, Russell Currey wrote:
>On Thu, 2016-04-21 at 21:53 +1000, Gavin Shan wrote:
>> The function eeh_pe_reset_and_recover() is used to recover EEH
>> error when the passthrou device are transferred to guest and
>> backwords. The content in the device's config space will be lost
>
>Spelling, as before :)
>
>> on PE reset issued in the middle of the recovery. The function
>> saves/restores it before/after the reset. However, config access
>> to some adapters like Broadcom BCM5719 at this point will causes
>> fended PHB. The config space is always blocked and we save 0xFF's
>
>"fended" should be "fenced"
>

Thanks, Russell. I'll fix it in next revision ;-)

>> that are restored at late point. The memory BARs are totally
>> corrupted, causing another EEH error upon access to one of the
>> memory BARs.
>> 
>> This restores the config space from the content saved to the
>> EEH device when it's populated, to resolve above issue.
>> 
>> Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
>> Cc: stable@vger.kernel.org #v3.18+
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>
>Reviewed-by: Russell Currey <ruscur@russell.cc>
>
