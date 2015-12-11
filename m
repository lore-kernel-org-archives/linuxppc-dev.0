Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88C561A0809
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 16:44:04 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 11 Dec 2015 15:44:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 211842CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 16:43:59 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBB5hWKs12058788
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 16:43:40 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBB5hQWE028043
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 16:43:26 +1100
Message-ID: <566A6255.3060804@linux.vnet.ibm.com>
Date: Fri, 11 Dec 2015 13:42:45 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, tglx@linutronix.de
Subject: Re: [PATCH] powerpc/nvram: Fix an incorrect partition merge
References: <566929FA.2050409@linux.vnet.ibm.com>
In-Reply-To: <566929FA.2050409@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, all
	I do some tests *without* my fix patch. after reboot, I saw logs below.

[    0.271236] WARNING: nvram partition checksum was 58, should be 24!
[    0.271239] Terminating nvram partition scan

If I do tests *with* my fix patch, logs are:

[    0.291419] --------NVRAM Partitions---------
[    0.291422] indx             sig     chks    len     name
[    0.291425]    0     51      15      512      ibm,CPU0log
[    0.291428] 8192     51      94      128      ibm,CPU1log
[    0.291431] 10240            70      fc      256           common
[    0.291434] 14336            a0      b5      131     ibm,rtas-log
[    0.291437] 16432            a0      4f      251     lnx,oops-log
[    0.291440] 20448            7f      26      2818    wwwwwwwwwwww


HOW TO REPRODUCE this warning?:
root@ubuntu:/home/pp/host# ./a.out 0 xinhui 4096
root@ubuntu:/home/pp/host# ./a.out 0 xinhui2 4096
root@ubuntu:/home/pp/host# ./a.out 0 xinhui3 4096
root@ubuntu:/home/pp/host# ./a.out 1 xinhui2
root@ubuntu:/home/pp/host# ./a.out 1 xinhui3
root@ubuntu:/home/pp/host# ./a.out 1 xinhui

then logs from dmesg are:
[  844.205337] XINHUI: dev_nvram_ioctl, [xinhui],[0]
[  844.205449] --------NVRAM Partitions---------
[  844.205482] indx             sig     chks    len     name
[  844.205510]    0     51      15      512      ibm,CPU0log
[  844.205541] 8192     51      94      128      ibm,CPU1log
[  844.205573] 10240            70      fc      256           common
[  844.205604] 14336            a0      b5      131     ibm,rtas-log
[  844.205636] 16432            a0      4f      251     lnx,oops-log
[  844.205667] 20448            7f      5e      2818      free space
[  851.636438] XINHUI: dev_nvram_ioctl, [xinhui],[4096]
[  851.636534] --------NVRAM Partitions---------
[  851.636573] indx             sig     chks    len     name
[  851.636614]    0     51      15      512      ibm,CPU0log
[  851.636651] 8192     51      94      128      ibm,CPU1log
[  851.636688] 10240            70      fc      256           common
[  851.636725] 14336            a0      b5      131     ibm,rtas-log
[  851.636762] 16432            a0      4f      251     lnx,oops-log
[  851.636798] 20448            ef      89      257           xinhui
[  851.636836] 24560            7f      5c      2561      free space
[  855.354409] XINHUI: dev_nvram_ioctl, [xinhui2],[4096]
[  855.354600] --------NVRAM Partitions---------
[  855.354639] indx             sig     chks    len     name
[  855.354671]    0     51      15      512      ibm,CPU0log
[  855.354708] 8192     51      94      128      ibm,CPU1log
[  855.355499] 10240            70      fc      256           common
[  855.356186] 14336            a0      b5      131     ibm,rtas-log
[  855.356816] 16432            a0      4f      251     lnx,oops-log
[  855.357429] 20448            ef      89      257           xinhui
[  855.357966] 24560            ef      bb      257          xinhui2
[  855.358466] 28672            7f      5a      2304      free space
[  857.866574] XINHUI: dev_nvram_ioctl, [xinhui3],[4096]
[  857.867449] --------NVRAM Partitions---------
[  857.868250] indx             sig     chks    len     name
[  857.869082]    0     51      15      512      ibm,CPU0log
[  857.869901] 8192     51      94      128      ibm,CPU1log
[  857.870727] 10240            70      fc      256           common
[  857.871569] 14336            a0      b5      131     ibm,rtas-log
[  857.872392] 16432            a0      4f      251     lnx,oops-log
[  857.873202] 20448            ef      89      257           xinhui
[  857.874019] 24560            ef      bb      257          xinhui2
[  857.874811] 28672            ef      bc      257          xinhui3
[  857.875568] 32784            7f      58      2047      free space
[ 1015.661796] XINHUI: dev_nvram_ioctl, [xinhui2],[16383]
[ 1015.662670] --------NVRAM Partitions---------
[ 1015.663457] indx             sig     chks    len     name
[ 1015.664150]    0     51      15      512      ibm,CPU0log
[ 1015.664788] 8192     51      94      128      ibm,CPU1log
[ 1015.665396] 10240            70      fc      256           common
[ 1015.665948] 14336            a0      b5      131     ibm,rtas-log
[ 1015.666470] 16432            a0      4f      251     lnx,oops-log
[ 1015.666977] 20448            ef      89      257           xinhui
[ 1015.667455] 24560            7f      1b      257     wwwwwwwwwwww
[ 1015.667914] 28672            ef      bc      257          xinhui3
[ 1015.668359] 32784            7f      58      2047      free space
[ 1017.452055] XINHUI: dev_nvram_ioctl, [xinhui3],[16383]
[ 1017.452902] --------NVRAM Partitions---------
[ 1017.453731] indx             sig     chks    len     name
[ 1017.454531]    0     51      15      512      ibm,CPU0log
[ 1017.455341] 8192     51      94      128      ibm,CPU1log
[ 1017.456121] 10240            70      fc      256           common
[ 1017.456916] 14336            a0      b5      131     ibm,rtas-log
[ 1017.457705] 16432            a0      4f      251     lnx,oops-log
[ 1017.458473] 20448            ef      89      257           xinhui
[ 1017.459256] 24560            7f      58      2561    wwwwwwwwwwww
[ 1020.871652] XINHUI: dev_nvram_ioctl, [xinhui],[16383]
[ 1020.872141] --------NVRAM Partitions---------
[ 1020.872584] indx             sig     chks    len     name
[ 1020.873021]    0     51      15      512      ibm,CPU0log
[ 1020.873475] 8192     51      94      128      ibm,CPU1log
[ 1020.873907] 10240            70      fc      256           common
[ 1020.874339] 14336            a0      b5      131     ibm,rtas-log
[ 1020.874777] 16432            a0      4f      251     lnx,oops-log
[ 1020.875205] 20448            7f      24      2818    wwwwwwwwwwww

the we reboot system, we would see warning logs, it means nvram partition is corrupted!

WHY IT CORRUPTED?:
when we combine two continuous partitions, current codes do wrong merge!
see my fix patch codes below:
@@ -1017,8 +1017,8 @@ int nvram_remove_partition(const char *name, int sig,
                }
                if (prev) {
                        prev->header.length += part->header.length;
-                       prev->header.checksum = nvram_checksum(&part->header);
[XINHUI]: we update prev->header.length, then we need re-calculate it's checksum, not part's! 
-                       rc = nvram_write_header(part);
[XINHUI]: we update prev->header, so we need write prev's header to nvram. not part's! 
+                       prev->header.checksum = nvram_checksum(&prev->header);
+                       rc = nvram_write_header(prev);
[XINHUI]: this is the correct code.
                        if (rc <= 0) {
                                printk(KERN_ERR "nvram_remove_partition: nvram_write failed (%d)\n", rc);
                                return rc;

these two partitions looks like
before merge:
------  -----------  ---------   -------
other| | prev     | | part    | | other...
------  ----------  ---------   -------
after merge:
------  ----------------------   -------
other| | prev(updated)        | | other...
------  ----------------------   -------

NOW let me share the *debug* patch and the user-space codes, they are :

>From 5f7e0fe90b7671f8bbb142d9df1f5d4013819c48 Mon Sep 17 00:00:00 2001
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Date: Fri, 11 Dec 2015 12:36:57 +0800
Subject: [PATCH] debug nvram

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/nvram_64.c | 53 ++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index a8939f5..4d91654 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -36,6 +36,13 @@
 #include <asm/machdep.h>
 
 #undef DEBUG_NVRAM
+#define DEBUG_NVRAM
+struct x{
+	char name[12];
+	unsigned int size;
+};
+#define IOC_NVRAM_CREATE        _IOWR('p', 0x44, struct x)
+#define IOC_NVRAM_REMOVE        _IOWR('p', 0x45, struct x)
 
 #define NVRAM_HEADER_LEN	sizeof(struct nvram_header)
 #define NVRAM_BLOCK_LEN		NVRAM_HEADER_LEN
@@ -843,9 +850,12 @@ out:
 
 }
 
+static void nvram_print_partitions(char * label);
+
 static long dev_nvram_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
+	int remove = 0;
 	switch(cmd) {
 #ifdef CONFIG_PPC_PMAC
 	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
@@ -867,6 +877,25 @@ static long dev_nvram_ioctl(struct file *file, unsigned int cmd,
 		return 0;
 	}
 #endif /* CONFIG_PPC_PMAC */
+	case IOC_NVRAM_REMOVE:
+		remove  = 1;
+	case IOC_NVRAM_CREATE: {
+		struct x h;
+		if (copy_from_user(&h, (void __user*)arg, sizeof(h)) != 0) {
+			printk("XINHUI: %s fails\n", __func__);
+			return 0;
+		}
+		printk("XINHUI: %s, [%s],[%d]\n", __func__, h.name, h.size);
+		if (remove == 0)
+			nvram_create_partition(h.name, 0xef, h.size, 0x100);
+		else
+			nvram_remove_partition(h.name, 0xef, NULL);
+       }
+
+#ifdef DEBUG_NVRAM
+		nvram_print_partitions("NVRAM Partitions");
+#endif
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -878,6 +907,7 @@ const struct file_operations nvram_fops = {
 	.read		= dev_nvram_read,
 	.write		= dev_nvram_write,
 	.unlocked_ioctl	= dev_nvram_ioctl,
+	.compat_ioctl	= dev_nvram_ioctl,
 };
 
 static struct miscdevice nvram_dev = {
@@ -888,7 +918,7 @@ static struct miscdevice nvram_dev = {
 
 
 #ifdef DEBUG_NVRAM
-static void __init nvram_print_partitions(char * label)
+static void nvram_print_partitions(char * label)
 {
 	struct nvram_partition * tmp_part;
 	
@@ -904,7 +934,7 @@ static void __init nvram_print_partitions(char * label)
 #endif
 
 
-static int __init nvram_write_header(struct nvram_partition * part)
+static int nvram_write_header(struct nvram_partition * part)
 {
 	loff_t tmp_index;
 	int rc;
@@ -920,7 +950,7 @@ static int __init nvram_write_header(struct nvram_partition * part)
 }
 
 
-static unsigned char __init nvram_checksum(struct nvram_header *p)
+static unsigned char nvram_checksum(struct nvram_header *p)
 {
 	unsigned int c_sum, c_sum2;
 	unsigned short *sp = (unsigned short *)p->name; /* assume 6 shorts */
@@ -965,7 +995,7 @@ static int nvram_can_remove_partition(struct nvram_partition *part,
  *        leave these alone.
  */
 
-int __init nvram_remove_partition(const char *name, int sig,
+int nvram_remove_partition(const char *name, int sig,
 						const char *exceptions[])
 {
 	struct nvram_partition *part, *prev, *tmp;
@@ -1023,7 +1053,7 @@ int __init nvram_remove_partition(const char *name, int sig,
  * you need to query for the actual size yourself after the
  * call using nvram_partition_get_size().
  */
-loff_t __init nvram_create_partition(const char *name, int sig,
+loff_t nvram_create_partition(const char *name, int sig,
 				     int req_size, int min_size)
 {
 	struct nvram_partition *part;
-- 
2.5.0


*user-space* codes:

#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <linux/ioctl.h>

struct x{
           char name[12];
           unsigned int size;
};

#define IOC_NVRAM_CREATE        _IOWR('p', 0x44, struct x)
#define IOC_NVRAM_REMOVE        _IOWR('p', 0x45, struct x)

void main(int argc, char *argv[])
{
	int fd;
	unsigned int cmd;
	struct x h;

	fd = open("/dev/nvram", O_RDWR);
	if (fd < 0) {
		printf("fails open\n");
		return;
	}

	cmd = atoi(argv[1]);
	if (cmd == 0)
		cmd = IOC_NVRAM_CREATE;
	else 
		cmd = IOC_NVRAM_REMOVE;

	strncpy(h.name, argv[2], 12);

	if (cmd == IOC_NVRAM_CREATE)
		h.size = atoi(argv[3]);

	printf("%s, %d\n", h.name, h.size);

	if (ioctl(fd, cmd, &h) < 0) {
		printf("fails ioctl\n");
		return;
	}
	close(fd);
	return;
}



any comments are welcome :)

thanks
xinhui

On 2015年12月10日 15:30, xinhui wrote:
> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> When we merge two contiguous partitions whose signatures are marked
> NVRAM_SIG_FREE, We need update prev's length and checksum, then write it
> to nvram, not cur's. So lets fix this mistake now.
> 
> Also use memset instead of strncpy to set the partition's name. It's
> more readable if we want to fill up with duplicate chars .
> 
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/nvram_64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index 21a278b7..40e80ca 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -969,7 +969,7 @@ int __init nvram_remove_partition(const char *name, int sig,
>  
>  		/* Make partition a free partition */
>  		part->header.signature = NVRAM_SIG_FREE;
> -		strncpy(part->header.name, "wwwwwwwwwwww", 12);
> +		memset(part->header.name, 'w', 12);
>  		part->header.checksum = nvram_checksum(&part->header);
>  		rc = nvram_write_header(part);
>  		if (rc <= 0) {
> @@ -987,8 +987,8 @@ int __init nvram_remove_partition(const char *name, int sig,
>  		}
>  		if (prev) {
>  			prev->header.length += part->header.length;
> -			prev->header.checksum = nvram_checksum(&part->header);
> -			rc = nvram_write_header(part);
> +			prev->header.checksum = nvram_checksum(&prev->header);
> +			rc = nvram_write_header(prev);
>  			if (rc <= 0) {
>  				printk(KERN_ERR "nvram_remove_partition: nvram_write failed (%d)\n", rc);
>  				return rc;
> 
