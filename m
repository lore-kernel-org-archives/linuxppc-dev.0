Message-ID: <001f01bffc66$d4da4000$4607a8c0@LocalHost>
From: "Gong Zhuo" <gongzhuo@163.net>
To: "Linux PPC Mailing List" <linuxppc-embedded@lists.linuxppc.org>
Subject: How to using Raven timer interrupt on MVME2600?
Date: Wed, 2 Aug 2000 17:48:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:
   I want to using the timer of RAVEN to get cycle interrupt.
   I have done sth. like this:

   1. 0x1092f107 ==> timer base count 0 (0xfc001110) ( the cycle is 16s and
value is 0x07f19210 on pci bus)
   2. 0x80000700 ==> timer 0 vector/priority reg.(0xfc001120) ( vector 80,
priority 7)
   3. 0x01000000 ==> timer 0 destination reg. (0xfc001130) ( interrupt to
processor 0)
   4. 0x06000000 ==> interrupt task priority reg. (0xfc020080) (task
priority is 6)

   I can see the value of timer 0 current count reg. is changing and the 'T'
bit of timer 0 current count reg. changing between 0 and 1.
   The 'ACT' bit of timer0 vector/priority reg. is 1 (the whole value is
0x80000740) after interrupt enabled.

   In my interrupt processing:
   1. read interrupt ack reg.
   2. judge the vector to see if it is 0x80 (the timer 0 vector)
   3. do the interrupte processing
   4. write a value to EOI register

   But it seems that the interrupt has never happened. After I read the
interrupt ack reg. under PPCbug , the 'ACT' bit of vector/priority reg. will
not change. Is that right? Something else I should do?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
