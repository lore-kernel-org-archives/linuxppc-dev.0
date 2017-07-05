Return-Path: <clg@kaod.org>
Received: from 7.mo3.mail-out.ovh.net (7.mo3.mail-out.ovh.net [46.105.57.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2pGs0VndzDr1p
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 03:47:16 +1000 (AEST)
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 6691EFCB28
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 19:31:55 +0200 (CEST)
Subject: Re: [RFC PATCH 1/2] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
To: David Gibson <david@gibson.dropbear.id.au>
References: <1498123757-18427-1-git-send-email-clg@kaod.org>
 <1498123757-18427-2-git-send-email-clg@kaod.org>
 <20170703035552.GQ13989@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bcb9eeda-7ee5-5ec2-5957-d40174e477c0@kaod.org>
Date: Wed, 5 Jul 2017 19:31:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170703035552.GQ13989@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2017 05:55 AM, David Gibson wrote:
> On Thu, Jun 22, 2017 at 11:29:16AM +0200, Cédric Le Goater wrote:
>> This is the framework for using XIVE in a PowerVM guest. The support
>> is very similar to the native one in a much simpler form.
>>
>> Instead of OPAL calls, a set of Hypervisors call are used to configure
>> the interrupt sources and the event/notification queues of the guest:
>>
>>    H_INT_GET_SOURCE_INFO
>>    H_INT_SET_SOURCE_CONFIG
>>    H_INT_GET_SOURCE_CONFIG
>>    H_INT_GET_QUEUE_INFO
>>    H_INT_SET_QUEUE_CONFIG
>>    H_INT_GET_QUEUE_CONFIG
>>    H_INT_RESET
>>
>> Calls that still need to be addressed :
>>
>>    H_INT_SET_OS_REPORTING_LINE
>>    H_INT_GET_OS_REPORTING_LINE
>>    H_INT_ESB
>>    H_INT_SYNC
> 
> So, does this mean there's a PAPR update with the XIVE virtualization
> stuff?  Or at least an ACR?  Can we have that available please...

The QEMU patchset has some initial info on the hcalls : 

	http://patchwork.ozlabs.org/patch/784785/

C.
