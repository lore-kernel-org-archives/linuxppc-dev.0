Date: Tue, 11 Jul 2000 06:52:00 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <bh40@calva.net>, toa@pop.agri.ch,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test3
In-Reply-To: <Pine.HPX.4.10.10007110953000.9548-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000711064628.14195J-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Jul 2000, Gabriel Paubert wrote:

> On Mon, 10 Jul 2000, Takashi Oe wrote:
>
> > 601's BAT doesn't have G bit.  Maybe that's the problem?
>
> No 601 BATs are completely different, see the source code in the early
> init. The valid bits in not in the same (BATL or BATU), the size (limited
> to 8 Mb) and protection encoding are different (only one valid bit, not Vs
> and Vu, and WIMGxPP are coded as in the PTE). I think the G bit is
> ignored.

Yes, that's very true ....  Are the following codes incorrect for 601?

[from prepare_disp_BAT() in prom.c]

		/* 601 */
		addr &= 0xFF800000UL;
		RELOC(disp_BATU) = addr | (_PAGE_NO_CACHE | PP_RWXX) | 4;
		RELOC(disp_BATL) = addr | BL_8M | 0x40;

Previously, it had "_PAGE_GUARDED" for BATU, which I thought was
incorrect.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
