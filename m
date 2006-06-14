Return-Path: <mkravetz@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F13267B5D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 15:07:07 +1000 (EST)
Received: from e3.ny.us.ibm.com (e3.pok.ibm.com [9.56.232.143])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5E3sV6H026834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 23:54:32 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5E3sNdB003470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 23:54:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5E3sN5o284368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 23:54:23 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5E3sMQp029650
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 23:54:23 -0400
Date: Tue, 13 Jun 2006 20:54:20 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] powerpc: Instrument Hypervisor Calls: add sysfs files
Message-ID: <20060614035420.GD6759@monkey.ibm.com>
References: <20060614034756.GA6759@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060614034756.GA6759@monkey.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make statistics available via files in sysfs.

-- 
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>


diff -Naupr linux-2.6.17-rc6/arch/powerpc/kernel/sysfs.c linux-2.6.17-rc6.work/arch/powerpc/kernel/sysfs.c
--- linux-2.6.17-rc6/arch/powerpc/kernel/sysfs.c	2006-06-06 00:57:02.000000000 +0000
+++ linux-2.6.17-rc6.work/arch/powerpc/kernel/sysfs.c	2006-06-13 21:42:32.000000000 +0000
@@ -356,6 +356,39 @@ static ssize_t show_physical_id(struct s
 }
 static SYSDEV_ATTR(physical_id, 0444, show_physical_id, NULL);
 
+#ifdef CONFIG_HCALL_STATS
+DECLARE_PER_CPU(struct hcall_stats[MAX_HCALL_OPCODES+1], hcall_stats);
+
+static ssize_t show_hcall_stats(struct sys_device *dev, char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
+	struct hcall_stats *hs = per_cpu(hcall_stats, cpu->sysdev.id);
+	size_t rc = 0;
+	size_t b_written = 0;
+	size_t b_remain = PAGE_SIZE;
+	unsigned long i;
+
+	for (i=0; i<MAX_HCALL_OPCODES+1; i++){
+		if (!hs[i].num_calls)
+			continue;
+
+		b_written = snprintf(buf+rc, b_remain,
+				"%lu %lu %lu\n",
+				i<<2, hs[i].num_calls, hs[i].total_time);
+
+		if (b_written >= b_remain)
+			break;	/* end of buffer */
+
+		rc += b_written;
+		b_remain -= b_written;
+	}
+
+	return rc;
+}
+
+static SYSDEV_ATTR(hcall_stats, 0666, show_hcall_stats, NULL);
+#endif /* CONFIG_HCALL_STATS */
+
 static int __init topology_init(void)
 {
 	int cpu;
@@ -390,6 +423,9 @@ static int __init topology_init(void)
 			register_cpu(c, cpu, parent);
 
 			sysdev_create_file(&c->sysdev, &attr_physical_id);
+#ifdef CONFIG_HCALL_STATS
+			sysdev_create_file(&c->sysdev, &attr_hcall_stats);
+#endif
 		}
 
 		if (cpu_online(cpu))
