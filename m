Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 4059667A85
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 11:22:14 +1100 (EST)
Received: from mailman.pit.comms.marconi.com (mailman.pit.comms.marconi.com
	[169.144.2.12])
	by mailgate.pit.comms.marconi.com (8.12.10+Sun/8.12.10) with ESMTP id
	j0K0M4jO024988 for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 19:22:04 -0500 (EST)
Received: from uspitsmsgrtr01.pit.comms.marconi.com
	(uspitsmsgrtr01.pit.comms.marconi.com [169.144.2.221])
	by mailman.pit.comms.marconi.com (8.9.3/8.9.3) with ESMTP id TAA23947
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 19:22:03 -0500 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647523@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 19 Jan 2005 19:22:00 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: Narrowed it down - RE:  Linux 2.6-10.rc3  8xx: Only 3 characters
	are printed well in  __in it start_kernel() upon kernel booting
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here is my software "debugging tool", which allowed me to disable writing
throgh printk()
to the log buffer - until I want it to be enabled
by using this "tool" I've performed some investigation
(however inconclusive - so opinions and suggestions are welcomed).


/* ... linux/init/main.c ...*/
...
+ unsigned long disable_printk = 1;
  extern char *linux_banner;
...
 __in it start_kernel(...) 
...
disable_printk = 0;
printk("Alex\n");
vfs_caches_init_early();
mem_init();
...
*************************************************

/* ... kernel/printk.c ... */
...
  DECLARE_WAIT_QUEUE_HEAD(log_wait);

+ extern unsigned long disable_printk ;
...
asmlinkage int printk(const char *fmt, ...)
{
        va_list args;
        int r;
+       if (disable_printk) return 0;
        va_start(args, fmt);
...

**************************************************
I was "sliding down" those two statements:

disable_printk = 0;
printk("Alex\n");

down to cosole_init() and further down beyond it,
while I could see "Ale" in - I was moving it further down ...

To double check, couple times I would do just 

disable_printk = 0;
without
printk("Alex\n");

then I have seen once:
"Con"

and moving further down:
"Den"

which I think is from: "Dentry cache hash table entries ..."

But I can not see my output when do it 
just before
 vfs_caches_init_early();

but it is very close to

mem_init();

so I am not sure, which is the culprit ...

Should I put some delay between those two (what is the best way to do it ?)

Thanks,
Best regards,
Alex
