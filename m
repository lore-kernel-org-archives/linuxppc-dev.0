In-Reply-To: <Pine.HPX.4.10.10002111837290.1866-100000@gra-ux1.iram.es>
Date: Fri, 11 Feb 2000 19:38:08 +0100
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Latest OpenPic changes
Message-Id: <20000211193808.018868@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 11, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>If it's truly the case we should consider a different solution. Masking
>interrupts in a device or controller for a very short lapse is dominated
>by the HW access overhead, and this is bad. sync instructions are also
>extremely bad.

I implemented it in both enable and disable for "correctness" so that the
status of the controller is guaranteed when exiting any of those 2
functions. I agree that the unmask case may not be important.

I beleive the sync here can also be completely removed too. A single
eieio is plenty enough because of the read. Isn't it ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
