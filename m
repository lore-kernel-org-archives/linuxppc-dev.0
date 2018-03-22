Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406Hpg1kQ3zF1tY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 18:09:14 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2M751jC085824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 03:09:11 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gv7ad1b11-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 03:09:10 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 22 Mar 2018 07:09:08 -0000
Date: Thu, 22 Mar 2018 00:09:00 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Li Wang <liwang@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jan Stancek <jstancek@redhat.com>,
 ltp@lists.linux.it, linux-mm@kvack.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [bug?] Access was denied by memory protection keys in
 execute-only address
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <CAEemH2f0LDqyR5AmUYv17OuBc5-UycckDPWgk46XU_ghQo4diw@mail.gmail.com>
 <871sguep4v.fsf@concordia.ellerman.id.au>
 <20180308164545.GM1060@ram.oc3035372033.ibm.com>
 <CAEemH2czWDjvJLpL6ynV1+VxCFh_-A-d72tJhA5zwgrAES2nWA@mail.gmail.com>
 <20180320215828.GA5825@ram.oc3035372033.ibm.com>
 <CAEemH2eewab4nsn6daMRAtn9tDrHoZb_PnbH8xA17ypFCTg6iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAEemH2eewab4nsn6daMRAtn9tDrHoZb_PnbH8xA17ypFCTg6iA@mail.gmail.com>
Message-Id: <20180322070900.GA5605@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2018 at 02:53:00PM +0800, Li Wang wrote:
>    On Wed, Mar 21, 2018 at 5:58 AM, Ram Pai <[1]linuxram@us.ibm.com> wrote:
> 
>      On Fri, Mar 09, 2018 at 11:43:00AM +0800, Li Wang wrote:
>      >    On Fri, Mar 9, 2018 at 12:45 AM, Ram Pai
>      <[1][2]linuxram@us.ibm.com> wrote:
>      >
>      >      On Thu, Mar 08, 2018 at 11:19:12PM +1100, Michael Ellerman wrote:
>      >      > Li Wang <[2][3]liwang@redhat.com> writes:
>      >      > > Hi,
>      >      > >
>      >      am wondering if the slightly different cpu behavior is dependent
..snip..
>      on the
>      >      version of the firmware/microcode?
>      >
>      >    ​I also run this reproducer on series ppc kvm machines, but none of
>      them
>      >    get the FAIL.
>      >    If you need some more HW info, pls let me know.​
> 
>      Hi Li,
> 
>         Can you try the following patch and see if it solves your problem.
> 
>    ​It only works on power7 lpar machine.
> 
>    But for p8 lpar, it still get failure as that before, the thing I wondered
>    is
>    that why not disable the pkey_execute_disable_supported on p8 machine?

It turns out to be a testcase bug.  On Big endian powerpc ABI, function
ptrs are basically pointers to function descriptors.  The testcase
copies functions which results in function descriptors getting copied.
You have to apply the following patch to your test case for it to
operate as intended.  Thanks to Michael Ellermen for helping me out.
Otherwise I would be scratching my head for ever.


diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 1173afd..9fe9001 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -189,18 +189,30 @@ static void clear_cache(void *start, int len)
 #endif
 }
 
+typedef struct {
+	uintptr_t entry;
+	uintptr_t toc;
+	uintptr_t env;
+} func_descr_t;
+
+typedef void (*func_ptr_t)(void);
+
 /*
  * Copy page where &exec_func resides. Also try to copy subsequent page
  * in case exec_func is close to page boundary.
  */
-static void *get_func(void *mem)
+void *get_func(void *mem)
 {
 	uintptr_t page_sz = getpagesize();
 	uintptr_t page_mask = ~(page_sz - 1);
-	uintptr_t func_page_offset = (uintptr_t)&exec_func & (page_sz - 1);
-	void *func_copy_start = mem + func_page_offset;
-	void *page_to_copy = (void *)((uintptr_t)&exec_func & page_mask);
+	uintptr_t func_page_offset;
+	void *func_copy_start, *page_to_copy;
 	void *mem_start = mem;
+	func_descr_t *opd =  (func_descr_t *)&exec_func;
+
+	func_page_offset = (uintptr_t)opd->entry & (page_sz - 1);
+	func_copy_start = mem + func_page_offset;
+	page_to_copy = (void *)((uintptr_t)opd->entry & page_mask);
 
 	/* copy 1st page, if it's not present something is wrong */
 	if (!page_present(page_to_copy)) {
@@ -228,15 +240,17 @@ static void *get_func(void *mem)
 
 static void testfunc_protexec(void)
 {
-	void (*func)(void);
 	void *p;
+	func_ptr_t func;
+	func_descr_t opd;
 
 	sig_caught = 0;
 
 	p = SAFE_MMAP(cleanup, 0, copy_sz, PROT_READ | PROT_WRITE,
 		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
-	func = get_func(p);
+	opd.entry = (uintptr_t)get_func(p);
+	func = (func_ptr_t)&opd;
 
 	/* Change the protection to PROT_EXEC. */
 	TEST(mprotect(p, copy_sz, PROT_EXEC));


RP
