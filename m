Message-ID: <00a701c47371$f44de1e0$0a589edd@free>
From: =?ks_c_5601-1987?B?sejEociv?= <willy@airpoint.co.kr>
To: "linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Subject: enable_irq(12) unbalanced for ppc8260
Date: Tue, 27 Jul 2004 09:37:53 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, there.

I used ppc8260 cpm timer as followings:

void  init_timer()
{
    ...
    request_8xxirq(SIU_INT_TIMER1, handler, 0, "TIMER", NULL);
    enable_irq(SIU_INT_TIMER1);
    ...
}

void stop_timer()
{
    disable_irq(SIU_INT_TIMER1);
    free_irq(SIU_INT_TIMER1, NULL);
}

I called init_timer() after loading module and then called stop_timer()
after 10 seconds by user space program. It works well for first time
just after loading module and executing user space program. But it fails
from the next execution of user space program throwing 'enable_irq(12)
unbalanced' error. I mean interrupt won't occur.

What's wrong? What should I do to disable timer interrupt to avoid above
error?

Thanks.

willy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
