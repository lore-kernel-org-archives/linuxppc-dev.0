Date: Wed, 5 Jun 2002 17:08:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: LMbench results for large page patch
Message-ID: <20020605070832.GF2630@zax>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've done some more LMbench testing, with the large page patch I
posted earlier.  The three cases are:
	- "nopintlb", linuxppc_2_4_devel with CONFIG_PIN_TLB=n
	- "2pintlb", linuxppc_2_4_devel with CONFIG_PIN_TLB=y
	- "largepte", linuxppc_2_4_devel with a slightly updated
version of the large page PTE entries patch I posted last week (patch
attached).

There are 5 runs in each case.

These results shouldn't be compared directly to the numbers in the
last LMbench summary I posted, since some tweaks to the TLB handler
and set_context() in both the normal and largepte cases (which have
been committed to 2_4_devel) have gone in since then.

All tests were done on a Walnut with 200MHz 405GP (PVR 401100c4),
128MB RAM and IDE disk on a Promise PCI IDE controller.

Overall summary:
	Performance of the large PTE patch is very similar to that
with pinned large page TLB entries.  It is slightly better in a few
cases (more on this below) and slightly worse in one or two (notably
prot fault).  It seems to do as well or better than having no large
page entries at all (pinned or otherwise).

I think the improvement over having pinned TLB entries, where it
occurs, is in most cases probably due to the fact that we use large
page entries for all of the kernel mapping of physical RAM, whereas
with pinned entries we only use them for the first 32M.  I'll try to
rerun the tests tomorrow with only 32M of RAM - I expect the results
to put largepte and pinned TLBs even closer together.  The exception
to this is the main memory latency - that's likely to be due to the
fact that userspace can use all 64 TLB entries, thus slightly reducing
the frequency of TLB misses.

If the largepte code does as well in some more testing, particularly
on low-memory machines, I think we should ditch CONFIG_PIN_TLB and use
this instead.  Well, after the implementation has been cleaned up a
little (iopa() especially).

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
2pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
2pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
2pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
2pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
2pintlb   Linux 2.4.19-       powerpc-linux-gnu  199
largepte  Linux 2.4.19-       powerpc-linux-gnu  199
largepte  Linux 2.4.19-       powerpc-linux-gnu  199
largepte  Linux 2.4.19-       powerpc-linux-gnu  199
largepte  Linux 2.4.19-       powerpc-linux-gnu  199
largepte  Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb  Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb  Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb  Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb  Linux 2.4.19-       powerpc-linux-gnu  199
nopintlb  Linux 2.4.19-       powerpc-linux-gnu  199

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
2pintlb   Linux 2.4.19-  199 1.44 2.73 16.4 24.0 153.4 5.60 19.8 1810 8281 31.K
2pintlb   Linux 2.4.19-  199 1.44 2.58 16.3 24.0 156.8 5.60 19.7 1781 8231 30.K
2pintlb   Linux 2.4.19-  199 1.44 2.58 16.4 24.4 156.6 5.60 19.6 1796 8244 30.K
2pintlb   Linux 2.4.19-  199 1.44 2.57 16.1 24.2 153.6 5.57 19.8 1804 8273 31.K
2pintlb   Linux 2.4.19-  199 1.44 2.58 16.1 24.3 154.4 5.57 19.7 1791 8299 31.K
largepte  Linux 2.4.19-  199 1.41 2.47 15.9 23.1 138.0 5.55 19.5 1697 7981 29.K
largepte  Linux 2.4.19-  199 1.43 2.48 15.8 24.0 161.6 5.59 19.4 1678 7949 29.K
largepte  Linux 2.4.19-  199 1.43 2.49 15.9 23.1 138.4 5.59 19.5 1682 8002 29.K
largepte  Linux 2.4.19-  199 1.43 2.63 15.9 23.4 137.3 5.59 19.4 1686 7958 30.K
largepte  Linux 2.4.19-  199 1.43 2.50 16.4 24.0 141.0 5.59 20.2 1687 7978 29.K
nopintlb  Linux 2.4.19-  199 1.46 2.73 17.0 25.4 156.8 6.00 19.5 2042 9039 34.K
nopintlb  Linux 2.4.19-  199 1.46 2.73 17.0 26.0 157.4 6.03 19.5 2082 9101 34.K
nopintlb  Linux 2.4.19-  199 1.46 2.73 16.8 26.1 157.4 6.01 19.5 2075 9093 34.K
nopintlb  Linux 2.4.19-  199 1.46 2.73 16.8 25.6 157.1 6.12 19.2 2053 9061 34.K
nopintlb  Linux 2.4.19-  199 1.46 2.73 17.0 25.4 156.9 6.04 19.2 2082 9140 34.K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
2pintlb   Linux 2.4.19- 5.040   77.4  269.8   90.3  269.5    89.4   270.7
2pintlb   Linux 2.4.19- 6.290   78.7  262.1   89.0  268.5    88.7   267.9
2pintlb   Linux 2.4.19- 3.420   76.3  255.8   89.3  268.7    89.7   268.4
2pintlb   Linux 2.4.19- 2.440   80.5  267.9   90.9  269.7    92.0   270.6
2pintlb   Linux 2.4.19- 5.850   76.6  271.3   91.5  270.3    90.0   270.2
largepte  Linux 2.4.19- 4.220   77.5  253.6   87.8  264.4    86.3   263.4
largepte  Linux 2.4.19- 4.660   78.5  250.3   87.3  262.2    86.8   262.6
largepte  Linux 2.4.19- 3.060   75.0  253.0   87.1  265.3    86.7   264.9
largepte  Linux 2.4.19- 5.460   79.3  249.7   86.5  263.1    87.1   264.1
largepte  Linux 2.4.19- 5.400   75.4  253.5   85.8  264.6    86.0   265.6
nopintlb  Linux 2.4.19- 4.740   77.8  276.0   96.7  275.2    97.1   275.2
nopintlb  Linux 2.4.19- 5.600   78.8  270.5   93.8  274.0    95.3   276.7
nopintlb  Linux 2.4.19- 5.680   78.5  274.6   94.8  275.7    96.6   277.8
nopintlb  Linux 2.4.19- 4.250   80.6  275.6   96.2  278.7    96.7   277.4
nopintlb  Linux 2.4.19- 4.860   77.4  276.3   94.3  277.5    94.3   278.5

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
2pintlb   Linux 2.4.19- 5.040  35.1 62.5             247.0       891.
2pintlb   Linux 2.4.19- 6.290  31.8 65.8             243.3       901.
2pintlb   Linux 2.4.19- 3.420  33.6 68.7             238.6       899.
2pintlb   Linux 2.4.19- 2.440  36.2 63.6             237.9       903.
2pintlb   Linux 2.4.19- 5.850  35.6 70.6             242.6       904.
largepte  Linux 2.4.19- 4.220  29.6 55.8             277.9       901.
largepte  Linux 2.4.19- 4.660  31.0 66.6             280.2       898.
largepte  Linux 2.4.19- 3.060  31.6 67.4             279.3       908.
largepte  Linux 2.4.19- 5.460  34.2 66.9             280.2       909.
largepte  Linux 2.4.19- 5.400  32.2 57.9             279.0       916.
nopintlb  Linux 2.4.19- 4.740  35.3 67.0             364.5       1146
nopintlb  Linux 2.4.19- 5.600  38.6 68.4             365.7       1151
nopintlb  Linux 2.4.19- 5.680  37.7 64.6             326.0       1171
nopintlb  Linux 2.4.19- 4.250  32.2 65.9             326.0       1147
nopintlb  Linux 2.4.19- 4.860  37.5 67.0             374.5       1162

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page
                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
2pintlb   Linux 2.4.19-  581.7  161.0 1236.1  311.9   1440.0 1.442    21.0
2pintlb   Linux 2.4.19-  581.7  160.6 1248.4  303.6   1458.0 0.965    21.0
2pintlb   Linux 2.4.19-  583.4  161.8 1265.8  319.7   1450.0 1.001    20.0
2pintlb   Linux 2.4.19-  582.1  163.6 1254.7  311.3   1449.0 0.993    20.0
2pintlb   Linux 2.4.19-  581.4  160.7 1248.4  302.3   1458.0 0.971    20.0
largepte  Linux 2.4.19-  579.7  157.6 1219.5  308.3   1381.0 2.267    20.0
largepte  Linux 2.4.19-  580.0  163.5 1218.0  312.9   1393.0 2.131    19.0
largepte  Linux 2.4.19-  581.4  165.8 1219.5  297.7   1441.0 2.557    20.0
largepte  Linux 2.4.19-  579.4  157.1 1204.8  304.2   1380.0 2.884    20.0
largepte  Linux 2.4.19-  581.4  158.8 1222.5  296.2   1385.0 1.666    20.0
nopintlb  Linux 2.4.19-  649.4  216.6 1445.1  401.1   1724.0 2.024    24.0
nopintlb  Linux 2.4.19-  649.4  216.0 1440.9  410.2   1740.0 2.151    24.0
nopintlb  Linux 2.4.19-  650.6  215.6 1445.1  400.2   1742.0 1.985    24.0
nopintlb  Linux 2.4.19-  648.1  216.3 1424.5  405.5   1780.0 2.319    24.0
nopintlb  Linux 2.4.19-  648.1  218.7 1436.8  414.4   1744.0 2.638    24.0

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
2pintlb   Linux 2.4.19- 42.7 41.8 32.1   48.0  115.6   86.2   84.3 115. 128.7
2pintlb   Linux 2.4.19- 45.6 42.1 62.7   48.3  115.6   86.1   84.4 115. 130.0
2pintlb   Linux 2.4.19- 43.8 42.9 32.2   48.3  115.6   85.9   84.3 115. 130.0
2pintlb   Linux 2.4.19- 42.0 42.5 30.9   47.5  115.6   85.0   84.2 115. 128.0
2pintlb   Linux 2.4.19- 43.1 41.6 31.6   47.8  115.6   85.5   84.0 115. 129.1
largepte  Linux 2.4.19- 43.4 42.4 65.3   48.4  115.7   86.2   84.5 115. 128.5
largepte  Linux 2.4.19- 43.4 44.0 33.0   49.0  115.7   86.2   84.5 115. 130.9
largepte  Linux 2.4.19- 43.8 43.3 65.7   49.0  115.7   86.3   84.3 115. 130.8
largepte  Linux 2.4.19- 43.6 43.7 65.5   48.9  115.7   86.2   84.4 115. 130.0
largepte  Linux 2.4.19- 44.5 44.1 33.2   48.5  115.7   86.4   84.4 115. 131.3
nopintlb  Linux 2.4.19- 41.0 39.3 29.1   47.6  115.5   85.5   84.0 115. 128.5
nopintlb  Linux 2.4.19- 40.9 39.7 59.8   47.6  115.5   85.8   84.1 115. 130.6
nopintlb  Linux 2.4.19- 41.1 39.3 29.5   47.6  115.5   85.8   84.2 115. 131.2
nopintlb  Linux 2.4.19- 39.2 39.3 59.4   47.2  115.5   85.4   83.8 115. 127.7
nopintlb  Linux 2.4.19- 41.2 38.6 29.6   47.3  115.5   85.3   83.9 115. 130.3

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
2pintlb   Linux 2.4.19-   199  15.0  133.9  148.0    No L2 cache?
2pintlb   Linux 2.4.19-   199  15.0  133.8  147.9    No L2 cache?
2pintlb   Linux 2.4.19-   199  15.0  133.8  148.0    No L2 cache?
2pintlb   Linux 2.4.19-   199  15.0  134.0  148.1    No L2 cache?
2pintlb   Linux 2.4.19-   199  15.0  133.9  148.0    No L2 cache?
largepte  Linux 2.4.19-   199  15.0  133.9  147.4    No L2 cache?
largepte  Linux 2.4.19-   199  15.0  133.8  147.4    No L2 cache?
largepte  Linux 2.4.19-   199  15.0  133.8  147.4    No L2 cache?
largepte  Linux 2.4.19-   199  15.0  133.8  147.4    No L2 cache?
largepte  Linux 2.4.19-   199  15.0  133.9  147.4    No L2 cache?
nopintlb  Linux 2.4.19-   199  15.0  134.0  147.9    No L2 cache?
nopintlb  Linux 2.4.19-   199  15.0  134.0  147.9    No L2 cache?
nopintlb  Linux 2.4.19-   199  15.0  134.0  147.9    No L2 cache?
nopintlb  Linux 2.4.19-   199  15.0  134.1  147.9    No L2 cache?
nopintlb  Linux 2.4.19-   199  15.0  134.0  147.9    No L2 cache?


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Description: largepte patch against current 2_4_devel
Content-Disposition: attachment; filename=patch1

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S linux-grinch-largepage/arch/ppc/kernel/head_4xx.S
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S	Wed Jun  5 13:11:27 2002
+++ linux-grinch-largepage/arch/ppc/kernel/head_4xx.S	Wed Jun  5 16:09:29 2002
@@ -261,10 +261,10 @@
 	tophys(r21, r21)
 	rlwimi	r21, r20, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r21, 0(r21)		/* Get L1 entry */
-	rlwinm.	r22, r21, 0, 0, 19	/* Extract L2 (pte) base address */
+	andi.	r22, r21, _PMD_PRESENT	/* Check if it points to a PTE page */
 	beq	2f			/* Bail if no table */

-	tophys(r22, r22)
+	tophys(r22, r21)
 	rlwimi	r22, r20, 22, 20, 29	/* Compute PTE address */
 	lwz	r21, 0(r22)		/* Get Linux PTE */

@@ -495,33 +495,40 @@
 	tophys(r21, r21)
 	rlwimi	r21, r20, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r21, 0(r21)		/* Get L1 entry */
-	rlwinm.	r22, r21, 0, 0, 19	/* Extract L2 (pte) base address */
+	andi.	r22, r21, _PMD_PRESENT	/* check if it points to pte page */
 	beq	2f			/* Bail if no table */

-	tophys(r22, r22)
+	tophys(r22, r21)
 	rlwimi	r22, r20, 22, 20, 29	/* Compute PTE address */
 	lwz	r21, 0(r22)		/* Get Linux PTE */
 	andi.	r23, r21, _PAGE_PRESENT
-	beq	2f
+	beq	5f

 	ori	r21, r21, _PAGE_ACCESSED
 	stw	r21, 0(r22)

-	/* Most of the Linux PTE is ready to load into the TLB LO.
-	 * We set ZSEL, where only the LS-bit determines user access.
-	 * We set execute, because we don't have the granularity to
-	 * properly set this at the page level (Linux problem).
-	 * If shared is set, we cause a zero PID->TID load.
-	 * Many of these bits are software only.  Bits we don't set
-	 * here we (properly should) assume have the appropriate value.
+	/* Create TLB tag.  This is the faulting address plus a static
+	 * set of bits.  These are size, valid, E, U0.
 	 */
-	li	r22, 0x0ce2
-	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
+	li	r22, 0x00c0
+	rlwimi	r20, r22, 0, 20, 31

 	b	finish_tlb_load

-
+	/* Check for possible large-page pmd entry */
 2:
+	rlwinm.	r22,r21,2,22,24		/* size != 0 means large-page */
+	beq	5f
+
+	/* Create EPN.  This is the faulting address plus a static
+	 * set of bits (valid, E, U0) plus the size from the PMD.
+	 */
+	ori	r22,r22,0x40
+	rlwimi	r20, r22, 0, 20, 31
+
+	b	finish_tlb_load
+
+5:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
@@ -588,32 +595,40 @@
 	tophys(r21, r21)
 	rlwimi	r21, r20, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
 	lwz	r21, 0(r21)		/* Get L1 entry */
-	rlwinm.	r22, r21, 0, 0, 19	/* Extract L2 (pte) base address */
+	andi.	r22, r21, _PMD_PRESENT	/* check if it points to pte page */
 	beq	2f			/* Bail if no table */

-	tophys(r22, r22)
+	tophys(r22, r21)
 	rlwimi	r22, r20, 22, 20, 29	/* Compute PTE address */
 	lwz	r21, 0(r22)		/* Get Linux PTE */
 	andi.	r23, r21, _PAGE_PRESENT
-	beq	2f
+	beq	5f

 	ori	r21, r21, _PAGE_ACCESSED
 	stw	r21, 0(r22)

-	/* Most of the Linux PTE is ready to load into the TLB LO.
-	 * We set ZSEL, where only the LS-bit determines user access.
-	 * We set execute, because we don't have the granularity to
-	 * properly set this at the page level (Linux problem).
-	 * If shared is set, we cause a zero PID->TID load.
-	 * Many of these bits are software only.  Bits we don't set
-	 * here we (properly should) assume have the appropriate value.
+	/* Create EPN.  This is the faulting address plus a static
+	 * set of bits.  These are size, valid, E, U0.
 	 */
-	li	r22, 0x0ce2
-	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
+	li	r22, 0x00c0
+	rlwimi	r20, r22, 0, 20, 31

 	b	finish_tlb_load

+	/* Check for possible large-page pmd entry */
 2:
+	rlwinm.	r22,r21,2,22,24		/* size != 0 means large-page */
+	beq	5f
+
+	/* Create EPN.  This is the faulting address plus a static
+	 * set of bits (valid=1, E=0, U0=0) plus the size from the PMD.
+	 */
+	ori	r22,r22,0x40
+	rlwimi	r20, r22, 0, 20, 31
+
+	b	finish_tlb_load
+
+5:
 	/* The bailout.  Restore registers to pre-exception conditions
 	 * and call the heavyweights to help us out.
 	 */
@@ -758,14 +773,16 @@
 	stw	r23, tlb_4xx_index@l(0)

 6:
+	/*
+	 * Clear out the software-only bits in the PTE to generate the
+	 * TLB_DATA value.  These are the bottom 2 bits of RPN, the
+	 * top 3 bits of the zone field, and M.
+	 */
+	li	r22, 0x0ce2
+	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
+
 	tlbwe	r21, r23, TLB_DATA		/* Load TLB LO */

-	/* Create EPN.  This is the faulting address plus a static
-	 * set of bits.  These are size, valid, E, U0, and ensure
-	 * bits 20 and 21 are zero.
-	 */
-	li	r22, 0x00c0
-	rlwimi	r20, r22, 0, 20, 31
 	tlbwe	r20, r23, TLB_TAG		/* Load TLB HI */

 	/* Done...restore registers and get out of here.
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/pgtable.c linux-grinch-largepage/arch/ppc/mm/pgtable.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/mm/pgtable.c	Mon Apr  8 10:29:07 2002
+++ linux-grinch-largepage/arch/ppc/mm/pgtable.c	Fri May 31 13:51:48 2002
@@ -348,7 +348,38 @@

 	v = KERNELBASE;
 	p = PPC_MEMSTART;
-	for (s = 0; s < total_lowmem; s += PAGE_SIZE) {
+	s = 0;
+#if defined(CONFIG_40x)
+	for (; s <= (total_lowmem - 16*1024*1024); s += 16*1024*1024) {
+		pmd_t *pmdp;
+		unsigned long val = p | _PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE;
+
+		spin_lock(&init_mm.page_table_lock);
+		pmdp = pmd_offset(pgd_offset_k(v), v);
+		pmd_val(*pmdp++) = val;
+		pmd_val(*pmdp++) = val;
+		pmd_val(*pmdp++) = val;
+		pmd_val(*pmdp++) = val;
+		spin_unlock(&init_mm.page_table_lock);
+
+		v += 16*1024*1024;
+		p += 16*1024*1024;
+	}
+
+	for(; s <= (total_lowmem - 4*1024*1024); s += 4*1024*1024) {
+		pmd_t *pmdp;
+		unsigned long val = p | _PMD_SIZE_4M | _PAGE_HWEXEC | _PAGE_HWWRITE;
+
+		spin_lock(&init_mm.page_table_lock);
+		pmdp = pmd_offset(pgd_offset_k(v), v);
+		pmd_val(*pmdp) = val;
+		spin_unlock(&init_mm.page_table_lock);
+
+		v += 4*1024*1024;
+		p += 4*1024*1024;
+	}
+#endif
+	for (; s < total_lowmem; s += PAGE_SIZE) {
 		/* On the MPC8xx, we want the page shared so we
 		 * don't get ASID compares on kernel space.
 		 */
@@ -468,8 +499,33 @@
 		mm = &init_mm;

 	pa = 0;
+#ifdef CONFIG_40x
+	{
+		pgd_t	*pgd;
+		pmd_t	*pmd;
+		const unsigned long large_page_mask[] = {
+			0xfffff800, 0xffffe000, 0xffff8000, 0xfffe0000,
+			0xfff80000, 0xffe00000, 0xff800000, 0xfe000000
+		};
+
+		pgd = pgd_offset(mm, addr & PAGE_MASK);
+		if (pgd) {
+			pmd = pmd_offset(pgd, addr & PAGE_MASK);
+			if (pmd_present(*pmd)) {
+				pte = pte_offset(pmd, addr & PAGE_MASK);
+				pa = (pte_val(*pte) & PAGE_MASK) | (addr & ~PAGE_MASK);
+			} else if (pmd_val(*pmd) & _PMD_SIZE) {
+				unsigned long mask =
+					large_page_mask[(pmd_val(*pmd) & _PMD_SIZE) >> 5];
+				pa = (pmd_val(*pmd) & mask) | (addr & ~mask);
+			}
+		}
+	}
+
+#else
 	if (get_pteptr(mm, addr, &pte))
 		pa = (pte_val(*pte) & PAGE_MASK) | (addr & ~PAGE_MASK);
+#endif

 	return(pa);
 }
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h linux-grinch-largepage/include/asm-ppc/pgtable.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/pgtable.h	Mon Jun  3 12:36:27 2002
+++ linux-grinch-largepage/include/asm-ppc/pgtable.h	Wed Jun  5 13:40:58 2002
@@ -301,8 +301,12 @@
 #define _PAGE_HWWRITE	0x100	/* hardware: Dirty & RW, set in exception */
 #define _PAGE_HWEXEC	0x200	/* hardware: EX permission */
 #define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
-#define _PMD_PRESENT	PAGE_MASK

+#define _PMD_PRESENT	0x400	/* PMD points to page of PTEs */
+#define _PMD_SIZE	0x0e0	/* size field, != 0 for large-page PMD entry */
+#define _PMD_SIZE_4M	0x0c0
+#define _PMD_SIZE_16M	0x0e0
+#define _PMD_BAD	0x802
 #elif defined(CONFIG_440)

 /*
@@ -357,9 +361,10 @@
 #define _PAGE_HWWRITE	0x0100	/* h/w write enable: never set in Linux PTE */
 #define _PAGE_USER	0x0800	/* One of the PP bits, the other is USER&~RW */

-#define _PMD_PRESENT	PAGE_MASK
+#define _PMD_PRESENT	0x0001
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
+#define _PMD_BAD	0x0ff0

 #else /* CONFIG_6xx */
 /* Definitions for 60x, 740/750, etc. */
@@ -374,7 +379,9 @@
 #define _PAGE_ACCESSED	0x100	/* R: page referenced */
 #define _PAGE_EXEC	0x200	/* software: i-cache coherency required */
 #define _PAGE_RW	0x400	/* software: user write access allowed */
-#define _PMD_PRESENT	PAGE_MASK
+
+#define _PMD_PRESENT	0x800
+#define _PMD_BAD	0x7ff
 #endif

 /* The non-standard PowerPC MMUs, which includes the 4xx and 8xx (and
@@ -474,7 +481,7 @@
 #define pte_clear(ptep)		do { set_pte((ptep), __pte(0)); } while (0)

 #define pmd_none(pmd)		(!pmd_val(pmd))
-#define	pmd_bad(pmd)		((pmd_val(pmd) & _PMD_PRESENT) == 0)
+#define	pmd_bad(pmd)		((pmd_val(pmd) & _PMD_BAD) != 0)
 #define	pmd_present(pmd)	((pmd_val(pmd) & _PMD_PRESENT) != 0)
 #define	pmd_clear(pmdp)		do { pmd_val(*(pmdp)) = 0; } while (0)


--FL5UXtIhxfXey3p5--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
