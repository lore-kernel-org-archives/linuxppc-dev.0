From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.0-test3
Date: Tue, 11 Jul 2000 17:57:56 +0200
Message-Id: <20000711155756.6478@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10007111341520.9548-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10007111341520.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>In this case, are we sure that the 601 problems are introduced by this
>change ? Historically, there have been other 601 related problems, like
>code touching HID0 without checking processor version or so.
>
>Another possibility is an ordering problem, it seems that the code
>reloads all the BATs from the BAT array setup by mm/init.c. Is it possible
>that the crash happens this late and do you still need BAT3 after this ?
>
>Maybe the fix will be as simple as writing 0 to the IBATL in LOAD_BAT so
>that we are sure that the BAT is disabled before being reloaded, or call
>again clear_bats before the series of LOAD_BATs.

Well, Andreas re-did the tests with my latest fix (which was to remove
the bogus PAGE_GUARDED in the 601 case) and with the mftb 601 fixes and
his kernel now works.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
