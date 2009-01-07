Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 055AFDE2C1
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 20:46:26 +1100 (EST)
Date: Wed, 7 Jan 2009 03:46:11 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] sysfs cache code rewrite
Message-ID: <20090107094611.GD7376@localdomain>
References: <20081224045554.GA6958@localdomain>
	<20090106212533.GB7376@localdomain> <1231311102.14860.80.camel@pasglop>
	<1231311324.14860.81.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1231311324.14860.81.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> 
> > I don't know quite the detail of the new cpumask stuff ... It could be
> > as simple as passing a pointer instead of the value in the
> > cpumask_scnprintf call though...
> 
> Actually, I'll do more tests and if that ends up being the only needed
> change, I'll push your patch with that small change out to powerpc next
> tonight.

Sorry about that, here's an incremental... let me know if you want the
whole thing re-posted.

Thanks.


diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index f3e3ae3..b33f041 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -611,7 +611,7 @@ static ssize_t shared_cpu_map_show(struct kobject *k, struct kobj_attribute *att
 	len = PAGE_SIZE - 2;
 
 	if (len > 1) {
-		n = cpumask_scnprintf(buf, len, cache->shared_cpu_map);
+		n = cpumask_scnprintf(buf, len, &cache->shared_cpu_map);
 		buf[n++] = '\n';
 		buf[n] = '\0';
 	}
