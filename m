Return-Path: <cyeoh@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17534.30511.192632.558778@localhost.localdomain>
Date: Thu, 1 Jun 2006 15:12:15 +1000
From: "Christopher Yeoh" <cyeoh@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: Collecting hypervisor call stats
In-Reply-To: <AEFF6654-C958-42F7-93CF-64103B015CB1@watson.ibm.com>
References: <20060531204144.GA7909@w-mikek2.ibm.com>
	<AEFF6654-C958-42F7-93CF-64103B015CB1@watson.ibm.com>
Cc: Chris Yeoh <yeohc@au1.ibm.com>, Bryan Rosenburg <rosnbrg@us.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At 2006/6/1 00:34-0400  Jimi Xenidis writes:
> IIRC, chris and bryan have done some work to track this, they may  
> have some code to contribute.
> On May 31, 2006, at 4:41 PM, Mike Kravetz wrote:
> 

Hi Mike,

Here's a patch we've used for collecting hcall counts and times.  I
think I have a perl script lying around somewhere that helps process
the (per cpu) data a bit. I'm not sure where I put it at the moment,
but give me a ping if you're interested and I'll have another look.

Regards,

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
diff -urpN -X linux-2.6.15.6/Documentation/dontdiff linux-2.6.15.6.ref/arch/powerpc/kernel/sysfs.c linux-2.6.15.6.hcall/arch/powerpc/kernel/sysfs.c
--- linux-2.6.15.6.ref/arch/powerpc/kernel/sysfs.c	2006-03-06 06:07:54.000000000 +1100
+++ linux-2.6.15.6.hcall/arch/powerpc/kernel/sysfs.c	2006-04-05 13:56:47.000000000 +1000
@@ -338,6 +338,213 @@ static ssize_t show_physical_id(struct s
 }
 static SYSDEV_ATTR(physical_id, 0444, show_physical_id, NULL);
 
+
+DECLARE_PER_CPU(unsigned long[NUM_HCALL_TYPES], hcall_type_count);
+DECLARE_PER_CPU(unsigned long[NUM_HCALL_TYPES], hcall_type_time);
+
+static ssize_t store_hcall_stats(struct sys_device *dev,
+				 const char *buf,
+				 size_t count)
+{
+    struct cpu *cpu = container_of(dev, struct cpu, sysdev);
+    int i;
+
+    // Clear counters
+    for (i=0; i<NUM_HCALL_TYPES; i++) {
+	per_cpu(hcall_type_count, cpu->sysdev.id)[i] = 0;
+	per_cpu(hcall_type_time, cpu->sysdev.id)[i] = 0;
+    }
+    return count;
+}
+
+static ssize_t show_hcall_stats(struct sys_device *dev, char *buf)
+{
+    struct cpu *cpu = container_of(dev, struct cpu, sysdev);
+
+    return snprintf(buf, PAGE_SIZE,
+		    "H_REMOVE\t%lu\t%lu\n"
+		    "H_ENTER\t%lu\t%lu\n"
+		    "H_READ\t%lu\t%lu\n"
+		    "H_CLEAR_MOD\t%lu\t%lu\n"
+		    "H_CLEAR_REF\t%lu\t%lu\n"
+		    "H_PROTECT\t%lu\t%lu\n"
+		    "H_GET_TCE\t%lu\t%lu\n"
+		    "H_PUT_TCE\t%lu\t%lu\n"
+		    "H_SET_SPRG0\t%lu\t%lu\n"
+		    "H_SET_DABR\t%lu\t%lu\n"
+		    "H_PAGE_INIT\t%lu\t%lu\n"
+		    "H_SET_ASR\t%lu\t%lu\n"
+		    "H_ASR_ON\t%lu\t%lu\n"
+		    "H_ASR_OFF\t%lu\t%lu\n"
+		    "H_LOGICAL_CI_LOAD\t%lu\t%lu\n"
+		    "H_LOGICAL_CI_STORE\t%lu\t%lu\n"
+		    "H_LOGICAL_CACHE_LOAD\t%lu\t%lu\n"
+		    "H_LOGICAL_CACHE_STORE\t%lu\t%lu\n"
+		    "H_LOGICAL_ICBI\t%lu\t%lu\n"
+		    "H_LOGICAL_DCBF\t%lu\t%lu\n"
+		    "H_GET_TERM_CHAR\t%lu\t%lu\n"
+		    "H_PUT_TERM_CHAR\t%lu\t%lu\n"
+		    "H_REAL_TO_LOGICAL\t%lu\t%lu\n"
+		    "H_HYPERVISOR_DATA\t%lu\t%lu\n"
+		    "H_EOI\t%lu\t%lu\n"
+		    "H_CPPR\t%lu\t%lu\n"
+		    "H_IPI\t%lu\t%lu\n"
+		    "H_IPOLL\t%lu\t%lu\n"
+		    "H_XIRR\t%lu\t%lu\n"
+		    "H_PERFMON\t%lu\t%lu\n"
+		    "H_MIGRATE_DMA\t%lu\t%lu\n"
+		    "H_REGISTER_VPA\t%lu\t%lu\n"
+		    "H_CEDE\t%lu\t%lu\n"
+		    "H_CONFER\t%lu\t%lu\n"
+		    "H_PROD\t%lu\t%lu\n"
+		    "H_GET_PPP\t%lu\t%lu\n"
+		    "H_SET_PPP\t%lu\t%lu\n"
+		    "H_PURR\t%lu\t%lu\n"
+		    "H_PIC\t%lu\t%lu\n"
+		    "H_REG_CRQ\t%lu\t%lu\n"
+		    "H_FREE_CRQ\t%lu\t%lu\n"
+		    "H_VIO_SIGNAL\t%lu\t%lu\n"
+		    "H_SEND_CRQ\t%lu\t%lu\n"
+		    "H_COPY_RDMA\t%lu\t%lu\n"
+		    "H_STUFF_TCE\t%lu\t%lu\n"
+		    "H_PUT_TCE_INDIRECT\t%lu\t%lu\n"
+		    "H_VTERM_PARTNER_INFO\t%lu\t%lu\n"
+		    "H_REGISTER_VTERM\t%lu\t%lu\n"
+		    "H_FREE_VTERM\t%lu\t%lu\n"
+		    "H_POLL_PENDING\t%lu\t%lu\n"
+		    "H_REGISTER_LOGICAL_LAN\t%lu\t%lu\n"
+		    "H_FREE_LOGICAL_LAN\t%lu\t%lu\n"
+		    "H_ADD_LOGICAL_LAN_BUFFER\t%lu\t%lu\n"
+		    "H_SEND_LOGICAL_LAN\t%lu\t%lu\n"
+		    "H_MULTICAST_CTRL\t%lu\t%lu\n"
+		    "H_CHANGE_LOGICAL_LAN_MAC\t%lu\t%lu\n",
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[0],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[0],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[1],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[1],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[2],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[2],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[3],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[3],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[4],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[4],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[5],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[5],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[6],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[6],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[7],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[7],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[8],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[8],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[9],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[9],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[10],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[10],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[11],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[11],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[12],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[12],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[13],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[13],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[14],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[14],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[15],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[15],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[16],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[16],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[17],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[17],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[18],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[18],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[19],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[19],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[20],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[20],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[21],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[21],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[22],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[22],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[23],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[23],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[24],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[24],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[25],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[25],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[26],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[26],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[27],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[27],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[28],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[28],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[29],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[29],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[30],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[30],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[31],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[31],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[32],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[32],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[33],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[33],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[34],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[34],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[35],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[35],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[36],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[36],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[37],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[37],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[38],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[38],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[39],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[39],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[40],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[40],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[41],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[41],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[42],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[42],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[43],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[43],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[44],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[44],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[45],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[45],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[46],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[46],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[47],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[47],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[48],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[48],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[49],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[49],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[50],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[50],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[51],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[51],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[52],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[52],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[53],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[53],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[54],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[54],
+		    per_cpu(hcall_type_count,cpu->sysdev.id)[55],
+		    per_cpu(hcall_type_time,cpu->sysdev.id)[55]);
+}
+
+static SYSDEV_ATTR(hcall_stats, 0666, show_hcall_stats, store_hcall_stats);
+
+static int __init hcall_stats_data_init(void)
+{
+    int cpu;
+
+    for_each_cpu(cpu) {
+		struct cpu *c = &per_cpu(cpu_devices, cpu);
+		sysdev_create_file(&c->sysdev, &attr_hcall_stats);
+    }
+    return 0;
+}
+
 static int __init topology_init(void)
 {
 	int cpu;
@@ -378,6 +585,7 @@ static int __init topology_init(void)
 			register_cpu_online(cpu);
 	}
 
-	return 0;
+	return hcall_stats_data_init();
 }
 __initcall(topology_init);
+
diff -urpN -X linux-2.6.15.6/Documentation/dontdiff linux-2.6.15.6.ref/arch/powerpc/platforms/pseries/hvCall.S linux-2.6.15.6.hcall/arch/powerpc/platforms/pseries/hvCall.S
--- linux-2.6.15.6.ref/arch/powerpc/platforms/pseries/hvCall.S	2006-03-06 06:07:54.000000000 +1100
+++ linux-2.6.15.6.hcall/arch/powerpc/platforms/pseries/hvCall.S	2006-04-05 13:52:20.000000000 +1000
@@ -27,7 +27,7 @@
 			unsigned long *out2,		R9
 			unsigned long *out3);		R10
  */
-_GLOBAL(plpar_hcall)
+_GLOBAL(plpar_hcall_real)
 	HMT_MEDIUM
 
 	mfcr	r0
@@ -53,10 +53,15 @@ _GLOBAL(plpar_hcall)
 	blr				/* return r3 = status */
 
 
-/* Simple interface with no output values (other than status) */
 _GLOBAL(plpar_hcall_norets)
 	HMT_MEDIUM
 
+	b plpar_hcall_norets_C
+	
+/* Simple interface with no output values (other than status) */
+_GLOBAL(plpar_hcall_norets_real)
+	HMT_MEDIUM
+
 	mfcr	r0
 	stw	r0,8(r1)
 
@@ -78,7 +83,7 @@ _GLOBAL(plpar_hcall_norets)
 			unsigned long arg8,		112(R1)
 			unsigned long *out1);		120(R1)
  */
-_GLOBAL(plpar_hcall_8arg_2ret)
+_GLOBAL(plpar_hcall_8arg_2ret_real)
 	HMT_MEDIUM
 
 	mfcr	r0
@@ -104,7 +109,7 @@ _GLOBAL(plpar_hcall_8arg_2ret)
 		 	unsigned long *out3,		R10
 		 	unsigned long *out4);		112(R1)
  */
-_GLOBAL(plpar_hcall_4out)
+_GLOBAL(plpar_hcall_4out_real)
 	HMT_MEDIUM
 
 	mfcr	r0
diff -urpN -X linux-2.6.15.6/Documentation/dontdiff linux-2.6.15.6.ref/arch/powerpc/platforms/pseries/lpar.c linux-2.6.15.6.hcall/arch/powerpc/platforms/pseries/lpar.c
--- linux-2.6.15.6.ref/arch/powerpc/platforms/pseries/lpar.c	2006-03-06 06:07:54.000000000 +1100
+++ linux-2.6.15.6.hcall/arch/powerpc/platforms/pseries/lpar.c	2006-04-05 13:54:48.000000000 +1000
@@ -532,3 +532,286 @@ void hpte_init_lpar(void)
 
 	htab_finish_init();
 }
+
+DEFINE_PER_CPU(unsigned long[NUM_HCALL_TYPES], hcall_type_count);
+DEFINE_PER_CPU(unsigned long[NUM_HCALL_TYPES], hcall_type_time);
+
+/* From ibmveth.h */
+/* hcall numbers */
+#define H_VIO_SIGNAL             0x104
+#define H_REGISTER_LOGICAL_LAN   0x114
+#define H_FREE_LOGICAL_LAN       0x118
+#define H_ADD_LOGICAL_LAN_BUFFER 0x11C
+#define H_SEND_LOGICAL_LAN       0x120
+#define H_MULTICAST_CTRL         0x130
+#define H_CHANGE_LOGICAL_LAN_MAC 0x14C
+
+inline int map_hcall_to_index(unsigned long opcode)
+{
+    switch (opcode) {
+    case H_REMOVE:
+	return 0;
+    case H_ENTER:
+	return 1;
+    case H_READ:
+	return 2;
+    case H_CLEAR_MOD:
+	return 3;
+    case H_CLEAR_REF:
+	return 4;
+    case H_PROTECT:
+	return 5;
+    case H_GET_TCE:
+	return 6;
+    case H_PUT_TCE:
+	return 7;
+    case H_SET_SPRG0:
+	return 8;
+    case H_SET_DABR:
+	return 9;
+    case H_PAGE_INIT:
+	return 10;
+    case H_SET_ASR:
+	return 11;
+    case H_ASR_ON:
+	return 12;
+    case H_ASR_OFF:
+	return 13;
+    case H_LOGICAL_CI_LOAD:
+	return 14;
+    case H_LOGICAL_CI_STORE:
+	return 15;
+    case H_LOGICAL_CACHE_LOAD:
+	return 16;
+    case H_LOGICAL_CACHE_STORE:
+	return 17;
+    case H_LOGICAL_ICBI:
+	return 18;
+    case H_LOGICAL_DCBF:
+	return 19;
+    case H_GET_TERM_CHAR:
+	return 20;
+    case H_PUT_TERM_CHAR:
+	return 21;
+    case H_REAL_TO_LOGICAL:
+	return 22;
+    case H_HYPERVISOR_DATA:
+	return 23;
+    case H_EOI:
+	return 24;
+    case H_CPPR:
+	return 25;
+    case H_IPI:
+	return 26;
+    case H_IPOLL:
+	return 27;
+    case H_XIRR:
+	return 28;
+    case H_PERFMON:
+	return 29;
+    case H_MIGRATE_DMA:
+	return 30;
+    case H_REGISTER_VPA:
+	return 31;
+    case H_CEDE:
+	return 32;
+    case H_CONFER:
+	return 33;
+    case H_PROD:
+	return 34;
+    case H_GET_PPP:
+	return 35;
+    case H_SET_PPP:
+	return 36;
+    case H_PURR:
+	return 37;
+    case H_PIC:
+	return 38;
+    case H_REG_CRQ:
+	return 39;
+    case H_FREE_CRQ:
+	return 40;
+    case H_VIO_SIGNAL:
+	return 41;
+    case H_SEND_CRQ:
+	return 42;
+    case H_COPY_RDMA:
+	return 43;
+    case H_STUFF_TCE:
+	return 44;
+    case H_PUT_TCE_INDIRECT:
+	return 45;
+    case H_VTERM_PARTNER_INFO:
+	return 46;
+    case H_REGISTER_VTERM:
+	return 47;
+    case H_FREE_VTERM:
+	return 48;
+    case H_POLL_PENDING:
+	return 49;
+    case H_REGISTER_LOGICAL_LAN:
+	return 50;
+    case H_FREE_LOGICAL_LAN:
+	return 51;
+    case H_ADD_LOGICAL_LAN_BUFFER:
+	return 52;
+    case H_SEND_LOGICAL_LAN:
+	return 53;
+    case H_MULTICAST_CTRL:
+	return 54;
+    case H_CHANGE_LOGICAL_LAN_MAC:
+	return 55;
+    default:
+	printk("Unknown hcall %ld\n", opcode);
+	return 0;
+    }
+}
+
+extern long plpar_hcall_real(unsigned long opcode,
+			     unsigned long arg1,
+			     unsigned long arg2,
+			     unsigned long arg3,
+			     unsigned long arg4,
+			     unsigned long *out1,
+			     unsigned long *out2,
+			     unsigned long *out3);
+
+long plpar_hcall(unsigned long opcode, unsigned long arg1,
+			unsigned long arg2, unsigned long arg3,
+			unsigned long arg4, unsigned long *out1,
+			unsigned long *out2, unsigned long *out3)
+{
+    long retcode;
+    unsigned long t_entry;
+    int opcode_index;
+    
+    opcode_index = map_hcall_to_index(opcode);
+    
+    t_entry = mfspr(SPRN_PURR);
+    barrier();
+    
+    retcode = plpar_hcall_real(opcode, arg1, arg2, arg3, arg4,
+			       out1, out2, out3);
+    
+    barrier();
+    get_cpu_var(hcall_type_count)[opcode_index]++;
+    put_cpu_var(hcall_type_count);
+    get_cpu_var(hcall_type_time)[opcode_index] += mfspr(SPRN_PURR) - t_entry;
+    put_cpu_var(hcall_type_time);
+    
+    return retcode;
+};
+
+extern long plpar_hcall_norets_real(unsigned long opcode, ...);
+
+long plpar_hcall_norets_C(unsigned long opcode,
+			  unsigned long arg1,
+			  unsigned long arg2,
+			  unsigned long arg3,
+			  unsigned long arg4,
+			  unsigned long arg5,
+			  unsigned long arg6) 
+{
+    long retcode;
+    unsigned long t_entry;
+    int opcode_index;
+    
+    opcode_index = map_hcall_to_index(opcode);
+    t_entry = mfspr(SPRN_PURR);
+    barrier();
+
+    retcode = plpar_hcall_norets_real(opcode, arg1, arg2, arg3, arg4,
+				      arg5, arg6);
+
+    barrier();
+    get_cpu_var(hcall_type_count)[opcode_index]++;
+    put_cpu_var(hcall_type_count);
+    get_cpu_var(hcall_type_time)[opcode_index] += mfspr(SPRN_PURR) - t_entry;
+    put_cpu_var(hcall_type_time);
+
+    return retcode;
+}
+
+extern long plpar_hcall_8arg_2ret_real(unsigned long opcode,
+				       unsigned long arg1,
+				       unsigned long arg2,
+				       unsigned long arg3,
+				       unsigned long arg4,
+				       unsigned long arg5,
+				       unsigned long arg6,
+				       unsigned long arg7,
+				       unsigned long arg8,
+				       unsigned long *out1);
+
+long plpar_hcall_8arg_2ret(unsigned long opcode,
+			   unsigned long arg1,
+		  	   unsigned long arg2,
+			   unsigned long arg3,
+			   unsigned long arg4,
+			   unsigned long arg5,
+			   unsigned long arg6,
+			   unsigned long arg7,
+			   unsigned long arg8,
+			   unsigned long *out1)
+{
+    long retcode;
+    unsigned long t_entry;
+    int opcode_index;
+    
+    opcode_index = map_hcall_to_index(opcode);
+    t_entry = mfspr(SPRN_PURR);
+    barrier();
+
+    retcode = plpar_hcall_8arg_2ret_real(opcode, arg1, arg2, arg3, arg4,
+					 arg5, arg6, arg7, arg8, out1);
+
+    barrier();
+    get_cpu_var(hcall_type_count)[opcode_index]++;
+    put_cpu_var(hcall_type_count);
+    get_cpu_var(hcall_type_time)[opcode_index] += mfspr(SPRN_PURR) - t_entry;
+    put_cpu_var(hcall_type_time);
+
+    return retcode;
+}
+
+extern long plpar_hcall_4out_real(unsigned long opcode,
+				  unsigned long arg1,
+				  unsigned long arg2,
+				  unsigned long arg3,
+				  unsigned long arg4,
+				  unsigned long *out1,
+				  unsigned long *out2,
+				  unsigned long *out3,
+				  unsigned long *out4);
+
+long plpar_hcall_4out(unsigned long opcode,
+		      unsigned long arg1,
+		      unsigned long arg2,
+		      unsigned long arg3,
+		      unsigned long arg4,
+		      unsigned long *out1,
+		      unsigned long *out2,
+		      unsigned long *out3,
+		      unsigned long *out4)
+{
+    long retcode;
+    unsigned long t_entry;
+    int opcode_index;
+    
+    opcode_index = map_hcall_to_index(opcode);
+    t_entry = mfspr(SPRN_PURR);
+    barrier();
+
+    retcode = plpar_hcall_4out_real(opcode, arg1, arg2, arg3, arg4,
+				    out1, out2, out3, out4);
+
+    barrier();
+    get_cpu_var(hcall_type_count)[opcode_index]++;
+    put_cpu_var(hcall_type_count);
+    get_cpu_var(hcall_type_time)[opcode_index] += mfspr(SPRN_PURR) - t_entry;
+    put_cpu_var(hcall_type_time);
+
+    return retcode;
+}
+
+
diff -urpN -X linux-2.6.15.6/Documentation/dontdiff linux-2.6.15.6.ref/include/asm-powerpc/hvcall.h linux-2.6.15.6.hcall/include/asm-powerpc/hvcall.h
--- linux-2.6.15.6.ref/include/asm-powerpc/hvcall.h	2006-03-06 06:07:54.000000000 +1100
+++ linux-2.6.15.6.hcall/include/asm-powerpc/hvcall.h	2006-04-05 13:59:22.000000000 +1000
@@ -116,6 +116,11 @@
 
 #ifndef __ASSEMBLY__
 
+
+#define NUM_HCALL_TYPES 56
+/* Some are in ibmveth.h */
+
+
 /* plpar_hcall() -- Generic call interface using above opcodes
  *
  * The actual call interface is a hypervisor call instruction with
