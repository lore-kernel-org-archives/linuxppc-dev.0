Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3ED6298C.3070901@adtran.com>
Date: Thu, 29 May 2003 10:38:52 -0500
From: Ron Flory <ron.flory@adtran.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	ron flory <ron.flory@adtran.com>
Subject: embedded gcc PPC toolchain questions
References: <39EF7A07.5D946387@ctam.com.au> <39EFA8CE.33485BAD@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Hello;

  I have several low-level gcc toolchain questions.  I'm not new to
gcc or embedded programming, but this is the fist time I've tried
to use gcc for a stand-alone, non-linux embedded PPC project.

  Apologies in advance if these appear to be a little off-subject.
I welcome redirection to online FAQs or code snippets.  Thanks.

1.  How does one declare distinct data regions with GCC?  Consider
    the case where a separate non-cached memory region is needed
    for CPM/FEC use, I would do something like the following under
    GreenHills C/C++:

     #pragma ghs section data = ".nocacheram"
        static char fec_rbd_alloc[ <some length> ] = { 0 };
        static char fec_tbd_alloc[ <some length> ] = { 0 };
     #pragma ghs section

     Such distinct regions are generally collected and combined
    across modules, so the FEC and CPM drivers would place their
    buffers in the same non-cached area.

2.  Once I have defined and declared such regions, how does one
    instruct the linker to align and padd such regions?  Under
    Greenhills, this would be done in a linker control file, such
    as:

     .nocacheram  align(0x1000)   :
     .evtdata     align(0x1000)   :

       This would align ".nocacheram" on a 4kb boundary, and would
      ensure 4Kb length as well (since the following group was also
      4Kb aligned).

3.  Once I have defined, declared, and aligned these special memory
    regions, how would I determine their base/length?  Again, under
    GreenHills, we would declare:

      extern char __ghsbegin_nocacheram[];
      extern char __ghsend_nocacheram[];

     Which would provide the 'begin' and 'end' address of the region,
    allowing us to set the appropriate MMU attributes for this user-
    defined area.

4.  I know the question of embedded libc comes up often.  For
    the most part, we basically need the 'strxxx' and 'memxxx'
    functions, but 'sprintf' is quite a different critter.  Since
    we are running an 860, we won't have FP support (and we don't
    want to deal with emulation).  Do most folks use a hand-patched
    'sprintf' source file, manually removing the floating-point ops?
    I've looked into this a few years ago (the gcc sprintf source
    file is a horror).  Has the 'ulibc' that i've heard about been
    used with success by anybody on this list for embedded non-linux
    projects?

5.  We have access to many Macraigor 'Raven' BDM interfaces.  I've
    downloaded the x86 Linux support tools for this device.  Has
    anybody had good results with this device and support tools
    under Linux?

6.  OK, please don't flame me on this stupid question.  Does 'as'
    (the assembler) run its source input through the 'cpp' C
    PreProcessor?  I can always pipe through cpp myself with an
    implicit 'make' target if I need to...

  Thank you.

--

Ron Flory, Network Products.
email: mailto:ron.flory@adtran.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
