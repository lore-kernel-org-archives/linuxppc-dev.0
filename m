Subject: A few warning fixes
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Tue, 4 Apr 2000 18:36:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000404083642.6EEAD505F0@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi dudes,

Here's a patch that fixes a number of warnings in the 2.2.13 kernel which
appear when compiled with gcc-2.95.2. I'm too scared to fix the ones in
math-emu, which is a shame because they're pretty scary.

Index: arch/ppc/8xx_io/commproc.h
===================================================================
retrieving revision 1.2
diff -c -r1.2 commproc.h
*** arch/ppc/8xx_io/commproc.h	2000/03/13 08:32:52	1.2
--- arch/ppc/8xx_io/commproc.h	2000/04/04 07:52:21
***************
*** 706,711 ****
--- 706,712 ----

  extern void cpm_install_handler(int vec, void (*handler)(void *), void *dev_id);
  extern void cpm_free_handler(int vec);
+ extern void cpm_interrupt_init(void);

  /* CPM interrupt configuration vector.
  */
Index: arch/ppc/8xx_io/fec.c
===================================================================
retrieving revision 1.5
diff -c -r1.5 fec.c
*** arch/ppc/8xx_io/fec.c	2000/03/21 22:18:42	1.5
--- arch/ppc/8xx_io/fec.c	2000/04/04 08:16:56
***************
*** 687,694 ****
  static void
  mii_discover_phy(uint mii_reg, struct device *dev)
  {
- 	volatile uint	prev_duplex;
-
  	if (phyno < 32) {
  		if ((phytype = (mii_reg & 0xffff)) != 0xffff) {
  			phyaddr = phyno;
--- 688,693 ----
***************
*** 1172,1178 ****
  	volatile	cbd_t	*bdp;
  	volatile	immap_t	*immap;
  	volatile	fec_t	*fecp;
! 	extern		uint	_get_IMMR();

  	immap = (immap_t *)IMAP_ADDR;	/* pointer to internal registers */

--- 1171,1177 ----
  	volatile	cbd_t	*bdp;
  	volatile	immap_t	*immap;
  	volatile	fec_t	*fecp;
! 	extern		uint	_get_IMMR(void);

  	immap = (immap_t *)IMAP_ADDR;	/* pointer to internal registers */

Index: arch/ppc/kernel/m8xx_setup.c
===================================================================
retrieving revision 1.1.1.3
diff -c -r1.1.1.3 m8xx_setup.c
*** arch/ppc/kernel/m8xx_setup.c	2000/03/10 01:11:11	1.1.1.3
--- arch/ppc/kernel/m8xx_setup.c	2000/04/04 08:09:48
***************
*** 46,51 ****
--- 46,52 ----

  #include "time.h"
  #include "ppc8xx_pic.h"
+ #include "commproc.h"

  static int m8xx_set_rtc_time(unsigned long time);
  unsigned long m8xx_get_rtc_time(void);
***************
*** 531,537 ****

  #if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
  int
! rpx_pcmcia_config()
  {
  	volatile pcmconf8xx_t	*pcmp;
  	int i;
--- 532,538 ----

  #if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
  int
! rpx_pcmcia_config(void)
  {
  	volatile pcmconf8xx_t	*pcmp;
  	int i;
***************
*** 620,626 ****
  	pcmp->pcmc_por3 = pcmp->pcmc_por4 = pcmp->pcmc_por5 = 0;
  	pcmp->pcmc_por6 = pcmp->pcmc_por7 = 0;

! printk("PCMCIA Addr %x\n", &(pcmp->pcmc_pbr0));
  	/* We have to set up the base, option, and control registers
  	 * for a 16-bit memory window.
  	 */
--- 621,627 ----
  	pcmp->pcmc_por3 = pcmp->pcmc_por4 = pcmp->pcmc_por5 = 0;
  	pcmp->pcmc_por6 = pcmp->pcmc_por7 = 0;

! printk("PCMCIA Addr %p\n", &(pcmp->pcmc_pbr0));
  	/* We have to set up the base, option, and control registers
  	 * for a 16-bit memory window.
  	 */
Index: arch/ppc/kernel/time.h
===================================================================
retrieving revision 1.1.1.2
diff -c -r1.1.1.2 time.h
*** arch/ppc/kernel/time.h	2000/03/10 01:11:15	1.1.1.2
--- arch/ppc/kernel/time.h	2000/04/04 07:46:19
***************
*** 33,36 ****
--- 33,38 ----
  {
  	asm volatile("mtspr 22,%0" : : "r" (val));
  }
+ #else
+ void set_dec(unsigned int val);
  #endif
Index: arch/ppc/mbxboot/iic.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 iic.c
*** arch/ppc/mbxboot/iic.c	1999/12/30 05:56:23	1.1.1.1
--- arch/ppc/mbxboot/iic.c	2000/04/04 08:27:53
***************
*** 145,151 ****
  	 */
  	tb = iitemp;
  	tb = (u_char *)(((uint)tb + 15) & ~15);
! 	tbdf->cbd_bufaddr = tb;
  	*tb = devaddr & 0xfe;	/* Device address */
  	*(tb+1) = offset;		/* Offset */
  	tbdf->cbd_datlen = 2;		/* Length */
--- 145,151 ----
  	 */
  	tb = iitemp;
  	tb = (u_char *)(((uint)tb + 15) & ~15);
! 	tbdf->cbd_bufaddr = (uint)tb;
  	*tb = devaddr & 0xfe;	/* Device address */
  	*(tb+1) = offset;		/* Offset */
  	tbdf->cbd_datlen = 2;		/* Length */
***************
*** 185,191 ****
  	 * All that is used is the first byte for address, the remainder
  	 * is just used for timing (and doesn't really have to exist).
  	 */
! 	tbdf->cbd_bufaddr = tb;
  	*tb = devaddr | 1;	/* Device address */
  	rbdf->cbd_bufaddr = (uint)buf;		/* Desination buffer */
  	tbdf->cbd_datlen = rbdf->cbd_datlen = count + 1;	/* Length */
--- 185,191 ----
  	 * All that is used is the first byte for address, the remainder
  	 * is just used for timing (and doesn't really have to exist).
  	 */
! 	tbdf->cbd_bufaddr = (uint)tb;
  	*tb = devaddr | 1;	/* Device address */
  	rbdf->cbd_bufaddr = (uint)buf;		/* Desination buffer */
  	tbdf->cbd_datlen = rbdf->cbd_datlen = count + 1;	/* Length */
Index: arch/ppc/mm/fault.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 fault.c
*** arch/ppc/mm/fault.c	1999/12/30 05:56:30	1.1.1.1
--- arch/ppc/mm/fault.c	2000/04/04 07:58:21
***************
*** 262,269 ****
                                  printk(" (0x%08lx)->(0x%08lx)->0x%08lx\n",
                                          (long)pgd, (long)pte, (long)pte_val(*pte));
  #define pp ((long)pte_val(*pte))
! 				printk(" RPN: %05x PP: %x SPS: %x SH: %x "
! 				       "CI: %x v: %x\n",
  				       pp>>12,    /* rpn */
  				       (pp>>10)&3, /* pp */
  				       (pp>>3)&1, /* small */
--- 262,269 ----
                                  printk(" (0x%08lx)->(0x%08lx)->0x%08lx\n",
                                          (long)pgd, (long)pte, (long)pte_val(*pte));
  #define pp ((long)pte_val(*pte))
! 				printk(" RPN: %05lx PP: %lx SPS: %lx SH: %lx "
! 				       "CI: %lx v: %lx\n",
  				       pp>>12,    /* rpn */
  				       (pp>>10)&3, /* pp */
  				       (pp>>3)&1, /* small */
Index: arch/ppc/mm/init.c
===================================================================
retrieving revision 1.1.1.3
diff -c -r1.1.1.3 init.c
*** arch/ppc/mm/init.c	2000/03/10 01:11:30	1.1.1.3
--- arch/ppc/mm/init.c	2000/04/04 08:02:01
***************
*** 111,117 ****
--- 111,119 ----
  static void remove_mem_piece(struct mem_pieces *, unsigned, unsigned, int);
  void *find_mem_piece(unsigned, unsigned);
  static void print_mem_pieces(struct mem_pieces *);
+ #ifndef CONFIG_8xx
  static void append_mem_piece(struct mem_pieces *, unsigned, unsigned);
+ #endif

  extern struct task_struct *current_set[NR_CPUS];

***************
*** 407,413 ****
--- 409,417 ----

  	for (i = 0; i < size; i += PAGE_SIZE)
  		map_page(v+i, p+i, flags);
+ #ifndef CONFIG_8xx
  out:
+ #endif /* CONFIG_8xx */
  	return (void *) (v + (addr & ~PAGE_MASK));
  }

***************
*** 684,689 ****
--- 688,694 ----
  	printk("\n");
  }

+ #ifndef CONFIG_8xx
  /*
   * Add some memory to an array of pieces
   */
***************
*** 699,705 ****
  	rp->size = size;
  }

- #ifndef CONFIG_8xx
  static void hash_init(void);
  static void get_mem_prop(char *, struct mem_pieces *);
  static void sort_mem_pieces(struct mem_pieces *);
--- 704,709 ----
***************
*** 1172,1178 ****
--- 1176,1184 ----
  	int codepages = 0;
  	int datapages = 0;
  	int initpages = 0;
+ #ifndef CONFIG_8xx
  	extern unsigned int rtas_data, rtas_size;
+ #endif /* CONFIG_8xx */

  	end_mem &= PAGE_MASK;
  	high_memory = (void *) end_mem;
Index: drivers/block/loop.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 loop.c
*** drivers/block/loop.c	1999/12/30 05:56:57	1.1.1.1
--- drivers/block/loop.c	2000/04/04 07:08:21
***************
*** 334,341 ****
  	set_fs(old_fs);

  	if (retval < 0) {
! 		printk(KERN_WARNING "loop: cannot create block - FS write failed: code %d\n",
! 									retval);
  		return FALSE;
  	} else {
  		return TRUE;
--- 334,341 ----
  	set_fs(old_fs);

  	if (retval < 0) {
! 		printk(KERN_WARNING "loop: cannot create block - FS write failed: code %ld\n",
! 								(long)retval);
  		return FALSE;
  	} else {
  		return TRUE;
Index: drivers/char/mem.c
===================================================================
retrieving revision 1.1.1.2
diff -c -r1.1.1.2 mem.c
*** drivers/char/mem.c	2000/03/10 01:12:36	1.1.1.2
--- drivers/char/mem.c	2000/04/04 07:10:46
***************
*** 279,284 ****
--- 279,286 ----
  	return do_write_mem(file, (void*)p, p, buf, count, ppos);
  }

+ #if !defined(CONFIG_PPC) && !defined(__mc68000__)
+
  static ssize_t read_port(struct file * file, char * buf,
  			 size_t count, loff_t *ppos)
  {
***************
*** 317,322 ****
--- 319,326 ----
  	return tmp-buf;
  }

+ #endif
+
  static ssize_t read_null(struct file * file, char * buf,
  			 size_t count, loff_t *ppos)
  {
***************
*** 527,532 ****
--- 531,538 ----
  	NULL		/* fsync */
  };

+ #if !defined(CONFIG_PPC) && !defined(__mc68000__)
+
  static struct file_operations port_fops = {
  	memory_lseek,
  	read_port,
***************
*** 540,545 ****
--- 546,553 ----
  	NULL,		/* no special release code */
  	NULL		/* fsync */
  };
+
+ #endif

  static struct file_operations zero_fops = {
  	zero_lseek,
Index: fs/open.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 open.c
*** fs/open.c	1999/12/30 05:59:30	1.1.1.1
--- fs/open.c	2000/04/04 07:28:57
***************
*** 87,92 ****
--- 87,94 ----
  	return error;
  }

+ extern int abs(int x);
+
  asmlinkage int sys_truncate(const char * path, unsigned long length)
  {
  	struct dentry * dentry;
Index: fs/lockd/mon.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 mon.c
*** fs/lockd/mon.c	1999/12/30 05:59:47	1.1.1.1
--- fs/lockd/mon.c	2000/04/04 07:20:58
***************
*** 144,151 ****
  	u32	addr = ntohl(argp->addr);

  	dprintk("nsm: xdr_encode_mon(%08lx, %ld, %ld, %ld)\n",
! 			htonl(argp->addr), htonl(argp->proc),
! 			htonl(argp->vers), htonl(argp->proc));

  	/*
  	 * Use the dotted-quad IP address of the remote host as
--- 144,151 ----
  	u32	addr = ntohl(argp->addr);

  	dprintk("nsm: xdr_encode_mon(%08lx, %ld, %ld, %ld)\n",
! 		    (unsigned long)htonl(argp->addr), (long)htonl(argp->proc),
! 		    (long)htonl(argp->vers), (long)htonl(argp->proc));

  	/*
  	 * Use the dotted-quad IP address of the remote host as
Index: fs/lockd/svcproc.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 svcproc.c
*** fs/lockd/svcproc.c	1999/12/30 05:59:47	1.1.1.1
--- fs/lockd/svcproc.c	2000/04/04 07:19:37
***************
*** 44,50 ****
  	if (rqstp->rq_client == NULL) {
  		printk(KERN_NOTICE
  			"lockd: unauthenticated request from (%08lx:%d)\n",
! 			ntohl(rqstp->rq_addr.sin_addr.s_addr),
  			ntohs(rqstp->rq_addr.sin_port));
  		return nlm_lck_denied_nolocks;
  	}
--- 44,50 ----
  	if (rqstp->rq_client == NULL) {
  		printk(KERN_NOTICE
  			"lockd: unauthenticated request from (%08lx:%d)\n",
! 			(unsigned long)ntohl(rqstp->rq_addr.sin_addr.s_addr),
  			ntohs(rqstp->rq_addr.sin_port));
  		return nlm_lck_denied_nolocks;
  	}
***************
*** 110,116 ****
  	/* Now check for conflicting locks */
  	resp->status = nlmsvc_testlock(file, &argp->lock, &resp->lock);

! 	dprintk("lockd: TEST          status %ld\n", ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
--- 110,116 ----
  	/* Now check for conflicting locks */
  	resp->status = nlmsvc_testlock(file, &argp->lock, &resp->lock);

! 	dprintk("lockd: TEST          status %ld\n", (long)ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
***************
*** 153,159 ****
  	resp->status = nlmsvc_lock(rqstp, file, &argp->lock,
  					argp->block, &argp->cookie);

! 	dprintk("lockd: LOCK          status %ld\n", ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
--- 153,159 ----
  	resp->status = nlmsvc_lock(rqstp, file, &argp->lock,
  					argp->block, &argp->cookie);

! 	dprintk("lockd: LOCK          status %ld\n", (long)ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
***************
*** 183,189 ****
  	/* Try to cancel request. */
  	resp->status = nlmsvc_cancel_blocked(file, &argp->lock);

! 	dprintk("lockd: CANCEL        status %ld\n", ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
--- 183,189 ----
  	/* Try to cancel request. */
  	resp->status = nlmsvc_cancel_blocked(file, &argp->lock);

! 	dprintk("lockd: CANCEL        status %ld\n", (long)ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
***************
*** 216,222 ****
  	/* Now try to remove the lock */
  	resp->status = nlmsvc_unlock(file, &argp->lock);

! 	dprintk("lockd: UNLOCK        status %ld\n", ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
--- 216,222 ----
  	/* Now try to remove the lock */
  	resp->status = nlmsvc_unlock(file, &argp->lock);

! 	dprintk("lockd: UNLOCK        status %ld\n", (long)ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
***************
*** 234,240 ****

  	dprintk("lockd: GRANTED       called\n");
  	resp->status = nlmclnt_grant(&argp->lock);
! 	dprintk("lockd: GRANTED       status %ld\n", ntohl(resp->status));
  	return rpc_success;
  }

--- 234,240 ----

  	dprintk("lockd: GRANTED       called\n");
  	resp->status = nlmclnt_grant(&argp->lock);
! 	dprintk("lockd: GRANTED       status %ld\n", (long)ntohl(resp->status));
  	return rpc_success;
  }

***************
*** 340,346 ****
  	/* Now try to create the share */
  	resp->status = nlmsvc_share_file(host, file, argp);

! 	dprintk("lockd: SHARE         status %ld\n", ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
--- 340,346 ----
  	/* Now try to create the share */
  	resp->status = nlmsvc_share_file(host, file, argp);

! 	dprintk("lockd: SHARE         status %ld\n", (long)ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
***************
*** 373,379 ****
  	/* Now try to lock the file */
  	resp->status = nlmsvc_unshare_file(host, file, argp);

! 	dprintk("lockd: UNSHARE       status %ld\n", ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
--- 373,379 ----
  	/* Now try to lock the file */
  	resp->status = nlmsvc_unshare_file(host, file, argp);

! 	dprintk("lockd: UNSHARE       status %ld\n", (long)ntohl(resp->status));
  	nlm_release_host(host);
  	nlm_release_file(file);
  	return rpc_success;
***************
*** 425,431 ****
  	 || ntohs(saddr.sin_port) >= 1024) {
  		printk(KERN_WARNING
  			"lockd: rejected NSM callback from %08lx:%d\n",
! 			ntohl(rqstp->rq_addr.sin_addr.s_addr),
  			ntohs(rqstp->rq_addr.sin_port));
  		return rpc_system_err;
  	}
--- 425,431 ----
  	 || ntohs(saddr.sin_port) >= 1024) {
  		printk(KERN_WARNING
  			"lockd: rejected NSM callback from %08lx:%d\n",
! 			(unsigned long)ntohl(rqstp->rq_addr.sin_addr.s_addr),
  			ntohs(rqstp->rq_addr.sin_port));
  		return rpc_system_err;
  	}
Index: fs/lockd/svcsubs.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 svcsubs.c
*** fs/lockd/svcsubs.c	1999/12/30 05:59:48	1.1.1.1
--- fs/lockd/svcsubs.c	2000/04/04 07:20:09
***************
*** 85,91 ****
  	 * the file.
  	 */
  	if ((nfserr = nlmsvc_ops->fopen(rqstp, fh, &file->f_file)) != 0) {
! 		dprintk("lockd: open failed (nfserr %ld)\n", ntohl(nfserr));
  		goto out_free;
  	}

--- 85,91 ----
  	 * the file.
  	 */
  	if ((nfserr = nlmsvc_ops->fopen(rqstp, fh, &file->f_file)) != 0) {
! 		dprintk("lockd: open failed (nfserr %ld)\n", (long)ntohl(nfserr));
  		goto out_free;
  	}

Index: net/ipv4/icmp.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 icmp.c
*** net/ipv4/icmp.c	1999/12/30 06:01:23	1.1.1.1
--- net/ipv4/icmp.c	2000/04/04 07:33:29
***************
*** 956,962 ****
  	}
  	if (sysctl_ip_always_defrag == 0 && net_ratelimit())
  		printk(KERN_INFO "Wrong address mask %08lX from %08lX/%s\n",
! 		       ntohl(mask), ntohl(rt->rt_src), dev->name);
  }

  static void icmp_discard(struct icmphdr *icmph, struct sk_buff *skb, int len)
--- 956,964 ----
  	}
  	if (sysctl_ip_always_defrag == 0 && net_ratelimit())
  		printk(KERN_INFO "Wrong address mask %08lX from %08lX/%s\n",
! 		       (unsigned long)ntohl(mask),
! 		       (unsigned long)ntohl(rt->rt_src),
! 		       dev->name);
  }

  static void icmp_discard(struct icmphdr *icmph, struct sk_buff *skb, int len)
Index: net/ipv4/tcp_ipv4.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 tcp_ipv4.c
*** net/ipv4/tcp_ipv4.c	1999/12/30 06:01:32	1.1.1.1
--- net/ipv4/tcp_ipv4.c	2000/04/04 07:31:21
***************
*** 1870,1877 ****
  	if (!sk->saddr || !sk->rcv_saddr) {
  		printk(KERN_WARNING "tcp_v4_rebuild_header(): not valid sock addrs: "
  		       "saddr=%08lX rcv_saddr=%08lX\n",
! 		       ntohl(sk->saddr),
! 		       ntohl(sk->rcv_saddr));
  		return 0;
  	}

--- 1870,1877 ----
  	if (!sk->saddr || !sk->rcv_saddr) {
  		printk(KERN_WARNING "tcp_v4_rebuild_header(): not valid sock addrs: "
  		       "saddr=%08lX rcv_saddr=%08lX\n",
! 		       (unsigned long)ntohl(sk->saddr),
! 		       (unsigned long)ntohl(sk->rcv_saddr));
  		return 0;
  	}

Index: net/sunrpc/svc.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 svc.c
*** net/sunrpc/svc.c	1999/12/30 06:01:42	1.1.1.1
--- net/sunrpc/svc.c	2000/04/04 07:38:41
***************
*** 353,359 ****
  	goto sendit;

  err_bad_auth:
! 	dprintk("svc: authentication failed (%ld)\n", ntohl(auth_stat));
  	serv->sv_stats->rpcbadauth++;
  	resp->buf[-1] = xdr_one;	/* REJECT */
  	svc_putlong(resp, xdr_one);	/* AUTH_ERROR */
--- 353,359 ----
  	goto sendit;

  err_bad_auth:
! 	dprintk("svc: authentication failed (%ld)\n", (long)ntohl(auth_stat));
  	serv->sv_stats->rpcbadauth++;
  	resp->buf[-1] = xdr_one;	/* REJECT */
  	svc_putlong(resp, xdr_one);	/* AUTH_ERROR */
Index: net/sunrpc/svcsock.c
===================================================================
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 svcsock.c
*** net/sunrpc/svcsock.c	1999/12/30 06:01:42	1.1.1.1
--- net/sunrpc/svcsock.c	2000/04/04 07:41:43
***************
*** 266,274 ****
  	set_fs(oldfs);
  #endif

! 	dprintk("svc: socket %p sendto([%p %d... ], %d, %d) = %d\n",
  			rqstp->rq_sock,
! 			iov[0].iov_base, iov[0].iov_len, nr,
  			buflen, len);

  	return len;
--- 266,274 ----
  	set_fs(oldfs);
  #endif

! 	dprintk("svc: socket %p sendto([%p %ld... ], %d, %d) = %d\n",
  			rqstp->rq_sock,
! 			iov[0].iov_base, (long)iov[0].iov_len, nr,
  			buflen, len);

  	return len;
***************
*** 326,333 ****
  	set_fs(oldfs);
  #endif

! 	dprintk("svc: socket %p recvfrom(%p, %d) = %d\n", rqstp->rq_sock,
! 				iov[0].iov_base, iov[0].iov_len, len);

  	return len;
  }
--- 326,333 ----
  	set_fs(oldfs);
  #endif

! 	dprintk("svc: socket %p recvfrom(%p, %ld) = %d\n", rqstp->rq_sock,
! 				iov[0].iov_base, (long)iov[0].iov_len, len);

  	return len;
  }
***************
*** 920,926 ****

  	dprintk("svc: svc_create_socket(%s, %d, %08lx:%d)\n",
  				serv->sv_program->pg_name, protocol,
! 				ntohl(sin->sin_addr.s_addr),
  				ntohs(sin->sin_port));

  	if (protocol != IPPROTO_UDP && protocol != IPPROTO_TCP) {
--- 920,926 ----

  	dprintk("svc: svc_create_socket(%s, %d, %08lx:%d)\n",
  				serv->sv_program->pg_name, protocol,
! 				(unsigned long)ntohl(sin->sin_addr.s_addr),
  				ntohs(sin->sin_port));

  	if (protocol != IPPROTO_UDP && protocol != IPPROTO_TCP) {
Index: net/sunrpc/xprt.c
===================================================================
RCS file: /home/elph/archive/epc/sw/linux/net/sunrpc/xprt.c,v
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 xprt.c
*** net/sunrpc/xprt.c	1999/12/30 06:01:42	1.1.1.1
--- net/sunrpc/xprt.c	2000/04/04 07:37:56
***************
*** 1469,1475 ****
  	int		type, err;

  	dprintk("RPC:      xprt_create_socket(%08lx, %s %d)\n",
! 			   sap? ntohl(sap->sin_addr.s_addr) : 0,
  			   (proto == IPPROTO_UDP)? "udp" : "tcp", proto);

  	type = (proto == IPPROTO_UDP)? SOCK_DGRAM : SOCK_STREAM;
--- 1469,1475 ----
  	int		type, err;

  	dprintk("RPC:      xprt_create_socket(%08lx, %s %d)\n",
! 			   sap? (unsigned long)ntohl(sap->sin_addr.s_addr) : 0,
  			   (proto == IPPROTO_UDP)? "udp" : "tcp", proto);

  	type = (proto == IPPROTO_UDP)? SOCK_DGRAM : SOCK_STREAM;
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
