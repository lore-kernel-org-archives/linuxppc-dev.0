Date: Sat, 9 Feb 2002 14:20:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] adjust BAT mapping according to max_low_mem
Message-ID: <20020209212032.GD872@opus.bloom.county>
References: <20020208133604.H25005@boardwalk> <20020209204716.GA872@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020209204716.GA872@opus.bloom.county>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 09, 2002 at 01:47:16PM -0700, Tom Rini wrote:
>
> On Fri, Feb 08, 2002 at 01:36:04PM -0700, Val Henson wrote:
>
> > I'm testing highmem by setting max_low_mem to 64MB and using 256MB RAM
> > total (this does not trigger my SCSI bug).  I had to change a few
> > things in adjust_total_lowmem to force it to _not_ BAT map of all the
> > RAM.  I think the printout of residual is wrong but I'm not sure.
>
> If I'm reading all of the code right, residual at this point should be
> (total_lowmem (initial value) - ram mapped in BATs), so I think this:
>
> > +	/* adjust BAT block size to max_low_mem */
> > +	if (max_low_mem < bat_max)
> > +		bat_max = max_low_mem;
> > +
> > +	/* adjust lowmem size to max_low_mem */
> > +	if (max_low_mem < total_lowmem)
> > +		total_lowmem = max_low_mem;
> > +
> > +	ram = total_lowmem;
>
> Should be:
> 	/* adjust BAT block size to max_low_mem */
> 	if (max_low_mem < bat_max)
> 		bat_max = max_low_mem;
>
> 	/* adjust lowmem size to max_low_mem */
> 	if (max_low_mem < total_lowmem)
> 		ram = max_low_mem;
> 	else
> 		ram = total_lowmem;
> 	...
>
> 	printk(KERN_INFO "Memory BAT mapping: BAT2=%ldMb, BAT3=%ldMb, "
> 		"residual: %ldMb\n", __bat2 >> 20, __bat3 >> 20,
> 		(total_lowmem - ram) >> 20);

And after actually testing:
	printk(KERN_INFO "...
		(total_lowmem - (__bat2 + __bat3)) >> 20);

If someone else can confirm that the above thinking is right, I'll check
in the following patch, which fixes this and the printk for more RAM
than BATS && !CONFIG_HIGHMEM

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/mm/pgtable.c 1.15 vs edited =====
--- 1.15/arch/ppc/mm/pgtable.c	Mon Jan 28 04:11:59 2002
+++ edited/arch/ppc/mm/pgtable.c	Sat Feb  9 14:07:26 2002
@@ -205,7 +205,7 @@
 #ifdef HAVE_BATS
 	unsigned long bat_max = 0x10000000;
 	unsigned long align;
-	unsigned long ram = total_lowmem;
+	unsigned long ram;
 	int is601 = 0;

 	/* 601s have smaller BATs */
@@ -214,6 +214,16 @@
 		is601 = 1;
 	}

+	/* adjust BAT block size to max_low_mem */
+	if (max_low_mem < bat_max)
+		bat_max = max_low_mem;
+
+	/* adjust lowmem size to max_low_mem */
+	if (max_low_mem < total_lowmem)
+		ram = max_low_mem;
+	else
+		ram = total_lowmem;
+
 	/* Make sure we don't map a block larger than the
 	   smallest alignment of the physical address. */
 	/* alignment of PPC_MEMSTART */
@@ -234,8 +244,9 @@
 		ram -= __bat3;
 	}

-	printk(KERN_INFO "Memory BAT mapping: BAT2=%ldMb, BAT3=%ldMb, residual: %ldMb\n",
-		__bat2 >> 20, __bat3 >> 20, ram >> 20);
+	printk(KERN_INFO "Memory BAT mapping: BAT2=%ldMb, BAT3=%ldMb,"
+			" residual: %ldMb\n", __bat2 >> 20, __bat3 >> 20,
+			(total_lowmem - (__bat2 - __bat3)) >> 20);

 	/* On SMP, we limit the lowmem to the area mapped with BATs.
 	 * We also assume nobody will do SMP with 601s
@@ -249,8 +260,9 @@
 	if (total_lowmem > max_low_mem) {
 		total_lowmem = max_low_mem;
 #ifndef CONFIG_HIGHMEM
-		printk(KERN_INFO "Warning, memory limited to %ld Mb, use CONFIG_HIGHMEM"
-			" to reach %ld Mb\n", max_low_mem >> 20, total_lowmem >> 20);
+		printk(KERN_INFO "Warning, memory limited to %ld Mb, use "
+				" CONFIG_HIGHMEM to reach %ld Mb\n",
+				max_low_mem >> 20, total_memory >> 20);
 		total_memory = total_lowmem;
 #endif /* CONFIG_HIGHMEM */
 	}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
