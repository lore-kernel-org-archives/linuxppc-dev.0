Message-ID: <38E9BA8F.913681C7@ascom.ch>
Date: Tue, 04 Apr 2000 11:49:03 +0200
From: Ruedi Hofer <ruedi.hofer@ascom.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
CC: erammsu@kieraypc01.p.y.ki.era.ericsson.se, kernel@linux01.hasler.ascom.ch
Subject: Re: Re: PCMCIA support for 860
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Thanx for the answers...

I patched the files mpc8xx.h and init.c as you wrote. Then I recompiled the
kernel (2.2.13, including fpu, damm, bossek patches) and restarted it.
Then I used the rc.pcmcia to set the modules up. It fails because of...

sh-2.03# ./rc.pcmcia start
Starting PCMCIA services: modules/lib/modules/2.2.13/pcmcia/pcmcia_core.o:
unresolved symbol request_8xxirq
/lib/modules/2.2.13/pcmcia/i82365.o: /lib/modules/2.2.13/pcmcia/i82365.o: No
such file or directory
/lib/modules/2.2.13/pcmcia/ds.o: unresolved symbol proc_pccard
/lib/modules/2.2.13/pcmcia/ds.o: unresolved symbol CardServices
 cardmgr.
sh-2.03# cardmgr[67]: starting, version is 3.1.10
cardmgr[67]: no pcmcia driver in /proc/devices
cardmgr[67]: exiting


I suppose that I should find the missing request in /proc/ksyms. But there
ain't nothing like this:

sh-2.03# cat /proc/ksyms | grep request
c0019478 request_module
c00e8f50 wait_for_request
c00ac2d0 make_request
c0008d6c request_irq
c000eb04 request_dma
c0016ac0 request_region
c00e5898 io_request_lock
c00acd30 end_that_request_first
c00ace3c end_that_request_last
sh-2.03# cat /proc/ksyms | grep 8xx
sh-2.03#

Does someone have a clue on that? Is request_irq and request_8xxirq related??

--
Best regards

Ruedi Hofer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
