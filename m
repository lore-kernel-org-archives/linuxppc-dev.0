Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B7E12C0313
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:43:23 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 22:34:16 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 27FEA357804E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:43:20 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICUrFr9109906
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:30:53 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IChIhT026652
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:43:19 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 22/46] crypto: pcrypt - Protect access to cpu_online_mask
 with get/put_online_cpus()
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:11:15 +0530
Message-ID: <20130218124115.26245.88223.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pcrypt_aead_init_tfm() function access the cpu_online_mask without
disabling CPU hotplug. And it looks like it can afford to sleep, so use
the get/put_online_cpus() APIs to protect against CPU hotplug.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 crypto/pcrypt.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index b2c99dc..10f64e2 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -280,12 +280,16 @@ static int pcrypt_aead_init_tfm(struct crypto_tfm *tfm)
 
 	ictx->tfm_count++;
 
+	get_online_cpus();
+
 	cpu_index = ictx->tfm_count % cpumask_weight(cpu_online_mask);
 
 	ctx->cb_cpu = cpumask_first(cpu_online_mask);
 	for (cpu = 0; cpu < cpu_index; cpu++)
 		ctx->cb_cpu = cpumask_next(ctx->cb_cpu, cpu_online_mask);
 
+	put_online_cpus();
+
 	cipher = crypto_spawn_aead(crypto_instance_ctx(inst));
 
 	if (IS_ERR(cipher))
