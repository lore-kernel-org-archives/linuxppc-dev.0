Message-ID: <004701c11341$43e704a0$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: About system calls question...
Date: Mon, 23 Jul 2001 14:32:36 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a question about how to use system calls...
I notice that in init/main.c=>init() functions:

init(void * unused)
{
    ....
if (open("/dev/console", O_RDWR, 0) < 0)
  printk("Warning: unable to open an initial console.\n");

 (void) dup(0);
 (void) dup(0);

 /*
  * We try each of these until one succeeds.
  *
  * The Bourne shell can be used instead of init if we are
  * trying to recover a really broken machine.
  */

 if (execute_command)
  execve(execute_command,argv_init,envp_init);
 execve("/sbin/init",argv_init,envp_init);
......
}

My question is since "open" "dup" and "execve" are system calls, they should
be called  only in user process instead of in kernel space.

Why can they be used in this way here?
Thanks in advance!

machael thailer


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
