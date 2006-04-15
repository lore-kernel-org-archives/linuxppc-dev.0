Return-Path: <cel@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E11CA67A41
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 10:16:11 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3F0G3lr003547
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 20:16:03 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3F0CUIO227352
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 18:12:30 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3F0G3fL029860
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 18:16:03 -0600
Subject: Re: patch for powerpc lparcfg.c
From: Carl Love <cel@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>, linuxppc-dev@ozlabs.org
In-Reply-To: <20060414175039.GD25138@localdomain>
References: <1144969793.5286.10.camel@dyn9047021119.beaverton.ibm.com>
	<20060414002539.GC25138@localdomain>
	<1145035146.5214.16.camel@dyn9047021119.beaverton.ibm.com>
	<20060414175039.GD25138@localdomain>
Content-Type: multipart/mixed; boundary="=-eOEr1FVz8OC1A6ChLszA"
Date: Fri, 14 Apr 2006 17:16:02 -0700
Message-Id: <1145060162.5214.30.camel@dyn9047021119.beaverton.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-eOEr1FVz8OC1A6ChLszA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Nathan Lynch:

Oops, lost the cc line the last time.

I wasn't aware that the partition name was already being printed in
the /proc/device-tree.  Yes, my tool could use that entry.  It just
means opening multiple locations to get all the information.  I will go
ahead and use it since it is there.   

The patch becomes a bit more academic.  The question becomes, should the
partition name also be printed in /proc/ppc64/lparcfg along with the
rest of the partition information?  Seems like a good idea to me since
it makes the information in lparcfg more complete.  I will leave it up
to the maintainers to decide. 

I have reattached the updated patch in case anyone cares. 

Thanks for letting me know where I can get the partition name.

                  Carl Love



On Fri, 2006-04-14 at 12:50 -0500, Nathan Lynch wrote:
> You forgot to cc the list...
> 
> Carl Love wrote:
> > 
> > The intended consumer of this information is a tool that I am working
> > on.  The tool prints the CPU utilization as a function of the
> > partition's processor entitlement, hypervisor call statistics (number of
> > calls, average call time, max call time, min call time) and partition
> > configuration information.  Specifically, the -i option is to print the
> > partition information.  The required information includes the partition
> > name.  Most of the other required information comes from
> > the  /proc/ppc64/lparcfg file.  This seems like a logical place to
> > include the partition name.
> 
> The partition name, if it exists, is already available at
> /proc/device-tree/ibm,partition-name.  Any reason your tool couldn't
> use that?

--=-eOEr1FVz8OC1A6ChLszA
Content-Disposition: attachment; filename=linux-2.6.17-rc1-git8-lparcfg.patch
Content-Type: text/x-patch; name=linux-2.6.17-rc1-git8-lparcfg.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rauN -X /home/carll/dontdiff linux-2.6.17-rc1-git8/arch/powerpc/kernel/lparcfg.c linux-2.6.17-rc1-git8-new/arch/powerpc/kernel/lparcfg.c
--- linux-2.6.17-rc1-git8/arch/powerpc/kernel/lparcfg.c	2006-04-13 12:25:11.000000000 -0700
+++ linux-2.6.17-rc1-git8-new/arch/powerpc/kernel/lparcfg.c	2006-04-14 09:24:12.000000000 -0700
@@ -340,6 +340,7 @@
 	struct device_node *rootdn;
 	const char *model = "";
 	const char *system_id = "";
+	const char *partition_name = NULL;
 	unsigned int *lp_index_ptr, lp_index = 0;
 	struct device_node *rtas_node;
 	int *lrdrp = NULL;
@@ -347,6 +348,8 @@
 	rootdn = find_path_device("/");
 	if (rootdn) {
 		model = get_property(rootdn, "model", NULL);
+		partition_name = get_property(rootdn, 
+					      "ibm,partition-name", NULL);
 		system_id = get_property(rootdn, "system-id", NULL);
 		lp_index_ptr = (unsigned int *)
 		    get_property(rootdn, "ibm,partition-no", NULL);
@@ -360,6 +363,9 @@
 
 	seq_printf(m, "system_type=%s\n", model);
 
+	if (!NULL)
+		seq_printf(m, "partition_name=%s\n", partition_name);
+
 	seq_printf(m, "partition_id=%d\n", (int)lp_index);
 
 	rtas_node = find_path_device("/rtas");

--=-eOEr1FVz8OC1A6ChLszA--
