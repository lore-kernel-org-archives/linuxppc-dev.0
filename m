Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [59.145.155.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C84EB7B8E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 17:54:58 +1100 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id n956srUD014887
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 12:24:53 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n956sq3e1843348
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 12:24:53 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n956sqRr014191
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2009 17:54:52 +1100
Message-ID: <4AC9983C.7070300@in.ibm.com>
Date: Mon, 05 Oct 2009 12:24:52 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>
	<4ABA2DE2.6000601@kernel.org> <4ABB269F.6020309@in.ibm.com>
	<4ABB6D33.6060706@kernel.org> <4ABB72BD.9050905@in.ibm.com>
	<1253826309.7103.461.camel@pasglop>
	<4ABC376D.1020704@kernel.org> <4ABC6E25.7090904@in.ibm.com>
	<4ABC73C7.20403@kernel.org> <4ABC7486.8040500@kernel.org>
	<4ABC7955.2070404@in.ibm.com> <4ABC86E0.9090807@kernel.org>
	<1253872111.7103.520.camel@pasglop>
In-Reply-To: <1253872111.7103.520.camel@pasglop>
Content-Type: multipart/mixed; boundary="------------040608040507060505040604"
Cc: Tejun Heo <tj@kernel.org>, Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040608040507060505040604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Fri, 2009-09-25 at 18:01 +0900, Tejun Heo wrote:
>   
>>> With this patch applied the machine boots OK :-)
>>>       
>> Ah... so, the problem really is too high address.  If you've got some
>> time, it might be interesting to find out how far high is safe.
>>
>>     
> Might give me a clue about what the problem is but I think I'll just
> cook up a test case that forcibly vmap something high up and see how it
> goes from there. It could be a very old bug that nobody ever noticed
> because our vmalloc space on 64-bit is so huge :-)
>   
I still have this problem with 2.6.32-rc3.
Here is the relevant information

0:mon> t
[link register   ] c0000000001a7f78 .pcpu_alloc+0x798/0xa04
[c0000000033e37f0] c0000000001a7f08 .pcpu_alloc+0x728/0xa04 (unreliable)
[c0000000033e3920] c0000000001a8278 .__alloc_percpu+0x3c/0x58
[c0000000033e39b0] c0000000005d1ad0 .snmp_mib_init+0x64/0xb0
[c0000000033e3a40] c0000000005d1c00 .ipv4_mib_init_net+0xe4/0x1f8
[c0000000033e3b00] c00000000055b608 .setup_net+0x78/0x138
[c0000000033e3ba0] c00000000055be38 .copy_net_ns+0x9c/0x148
[c0000000033e3c30] c0000000000d06d8 .create_new_namespaces+0x120/0x1e4
[c0000000033e3ce0] c0000000000d09e0 .unshare_nsproxy_namespaces+0x7c/0xfc
[c0000000033e3d80] c00000000009dd74 .SyS_unshare+0x148/0x33c
[c0000000033e3e30] c0000000000085b4 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 00000fff8b0ab978
SP (fffe633fe30) is in userspace
0:mon> e
cpu 0x0: Vector: 501 (Hardware Interrupt) at [c0000000033e3570]
    pc: c00000000004bdc0: .memset+0x60/0xfc
    lr: c0000000001a7f78: .pcpu_alloc+0x798/0xa04
    sp: c0000000033e37f0
   msr: 8000000000009032
  current = 0xc000000003270860
  paca    = 0xc0000000010c2600
    pid   = 3442, comm = two_children_ns
0:mon> r
R00 = 0000000000000040   R07 = d00007fffff00000
R01 = c0000000033e37f0   R08 = 0000000000000000
R02 = c000000000fe7c78   R09 = c000000001700180
R03 = d00007fffff00000   R10 = c000000001095aa0
R04 = 0000000000000000   R11 = 00000000000003c0
R05 = 0000000000000000   R12 = 0000000048004428
R06 = d00007fffff00000   R13 = c0000000010c2600
pc  = c00000000004bdc0 .memset+0x60/0xfc
lr  = c0000000001a7f78 .pcpu_alloc+0x798/0xa04
msr = 8000000000009032   cr  = 44004420
ctr = 0000000000000040   xer = 0000000020000020   trap =  501
0:mon> di $.memset
c00000000004bd60  7c0300d0      neg     r0,r3
c00000000004bd64  5084442e      rlwimi  r4,r4,8,16,23
c00000000004bd68  70000007      andi.   r0,r0,7
c00000000004bd6c  5084801e      rlwimi  r4,r4,16,0,15
c00000000004bd70  7c850040      cmplw   cr1,r5,r0
c00000000004bd74  7884000e      rldimi  r4,r4,32,0
c00000000004bd78  7c101120      mtocrf  1,r0
c00000000004bd7c  7c661b78      mr      r6,r3
c00000000004bd80  418400ac      blt     cr1,c00000000004be2c    # .memset+0xcc/0xfc
c00000000004bd84  41e2002c      beq+    c00000000004bdb0        # .memset+0x50/0xfc
c00000000004bd88  7ca02850      subf    r5,r0,r5
c00000000004bd8c  409f000c      bns     cr7,c00000000004bd98    # .memset+0x38/0xfc
c00000000004bd90  98860000      stb     r4,0(r6)
c00000000004bd94  38c60001      addi    r6,r6,1
c00000000004bd98  409e000c      bne     cr7,c00000000004bda4    # .memset+0x44/0xfc
c00000000004bd9c  b0860000      sth     r4,0(r6)
0:mon>
c00000000004bda0  38c60002      addi    r6,r6,2
c00000000004bda4  409d000c      ble     cr7,c00000000004bdb0    # .memset+0x50/0xfc
c00000000004bda8  90860000      stw     r4,0(r6)
c00000000004bdac  38c60004      addi    r6,r6,4
c00000000004bdb0  78a0d183      rldicl. r0,r5,58,6
c00000000004bdb4  78a506a0      clrldi  r5,r5,58
c00000000004bdb8  7c0903a6      mtctr   r0
c00000000004bdbc  4182002c      beq     c00000000004bde8        # .memset+0x88/0xfc
c00000000004bdc0  f8860000      std     r4,0(r6)

At this point R06 contains d00007fffff00000.

Have attached the xmon log.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------040608040507060505040604
Content-Type: text/plain;
 name="xmonlog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xmonlog"

0:mon> t
[link register   ] c0000000001a7f78 .pcpu_alloc+0x798/0xa04
[c0000000033e37f0] c0000000001a7f08 .pcpu_alloc+0x728/0xa04 (unreliable)
[c0000000033e3920] c0000000001a8278 .__alloc_percpu+0x3c/0x58
[c0000000033e39b0] c0000000005d1ad0 .snmp_mib_init+0x64/0xb0
[c0000000033e3a40] c0000000005d1c00 .ipv4_mib_init_net+0xe4/0x1f8
[c0000000033e3b00] c00000000055b608 .setup_net+0x78/0x138
[c0000000033e3ba0] c00000000055be38 .copy_net_ns+0x9c/0x148
[c0000000033e3c30] c0000000000d06d8 .create_new_namespaces+0x120/0x1e4
[c0000000033e3ce0] c0000000000d09e0 .unshare_nsproxy_namespaces+0x7c/0xfc
[c0000000033e3d80] c00000000009dd74 .SyS_unshare+0x148/0x33c
[c0000000033e3e30] c0000000000085b4 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 00000fff8b0ab978
SP (fffe633fe30) is in userspace
0:mon> e
cpu 0x0: Vector: 501 (Hardware Interrupt) at [c0000000033e3570]
    pc: c00000000004bdc0: .memset+0x60/0xfc
    lr: c0000000001a7f78: .pcpu_alloc+0x798/0xa04
    sp: c0000000033e37f0
   msr: 8000000000009032
  current = 0xc000000003270860
  paca    = 0xc0000000010c2600
    pid   = 3442, comm = two_children_ns
0:mon> r
R00 = 0000000000000040   R07 = d00007fffff00000
R01 = c0000000033e37f0   R08 = 0000000000000000
R02 = c000000000fe7c78   R09 = c000000001700180
R03 = d00007fffff00000   R10 = c000000001095aa0
R04 = 0000000000000000   R11 = 00000000000003c0
R05 = 0000000000000000   R12 = 0000000048004428
R06 = d00007fffff00000   R13 = c0000000010c2600
pc  = c00000000004bdc0 .memset+0x60/0xfc
lr  = c0000000001a7f78 .pcpu_alloc+0x798/0xa04
msr = 8000000000009032   cr  = 44004420
ctr = 0000000000000040   xer = 0000000020000020   trap =  501
0:mon> di $.memset
c00000000004bd60  7c0300d0      neg     r0,r3
c00000000004bd64  5084442e      rlwimi  r4,r4,8,16,23
c00000000004bd68  70000007      andi.   r0,r0,7
c00000000004bd6c  5084801e      rlwimi  r4,r4,16,0,15
c00000000004bd70  7c850040      cmplw   cr1,r5,r0
c00000000004bd74  7884000e      rldimi  r4,r4,32,0
c00000000004bd78  7c101120      mtocrf  1,r0
c00000000004bd7c  7c661b78      mr      r6,r3
c00000000004bd80  418400ac      blt     cr1,c00000000004be2c    # .memset+0xcc/0xfc
c00000000004bd84  41e2002c      beq+    c00000000004bdb0        # .memset+0x50/0xfc
c00000000004bd88  7ca02850      subf    r5,r0,r5
c00000000004bd8c  409f000c      bns     cr7,c00000000004bd98    # .memset+0x38/0xfc
c00000000004bd90  98860000      stb     r4,0(r6)
c00000000004bd94  38c60001      addi    r6,r6,1
c00000000004bd98  409e000c      bne     cr7,c00000000004bda4    # .memset+0x44/0xfc
c00000000004bd9c  b0860000      sth     r4,0(r6)
0:mon> 
c00000000004bda0  38c60002      addi    r6,r6,2
c00000000004bda4  409d000c      ble     cr7,c00000000004bdb0    # .memset+0x50/0xfc
c00000000004bda8  90860000      stw     r4,0(r6)
c00000000004bdac  38c60004      addi    r6,r6,4
c00000000004bdb0  78a0d183      rldicl. r0,r5,58,6
c00000000004bdb4  78a506a0      clrldi  r5,r5,58
c00000000004bdb8  7c0903a6      mtctr   r0
c00000000004bdbc  4182002c      beq     c00000000004bde8        # .memset+0x88/0xfc
c00000000004bdc0  f8860000      std     r4,0(r6)
c00000000004bdc4  f8860008      std     r4,8(r6)
c00000000004bdc8  f8860010      std     r4,16(r6)
c00000000004bdcc  f8860018      std     r4,24(r6)
c00000000004bdd0  f8860020      std     r4,32(r6)
c00000000004bdd4  f8860028      std     r4,40(r6)
c00000000004bdd8  f8860030      std     r4,48(r6)
c00000000004bddc  f8860038      std     r4,56(r6)
0:mon> u
SLB contents of cpu 0
00 c000000008000000 40004f7ca3000500  1T  ESID=   c00000  VSID=       4f7ca3 LLP:100 
01 d000000008000000 4000eb71b0000510  1T  ESID=   d00000  VSID=       eb71b0 LLP:110 
20 f000000008000000 4000235bcc000500  1T  ESID=   f00000  VSID=       235bcc LLP:100 
27 00000f0008000000 400014e596000d90  1T  ESID=        f  VSID=       14e596 LLP:110 
28 0000000018000000 00004be47e859d90 256M ESID=        1  VSID=    4be47e859 LLP:110 
29 d000070008000000 400026a7a5000400  1T  ESID=   d00007  VSID=       26a7a5 LLP:  0 
30 d000080008000000 4000e5f87e000400  1T  ESID=   d00008  VSID=       e5f87e LLP:  0 
0:mon> S
msr  = 8000000000001032  sprg0= 0000000000000000
pvr  = 00000000003e0301  sprg1= c0000000010c2600
dec  = 0000000058fe12dd  sprg2= c0000000010c2600
sp   = c00000000fffb8f0  sprg3= 0000000000000000
toc  = c000000000fe7c78  dar  = d00007fffff00000



--------------040608040507060505040604--
