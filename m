From: "Chris Hallinan" <clh@net1plus.com>
To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Timer interrup can not go forward!
Date: Wed, 12 Jun 2002 09:55:16 -0400
Message-ID: <NEBBKJPFOLJNBMFNKBIIEEKJCOAA.clh@net1plus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
In-Reply-To: <001901c211b4$194a4b40$7301a8c0@zhongqx>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zhonggx wrote:
>     How are you!
>     I find the problem with my linux-2.4.18 on MPC8xxFADS
> board ,I find when the Start_kernel function in
> /init/main.c run to Sti(),
> then time_interrupt() start,but it can not be finished,it
> loop in while loops like following ,can not go out from

This is a common problem, and has been addressed on this list
before.  The  decrementer is set wrong, and the timer interrupt is
happening many times faster than it should.  As soon as the timer
interrupt completes, it is entered again.  It is spinning in the
ISR.

Chris Hallinan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
