Message-Id: <v03110703b31c014a3e67@[129.59.235.1]>
In-Reply-To: <Pine.A41.3.95a.990319095602.150872B-100000@rsplus06.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 22 Mar 1999 08:21:26 -0600
To: Marc Dejardin <Marc.Dejardin@cern.ch>, linuxppc-dev@lists.linuxppc.org
From: "Marcus H. Mendenhall" <mendenmh@nashville.net>
Subject: Re: Kernel panic with telnet using 2.2.2 and f771 with 2.2.3
Cc: linuxppc-user@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is more of the problem I have been reporting, but have had little time
to further trace.  Look up mm->pgd in tghe mailing list archives and you
will find a log of previous discussion.  Apparently the bug is rare, so it
hasn't yet fallen on someone with enough time to track it.  However, you
have provided one _critical_ clue in the info below... you only have SCSI
disks. Also, you are on a 604e, and not a 750. I was beginning to smell
trouble in the page faults on IDE drives (I only have IDE), but since it
now is reported on a SCSI machine, the IDE driver is exonerated.

Marcus Mendenhall

At 3:01 AM -0600 3/19/99, Marc Dejardin wrote:
>Hello,
>
>I have got kernel panics in telnet and f771 (according to log/messages) ...
>I don't know if it could be usefull to anybody ?
>I don't know really what to do with this.
>But if one of the goal of linux is to be the most stable OS, perhaps it
>could be
>interreting to understand why it happens.
>
>Thanks for your help.
>
>            Marc Déjardin
>
>First kernel panic :
>
>Linux version 2.2.2 (dejard1@xxxxxx.xxxxxx.xxx.fr) (gcc version egcs-2.91.57
>19980901 (egcs-1.1 release)) #1 Fri Mar 5 10:45:47 CET
>1999
>
>Mar 18 18:00:36 xxxxxx kernel: NIP: C00CDFDC XER: 20000000 LR: C002966C
>REGS: c1cfbd20 TRAP: 0300
>Mar 18 18:00:36 xxxxxx kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
>Mar 18 18:00:36 xxxxxx kernel: TASK = c1cfa000[2269] 'telnet' mm->pgd
>c3fdf000
                                                               ^^^^^^^^
>Mar 19 09:25:58 xxxxxx kernel: TASK = c4c96000[678] 'f771' mm->pgd c2276000
                                                            ^^^^^^^^^^^
>
>-- Versions installed: (if some fields are empty or looks
>-- unusual then possibly you have very old versions)
>Linux xxxxxx.xxxxxx.xxx.fr 2.2.2 #1 Fri Mar 5 10:45:47 CET 1999 ppc unknown
>Kernel modules         found
>Gnu C                  egcs-2.91.60
>Binutils               2.9.1
>Linux C Library        ..
>Dynamic Linker (ld.so) such
>Linux C++ Library      2.8.1
>Procps                 1.2.7
>Mount                  2.7f
>Net-tools              (1997-09-21)
>Kbd                    0.93
>Sh-utils               1.16
>
>processor       : 0
>cpu             : 604e
>clock           : 180MHz
>revision        : 2.2
>bogomips        : 359.63
>zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/86 (0%)
>machine         : Power Macintosh
>motherboard     : AAPL,8500 MacRISC
>L2 cache        : 256K unified
>memory          : 80MB
>
>Attached devices:
>Host: scsi0 Channel: 00 Id: 00 Lun: 00
>  Vendor: SEAGATE  Model: ST32151N         Rev: 0560
>  Type:   Direct-Access                    ANSI SCSI revision: 02
>Host: scsi0 Channel: 00 Id: 03 Lun: 00
>  Vendor: MATSHITA Model: CD-ROM CR-8008   Rev: 8.0e
>  Type:   CD-ROM                           ANSI SCSI revision: 02
>Host: scsi1 Channel: 00 Id: 02 Lun: 00
>  Vendor: QUANTUM  Model: XP34301          Rev: 1037
>  Type:   Direct-Access                    ANSI SCSI revision: 02
>



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
