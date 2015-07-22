Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A0FE1A1A45
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 21:40:07 +1000 (AEST)
Message-ID: <55AF8111.4080905@redhat.com>
Date: Wed, 22 Jul 2015 13:40:01 +0200
From: Thomas Huth <thuth@redhat.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com
CC: paulus@samba.org, anton@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: powerpc/rtas: Introduce rtas_get_sensor_fast() for IRQ handlers
References: <20150722112527.B36E01402C8@ozlabs.org>
In-Reply-To: <20150722112527.B36E01402C8@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/07/15 13:25, Michael Ellerman wrote:
> On Fri, 2015-17-07 at 10:46:58 UTC, Thomas Huth wrote:
>> The EPOW interrupt handler uses rtas_get_sensor(), which in turn
>> uses rtas_busy_delay() to wait for RTAS becoming ready in case it
>> is necessary. But rtas_busy_delay() is annotated with might_sleep()
>> and thus may not be used by interrupts handlers like the EPOW handler!
>> This leads to the following BUG when CONFIG_DEBUG_ATOMIC_SLEEP is
>> enabled:
> 
> When did we break this?

 Hi Michael,

the bug has been introduced by commit 587f83e8dd50d22bc0c62e32ec49fd31
("powerpc/pseries: Use rtas_get_sensor in RAS code") which switched the
EPOW handler to use rtas_get_sensor() instead of using rtas_call directly.

Also have a look at this thread here:
http://www.spinics.net/lists/kvm-ppc/msg10768.html

 Thomas
