Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BCA652C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 05:16:53 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Mon, 24 Jun 2013 13:16:20 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8632219D805E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:16:09 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5OJGEdW143992
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:16:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5OJGEHO016657
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:16:14 -0600
Received: from kernel.stglabs.ibm.com (kernel.stglabs.ibm.com [9.114.214.19])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP
 id r5OJGEhp016616
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 13:16:14 -0600
Date: Mon, 24 Jun 2013 14:16:11 -0500
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH] Do not update sysfs cpu registration from invalid context
Message-ID: <20130624191611.GC3869@cerebellum>
References: <51C8543F.6080905@linux.vnet.ibm.com>
 <20130624171804.GB3869@cerebellum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130624171804.GB3869@cerebellum>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 24, 2013 at 12:18:04PM -0500, Seth Jennings wrote:
> On Mon, Jun 24, 2013 at 09:14:23AM -0500, Nathan Fontenot wrote:
> > The topology update code that updates the cpu node registration in sysfs
> > should not be called while in stop_machine(). The register/unregister
> > calls take a lock and may sleep.
> > 
> > This patch moves these calls outside of the call to stop_machine().
> > 
> > Signed-off-by:Nathan Fontenot <nfont@linux.vnet.ibm.com>
> 
> Reviewed-by: Seth Jennings <sjenning@linux.vnet.ibm.com>

Gah! I _knew_ I should have waited for my cross compiler to finish
building.  This thing doesn't build:

  CC      arch/powerpc/mm/numa.o
/home/sjennings/ltc/linux/arch/powerpc/mm/numa.c: In function 'arch_update_cpu_topology':
/home/sjennings/ltc/linux/arch/powerpc/mm/numa.c:1486: error: 'update' undeclared (first use in this function)
/home/sjennings/ltc/linux/arch/powerpc/mm/numa.c:1486: error: (Each undeclared identifier is reported only once
/home/sjennings/ltc/linux/arch/powerpc/mm/numa.c:1486: error: for each function it appears in.)

s/update/ud/ in the *_cpu_under_node() calls.

Seth
