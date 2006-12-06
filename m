Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C63A67D79
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 06:45:30 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6JjIGX014859
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 14:45:18 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6JjHDS514862
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 12:45:17 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6JjHJo032646
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 12:45:17 -0700
Date: Wed, 6 Dec 2006 13:45:17 -0600
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
Message-ID: <20061206194516.GD17931@austin.ibm.com>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45770E44.30000@ru.mvista.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, a revised patch below, please apply.

On Wed, Dec 06, 2006 at 09:39:00PM +0300, Sergei Shtylyov wrote:
> 
>    A minor type here -- double "the".

Dohh. New patch below.

> WBR, Sergei

What does "WBR" mean?

--linas


Clarify why twi appears in the i/o macros.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

----
 include/asm-powerpc/io.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6.19-git7/include/asm-powerpc/io.h
===================================================================
--- linux-2.6.19-git7.orig/include/asm-powerpc/io.h	2006-12-06 13:38:43.000000000 -0600
+++ linux-2.6.19-git7/include/asm-powerpc/io.h	2006-12-06 13:41:50.000000000 -0600
@@ -78,6 +78,17 @@ extern unsigned long pci_dram_offset;
  * Note: I might drop the _ns suffix on the stream operations soon as it is
  * simply normal for stream operations to not swap in the first place.
  *
+ * Read operations have additional twi & isync to make sure the read
+ * is actually performed (i.e. the data has come back) before we start
+ * executing any following instructions.
+ *
+ * A data-dependent branch followed by an isync ensures that
+ * no instructions after the isync in program order will be
+ * (speculatively) executed before the isync has completed,
+ * and the isync won't complete until the branch is resolved.
+ * The load that the twi depends on has to complete before
+ * anything else is executed; in particular, it's a barrier
+ * to keep MMIO reads ordered before main-storage accesses.
  */
 
 #ifdef CONFIG_PPC64
