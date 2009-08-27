Return-Path: <hongwoo7@gmail.com>
Received: from mail-pz0-f199.google.com (mail-pz0-f199.google.com
	[209.85.222.199])
	by bilbo.ozlabs.org (Postfix) with ESMTP id C3553B7B77
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 15:04:40 +1000 (EST)
Received: by pzk37 with SMTP id 37so807442pzk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 22:04:39 -0700 (PDT)
Message-ID: <4A9613E3.8020700@gmail.com>
Date: Thu, 27 Aug 2009 14:04:35 +0900
From: HongWoo Lee <hongwoo7@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Question : about difference with bdnz and bdnz+ 
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi ~

I found the code in the linux kernel.

static __inline__ void clear_page(void *addr)
{
    unsigned long lines, line_size;
    line_size = cpu_caches.dline_size;
    lines = cpu_caches.dlines_per_page;

    __asm__ __volatile__(
            "mtctr  %1      # clear_page\n\
            1:  dcbz    0,%0\n\
            add     %0,%0,%3\n\
            bdnz+   1b"
            : "=r" (addr)
            : "r" (lines), "0" (addr), "r" (line_size)
            : "ctr", "memory");
}

And I have a question about bdnz+ instruction.
Through googling, I learned that bdnz does decrement count register and 
branch if it is still nonzero.
But I couldn't find what "bdnz+" is.
Can anybody explain to me what it is ??

Thanks in advance.

HongWoo.
