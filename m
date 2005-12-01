Return-Path: <zengshuai@sogou.com>
Received: from sogoumx75.mail.sogou.com (unknown [61.135.132.136])
	by ozlabs.org (Postfix) with ESMTP id 5DB50687DE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 19:50:22 +1100 (EST)
Received: from mx3.mail.sohu.com (unknown [192.168.95.78])
	by sogoumx75.mail.sogou.com (Postfix) with ESMTP id 2365208A5CF9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 16:49:50 +0800 (CST)
Message-ID: <13090422.1133426263198.JavaMail.postfix@mx3.mail.sohu.com>
Date: Thu, 1 Dec 2005 16:37:43 +0800 (CST)
From: <zengshuai@sogou.com>
To: "ppc" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Subject: bus error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

//test.c
#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

int main(void)
{
	static volatile char *reg_mem;
  static int axs_mem_fd = -1;
  axs_mem_fd = open("/dev/mem", O_RDWR|O_SYNC);
    if (axs_mem_fd < 0) {
        perror("AXS: can't open /dev/mem");
        return NULL;
    }
    /* memory map */
  reg_mem =(volatile char*)mmap(
      (caddr_t)reg_mem,
      0x4,
      PROT_READ|PROT_WRITE,
      MAP_SHARED,
      axs_mem_fd,
      0x04600000
  );
	if(reg_mem[0]==0x10) printf("OK");
	else printf("sorry");
}
host:
ppc_6xx-gcc -o test test.c
target:
./test
Bus error

need help,thanks

------------------------------
我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=linuxppc-embedded&FullName=linuxppc-embedded&Email=linuxppc-embedded%40ozlabs.org&verify=755eff4e640bdcfc57d93cbd8b0a9cb7
