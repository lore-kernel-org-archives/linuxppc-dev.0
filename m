Message-ID: <20011119091157.67350.qmail@web15001.mail.bjs.yahoo.com>
Date: Mon, 19 Nov 2001 17:11:57 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: About floating point exception!
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello all:
 	I try to write a program to send data from device
 then send them to ethenet using UDP.
 	My devices generate interrupt 1206 times/sec.
 But it always generate Floating point exception,I
 don't know why?
 Here is dump message:
 Oops: Kernel Mode Software FPU Emulation, sig: 8
 NIP: 00001FFC XER: 00000000 LR: 00000590 SP:
 C05DDBC0
 REGS: c05ddb10 TRAP: 1000
 MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
 TASK = c05dc000[27] 'udpserver' Last syscall: 102
 last math 00000000 last altivec 00000000
 GPR00: 00000000 C05DDBC0 C05DC000 C05DDBD0 00000000
 00008000 C05DDD38 10020E38
 GPR08: 00000000 00000000 00000000 00000000 44000022
 10018CE8 00000000 00000000
 GPR16: 00000000 00000000 00000000 00000000 00001032
 005DDBC0 C00CAFFC 00009032
 GPR24: 00000000 00008000 00008000 C0A806C2 C05DDD38
 C05DDDF8 C05DDDF8 C0373990
 Call backtrace:
 C05DDBB0 C00CB234 C00D1308 C009E2A0 C009F15C
 C009FA3C
 C000259C
 7FFFFAC8 1000088C 7FFFFD08 10000A84 10000830
 0FF094F8
 00000000

 [1] 27 Floating point exception ./udpserver

 And here is my source file:
 void service()
 {
         int len;
         int index=0;
         int val;
         void (*old_handler)(int);
         old_handler=signal(SIGIO,readbuf);
         fd=open("/dev/capvideo",O_RDWR);
         if(fd<0)
         {
                 printf("Open deivdes fail\n");
                 exit(0);
         }
         if(fcntl(fd,F_SETOWN,getpid())==-1)
         {

                 close(fd);
                 printf("Can't SETOWN\n");
                 return;
         }
         val=fcntl(fd,F_GETFL,0);
         val |=FASYNC;
         fcntl(fd,F_SETFL,val);
         time(&t);
         printf("BEGIN:%ld\n",t);
         for(;;)
 	{
         }
         close(fd);
         return;

 }
 void readbuf(int signum)
 {
         (void)signal(SIGIO,readbuf);
         ioctl(fd,MYDEVICE_GETDATA,buffer);
         if(sendto(sd,buffer,BANK,0,(struct sockaddr
 *)&addr,addr_len)<0)
         {
                 time(&t);
                 printf("Block Time:%ld\n",t);
         }

         if(sendto(sd,&buffer[BANK],BANK,0,(struct
 sockaddr *)&addr,addr_len)<0)
         {
                 time(&t);
                 printf("Block Time:%ld\n",t);
         }

 }


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
