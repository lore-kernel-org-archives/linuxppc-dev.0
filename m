Message-ID: <3CEDA49D.8040001@redswitch.com>
Date: Thu, 23 May 2002 19:25:33 -0700
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: (interruptible_)sleep_on_timeout question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Is it possible to dynamically change the timeout value of
sleep_on_timeout()? I encountered a situation where the timeout value is
got from some interrupt handler, which will modify the value. For example,

main() {
/* the main process goes to sleep with a timeout */
....
interruptible_sleep_on_timeout(q, timeout);
....
}

int_handler() {
      /* If the interrupt happens before timeout, the handler
       * gets a new timeout value and makes the main process
       * continue to sleep.
       */
}

Is it possible to implement this mechanism? I thought about kernel timer
and variation of sleep_on_timeout(). But all seems to have some problems.

Thanks a lot.

Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
