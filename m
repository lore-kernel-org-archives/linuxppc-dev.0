Date: Wed, 24 Oct 2001 21:51:12 -0700
From: Okehee Goh <ogoh@asu.edu>
Subject: RE: MMU in MBX860
In-reply-to: <3BD78E88.90337302@mvista.com>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <AEEDJHMEPHBIHBAHOOCDIELKCAAA.ogoh@asu.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Thank you, Dan

 The problem is that it shares one global page table between kernel and
application processes.
 Some of memory space that is allocated to each application process must be
accessed by
 that application process. In other word, it must prevent an application
process from accessing to
 memory space allocated to other an application process. For this
protection, I need to use ASID.
 If memory space are marked as SHARED and suprevisor permission, kernel can
access all of memory space
  because ASID checking is disabled.
 But it can't support memory protection for application processes.

 I appreciate any your idea.
 Thank you so much.

 Okehee


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dan
Malek
Sent: Wednesday, October 24, 2001 9:01 PM
To: Okehee Goh
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU in MBX860



Okehee Goh wrote:

>  My question:
>  In MPC860, is there any way for supervisor mode's kernel to access all
> memory space

That's the purpose of the SHARED indicator in the TLB.  It effectively
disables ASID checking and if you mark pages SHARED but not user access
the kernel can access all pages while the applications are still protected.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
