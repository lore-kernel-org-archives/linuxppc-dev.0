Message-ID: <3B460601.6A3AA7D9@acm.org>
Date: Fri, 06 Jul 2001 11:40:01 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: IBM Microdrive PCCard on TiBook (ide-cs module)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have spent a little more time tracking down why the PCCard adapter for
my Microdrive causes the TiBook to shutdown.  But I need some help in
interpreting the information I have found.

1) I was able to catch with xmon a stack trace before it shutdown.  This
showed a stack trace as follows:

ide-cs.c:ide_config
ide.c:ide_register
ide.c:ide_register_hw
ide.c:ide_probe_module
ide-probe.c:ideprobe_init
ide-probe.c:probe_hwif
ide-probe.c:do_probe
ide-probe.c:try_to_identify
ide-probe.c:actual_try_to_identify  <== shutdown somewhere here??

2) I am assuming at this point it is writing to registers which are
mapped incorrectly (probably to the PMU) which cause it to shutdown.

3) I have found that the io_base addresses is 0x1000 (as set in my
config.opts file) and this is what is passed to the ide_register
function.  Changing this address does not seem to change it's behavior
though.  (??)

4) ide_register calls ide_init_hwif_ports with these addresses which
have a "pmac_" specific call.  So I am assuming that it would "ioremap"
these as appropriate.  (However, I don't see it modifying this address
at all?)

5) ide_register_hw calls "ide_probe_module" which takes me into the
ide-probe.c file.  But I see a specific "pmac_ide_probe" which is called
at init time.


My conclusion is that I should either be calling this pmac_ide_probe
rather than the generic ide_probe module (and making it _not_ an init
function).  OR I need to modify the ide_probe module to handle the
proper maping of the addresses such that I don't write to the PMU.

Unfortunatly I have not found any examples of the later in the pcmcia
drivers I have looked at so I am worried that I am totally off base.  If
I am "barking up the wrong tree" I hope someone can tell me such that I
can start looking elsewhere.

Thanks in advance,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
