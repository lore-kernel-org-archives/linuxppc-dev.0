Message-ID: <3E64DC21.4060802@tataelxsi.co.in>
Date: Tue, 04 Mar 2003 22:32:25 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: problem in ppc-linux-gcc cross compiler.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am not very sure if this is off topic.
I am facing a problem in variable argument passing in linux-gcc-ppc.

[om@pandatest1 ~/prg]$ cat macro2.c
#define __KERNEL__
#define bet_syslog(warning, format, msg...)\
do \
{ \
         printk( "<%d> In file %s, line %d, function %s(). " format "\n",\
              warning, __FILE__, __LINE__, __FUNCTION__, ##msg) ;\
} while (0)

void hell()
{
     bet_syslog(1,"Test Message - 1");
     bet_syslog(2,"Test Message - 2%d",100);
     return ;
}

[om@pandatest1 ~/prg]$ ppc-linux-gcc  -E macro2.c
# 1 "macro2.c"
void hell()
{
     do { printk( "<%d> In file %s, line %d, function %s(). "  "Test
Message - 1"  "\n",  1 , "macro2.c", 11,  ) ;} while (0) ;
     do { printk( "<%d> In file %s, line %d, function %s(). "  "Test
Message - 2%d"  "\n",  2 , "macro2.c", 12, __FUNCTION__,100 ) ;} while (0) ;
     return ;
}
[om@pandatest1 ~/prg]$ ppc-linux-gcc  -v
ppc-linux-gcc: Actual path = '/opt/hardhat/previewkit/ppc/82xx/bin/'
         Actual name = 'ppc_82xx-gcc'
         Invoking
/opt/hardhat/previewkit/ppc/82xx/bin/../lib/gcc-lib/powerpc-hardhat-linux/2.95.3/ppc_82xx-gcc
Reading specs from
/opt/hardhat/previewkit/ppc/82xx/bin/../lib/gcc-lib/powerpc-hardhat-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release/MontaVista)
[om@pandatest1 ~/prg]$


In the first message, __FUNCTION__ is missing and one `,` is extra.
Because of this, it will not compile, stating a parse error.
I am using monta vista linux.

Thanks in acvance.
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
