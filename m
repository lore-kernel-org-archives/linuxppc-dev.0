To: "Banks, Kelly" <kelly.banks@gilbarco.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Extended Scheduling Latency on LinuxPPC 2.4.10 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Feb 2002 16:21:27 EST."
             <A3E34B558F5CD211B4980008C7A4A99002424172@sparrow.gso.mcs.marconi.com>
Date: Tue, 26 Feb 2002 23:39:01 +0100
Message-Id: <20020226223906.96FAC109E3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kelly,

in message <A3E34B558F5CD211B4980008C7A4A99002424172@sparrow.gso.mcs.marconi.com> you wrote:
>
> Running LinuxPPC 2.4.10 in an MPC860 board, I am experiencing an extended
> period of time when the kernel seems to be 'out to lunch'.
>
> The system receives a periodic poll request over SCC2 & is designed to
> respond to the poll in a timely fashion.

Designed to respond ... in a timely fashion? I don't see any  mention
of RTAI here, which you should use if you have deadlines to meet.

> Occasionally, the system appears to 'hang' for a period of time from between
> 2 & 8 Seconds.  During this delay, poll requests seem to be queued into

I have never seen such huge delays with any of the standard kernels.

> The 2.4.10 low-latency patch has been ported into the system (successfully,
> I think), but the problem still exists.

Maybe that's the _cause_ of the problem? You are aware that there are some problems with the nested SIU and CPM interrupts on 8xx systems when it comes to RT resonses?

Try RTAI, where we added the CONFIG_CPM_MULTILEVEL_IRQ  configuration
option.




> This document contains confidential information of Gilbarco Inc.
> In consideration of receipt of this document, the recipient agrees
> not to reproduce, copy, use or transmit this document and/or the
> information contained herein, in whole or in part, or to suffer

F*ck. Now I did it. I transmitted parts of this  stupid  information.
Must I go to jail now or what?

Switch this OFF!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It's like deja vu all over again."                      - Yogi Berra

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
