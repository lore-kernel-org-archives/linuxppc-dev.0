Date: Wed, 19 Jun 2002 20:17:32 +0900
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: tlbia and PPC603
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20020619201733E.ekato@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Does _tlbia in arch/ppc/kernel/misc.S work fine on PPC603 Machintosh??


I've experienced instability (random crash) on UMAX C500 with benH
and bk kernel since last November.  Several users of PCI Performa also
reported this symptom as well, like
http://lists.linuxppc.org/linuxppc-user/200205/msg00061.html and
http://lists.linuxppc.org/linuxppc-user/200203/msg00027.html.


My Macintosh are very old, two Nubus Mac (PM6100AV, Performa6200), and
one oldworld PCI Mac (UMAX C500).  And I would like to use linux on
these machines.  Recently, I've updated Nubus-Pmac patch to current
PowerPC Linux tree (2.4.19-pre10).  In this process, I found this
instability also occur on Performa6200 (PPC603) but not in PM6100AV
(PPC601 and also with G3 upgrade card).  Performa6200 sometimes went
to xmon randomly and crashed at local_flush_tlb_mm().  And sometimes
just showing segmentation fault or illegal instruction error.  Then I
suspect _tlbia() is causing the crash, so I experimentally added
"isync" just after "sync" in _GLOBAL(_tlbia) in
arch/ppc/kernel/misc.S.

It appears this change made Performa6200 stable.  Also I tested this
change on UMAX C500 with linux-2.4.19-pre10, and UMAX C500 also became
stable.

I'm not sure adding "isync" is good choice, but it seems some problem
can be solved this.

Cheers,
--
Etsushi Kato
ekato@ees.hokudai.ac.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
