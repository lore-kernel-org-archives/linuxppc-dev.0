Date: Fri, 3 Jan 2003 16:26:47 -0700
From: Rob Baxter <robb@phx.mcd.mot.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: PPC 7455 bogomips calculation
Message-ID: <20030103162647.A25677@phx.mcd.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have a PPC 7455 based system running a 2.4.19 kernel.  I would
like to know what others are seeing, as far as the bogomips calculation,
on other PPC 7455 based systems.

I'm seeing a bogomips calculation that is equivalent to the processor
core frequency.  With systems based on pre 745x PPCs, normally one
would see a bogomips calculation of twice the processor core frequency.

I understand that it's just a calculation and not a benchmark and/or
performance measurement.  I'm trying to understand why it's half of
what we have been seeing.

The delay loop that is utilized is this:


        .align  5
_GLOBAL(__delay)
        cmpwi   0,r3,0
        mtctr   r3
        beqlr
1:      bdnz    1b
        blr


After some review of the PPC 7455 user's manual, it looks like the
branch prediction logic has changed a bit from earlier versions
(e.g., PPC 750, PPC 7400, PPC 7410).  This may account for the difference
in the bogomips calculation.


Rob Baxter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
