Cc: Seong-kyu Ko <sugenius@doit.ajou.ac.kr>,
        linuxppc-embedded@lists.linuxppc.org
Message-ID: <39AABEC8.4DDE4CA0@lucent.com>
Date: Mon, 28 Aug 2000 14:34:32 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: cal_erickson@mvista.com
Subject: Re: Problems of the corss-compiler.
References: <Pine.LNX.4.21.0008290209060.960-100000@doit.ajou.ac.kr> <39AAA991.32FDF058@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cal Erickson wrote:
> In the MSR of the PPC processor there is a bit
> that indicates whether there is hardware
> floating point unit available.

Beware -- Linux uses the bit to optimize FP-register usage in the
kernel. Basically it starts each process with the bit off, but turns
it on for a process which takes the "FP not avail" trap. The
optimization occurs in context switches where the FP registers are
not saved or restored for processes with this bit off.

This is, of course, for CPUs which have FP units.... IIRC the CPUs
without FP units have the bit hardwired to 0.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
