Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3ADE1A0C.EF3975DF@mvista.com>
Date: Wed, 18 Apr 2001 18:49:48 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kyle Harris <kharris@nexus-tech.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sound driver on mpc823
References: <3ADDDCFF.CB4B9A6F@nexus-tech.net> <3ADDFA54.D44199F7@mvista.com> <3ADE01A6.CB30230E@nexus-tech.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kyle Harris wrote:

> ....But
> I'm not sure exactly how the CPM correlates the RAM entries to buffer
> descriptors (e.g., does it advance buffer descriptors when the RAM entry
> changes).

They don't relate.  The TDM is an autonomous bit mux that moves
bits between the TDM I/O and the communication channels.  The TDM
RAM indicates where the bits are in the TDM I/O stream, how many
there are, and to which communication channel they are connected.
For example, you can tell the TDM there are three bits in every
major frame at offset 19 that belong to SMC2, and tell the SMC2 to
communicate with 8-bit data.  The TDM will pack three bits at a time
to the SMC, and when the SMC gets its eight bits it will do whatever
protocol is appropriate in the SMC and move the data to the buffer.
Any remaining bits between the TDM and the SMC are then used to start
the next 8-bits to the SMC.

The often more confusing part (but it really isn't :-), and very
necessary part is how the communication channel synchronizes to the
TDM frame.  Although it looks like there is lots to read in the
CPM and communication sections of the manual, the words are actually
quite few and very critical to understand.  There is a ton of
information in that manual that you have to understand, and don't
skip one word :-).

I have a telecom/telemetry background, so I guess I can apply that
application experience and make some sense out of the CPM/TDM a
little more easily :-).

Good Luck.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
