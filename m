Message-ID: <40EB1C28.3000402@246tNt.com>
Date: Tue, 06 Jul 2004 23:39:52 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: ppc linux embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Getting rid of static IO mapping
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

In the mpc5200 2.6 support, I'm trying to get rid of all static io
mapping.
So every address I use must be ioremaped. For the device drivers, no
problem they are remaped during probe and released if modules get
unloaded. For some routines used at boot & setup, I just ioremap at
the function begining and ioumap at the end. For interrupt handling,
since ioremap at each interrupt is not really nice, I just do it
durint irq_init and then keep the vaddr in a global var to the file
(static).

Until there, it works fine. My only problem left is with the
ppc_md.progress. I'm not sure what is the memory environment at each
time it might be called. Can I use ioremap/iounmap at each call ? (I
know I could just try but that might work even if it's wrong(tm) ).

In the current situation, I use the physical address and there is a
1:1 mapping. The mapping is first done by directly manipulating
{D,I}BAT2, then by setup_io_mappings.
If I understood correctly, I should use the physical address while the
BAT2 mapping is still active, then when the memory managment is ok,
ioremap it. Is it correct ? How can I know when BAT2 has been
overwritten and ioremap ready to go ? Is this the purpose of
mem_init_done ?


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
