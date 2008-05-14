Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92848DE062
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 01:34:13 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m4EFXWPX014270
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 01:33:32 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4EFcHb3053108
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 01:38:17 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4EFYBkq005332
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 01:34:12 +1000
Message-ID: <482B066F.4010605@linux.vnet.ibm.com>
Date: Wed, 14 May 2008 21:04:07 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [BUG] 2.6.26-rc2-mm1 - kernel panic at inet_create() on powerpc
References: <20080514010129.4f672378.akpm@linux-foundation.org>
In-Reply-To: <20080514010129.4f672378.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulmck@linux.vnet.ibm.com, davem@davemloft.net,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

2.6.26-rc2-mm1 kernel panics on powerpc, while running ltp test over it.
I have attached the gdb output of the pc and lr registers. The patch
list_for_each_rcu-must-die-networking.patch points to changes made 
to the same lines listed by the gdb output.

 Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc000000000481fa0
cpu 0x0: Vector: 300 (Data Access) at [c0000000eae37900]
    pc: c000000000481fa0: .inet_create+0xb4/0x330
    lr: c000000000413340: .__sock_create+0x190/0x280
    sp: c0000000eae37b80
   msr: 8000000000009032
   dar: 0
 dsisr: 40010000
  current = 0xc0000000cd201500
  paca    = 0xc0000000007c3480
    pid   = 6462, comm = socket01
enter ? for help
[c0000000eae37c30] c000000000413340 .__sock_create+0x190/0x280
[c0000000eae37cf0] c0000000004137e0 .sys_socket+0x40/0x98
[c0000000eae37d90] c000000000438e18 .compat_sys_socketcall+0xc0/0x234
[c0000000eae37e30] c0000000000086b4 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000ff20484
SP (ffc8f770) is in userspace


0xc000000000481fa0 is in inet_create (net/ipv4/af_inet.c:290).
285             /* Look for the requested type/protocol pair. */
286             answer = NULL;
287     lookup_protocol:
288             err = -ESOCKTNOSUPPORT;
289             rcu_read_lock();
290             list_for_each_entry_rcu(answer, &inetsw[sock->type], list) {
291
292                     /* Check the non-wild match. */
293                     if (protocol == answer->protocol) {
294                             if (protocol != IPPROTO_IP)


0xc000000000413340 is in __sock_create (net/socket.c:1171).
1166                    goto out_release;
1167
1168            /* Now protected by module ref count */
1169            rcu_read_unlock();
1170
1171            err = pf->create(net, sock, protocol);
1172            if (err < 0)
1173                    goto out_module_put;
1174
1175            /*

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
