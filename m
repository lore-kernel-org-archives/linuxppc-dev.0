Return-Path: <eparis@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A9371B6FC4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 09:08:45 +1000 (EST)
Message-ID: <4DE817CC.80404@redhat.com>
Date: Thu, 02 Jun 2011 19:07:56 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] Audit: push audit success and retcode into arch ptrace.h
References: <20110602210458.23613.24076.stgit@paris.rdu.redhat.com>	<201106030032.17398.richard@nod.at>
	<BANLkTik9kCs_06=7HKo44cWqpS0zB9fr+A@mail.gmail.com>
In-Reply-To: <BANLkTik9kCs_06=7HKo44cWqpS0zB9fr+A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, heiko.carstens@de.ibm.com,
	oleg@redhat.com, paulus@samba.org, hpa@zytor.com,
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
	Richard Weinberger <richard@nod.at>, x86@kernel.org,
	mingo@redhat.com, fenghua.yu@intel.com,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, jdike@addtoit.com,
	viro@zeniv.linux.org.uk, tglx@linutronix.de, monstr@monstr.eu,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	lethal@linux-sh.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2011 07:00 PM, Tony Luck wrote:
>> But there seems to be another problem.
>> Why is pt_regs of type void *?
>>
>> gcc complains:
>> In file included from include/linux/fsnotify.h:15:0,
>>                 from include/linux/security.h:26,
>>                 from init/main.c:32:
>> include/linux/audit.h: In function ‘audit_syscall_exit’:
>> include/linux/audit.h:440:17: warning: dereferencing ‘void *’ pointer
>> include/linux/audit.h:440:3: error: invalid use of void expression
>> include/linux/audit.h:441:21: warning: dereferencing ‘void *’ pointer
>> include/linux/audit.h:441:21: error: void value not ignored as it ought to be
> 
> Perhaps same issue on ia64 - but symptoms are different:
> 
>   CC      crypto/cipher.o
> In file included from include/linux/fsnotify.h:15,
>                  from include/linux/security.h:26,
>                  from init/do_mounts.c:8:
> include/linux/audit.h: In function ‘audit_syscall_exit’:
> include/linux/audit.h:440: warning: dereferencing ‘void *’ pointer
> include/linux/audit.h:440: error: request for member ‘r10’ in
> something not a structure or union
> include/linux/audit.h:441: error: request for member ‘r10’ in
> something not a structure or union
> include/linux/audit.h:441: error: request for member ‘r8’ in something
> not a structure or union
> include/linux/audit.h:441: error: request for member ‘r8’ in something
> not a structure or union
> include/linux/audit.h:441: error: expected ‘;’ before ‘}’ token
> include/linux/audit.h:441: error: void value not ignored as it ought to be

I think it is the same problem.  I'll redo the patch with typed static
inlines instead of #defines and all of this should hopefully work out.

-Eric
