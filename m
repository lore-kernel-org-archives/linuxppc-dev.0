Date: Fri, 18 Jul 2003 10:35:58 -0400
Message-Id: <200307181435.h6IEZwN21368@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: Charles.Wells@nielsenmedia.com
Cc: slowforce@21cn.com, linuxppc-embedded@lists.linuxppc.org
In-reply-to: 
	<762A181C0D966E459A2EB3B810142C7701514BF1@nmrusdunsx12.nmrlan.net>
	(Charles.Wells@nielsenmedia.com)
Subject: Re: need a fast byteorder changing routine
References: <762A181C0D966E459A2EB3B810142C7701514BF1@nmrusdunsx12.nmrlan.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Li,
>
>If you must do it one word at a time, the following works.
>
>long SwapBytes(long* p)
>{
>  __asm__(" lwbrx 3,0,3");
>}
>
>Charlie

And if you want it inlined:

static inline unsigned long loadWordAndSwapBytes(unsigned long *p)
{
  unsigned long val;

  __asm__ ("lwbrx %0,0,%1" : "=r" (val) : "r" (p));
  return val;
}

--
Peter Barada                             Peter.Barada@motorola.com
Wizard                                   781-852-2768 (direct)
WaveMark Solutions(A Motorola Company)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
