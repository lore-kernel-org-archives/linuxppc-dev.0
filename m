To: linuxppc-dev@lists.linuxppc.org
Subject: Bogus interrupt -1
From: Lars Brinkhoff <lars@nocrew.org>
Date: 20 Apr 2001 18:32:02 +0200
Message-ID: <85itjzilbx.fsf@junk.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got these messages from benh's 2.4.4-pre1 running SMP:

  Bogus interrupt -1 from PC = c000781c
  Bogus interrupt -1 from PC = c0017ba4
  Bogus interrupt -1 from PC = c0024c90
  Bogus interrupt -1 from PC = c0017ba4
  Bogus interrupt -1 from PC = c0017c34
  Bogus interrupt -1 from PC = c0017ba4
  Bogus interrupt -1 from PC = c0006e38
  Bogus interrupt -1 from PC = c0006e38
  Bogus interrupt -1 from PC = c0006e38
  Bogus interrupt -1 from PC = c0006e38
  Bogus interrupt -1 from PC = c0006e38
  Bogus interrupt -1 from PC = c0006e38

According to my System.map:
c0006e38 = _nmask_and_or_msr + 0x10
c000781c = _switch_to + 0x184
c0017ba4 = schedule + 0x1084
c0017c34 = schedule + 0x1228
c0024c90 = del_timer_sync + 0x184

At first, the first six or so messages appeared, but everything seemed
fine.  Later, the last messages appeared, and it seemed like one of
the two processors in my 2001 Dual G4 had wedged.  According to "top",
there was always at least 50% idle time.

--
http://lars.nocrew.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
