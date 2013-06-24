Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00D0D2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 05:26:08 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 00:49:51 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id F2F3E3940053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:56:01 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5OJQFrv30015502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 00:56:15 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5OJQ29g026310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 05:26:02 +1000
Message-ID: <51C89D47.3050504@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 14:25:59 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Subject: Re: [PATCH] Do not update sysfs cpu registration from invalid context
References: <51C8543F.6080905@linux.vnet.ibm.com>
 <20130624171804.GB3869@cerebellum> <20130624191611.GC3869@cerebellum>
In-Reply-To: <20130624191611.GC3869@cerebellum>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2013 02:16 PM, Seth Jennings wrote:
> On Mon, Jun 24, 2013 at 12:18:04PM -0500, Seth Jennings wrote:
>> On Mon, Jun 24, 2013 at 09:14:23AM -0500, Nathan Fontenot wrote:
>>> The topology update code that updates the cpu node registration in sysfs
>>> should not be called while in stop_machine(). The register/unregister
>>> calls take a lock and may sleep.
>>>
>>> This patch moves these calls outside of the call to stop_machine().
>>>
>>> Signed-off-by:Nathan Fontenot <nfont@linux.vnet.ibm.com>
>>
>> Reviewed-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
> 
> Gah! I _knew_ I should have waited for my cross compiler to finish
> building.  This thing doesn't build:
> 
>   CC      arch/powerpc/mm/numa.o
> /home/sjennings/ltc/linux/arch/powerpc/mm/numa.c: In function 'arch_update_cpu_topology':
> /home/sjennings/ltc/linux/arch/powerpc/mm/numa.c:1486: error: 'update' undeclared (first use in this function)
> /home/sjennings/ltc/linux/arch/powerpc/mm/numa.c:1486: error: (Each undeclared identifier is reported only once
> /home/sjennings/ltc/linux/arch/powerpc/mm/numa.c:1486: error: for each function it appears in.)
> 
> s/update/ud/ in the *_cpu_under_node() calls.

Oops! Time for patch submission re-education training.

New, and correct, patch coming soon.

-Nathan
