In-Reply-To: <Pine.LNX.4.05.10002220926260.9231-100000@callisto.of.borg>
Date: Tue, 22 Feb 2000 21:59:20 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: MESH
Message-Id: <20000222215920.028089@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 22, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>I have troubles compiling in the MESH driver on my CHRP LongTrail. The driver
>doesn't link due to the lack of
>
>    note_scsi_host
>    feature_set
>
>which are clearly Mac-ish functions. What's the purpose of these
functions? Do
>I need them?

feature_set is part of the feature control (abstraction over the various
"features" bits in Apple ASIC). You can disable all the mac-io/feature
stuffs in MESH on non-pmac machines.
We use them after spying macos to what looks like enabling the line drivers.

note_scsi_host is used by the pmac "guess boot device" mecanism, you can
forget it too.

>Furthermore I still find it weird that mesh.c has
>
>    #if !defined(MODULE)
>	note_scsi_host(mesh, mesh_host);
>    #endif
>
>While the note_scsi_host symbol is exported by arch/ppc/kernel/ppc_ksyms.c.

note_scsi_host is an initfunc.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
